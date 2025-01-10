set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
cmake_minimum_required(VERSION 3.22)

# Compiler set
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_AR arm-none-eabi-ar)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Project config
project(AT32F403ACGU7_Cmake C CXX ASM)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)

# Compiler options
add_compile_options(-mcpu=cortex-m4 -mthumb -mthumb-interwork)
add_compile_options(-ffunction-sections -fdata-sections -fno-common -fmessage-length=0)
# Uncomment for hardware floating point
#add_compile_definitions(ARM_MATH_CM4;ARM_MATH_MATRIX_CHECK;ARM_MATH_ROUNDING)
#add_compile_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)
#add_link_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)

# Uncomment for software floating point
add_compile_options(-mfloat-abi=soft)

# Assembler options
add_compile_options($<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>)

# Optimization settings
add_compile_options(-O0 -g)

# Директории для включаемых файлов
include_directories(
        inc
        Drivers/cmsis/cm4/core_support
        Drivers/cmsis/cm4/device_support
        Drivers/drivers/inc
)

# Project macros and defines
add_definitions(-DDEBUG -DAT_START_F403A_V1 -DAT32F403ACGU7 -DUSE_STDPERIPH_DRIVER -DOS_USE_TRACE_SEMIHOSTING_DEBUG -DTRACE)

# Set global sources
file(GLOB_RECURSE SOURCES
        "src/*.*"
        "Drivers/*.*")
# Add libraries
file(GLOB_RECURSE LIB_SOURCES "Libraries/MyLib/*.c")
include_directories(Libraries/MyLib)

# Set linker script
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/AT32F403AxG_FLASH.ld)

# Linker options
add_link_options(
        -Wl,-gc-sections,--print-memory-usage,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map
        -mcpu=cortex-m4 -mthumb -mthumb-interwork
        -Wl,--no-warn-rwx-segments
        -specs=nano.specs -lc -lgcc -lm -lrdimon
        -specs=nosys.specs
        -T ${LINKER_SCRIPT}
)

# Set exe file
add_executable(${PROJECT_NAME}.elf ${SOURCES} ${LIB_SOURCES} ${LINKER_SCRIPT})

# Path to HEX and BIN
set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)

# Commant to create HEX and BIN
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} and ${BIN_FILE}"
)
