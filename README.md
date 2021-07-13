# bir3_husky
How to run Husky+UR5 simulation:

Step 1: Clone git repositories to <your ros_ws>/src
  git clone https://github.com/uob-erl/bir03_husky.git
  git clone https://github.com/uob-erl/husky_manipulation.git
  git clone https://github.com/ros-industrial/universal_robot.git
  git clone https://github.com/uob-erl/husky.git

Step 2: Modify universal_robot pkg
  1. Go to src/universal_robot/ur_gazebo/controller/arm_controller_ur5.yaml and delet everything and paste the following:

	arm_controller:
	  type: position_controllers/JointTrajectoryController
	  joints:
	     - ur_arm_shoulder_pan_joint
	     - ur_arm_shoulder_lift_joint
	     - ur_arm_elbow_joint
	     - ur_arm_wrist_1_joint
	     - ur_arm_wrist_2_joint
	     - ur_arm_wrist_3_joint
	  constraints:
	      goal_time: 0.6
	      stopped_velocity_tolerance: 0
	      ur_arm_shoulder_pan_joint: {trajectory: 0.1, goal: 0.1}
	      ur_arm_shoulder_lift_joint: {trajectory: 0.1, goal: 0.1}
	      ur_arm_elbow_joint: {trajectory: 0.1, goal: 0.1}
	      ur_arm_wrist_1_joint: {trajectory: 0.1, goal: 0.1}
	      ur_arm_wrist_2_joint: {trajectory: 0.1, goal: 0.1}
	      ur_arm_wrist_3_joint: {trajectory: 0.1, goal: 0.1}
	  stop_trajectory_duration: 0.5
	  state_publish_rate:  25
	  action_monitor_rate: 10
	joint_group_position_controller:
	  type: position_controllers/JointGroupPositionController
	  joints:
	     - ur_arm_shoulder_pan_joint
	     - ur_arm_shoulder_lift_joint
	     - ur_arm_elbow_joint
	     - ur_arm_wrist_1_joint
	     - ur_arm_wrist_2_joint
	     - ur_arm_wrist_3_joint

  2. Go to src/universal_robot/ur_description/urdf, modify ur5.urdf.xacro in section "<joint name="${prefix}shoulder_lift_joint" type="revolute">", 
	change <origin xyz="0.0 ${shoulder_offset} 0.0" rpy="0.0 £{pi /2} 0.0" /> 
	to <origin xyz="0.0 ${shoulder_offset} 0.0" rpy="0.0 0.0 0.0" />
     This is actually changeing the initial position of UR5 arm. If don't do this, the Gazebo will run into conllision bug. Any change to a valid position are acceptable.

Step 3: Use launch file
  1. Use moveit!: roslaunch bir03_moveit demo_gazeo.launch
  2. Do not use moveit!: roslaunch bir03_husky_launch bir03_gazebo.launch

