# High Current Monitoring Script for Drones

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

---

## License

This script is provided as-is for educational and experimental purposes. Use it responsibly and ensure safety during drone operations.
