require('constants')

script.on_init(function()
    global.interfaces = {}
    global.vehicles = {}
  end)

local charging_info = {
  ["localized-charging-pole"] = {
    ['interface'] = 'localized-charging-pole-interface',
    ['range'] = 10,
    ['efficiency'] = 0.5,
  },
}

local electric_vehicles = {
  ['electric-locomotive'] = true,
  -- airship mod lol
  ['gunship'] = true,
  ['jet'] = true,
  ['cargo-plane'] = true,
  ['flying-fortress'] = true,
  -- predictabowl vehicle mammoth tank
  ['tank-mk3'] = true,
}

local function defaultdict(d)
  t = {}
  setmetatable(t, {
      __index = function (t, k)
        local ret = d()
        rawset(t, k, ret)
        return ret
      end
    })
  return t
end

local function get_chargable_items(grid)
  local items = {}

  for _, item in pairs(grid.equipment) do
    if(item.max_energy - item.energy > 0) then
      table.insert(items, item)
    end
  end

  return items
end

script.on_event(defines.events.on_tick, function(event)
    local remove = {}

    for k, vehicle_info in pairs(global.vehicles) do
      vehicle = vehicle_info.vehicle

      if(not vehicle.valid) then
        table.insert(remove, k)
      elseif(vehicle.grid ~= nil) then
        local grid = vehicle.grid
        local available_power = grid.available_in_batteries
        local current_power = vehicle.energy
        -- vehicles have a maximum energy cap that we have no way to read, so just get a delta to determine what we spent
        vehicle.energy = vehicle.energy + available_power
        local spent_power = vehicle.energy - current_power

        if(spent_power > 0) then
          for _, item in pairs(grid.equipment) do
            if(item.energy > 0) then
              if(item.energy > spent_power) then
                item.energy = item.energy - spent_power
                break
              else
                spent_power = spent_power - item.energy
                item.energy = 0
              end
            end
          end
        end
      end
    end

    for _, k in pairs(remove) do
      global.vehicles[k] = nil
    end

    if not (game.tick % scan_tick == 0) then
      return
    end

    local targets = {}
    local split = defaultdict(function() return 0 end)
    local splitpower = {}

    -- vehicles are checked for validity in the upper loop
    for _, vehicle_info in pairs(global.vehicles) do
      vehicle = vehicle_info.vehicle

      if(vehicle_info.charging == true or (game.tick - vehicle_info.lastCheck > vehicle_inventory_check)) then
        vehicle_info.lastCheck = game.tick

        -- maybe grid can be situational in future patches, who knows?
        local grid = vehicle.grid
        local hit = false

        if(grid ~= nil and grid.battery_capacity - grid.available_in_batteries > 0) then
          local pt = {
            ['ent'] = vehicle,
            ['grid'] = grid,
            ['towers'] = {},
          }

          for name, info in pairs(charging_info) do
            for _, tower in pairs(game.surfaces[1].find_entities_filtered{
                area={
                  {vehicle.position['x'] - info['range'], vehicle.position['y'] - info['range']},
                  {vehicle.position['x'] + info['range'], vehicle.position['y'] + info['range']},
                },
                name=name,
              }) do
              if(tower.force.name == vehicle.force.name and global.interfaces[tower.unit_number].energy > 0) then
                -- towers can charge multiple targets, find out which way the power will be split before actually doing the charge tick
                if(hit ~= true) then
                  table.insert(targets, pt)
                  hit = true
                end

                table.insert(pt.towers, tower)
                split[tower.unit_number] = split[tower.unit_number] + 1
                splitpower[tower.unit_number] = math.floor(global.interfaces[tower.unit_number].energy / split[tower.unit_number])
              end
            end
          end
        end

        vehicle_info.charging = hit
      end
    end

    for _, player in pairs(game.connected_players) do
      if(player.controller_type ~= defines.controllers.ghost and player.character ~= nil) then
        -- armor inventory is a one length inventory
        local item = player.get_inventory(defines.inventory.player_armor)[1]

        if(item.valid_for_read and item.grid and item.grid.battery_capacity - item.grid.available_in_batteries > 0) then
          local hit = false
          local pt = {
            ['ent'] = player.character,
            ['grid'] = item.grid,
            ['towers'] = {},
          }

          for name, info in pairs(charging_info) do
            for _, tower in pairs(game.surfaces[1].find_entities_filtered{
                area={
                  {player.position['x'] - info['range'], player.position['y'] - info['range']},
                  {player.position['x'] + info['range'], player.position['y'] + info['range']},
                },
                name=name,
              }) do
              if(tower.force.name == player.force.name and global.interfaces[tower.unit_number].energy > 0) then
                -- towers can charge multiple targets, find out which way the power will be split before actually doing the charge tick
                if(hit ~= true) then
                  table.insert(targets, pt)
                  hit = true
                end

                table.insert(pt.towers, tower)
                split[tower.unit_number] = split[tower.unit_number] + 1
                splitpower[tower.unit_number] = math.floor(global.interfaces[tower.unit_number].energy / split[tower.unit_number])
              end
            end
          end
        end
      end
    end

    for _, info in pairs(targets) do
      local grid = info.grid
      local items = get_chargable_items(grid)
      local item = table.remove(items, 1)

      if(item == nil) then -- wat
        game.print('Voltage: this should never happen: no chargable items?')
        error('Voltage: this should never happen: no chargable items?')
      end

      for _, tower in pairs(info.towers) do
        local power_info = charging_info[tower.name]
        local interface = global.interfaces[tower.unit_number]
        local energy_available = splitpower[tower.unit_number]

        -- lightning effect
        game.surfaces[1].create_entity{
          name = "charging-charge",
          position = {tower.position['x'], tower.position['y'] - 1.5},
          force = info.ent.force,
          target = info.ent
        }

        repeat
          local s = split[tower.unit_number]

          if(s == nil or s < 1) then
            error('Voltage: invalid tower split: ' .. tostring(s))
          end

          -- use ceil here to counter float imprecision
          local transfer = math.ceil(math.min(item.max_energy - item.energy, energy_available))
          interface.energy = interface.energy - transfer
          energy_available = energy_available - transfer
          item.energy = item.energy + math.ceil(transfer * power_info.efficiency)

          if(item.max_energy - item.energy < 1) then
            -- charge the next item
            item = table.remove(items, 1)

            -- everything has been charged
            if(item == nil) then
              break
            end
          end
        until energy_available < 1

        if(item == nil) then
          break
        end
      end
    end
  end)

local function on_entity_created(entity)
  if(charging_info[entity.name] ~= nil) then
    local uid = entity.unit_number
    local interface = game.surfaces[1].create_entity{
      name = "localized-charging-pole-interface",
      position = {entity.position['x'], entity.position['y']},
      -- stop ai in everything mode from attacking this invulnerable building
      force=game.forces['enemy'] --entity.force
    }

    interface.operable = false
    interface.destructible = false
    interface.minable = false

    global.interfaces[uid] = interface
  elseif(electric_vehicles[entity.name] ~= nil) then
    -- trains could be paused here if they haven't been detected as moving
    -- cars, etc can't be paused by event because there's no way to detect their inventory changing as it happens (no event)
    table.insert(global.vehicles, {
        ['vehicle'] = entity,
        ['charging'] = false,
        -- the last time the grid was scanned for non-empty batteries
        ['lastCheck'] = 0,
      })
  end
end

local function on_entity_deleted(entity)
  local interface = global.interfaces[entity.unit_number]

  if(interface ~= nil) then
    interface.destroy()
  end
end

-- hooks

script.on_event(defines.events.on_robot_built_entity, function(event)
    on_entity_created(event.created_entity)
  end)

script.on_event(defines.events.on_built_entity, function(event)
    on_entity_created(event.created_entity)
  end)

script.on_event(defines.events.on_entity_died, function(event)
    on_entity_deleted(event.entity)
  end)

script.on_event(defines.events.on_preplayer_mined_item, function(event)
    on_entity_deleted(event.entity)
  end)

script.on_event(defines.events.on_robot_pre_mined, function(event)
    on_entity_deleted(event.entity)
  end)

-- unpause vehicle when player starts driving it, repause it with a player -> vehicle map to determine
-- which vehicle stopped driving
-- this is for tanks, jets, etc
--
-- script.on_event(defines.events.on_player_driving_changed_state, function(event)
-- local player = game.players[event.player_index]

-- if(player.vehicle == nil) then
-- return
-- end

-- local entity = player.vehicle

-- if(entity.name == 'electric-locomotive') then
-- local current = entity.energy
-- entity.energy = entity.energy + 1000
-- game.print('added: ' .. tostring(entity.energy - current))
-- end
-- end)
