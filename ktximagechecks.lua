ktx_tests = {
    {"rgb-mipmap-reference.ktx", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
    {"conftestimage_R11_EAC.ktx", 64, 32, 1, 1, false, "ETC2_EAC_R11_UNORM"},
    {"conftestimage_RG11_EAC.ktx", 64, 32, 1, 1, false, "ETC2_EAC_R11G11_UNORM"},
    {"cubemap_yokohama_astc_8x8_unorm.ktx", 512, 512, 1, 6, true, "ASTC_8x8_UNORM" }, 
    {"cubemap_yokohama_BC3_unorm.ktx", 1024, 1024, 1, 6, true, "DXBC3_UNORM" }, 
    {"cubemap_yokohama_etc2_unorm.ktx", 512, 512, 1, 6, true, "ETC2_R8G8B8_UNORM" }, 
    {"etc1.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8_UNORM" }, 
    {"etc2-rgb.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8_UNORM" }, 
    {"etc2-rgba1.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8A1_UNORM" }, 
    {"etc2-rgba8.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8A8_UNORM" }, 
    {"etc2-sRGB.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8_SRGB" }, 
    {"etc2-sRGBa1.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8A1_SRGB" }, 
    {"etc2-sRGBa8.ktx", 128, 128, 1, 1, false, "ETC2_R8G8B8A8_SRGB" }, 
    {"hi_mark_sq.ktx", 145, 130, 1, 1, false, "R8G8B8_UNORM" }, 
    {"hi_mark.ktx", 180, 94, 1, 1, false, "R8G8B8_UNORM" }, 
    {"luminance-reference-metadata.ktx", 200, 100, 1, 1, false, "R8_UNORM" }, 
--    {"metalplate-amg-rgba8.ktx", 28, 128, 1, 1, false, "ETC2_R8G8B8_UNORM" }, 
--    {"not4_rgb888_srgb.ktx", 28, 128, 1, 1, false, "ETC2_R8G8B8_UNORM" }, 
    {"orient-down-metadata.ktx", 128, 128, 1, 1, false, "R8G8B8_UNORM" }, 
    {"orient-up-metadata.ktx", 128, 128, 1, 1, false, "R8G8B8_UNORM" }, 
    {"orient-up.ktx", 128, 128, 1, 1, false, "R8G8B8_UNORM" }, 
    {"pattern_02_bc2.ktx", 1024, 1024, 1, 1, false, "DXBC2_UNORM" }, 
--    {"rgb-amg-reference.ktx", 28, 128, 1, 1, false, "ETC2_R8G8B8_UNORM" }, 
    {"rgb-mipmap-reference.ktx", 64, 64, 1, 1, false, "R8G8B8_UNORM" }, 
    {"rgb-reference-metadata.ktx", 128, 128, 1, 1, false, "R8G8B8_UNORM" }, 
    {"rgb-reference.ktx", 128, 128, 1, 1, false, "R8G8B8_UNORM" }, 
    {"rgba-reference.ktx", 128, 128, 1, 1, false, "R8G8B8A8_UNORM" }, 
    {"texturearray_astc_8x8_unorm.ktx", 256, 256, 1, 7, false, "ASTC_8x8_UNORM" }, 
    {"texturearray_BC3_unorm.ktx", 256, 256, 1, 7, false, "DXBC3_UNORM" }, 
    {"texturearray_etc2_unorm.ktx", 256, 256, 1, 7, false, "ETC2_R8G8B8_UNORM" }, 
    {"no-npot.ktx", 256, 256, 1, 1, false, "R8G8B8_UNORM"},
}

Xktx_tests = {
    {"rgba-reference.ktx", 128, 128, 1, 1, false, "R8G8B8A8_UNORM" }, 
}

local ktx_tests_count = 0
local ktx_tests_passed = 0

for i,tex in ipairs(ktx_tests) do
    local test = ImageLoadAndSimpleCheck("input/testimages/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
    ktx_tests_count = ktx_tests_count + 1
    if test then
        ktx_tests_passed = ktx_tests_passed + 1
        test:saveAsKTX("artifacts/testimages/"..tex[1])
    end
end

detex_tests = {
    {"test-texture-BC1.ktx", 64, 64, 1, 1, false, "DXBC1_RGB_UNORM"},
    {"test-texture-BC1A.ktx", 64, 64, 1, 1, false, "DXBC1_RGBA_UNORM"},
    {"test-texture-BC2.ktx", 64, 64, 1, 1, false, "DXBC2_UNORM"},
    {"test-texture-BC3.ktx", 64, 64, 1, 1, false, "DXBC3_UNORM"},
    {"test-texture-BPTC_FLOAT.ktx", 64, 64, 1, 1, false, "DXBC6H_UFLOAT"},
    {"test-texture-BPTC.ktx", 64, 64, 1, 1, false, "DXBC7_UNORM"},
    {"test-texture-EAC_R11.ktx", 64, 64, 1, 1, false, "ETC2_EAC_R11_UNORM"},
    {"test-texture-EAC_RG11.ktx", 64, 64, 1, 1, false, "ETC2_EAC_R11G11_UNORM"},
    {"test-texture-EAC_SIGNED_R11.ktx", 64, 64, 1, 1, false, "ETC2_EAC_R11_SNORM"},
    {"test-texture-ETC1.ktx", 64, 64, 1, 1, false, "ETC2_R8G8B8_UNORM"},
    {"test-texture-ETC2_EAC.ktx", 64, 64, 1, 1, false, "ETC2_R8G8B8A8_UNORM"},
    {"test-texture-ETC2_PUNCHTHROUGH.ktx", 64, 64, 1, 1, false, "ETC2_R8G8B8_SRGB"}, -- this is incorrectly saved as non punchthrough
    {"test-texture-ETC2.ktx", 64, 64, 1, 1, false, "ETC2_R8G8B8_UNORM"},
    {"test-texture-FLOAT_RGB16.ktx", 64, 64, 1, 1, false, "R16G16B16_SFLOAT"},
    {"test-texture-FLOAT_RGBA16.ktx", 64, 64, 1, 1, false, "R16G16B16A16_SFLOAT"},
    {"test-texture-RGB8.dds", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
    {"test-texture-RGB8.ktx", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
    {"test-texture-RGBA8.dds", 64, 64, 1, 1, false, "R8G8B8A8_UNORM"},
    {"test-texture-RGBA8.ktx", 64, 64, 1, 1, false, "R8G8B8A8_UNORM"},
    {"test-texture-RGTC1.ktx", 64, 64, 1, 1, false, "DXBC4_UNORM"},
    {"test-texture-RGTC2.ktx", 64, 64, 1, 1, false, "DXBC5_UNORM"},
    {"test-texture-SIGNED_RGTC1.ktx", 64, 64, 1, 1, false, "DXBC4_SNORM"},
    {"test-texture-SIGNED_RGTC2.ktx", 64, 64, 1, 1, false, "DXBC5_SNORM"},
    {"test-texture-transparent.png", 64, 64, 1, 1, false, "R8G8B8A8_UNORM"},
    {"test-texture.png", 64, 64, 1, 1, false, "R8G8B8_UNORM"}
}

Xdetex_tests = {
    {"test-texture-FLOAT_RGB16.ktx", 64, 64, 1, 1, false, "R16G16B16_SFLOAT"},
}

local detex_tests_count = 0
local detex_tests_passed = 0

for i,tex in ipairs(detex_tests) do
    local test = ImageLoadAndSimpleCheck("input/detex/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
    detex_tests_count = detex_tests_count + 1
    if test then
        detex_tests_passed = detex_tests_passed + 1
        test:saveAsKTX("artifacts/testimages/"..tex[1])
    end
end


print("ktx_tests: " .. ktx_tests_passed .." passed out of " .. ktx_tests_count)
print("detex_tests: " .. detex_tests_passed .." passed out of " .. detex_tests_count)
