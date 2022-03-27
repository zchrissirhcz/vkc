# --- vulkan
find_package(Vulkan QUIET)
if(NOT Vulkan_FOUND)
    message(STATUS "=== CMAKE_SYSTEM_NAME is: ${CMAKE_SYSTEM_NAME}")
    if(DEFINED ENV{VULKAN_SDK})
        if(CMAKE_SYSTEM_NAME MATCHES "Linux")
            list(APPEND CMAKE_MODULE_PATH "$ENV{VULKAN_SDK}/../source/VulkanTools/cmake")
        elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
            list(APPEND CMAKE_MODULE_PATH "$ENV{VULKAN_SDK}/Samples/cmake")
        elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
            message(WARNING "Failed to find vulkan since cmake too old\n"
                "cmake >= 3.7 required. Consider `brew upgrade cmake`")
        endif()
    else()
        message(FATAL_ERROR "!! CMake didn't find Vulkan. Please set VULKAN_SDK env var, e.g.:\n"
            "Linux: export VULKAN_SDK=~/soft/vulkansdk/1.2.148.0/x86_64\n"
            "Windows: set VULKAN_SDK=E:/lib/VulkanSDK/1.2.148.0\n"
            "MacOS: export VULKAN_SDK=~/soft/vulkansdk/1.2.148.0/macOS\n"
        )
    endif()
    find_package(Vulkan REQUIRED)
endif()

message(STATUS "--- Vulkan_FOUND: ${Vulkan_FOUND}")
message(STATUS "--- Vulkan_LIB: ${Vulkan_LIB}")
message(STATUS "--- Vulkan_INCLUDE_DIR: ${Vulkan_INCLUDE_DIR}")
message(STATUS "--- Vulkan_LIBRARY: ${Vulkan_LIBRARY}")


# --- glfw
set(glfw3_DIR "/home/zz/artifacts/glfw/3.3.6/linux-x64/lib/cmake/glfw3")
find_package(glfw3 QUIET) # 3.3-stable branch recommended
if(glfw3_FOUND)
  message(STATUS "[Found glfw3] glfw3_DIR is ${glfw3_DIR}")
else()
  message(STATUS "[Not Found glfw3]")
  message(STATUS "Please remove cmake build cache, then:")
  message(STATUS "* If already installed glfw3, please set glfw3_DIR in one of:")
  message(STATUS "      file CMakeLists.txt, before `find_package(glfw3)`")
  message(STATUS "      file build/xxx.cache.cmake")
  message(STATUS "      file build/xxx.{sh,cmd}, with -Dglfw3_DIR=/path/to/glfw3Config.cmake")
  message(STATUS "      You may get inspired from build/xxx.cache.cmake :)")
  message(STATUS "* If not installed glfw3, may install binary via:")
  message(STATUS "      sudo apt install libglfw3-dev  # ubuntu")
  message(STATUS "      brew install glfw              # mac")
  message(STATUS "      vcpkg install glfw             # windows")
  message(STATUS "* You may also build and install glfw3 manually, e.g")
  message(STATUS "      git clone https://gitee.com/mirrors/glfw -b 3.3-stable glfw-3.3-stable")
  message(STATUS "      cd glfw-3.3-stable && mkdir build && cd build")
  message(STATUS "      cmake .. -DCMAKE_INSTALL_PREFIX=./install && cmake --build . && cmake --install .")
  message(STATUS "      then set glfw3_DIR before `find_package(glfw3)`")
  message(FATAL_ERROR "")
endif()


# --- glm
set(glm_DIR "/home/zz/artifacts/glm")
find_package(glm REQUIRED)