cmake_minimum_required(VERSION 3.10)
project(obfuscation_controller LANGUAGES CXX)

# The name of the executable created for the application. Change this to change
# the on-disk name of your application.
set(BINARY_NAME "obfuscation_controller")

# Set the flavor environment variable if not already set.
if(NOT DEFINED ENV{FLAVOR})
  set(ENV{FLAVOR} "dev")
endif()
set(FLAVOR "$ENV{FLAVOR}")

# Define the Flutter target based on the flavor.
set(FLUTTER_TARGET "${CMAKE_CURRENT_SOURCE_DIR}/../lib/environment/profile/main_obfuscation_controller_${FLAVOR}.dart")

# Locate the Flutter SDK and setup the Flutter environment.
set(FLUTTER_ROOT "$ENV{FLUTTER_ROOT}")
if(NOT FLUTTER_ROOT)
  message(FATAL_ERROR "FLUTTER_ROOT environment variable not set")
endif()
list(APPEND CMAKE_MODULE_PATH "${FLUTTER_ROOT}/cmake")
include(Flutter)

# Set the output directory for the generated files.
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_BINARY_DIR}/flutter")

# Define the build modes (Debug, Profile, Release).
set(FLUTTER_BUILD_MODES "Debug;Profile;Release")
foreach(MODE ${FLUTTER_BUILD_MODES})
  add_custom_target(${MODE}
    COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=${MODE} .
    COMMAND ${CMAKE_COMMAND} --build .
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endforeach()

# Set the application icon based on the flavor
if(FLAVOR STREQUAL "dev")
  set(APP_ICON_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../assets/image/app_icon_obfuscation_controller_dev.png")
  set(APP_NAME "Obfuscation Controller (Dev)")
elseif(FLAVOR STREQUAL "stage")
  set(APP_ICON_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../assets/image/app_icon_obfuscation_controller_stage.png")
  set(APP_NAME "Obfuscation Controller (Stage)")
elseif(FLAVOR STREQUAL "prod")
  set(APP_ICON_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../assets/image/app_icon_obfuscation_controller_prod.png")
  set(APP_NAME "Obfuscation Controller")
else()
  message(FATAL_ERROR "Unknown FLAVOR: ${FLAVOR}")
endif()

# Add a custom command to copy the app icon to the build directory
add_custom_command(
  TARGET ${BINARY_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_if_different
  "${APP_ICON_PATH}"
  "${CMAKE_BINARY_DIR}/app_icon.png"
)

# Configure the application build.
add_executable(${BINARY_NAME} "${FLUTTER_MANAGED_DIR}/main.cc")
flutter_target_create(${BINARY_NAME} ${FLUTTER_TARGET})

# Link the Flutter libraries.
target_link_libraries(${BINARY_NAME} PRIVATE flutter)

# Copy the assets directory into the build directory.
add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory
  "${PROJECT_SOURCE_DIR}/assets"
  "${CMAKE_BINARY_DIR}/assets")

# Install the application.
install(TARGETS ${BINARY_NAME} DESTINATION "${CMAKE_INSTALL_PREFIX}")

# Install the app icon
install(FILES "${APP_ICON_PATH}" DESTINATION "${CMAKE_INSTALL_PREFIX}")

# Set up the AOT libraries for non-Debug builds.
if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
  install(FILES "${AOT_LIBRARY}" DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()
