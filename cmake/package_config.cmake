#http://www.cmake.org/Wiki/CMake:CPackConfiguration

#don't write when git errored out resulting in unset version (ie when compiling from tarball)
if(NOT GIT_ERROR)
	configure_file(${springlobby_SOURCE_DIR}/cmake/config.h ${springlobby_BINARY_DIR}/springlobby_config.h)
endif()

set(PACKAGE_NAME springlobby)
set(PACKAGE_VERSION ${SPRINGLOBBY_REV})

if(WIN32)
	set(CPACK_GENERATOR "ZIP")
	set(CPACK_PACKAGE_FILE_NAME "springlobby-${SPRINGLOBBY_REV}-win32")
else()
	set(CPACK_CMAKE_GENERATOR "Unix Makefiles")
	set(CPACK_GENERATOR "TBZ2;TGZ")
	set(CPACK_PACKAGE_FILE_NAME "springlobby-${SPRINGLOBBY_REV}")
endif()
set(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_BINARY_DIR};${CMAKE_PROJECT_NAME};ALL;/")
# set(CPACK_OUTPUT_CONFIG_FILE "/home/andy/vtk/CMake-bin/CPackConfig.cmake")
# set(CPACK_PACKAGE_DESCRIPTION_FILE "/home/andy/vtk/CMake/Copyright.txt")
# set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "CMake is a build tool")
#set(CPACK_PACKAGE_EXECUTABLES "springlobby" "springsettings")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "springlobby")
set(CPACK_PACKAGE_NAME "springlobby")
set(CPACK_PACKAGE_VENDOR "The SpringLobby Team")
set(CPACK_PACKAGE_VERSION ${SPRINGLOBBY_REV})

set(CPACK_RESOURCE_FILE_LICENSE ${springlobby_SOURCE_DIR}/COPYING)
set(CPACK_RESOURCE_FILE_README ${springlobby_SOURCE_DIR}/README)
# set(CPACK_RESOURCE_FILE_WELCOME "/home/andy/vtk/CMake/Templates/CPack.GenericWelcome.txt")
set(CPACK_SOURCE_GENERATOR "TGZ;TBZ2")
# set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "/home/andy/vtk/CMake-bin/CPackSourceConfig.cmake")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "springlobby-${SPRINGLOBBY_REV}")
set(CPACK_STRIP_FILES TRUE)
set(CPACK_SOURCE_STRIP_FILES TRUE)
# set(CPACK_SYSTEM_NAME "Linux-i686")
# set(CPACK_TOPLEVEL_TAG "Linux-i686")
set(CPACK_SOURCE_IGNORE_FILES
"^${springlobby_SOURCE_DIR}/build*"
"^${springlobby_SOURCE_DIR}/bin/"
"^${springlobby_SOURCE_DIR}/.*"
"^${springlobby_SOURCE_DIR}/auto*"
"^${springlobby_SOURCE_DIR}/doc/"
"^${springlobby_SOURCE_DIR}/m4/"
"^${springlobby_SOURCE_DIR}/obj/"
"^${springlobby_SOURCE_DIR}/installer/"
)
include(CPack)
