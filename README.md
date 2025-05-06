# ArduPilot Lua Scripts Repository

This repository contains a collection of Lua scripts designed for use with ArduPilot-based autonomous vehicles (e.g., drones, rovers). These scripts extend ArduPilot's functionality by adding custom behaviors and automation.

## Scripts Included

This repository includes the following scripts:

* [Obstacle Avoidance Script (Front LiDAR)](#obstacle-avoidance-script-front-lidar)
* [Auto Mode → 90° Left → Fly 200m](#auto-mode--90-left--fly-200m)
* [High Current Monitoring Script](#high-current-monitoring-script)

## Obstacle Avoidance Script (Front LiDAR)

### Overview

This Lua script implements a basic obstacle avoidance system using a front-facing rangefinder (like LiDAR). When the vehicle is in `AUTO` mode and detects an obstacle within a specified threshold, it switches to `BRAKE` mode. Once the obstacle is cleared, the vehicle resumes `AUTO` mode. If the vehicle remains in `BRAKE` mode for a defined timeout, it switches to `RTL` (Return To Launch) mode.

### Features

* Front Obstacle Detection: Uses data from a front-facing rangefinder.
* Automatic Braking: Switches to `BRAKE` mode when an obstacle is detected.
* Resumption of Autonomous Flight: Resumes `AUTO` mode after the obstacle is cleared.
* Timeout to RTL: Switches to `RTL` mode if the vehicle is stuck in `BRAKE` mode.
* GCS Messaging: Sends status and warning messages to the Ground Control Station (GCS).

### Configuration

The following parameters can be configured within the script:

* `FRONT`: Orientation ID of the front-facing rangefinder.
* `AUTO`: Numerical ID for the `AUTO` flight mode.
* `BRAKE`: Numerical ID for the `BRAKE` flight mode.
* `RTL`: Numerical ID for the `RTL` flight mode.
* `threshold_m`: Obstacle detection threshold (meters).
* `timeout_ms`: Brake timeout (milliseconds).

### Installation

1.  Save the script to your ArduPilot flight controller's SD card (e.g., `APM/lua/`).
2.  Enable Lua scripting in ArduPilot (`LUA_ENABLED = 1`).
3.  Configure your rangefinder in ArduPilot.
4.  Reboot the flight controller.

### Usage

The script automatically monitors for obstacles when the vehicle is in `AUTO` mode.

### Important Considerations

* Ensure your rangefinder is properly calibrated and functioning.
* Adjust `threshold_m` based on your vehicle's braking distance.
* Test in a safe environment.

## Auto Mode → 90° Left → Fly 200m

### Overview

This script automates a flight sequence: when the vehicle is armed and switched to `AUTO` mode, it calculates a waypoint 200 meters to the left of its initial heading and flies to that waypoint at 20 meters altitude.

### Features

* Automated Trigger: Triggers when the flight mode is set to `AUTO` after arming.
* Relative Calculation: Calculates the waypoint relative to the vehicle's initial position and heading.
* Single Waypoint Mission: Creates a simple mission to fly to the calculated waypoint.
* Altitude Control: Sets the target altitude for the mission.
* GCS Feedback: Sends mission status and waypoint information to the GCS.

### Configuration

The following parameters can be configured by modifying the script:

* Turn angle: The script contains a hardcoded value of 90 degrees for the left turn.
* Flight distance: The script contains a hardcoded value of 200 meters.
* Target altitude: The script contains a hardcoded value of 20 meters.

### Installation

1.  Save the script to your ArduPilot flight controller's SD card.
2.  Enable Lua scripting in ArduPilot (`LUA_ENABLED = 1`).
3.  Reboot the flight controller.

### Usage

1.  Arm the vehicle.
2.  Switch the flight mode to `AUTO`.

### Important Considerations

* Requires a good GPS lock.
* Ensure accurate compass calibration.
* The target altitude is relative to the home altitude.
* The script executes the maneuver only once per arming cycle.

## High Current Monitoring Script

### Overview

This script monitors the total current draw from the vehicle's batteries. If the current exceeds a defined threshold, it sends a critical warning to the GCS.

### Features

* Continuous Current Monitoring: Periodically checks the total current.
* Configurable Threshold: The current threshold can be adjusted in the script.
* Multi-Battery Support: Supports up to two batteries.
* Critical Overcurrent Warning: Sends a high-priority warning to the GCS.
* Debug Information: Sends total current readings and arming status to the GCS.
* Pause on Disarm: Pauses monitoring when the vehicle is disarmed.

### Configuration

The following parameters can be configured within the script:

* `CHECK_INTERVAL_MS`: Interval (milliseconds) for checking the current.
* `CURRENT_THRESHOLD`: Maximum allowed current (Amperes).

### Installation

1.  Save the script to your ArduPilot flight controller's SD card.
2.  Enable Lua scripting in ArduPilot (`LUA_ENABLED = 1`).
3.  Reboot the flight controller.

### Usage

The script automatically starts monitoring the battery current when the vehicle is armed.

### Important Considerations

* The script assumes a maximum of two batteries. Modify the script for more batteries.
* Ensure your current sensors are properly calibrated.
* Set the `CURRENT_THRESHOLD` appropriately for your power system.
* A stable GCS connection is required for receiving warnings.

## General Notes

* All scripts are written in Lua and designed to run on ArduPilot firmware.
* Ensure that Lua scripting is enabled in your ArduPilot configuration.
* Refer to the ArduPilot documentation for more information on Lua scripting and supported functions.
* Test these scripts thoroughly in a safe environment before using them in critical applications.
