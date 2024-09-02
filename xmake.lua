add_rules("mode.debug", "mode.release")
if is_mode("debug") then
    add_defines("DEBUG")
end 
add_ldflags("/subsystem:windows")
add_defines("UNICODE", "_UNICODE")

target("sandbox")
    set_languages("c++17")
    add_files("source/*.cpp")
    add_includedirs("include")
    add_includedirs("3rd/Microsoft.Direct3D.D3D12.1.715.0-preview/build/native/include")
    if is_plat("windows") then
        add_syslinks("user32", "kernel32", "gdi32", "shell32", "dxgi", "d3d12", "d3dcompiler")
    end    