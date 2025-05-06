# 1,High Current Monitoring Script for Drones - hightcurrent.lua

This Lua script monitors the current drawn by the ESC (Electronic Speed Controller) of your drone. If the current exceeds the predefined threshold, it will send a critical warning message to the Ground Control Station (GCS).

---

## Features

- **Dynamic Battery Detection**: Automatically adjusts to single or dual battery setups.
- **Real-Time Monitoring**: Continuously checks the total current drawn by all batteries.
- **Critical Alerts**: Sends a high-priority warning if the current exceeds the threshold.
- **Debug Logs**: Provides debug messages to help identify issues in current readings or setup.

---

## Script Details

### **Constants**
- `CHECK_INTERVAL_MS`: Interval between each current check (default: 1000ms or 1 second).
- `CURRENT_THRESHOLD`: Current threshold for sending critical warnings (default: 35A).

### **Functions**

1. **`detect_battery_count()`**:
   - Detects the number of batteries connected to the drone (supports up to 2).

2. **`get_total_current()`**:
   - Aggregates the current from all detected batteries.
   - Logs debug messages if current data is unavailable.

3. **`monitor_current()`**:
   - Reads the total current and compares it to the threshold.
   - Sends critical alerts if the threshold is exceeded.

4. **Main Loop**:
   - Checks if the drone is armed.
   - Monitors the current periodically based on `CHECK_INTERVAL_MS`.

---

## Usage

1. **Upload the Script**:
   - Save the script to your flight controller using a compatible GCS (e.g., Mission Planner).

2. **Activate the Script**:
   - Ensure the script is running and observe the activation message: `High Current Monitoring Script Activated`.

3. **Monitor Current**:
   - Arm the drone.
   - The script will continuously monitor the current and send messages to the GCS.

4. **Warning Messages**:
   - If the current exceeds the threshold, the following message will be displayed:
     - `CRITICAL: Overcurrent detected! Current: XX.XA`

5. **Debugging**:
   - If current readings are unavailable, debug messages like `Battery X current unavailable` will help troubleshoot.

---

## Dependencies

- Drone firmware with Lua scripting support.
- Compatible Ground Control Station (e.g., Mission Planner, QGroundControl).

---

## Customization

- **Threshold Adjustment**:
   - Modify the `CURRENT_THRESHOLD` constant to set a different current limit.

- **Check Interval**:
   - Adjust `CHECK_INTERVAL_MS` to change the frequency of current checks.

- **Battery Configuration**:
   - Update the `detect_battery_count()` function if using more than two batteries.

---

## Troubleshooting

1. **No Messages in GCS**:
   - Verify Lua scripting is enabled in your drone firmware.
   - Ensure the script is properly uploaded and activated.

2. **Incorrect Current Readings**:
   - Check battery connections and telemetry settings.
   - Confirm the firmware supports `battery:current_amps()`.

3. **Warnings Not Triggering**:
   - Test by simulating or exceeding the threshold current.
   - Add debug logs to confirm the script is running correctly.

---

## Future Improvements

- Add support for more than two batteries.
- Integrate additional warnings for voltage drops or other critical parameters.
- Optimize for compatibility with various drone firmware versions.



# 2,ArduPilot Obstacle Avoidance Script (Front LiDAR) - obstacle_test.lua

## Overview

This Lua script for ArduPilot-based autonomous vehicles implements a basic obstacle avoidance system using a front-facing rangefinder (like a LiDAR). When the vehicle is in `AUTO` mode and detects an obstacle within a specified threshold, it will switch to `BRAKE` mode to stop. If the obstacle is cleared, the vehicle will resume `AUTO` mode. If the vehicle remains in `BRAKE` mode for a defined timeout period, it will automatically switch to `RTL` (Return To Launch) mode.

## Features

* **Front Obstacle Detection:** Uses data from a front-facing rangefinder to detect obstacles.
* **Automatic Braking:** Switches the vehicle to `BRAKE` mode when an obstacle is detected within the defined threshold.
* **Resumption of Autonomous Flight:** Automatically resumes `AUTO` mode once the obstacle is cleared.
* **Timeout to RTL:** If the vehicle remains in `BRAKE` mode for a specified duration, it will switch to `RTL` mode for safety.
* **Ground Control Station (GCS) Messaging:** Sends informative messages and warnings to the GCS about the script's status, detected distances, and mode changes.

## Configuration

The following parameters can be adjusted within the script to customize its behavior:

* `local FRONT = 0`: **Front Orientation ID:** This constant defines the orientation ID of your front-facing rangefinder as configured in ArduPilot. Ensure this value matches your setup.
* `local AUTO = 3`: **Autonomous Mode ID:** This is the numerical ID for the `AUTO` flight mode in ArduPilot.
* `local BRAKE = 17`: **Brake Mode ID:** This is the numerical ID for the `BRAKE` flight mode in ArduPilot.
* `local RTL = 6`: **Return To Launch Mode ID:** This is the numerical ID for the `RTL` flight mode in ArduPilot.
* `local threshold_m = 10`: **Obstacle Threshold (meters):** This value determines the distance (in meters) at which an obstacle is considered a threat and triggers the braking action. Adjust this based on your vehicle's braking characteristics and desired safety margin.
* `local timeout_ms = 180000`: **Brake Timeout (milliseconds):** This value defines the maximum duration (in milliseconds) the vehicle will remain in `BRAKE` mode before automatically switching to `RTL`. The current value is set to 180,000 ms (3 minutes).

## Installation

1.  **Save the script:** Save the Lua script (e.g., `obstacle_avoidance.lua`) to the appropriate scripts directory on your ArduPilot flight controller's SD card. The exact location may vary depending on your firmware version, but it's often in a directory named `APM/lua` or similar.
2.  **Enable Lua Scripting:** Ensure that Lua scripting is enabled in your ArduPilot parameters. You'll typically need to set the `LUA_ENABLED` parameter to `1`.
3.  **Configure Rangefinder:** Make sure you have a front-facing rangefinder properly configured in ArduPilot, and note its orientation ID. Update the `FRONT` constant in the script if necessary.
4.  **Reboot Flight Controller:** After saving the script and configuring the parameters, reboot your ArduPilot flight controller for the changes to take effect.

## Usage

Once the script is loaded and running, it will automatically monitor the front rangefinder data when the vehicle is in `AUTO` mode.

* When an obstacle is detected within the `threshold_m`, the vehicle will switch to `BRAKE` mode.
* If the obstacle moves out of the threshold, the vehicle will automatically resume `AUTO` mode.
* If the vehicle remains in `BRAKE` mode for more than `timeout_ms` without the obstacle being cleared, it will switch to `RTL` mode.
* The script will send messages to your GCS indicating its status and actions.

## Important Considerations

* **Sensor Reliability:** The effectiveness of this script heavily relies on the accuracy and reliability of your front-facing rangefinder. Ensure it is properly calibrated and functioning correctly.
* **Environmental Conditions:** The performance of rangefinders can be affected by environmental factors such as rain, fog, and dust. Consider these limitations.
* **Vehicle Dynamics:** The braking distance of your vehicle will influence the appropriate `threshold_m` value. Ensure you have adequate stopping distance.
* **Flight Mode Awareness:** This script only actively engages when the vehicle is in `AUTO` mode. It will not interfere with manual or other assisted flight modes.
* **Testing:** Thoroughly test this script in a safe and open environment before relying on it for critical operations. Monitor its behavior and adjust the parameters as needed.
* **Limitations:** This is a basic obstacle avoidance script. It only reacts to obstacles directly in front of the vehicle. It does not implement path planning or more sophisticated avoidance maneuvers.

## Author

Dhinoj DS


# 3,ArduPilot Script: Auto Mode → 90° Left → Fly 200m

## Overview

This Lua script for ArduPilot-based autonomous vehicles automates a specific flight maneuver. When the vehicle is armed and the flight mode is switched to `AUTO`, the script will:

1.  Determine the vehicle's initial heading.
2.  Calculate a waypoint 200 meters to the left of this initial heading.
3.  Create a simple mission containing this single waypoint at an altitude of 20 meters (relative to home).
4.  Initiate the mission, causing the vehicle to turn 90 degrees left and fly 200 meters straight.

## Features

* **Automated Trigger:** The maneuver is triggered automatically when the flight mode is set to `AUTO` after arming.
* **Relative Calculation:** The target waypoint is calculated relative to the vehicle's initial position and heading at the moment of mode switch.
* **Single Waypoint Mission:** Creates a simple mission with a single waypoint for the desired flight path.
* **Altitude Control:** Sets the target altitude for the mission to 20 meters.
* **GCS Feedback:** Sends informative messages to the Ground Control Station (GCS) about the script's actions and the calculated waypoint.

## Configuration

There are no user-configurable parameters within the script itself. The behavior is hardcoded as a 90-degree left turn and a 200-meter flight distance at 20 meters altitude. To modify these values, you would need to edit the script directly:

* **Turn Angle:** Change `- 90` on the line `local target_heading = (current_heading - 90) % 360` to a different value for a different turn angle (positive for right turn).
* **Flight Distance:** Modify `local distance = 200.0` to the desired flight distance in meters.
* **Target Altitude:** Change `local alt = 20` to the desired altitude in meters.

## Installation

1.  **Save the script:** Save the Lua script (e.g., `auto_left_200m.lua`) to the appropriate scripts directory on your ArduPilot flight controller's SD card (usually `APM/lua/`).
2.  **Enable Lua Scripting:** Ensure that Lua scripting is enabled in your ArduPilot parameters by setting `LUA_ENABLED` to `1`.
3.  **Reboot Flight Controller:** Reboot your ArduPilot flight controller for the script to be loaded.

## Usage

1.  **Arm your vehicle.**
2.  **Switch the flight mode to `AUTO`.**

    Upon entering `AUTO` mode for the first time after arming, the script will:
    * Determine the current GPS location and heading.
    * Calculate the target waypoint.
    * Load a mission with this single waypoint.
    * Start the mission after a 1-second delay.

The vehicle will then turn 90 degrees to the left and fly 200 meters in that direction at an altitude of 20 meters.

## Important Considerations

* **GPS Lock:** This script relies on a good GPS lock to determine the initial position and calculate the target waypoint. Ensure you have a strong GPS signal before arming and switching to `AUTO` mode.
* **Compass Calibration:** Accurate compass calibration is crucial for the correct heading determination and the resulting left turn.
* **Altitude Reference:** The target altitude of 20 meters is relative to the home altitude set when the vehicle was armed.
* **Single Execution:** The script is designed to execute its actions only once after arming and entering `AUTO` mode. To run the sequence again, you would need to disarm and re-arm the vehicle.
* **Safety:** Always ensure a safe environment for testing autonomous flight. Be ready to take manual control if necessary.

## Author

Gokul Krishna & Dhinoj DS





---

## License

This script is provided as-is for educational and experimental purposes. Use it responsibly and ensure safety during drone operations.
