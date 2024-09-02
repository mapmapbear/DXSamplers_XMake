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
    add_rules("copyD3D12")

rule("copyD3D12")
    after_build(function (target)
        -- if not os.exists("$(buildir)/windows/x64/debug") then 
        --     os.mkdir("$(buildir)/windows/x64/debug")
        --     print("LOG>>>>>>Create Output Folder Succseeful<<<<<<")
        -- end
        os.cp("$(scriptdir)/bin/*", "$(buildir)/windows/x64/debug")
    end)
    after_clean(function (target) 
        os.rmdir("$(buildir)/windows/x64/debug/D3D12")
        os.rm("$(buildir)/windows/x64/debug/shaders.hlsl")
    end)