local FRONT = 0
local AUTO = 3
local BRAKE = 17
local RTL = 6

local threshold_m = 10  -- 10 meters in cm
local timeout_ms = 180000  -- 3 minutes

local braking = false
local brake_start_time = 0

gcs:send_text(6, "🚀 Obstacle Avoidance Script Loaded")

function update()
    local mode = vehicle:get_mode()
    local now = millis()

    if rangefinder:has_data_orient(FRONT) then
        local dist = rangefinder:distance_orient(FRONT)
        gcs:send_text(6, string.format("📏 Front LiDAR: %.2f m", dist))

        if mode == AUTO and dist < threshold_m and not braking then
            vehicle:set_mode(BRAKE)
            gcs:send_text(6, "⚠️ Obstacle detected: Switching to BRAKE")
            brake_start_time = now
            braking = true
        end

        if braking then
            if dist >= threshold_m then
                vehicle:set_mode(AUTO)
                gcs:send_text(6, "✅ Obstacle cleared: Resuming AUTO")
                braking = false
            elseif now - brake_start_time > timeout_ms then
                vehicle:set_mode(RTL)
                gcs:send_text(6, "⏰ Timeout: Switching to RTL")
                braking = false
            end
        end
    else
        gcs:send_text(6, "⚠️ Front rangefinder has no data")
    end

    return update, 500
end

return update()
