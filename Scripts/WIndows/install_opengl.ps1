# Create the OpenGL directory if it doesn't exist
if (-not (Test-Path -Path "C:\OpenGL" -PathType Container)) {
  New-Item -ItemType Directory -Path "C:\OpenGL"
}

# Create the vcpkg directory if it doesn't exist
if (-not (Test-Path -Path "C:\vcpkg" -PathType Container)) {
  New-Item -ItemType Directory -Path "C:\vcpkg"
}

# Change directory to C:\
cd C:\

# Clone the vcpkg repository into C:\vcpkg
git clone https://github.com/microsoft/vcpkg.git C:\vcpkg

# Change directory to the vcpkg folder
cd C:\vcpkg

# Bootstrap vcpkg
.\bootstrap-vcpkg.bat

# --- Install GLFW and GLEW, specifying the installation root ---

# Install GLFW and GLEW (both static and dynamic, 64-bit),
#  using --x-install-root to put the installed files in C:\OpenGL
.\vcpkg install glfw3:x64-windows --x-install-root="C:\OpenGL"
.\vcpkg install glfw3:x64-windows-static --x-install-root="C:\OpenGL"
.\vcpkg install glew:x64-windows --x-install-root="C:\OpenGL"
.\vcpkg install glew:x64-windows-static --x-install-root="C:\OpenGL"

Write-Host "Installation complete. Remember to configure your Visual Studio projects manually."
Write-Host "Include Directories (add to Project Properties -> VC++ Directories -> Include Directories):"
Write-Host "  C:\OpenGL\installed\x64-windows\include"
Write-Host "  C:\OpenGL\installed\x64-windows-static\include"
Write-Host "Library Directories (add to Project Properties -> VC++ Directories -> Library Directories):"
Write-Host "  C:\OpenGL\installed\x64-windows\lib"
Write-Host "  C:\OpenGL\installed\x64-windows-static\lib"
Write-Host "Additional Dependencies (add to Project Properties -> Linker -> Input -> Additional Dependencies):"
Write-Host "  For dynamic linking:  glfw3.lib;glew32.lib;opengl32.lib"
Write-Host "  For static linking:  glfw3.lib;glew32s.lib;opengl32.lib (and define GLEW_STATIC)"
Write-Host "For dynamic linking, copy glfw3.dll and glew32.dll to your .exe directory or a directory in your PATH."
Write-Host "You can find them in C:\OpenGL\installed\x64-windows\bin"
Write-Host "For static, remember to turn off Auto-Link and select 'x64-windows-static' triplet in vcpkg project settings."