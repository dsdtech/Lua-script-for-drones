-- Constants
local CHECK_INTERVAL_MS = 1000 -- Interval to check current (1 second)
local CURRENT_THRESHOLD = 35   -- Current threshold for warning (Amperes)

-- Function to detect battery count
local function detect_battery_count()
    local count = 0
    for i = 0, 1 do
        if battery:current_amps(i) then
            count = count + 1
        end
    end
    return count
end

-- Function to get total current from all available batteries
local function get_total_current()
    local total_current = 0
    local num_batteries = detect_battery_count()
    for i = 0, num_batteries - 1 do
        local current = battery:current_amps(i)
        if current then
            total_current = total_current + current
        else
            gcs:send_text(6, "Debug: Battery " .. i .. " current unavailable")
        end
    end
    return total_current
end

-- Function to monitor current and send a warning message
local function monitor_current()
    local total_current = get_total_current()

    -- Debug log to confirm total current reading
    gcs:send_text(6, "Debug: Total Current: " .. total_current .. "A")

    if total_current > CURRENT_THRESHOLD then
        gcs:send_text(3, "CRITICAL: Overcurrent detected! Current: " .. total_current .. "A") -- Critical message
    end
end

-- Send script activation message
gcs:send_text(6, "High Current Monitoring Script Activated")

-- Main loop
return function()
    if not arming:is_armed() then
        gcs:send_text(6, "Debug: Drone is not armed. Monitoring paused.") -- Debug: Not armed
        return
    end
    monitor_current()
end, CHECK_INTERVAL_MS
