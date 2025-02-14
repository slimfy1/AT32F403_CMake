# **Artery AT32F403 Cmake Template**
![](img/artery.png )
<img src="img/cmake.png" width="65" />
## Project information

**AT32 Firmware version: 2.2.0 (latest on 06.01.2024)**

## Building
To build project use Cmake command:

`--build "path\to\folder" --target AT32F403ACGU7_Cmake.elf -j 18`

Replace "path\to\folder" to your path. For example:

`Windows: cmake --build D:\MCU_Tests\AT32Test\AT32F403ACGU7_Cmake\cmake-build-debug --target AT32F403ACGU7_Cmake.elf -j 18`

## Change MCU

To change MCU you need to change linker file (*.ld ) in root of project

Latest linker files store in _{$PROJECT_ROOT}/middlewares/libraries/cmsis/cm4/device_support/startup/gcc/linker_

After changing linking file you need to edit _CMakeLists.txt_

Example:

Lets change to AT32F403AxC MCU

`set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/AT32F403AxG_FLASH.ld)` change to `set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/AT32F403AxC_FLASH.ld)`

Your CMakeLists.txt must look like this after editing:

`set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/AT32F403AxC_FLASH.ld)`

## Middlewares

All middlewares store in _{$PROJECT_ROOT}/middlewares/_

If you need this middlewares in your project you need to include them in CMakeList.txt in _include_directories_ section
## License

BSD 3-Clause License

Copyright (c) 2022, Artery-MCU
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.