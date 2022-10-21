-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "imu_data_frame",      --tuned: imu_data_frame
  published_frame = "base_link",          --tuned: base_link
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  use_odometry = false,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 0,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 0.2, --def 0.2
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1. ,
  landmarks_sampling_ratio = 1.,
}

TRAJECTORY_BUILDER_3D.num_accumulated_range_data = 1
TRAJECTORY_BUILDER_3D.voxel_filter_size = 0.15    --tuned 0.15 default 0.15
TRAJECTORY_BUILDER_3D.submaps.num_range_data = 25 --tuned:30 default 160
TRAJECTORY_BUILDER_3D.ceres_scan_matcher.translation_weight = 1 --tuned:3/5 def 5.
TRAJECTORY_BUILDER_3D.ceres_scan_matcher.rotation_weight = 1  --tuned:7.5 def 4e2
TRAJECTORY_BUILDER_3D.use_online_correlative_scan_matching = true --(issue 1135) default false 
TRAJECTORY_BUILDER_3D.max_range = 50. --default 60
TRAJECTORY_BUILDER_3D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 50

MAP_BUILDER.use_trajectory_builder_3d = true
MAP_BUILDER.num_background_threads = 6 --tuned 6


POSE_GRAPH.optimization_problem.huber_scale = 5e2  --default 5e2(backpack_3d) 1e1(pose_graph)
POSE_GRAPH.optimization_problem.ceres_solver_options.max_num_iterations = 10 --default 10 
POSE_GRAPH.optimize_every_n_nodes = 320 --def 320 '0' for tuning localSLAM
POSE_GRAPH.constraint_builder.sampling_ratio = 0.2 --tuned0.2 def 0.03(backpack_3d) 0.3(pose_graph)
POSE_GRAPH.constraint_builder.min_score = 0.62 --before 0.8 default 0.62
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.66 --default 0.66
POSE_GRAPH.global_sampling_ratio = 0.002                 --before 0.002 default 0.003
POSE_GRAPH.global_constraint_search_after_n_seconds = 10 --default 10



return options
