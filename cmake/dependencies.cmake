cmake_minimum_required(VERSION 2.8)

#Static Openssl
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
set(OPENSSL_USE_STATIC_LIBS ON)
find_package(OpenSSL REQUIRED)
message(STATUS " ${OPENSSL_LIBRARIES}")

#NOOS library
find_package(noos)
message(STATUS "libraries: ${NOOS_STATIC_LIBRARIES}")
message(STATUS "headers: ${NOOS_INCLUDE_DIRS}")

set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")

#ALDEBARAN
if ("${NAOQI_PATH}" STREQUAL "")
    set(NAOQI ${NAOQI} "$ENV{HOME}/naoqi-sdk-2.1.4.13-linux32/")
else()
    set(NAOQI ${NAOQI} ${NAOQI_PATH})
endif()
message(STATUS "Naoqi library path: ${NAOQI}")

set(LIB_PATH ${LIB_PATH} "${NAOQI}/lib")
set(INCLUDE_PATH ${INCLUDE_PATH} "${NAOQI}/include")

find_library(ALPROXIES_LIBRARY NAMES alproxies HINTS ${LIB_PATH})
message(STATUS ${ALPROXIES_LIBRARY})

find_library(ALERROR_LIBRARY NAMES alerror HINTS ${LIB_PATH})
message(STATUS ${ALERROR_LIBRARY})

find_library(ALCOMMON_LIBRARY NAMES alcommon HINTS ${LIB_PATH})
message(STATUS ${ALCOMMON_LIBRARY})

find_library(ALVALUE_LIBRARY NAMES alvalue HINTS ${LIB_PATH})
message(STATUS ${ALVALUE_LIBRARY})

find_library(ALTHREAD_LIBRARY NAMES althread HINTS ${LIB_PATH})
message(STATUS ${ALTHREAD_LIBRARY})

find_library(ALVISION_LIBRARY NAMES alvision HINTS ${LIB_PATH})
message(STATUS ${ALVISION_LIBRARY})

find_library(QI_LIBRARY NAMES qi HINTS ${LIB_PATH})
message(STATUS ${QI_LIBRARY})

find_library(QITYPE_LIBRARY NAMES qitype HINTS ${LIB_PATH})
message(STATUS ${QITYPE_LIBRARY})
include_directories(${INCLUDE_PATH})

find_library(OPENCV_CORE_LIBRARY NAMES opencv_core HINTS ${LIB_PATH})
message(STATUS ${OPENCV_CORE_LIBRARY})
find_library(OPENCV_HIGHGUI_LIBRARY NAMES opencv_highgui HINTS ${LIB_PATH})
message(STATUS ${OPENCV_HIGHGUI_LIBRARY})

#COMMON
find_package(Threads REQUIRED)
find_library(Boost_SYSTEM NAMES boost_system HINTS ${LIB_PATH})
find_library(Boost_THREAD NAMES boost_thread HINTS ${LIB_PATH})
find_library(Boost_CHRONO NAMES boost_chrono HINTS ${LIB_PATH})
set(Boost_LIBRARIES ${Boost_SYSTEM}
                    ${Boost_CHRONO}
                    ${Boost_THREAD})
message(STATUS ${Boost_LIBRARIES})

include_directories("/usr/include"
                    "/usr/local/include"
                    ${INCLUDE_PATH}
                   )

set(NAO_LIBRARIES ${ALPROXIES_LIBRARY}
                  ${ALCOMMON_LIBRARY}
                  ${ALERROR_LIBRARY}
                  ${ALVALUE_LIBRARY}
                  ${ALTHREAD_LIBRARY}
                  ${ALVISION_LIBRARY}
                  ${QI_LIBRARY}
                  ${QITYPE_LIBRARY}
                  ${IMAGE_MODULE}
                  ${OPENCV_CORE_LIBRARY}
                  ${OPENCV_HIGHGUI_LIBRARY})

set(NOOS_LIBRARY ${NOOS_STATIC_LIBRARIES} 
                 ${OPENSSL_LIBRARIES} 
                 ${CMAKE_DL_LIBS}
                 ${Boost_LIBRARIES}
                 ${CMAKE_THREAD_LIBS_INIT})
