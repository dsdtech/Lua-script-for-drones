-- Script: Auto Mode → 90° Left → Fly 200m
-- Gokul Krishna – Debugged Version

local has_started = false

function update()
    if not arming:is_armed() then
        has_started = false
        return update, 1000
    end

    -- Trigger only when mode is AUTO (3) and mission not started
    if vehicle:get_mode() == 3 and not has_started then
        has_started = true

        local loc = gps:location()
        if not loc then
            gcs:send_text(6, "GPS not ready")
            return update, 1000
        end

        local yaw_rad = ahrs:get_yaw()
        local current_heading = math.deg(yaw_rad)
        local target_heading = (current_heading - 90) % 360  -- Turn left

        local distance = 200.0
        local angle_rad = math.rad(target_heading)

        local lat_start = loc:lat() * 1e-7
        local lon_start = loc:lon() * 1e-7

        local dLat = distance * math.cos(angle_rad) / 111320
        local dLon = distance * math.sin(angle_rad) / (111320 * math.cos(math.rad(lat_start)))

        local target_lat = lat_start + dLat
        local target_lon = lon_start + dLon

        local alt = 20  -- Set desired mission altitude

        gcs:send_text(6, string.format("Mission WP set to %.7f, %.7f", target_lat, target_lon))

        -- Create waypoint command
        local cmd = {
            command = MAV_CMD_NAV_WAYPOINT,
            frame = MAV_FRAME_GLOBAL_RELATIVE_ALT,
            x = target_lat * 1e7,
            y = target_lon * 1e7,
            z = alt,
            param1 = 0, param2 = 0, param3 = 0, param4 = 0
        }

        mission:clear()
        mission:add_item(cmd)
        mission:set_current(0)

        -- Delay start by 1s to make sure everything is registered
        gcs:send_text(6, "Mission loaded. Will start in 1 second.")

        -- Schedule mission start
        return function()
            mission:start()
            gcs:send_text(6, "Mission started.")
            return update, 1000
        end, 1000
    end

    return update, 1000
end

return update()
