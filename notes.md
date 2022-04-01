## 1. android 设备上的 vulkan 库文件位置？
/system/lib/libvulkan.so

/system/lib 目录下还有很多常见库可用：
- libz.so
- libyuv.so
- libion.so
- libjnigraphics.so
- libjpeg.so
- liblog.so
- libstdc++.so
- libsqlite.so
- libssl.so
- libtflite.so
- libtinyxml2.so
- libziparchive.so

## 2. android 官方关于 vulkan 的介绍文档?
https://developer.android.google.cn/ndk/guides/graphics

### 2.1 第一个 demo
https://github.com/LunarG/VulkanSamples.git
尝试按编译android步骤执行，期间执行下载glsl还是什么一个工具，下载失败。放弃。
```
(base) ➜  build git:(master) ✗ cmake ..
-- Using local loader
-- Using find_package to locate Vulkan
-- Vulkan FOUND = TRUE
-- Vulkan Include = /usr/local/include
-- Vulkan Lib = /usr/local/lib/libvulkan.dylib
-- Using cmake find_program to look for glslangValidator
   Downloading glslangValidator binary from glslang releases dir
CMake Error at CMakeLists.txt:174 (message):
  Must define location of vulkan headers -- see BUILD.md
```

实际上 lunarg 版已经不维护， 维护更新版本在：
https://github.com/KhronosGroup/Vulkan-Samples
这次直接编 mac 平台的， 没编 ndk 的

## 2.2 .vert 和 .frag 是特定类型文件的后缀名
看起来是 vertex 和 fragment 的缩写。
反正不是 vertical 的意思。
也就意味着不能随便乱改名字。

## 2.3 再次尝试 VulkanSamples/API-Samples
```bash
cd /Users/chris/work/VulkanSamples/API-Samples
cmake . -DVULKAN_HEADERS_INSTALL_DIR=$VULKAN_SDK/include/vulkan -DANDROID=ON -DABI_NAME=arm64-v8a

cd android
python3 compile_shaders.py # 这一步又失败了。
```

就很离谱，这下载为什么一动不动？看了 compile_shaders.py 发现内容简单。改掉查找的路径： 

```
import os, subprocess, platform, sys
script = os.path.join("..", "..", "scripts", "generate_spirv.py")
! #validator = os.path.join("..", "..", "glslang", "bin", "glslangValidator")
! validator = os.path.join("/usr/local/bin", "glslangValidator")
! #assembler = os.path.join("..", "..", "spirv-tools", "bin", "spirv-as")
! assembler = os.path.join("/usr/local/bin, "spirv-as")
```


设置？ 感觉没卵用
```
export ANDROID_SDK_ROOT=$ANDROID_SDK
export ANDROID_NDK_HOME=$ANDROID_NDK
```

需要准备 AS， 并且安装 bundle 版本的 NDK.

然后还需要手动在 build.gradle 添加 
```groovy
task wrapper(type: Wrapper){
   gradleVersion = '7.2'
}
```

