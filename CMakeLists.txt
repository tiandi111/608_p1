cmake_minimum_required(VERSION 3.16)
project(p1)

set(CMAKE_CXX_COMPILER /usr/bin/g++)
set(CMAKE_CXX_FLAGS "-std=c++11")

include_directories(.
        /usr/local/include)

add_executable(p1
    db.h
    main.cpp
    ds.h
    ds.cpp
    model.h)

target_link_directories(p1 PUBLIC /usr/local/lib)
target_link_libraries(p1 -lmysqlcppconn8)
