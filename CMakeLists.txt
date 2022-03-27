cmake_minimum_required(VERSION 3.0)

project(demo)

set(CMAKE_CXX_STANDARD 17)

include(deps.cmake)


add_executable(testbed
    main.cpp
)
target_link_libraries(testbed
    Vulkan::Vulkan
    glfw
    # glm::glm
)

find_program(Glslc NAMES glslc PATHS "/home/zz/soft/vulkansdk/1.1.126.0/x86_64/bin")

if(NOT Glslc)
    message(FATAL_ERROR "failed to find glslc")
else()
    message(STATUS ">>> Glslc is: ${Glslc}")
endif()

# compile the shaders
add_custom_command(TARGET testbed
    PRE_BUILD
    COMMAND ${Glslc} ${CMAKE_SOURCE_DIR}/shaders/shader.vert -o ${CMAKE_BINARY_DIR}/shader.vert.spv
    COMMAND ${Glslc} ${CMAKE_SOURCE_DIR}/shaders/shader.frag -o ${CMAKE_BINARY_DIR}/shader.frag.spv
)
