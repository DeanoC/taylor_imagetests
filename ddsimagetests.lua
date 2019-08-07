tacit_texview_tests = {
    {"CubemapLayoutGuide.dds", 512, 512, 1, 6, true, "BC1_RGBA_UNORM_BLOCK"},
    {"Gradient.tga", 640, 480, 1, 1, false, "R8G8B8_UNORM"},
    {"SkyBack.jpg", 1024, 1024, 1, 1, false, "R8G8B8_UNORM"},
    {"SkyBottom.gif", 1024, 1024, 1, 1, false, "R8G8B8A8_UNORM"},
    {"SkyFront.jpg", 512, 512, 1, 1, false, "R8G8B8_UNORM"},
    {"SkyLeft.jpg", 1024, 1024, 1, 1, false, "R8G8B8_UNORM"},
    --{"SkyRight.tiff", 1024,1024, 1, 1, false, "R8G8B8A8_UNORM"},
    {"SkyTop.jpg", 1024, 1024, 1, 1, false, "R8G8B8_UNORM"},
    {"TactileConceptDevelopment.jpg", 1024, 470, 1, 1, false, "R8G8B8_UNORM"},
    {"TestDXT1.dds", 256, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    {"TestDXT1BA.dds", 256, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    {"TestDXT3.dds", 256, 128, 1, 1, false, "BC2_UNORM_BLOCK"},
    {"TestDXT5.dds", 256, 128, 1, 1, false, "BC3_UNORM_BLOCK"},
    {"TestFP32.dds", 256, 128, 1, 1, false, "R32_SFLOAT"},
    {"TestR5G6B5.dds", 256, 128, 1, 1, false, "B5G6R5_UNORM_PACK16"},
    {"TestR8G8B8.dds", 256, 128, 1, 1, false, "B8G8R8_UNORM"},
    {"TextCursor.png", 512, 256, 1, 1, false, "R8G8B8_UNORM"},
    {"Xeyes.png", 128, 128, 1, 1, false, "R8G8B8A8_UNORM"},
}

tacit_texview_tests = {
}
local tacit_texview_tests_count = 0
local tacit_texview_tests_passed = 0

for i,tex in ipairs(tacit_texview_tests) do
    local test = ImageLoadAndSimpleCheck("input/tacit-texview/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
--    test:saveAsDDS("artifacts/openil-dds-testimages/"..tex[1])
    tacit_texview_tests_count = tacit_texview_tests_count + 1
    if test then
        tacit_texview_tests_passed = tacit_texview_tests_passed + 1
    end
end

block_compression_rs_tests = {
    {"rust-bc1-linear-no-mipmaps.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    {"rust-bc1-srgb-dx10-no-mipmaps.dds", 256, 256, 1, 1, false, "BC1_RGBA_SRGB_BLOCK"},
    {"rust-uncomp-no-mipmaps.dds", 256, 256, 1, 1, false, "R8G8B8A8_UNORM"},
}

block_compression_rs_tests = {
}
local block_compression_rs_tests_count = 0
local block_compression_rs_tests_passed = 0

for i,tex in ipairs(block_compression_rs_tests) do
    local test = ImageLoadAndSimpleCheck("input/block-compression-rs/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
--    test:saveAsDDS("artifacts/openil-dds-testimages/"..tex[1])
    block_compression_rs_tests_count = block_compression_rs_tests_count + 1
    if test then
        block_compression_rs_tests_passed = block_compression_rs_tests_passed + 1
    end
end

-- some of these tests are named and use D3D_FORMAT enum which is backwards to modern enums
--  so a16b16g16r16 is actually R16G16B816A16_UNORM in modern terms
dds_tests = {
    {"DDS_a1r5g5b5.dds", 200, 286, 1, 1, false, "B5G5R5A1_UNORM_PACK16"},
    {"DDS_a2b10g10r10.dds", 200, 286, 1, 1, false, "A2B10G10R10_UNORM_PACK32"},
    {"DDS_a2r10g10b10.dds", 200, 286, 1, 1, false, "A2R10G10B10_UNORM_PACK32"},
    {"DDS_a2w10v10u10.dds", 200, 286, 1, 1,false, "A2R10G10B10_SNORM_PACK32" }, 
    {"DDS_a4l4.dds", 200, 286, 1, 1, false, "R4G4_UNORM_PACK8" }, 
    {"DDS_a4r4g4b4.dds", 200, 286, 1, 1, false, "A4R4G4B4_UNORM_PACK16" }, 
    {"DDS_a8.dds", 200, 286, 1, 1, false, "A8_UNORM" }, 
    {"DDS_a8b8g8r8.dds", 200, 286, 1, 1, false, "R8G8B8A8_UNORM" }, 
    {"DDS_a8l8.dds", 200, 286, 1, 1, false, "R8G8_UNORM" }, 
    {"DDS_a8p8.dds", 200, 286, 1, 1, false, "B8G8R8A8_UNORM" },  -- this *IS NOT* a paleltted DDS is just ARGB8
    {"DDS_a8r3g3b2.dds", 200, 286, 1, 1, false, "B2G3R3A8_UNORM_PACK16" }, 
    {"DDS_a8r8g8b8.dds", 200, 286, 1, 1, false, "B8G8R8A8_UNORM" }, 
    {"DDS_a16b16g16r16.dds", 200, 286, 1, 1, false, "R16G16B16A16_UNORM"},
    {"DDS_a16b16g16r16f.dds", 200, 286, 1, 1, false, "R16G16B16A16_SFLOAT"},
    {"DDS_a32b32g32r32f.dds", 200, 286, 1, 1, false, "R32G32B32A32_SFLOAT"},
--    {"DDS_cxv8u8.dds", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
--    {"DDS_d16_lockable.dds", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
--    {"DDS_d32f_lockable.dds", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
    {"DDS_dxt1.dds", 200, 288, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    {"DDS_dxt2.dds", 200, 288, 1, 1, false, "BC2_UNORM_BLOCK"},
    {"DDS_dxt3.dds", 200, 288, 1, 1, false, "BC2_UNORM_BLOCK"},
    {"DDS_dxt4.dds", 200, 288, 1, 1, false, "BC3_UNORM_BLOCK"},
    {"DDS_dxt5.dds", 200, 288, 1, 1, false, "BC3_UNORM_BLOCK"},
--    {"DDS_g8r8_g8b8.dds", 64, 64, 1, 1, false, "R8G8B8_UNORM"},
    {"DDS_g16r16.dds", 200, 286,  1, 1, false, "R16G16_UNORM"},
    {"DDS_g16r16f.dds", 200, 286,  1, 1, false, "R16G16_SFLOAT"},
    {"DDS_g32r32f.dds", 200, 286,  1, 1, false, "R32G32_SFLOAT"},
--    {"DDS_l6v5u5.dds", 200, 286,  1, 1, false, "R8G8B8_UNORM"},
    {"DDS_l8.dds", 200, 286,  1, 1, false, "R8_UNORM"},
    {"DDS_l16.dds", 200, 286,  1, 1, false, "R16_UNORM"},
    {"DDS_p8.dds", 200, 286,  1, 1, false, "A8R8G8B8_UNORM_PACK32"}, -- this *IS NOT* a paleltted DDS is just ARGB8
    {"DDS_q8w8v8u8.dds", 200, 286,  1, 1, false, "A8B8G8R8_SNORM_PACK32"},
    {"DDS_q16w16v16u16.dds", 200, 286,  1, 1, false, "R16G16B16A16_SNORM"},
    {"DDS_r3g3b2.dds", 200, 286, 1, 1, false, "B2G3R3_UNORM_PACK16" }, 
    {"DDS_r5g6b5.dds", 200, 286,  1, 1, false, "R5G6B5_UNORM_PACK16"},
--    {"DDS_r8g8_b8g8.dds", 200, 286,  1, 1, false, "R8G8B8_UNORM"},
    {"DDS_r8g8b8.dds", 200, 286,  1, 1, false, "B8G8R8_UNORM"},
    {"DDS_r16f.dds", 200, 286,  1, 1, false, "R16_SFLOAT"},
    {"DDS_r32f.dds", 200, 286,  1, 1, false, "R32_SFLOAT"},
--    {"DDS_uyvy.dds", 200, 286,  1, 1, false, "R8G8B8_UNORM"},
    {"DDS_v8u8.dds", 200, 286,  1, 1, false, "R8G8_SNORM"},
    {"DDS_v16u16.dds", 200, 286,  1, 1, false, "R16G16_SNORM"},
    {"DDS_x1r5g5b5.dds", 200, 286,  1, 1, false, "B5G5R5A1_UNORM_PACK16"},
    {"DDS_x4r4g4b4.dds", 200, 286,  1, 1, false, "A4R4G4B4_UNORM_PACK16"},
    {"DDS_x8b8g8r8.dds", 200, 286,  1, 1, false, "A8B8G8R8_UNORM_PACK32"},
    {"DDS_x8l8v8u8.dds", 200, 286, 1, 1, false, "A8B8G8R8_SNORM_PACK32"},
--    {"DDS_yuy2.dds", 200, 286,  1, 1, false, "R8G8B8_UNORM"},
    {"EnvCubicSpecA.dds", 128, 128,  1, 6, true, "BC3_UNORM_BLOCK"},
}

dds_tests = {
    {"DDS_p8.dds", 200, 286,  1, 1, false, "A8R8G8B8_UNORM_PACK32"}, -- this *IS NOT* a paleltted DDS is just ARGB8
}

local openil_dds_tests_count = 0
local openil_dds_tests_passed = 0

for i,tex in ipairs(dds_tests) do
    local test = ImageLoadAndSimpleCheck("input/openil-dds-testimages/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
--    test:saveAsDDS("artifacts/openil-dds-testimages/"..tex[1])
    openil_dds_tests_count = openil_dds_tests_count + 1
    if test then
        openil_dds_tests_passed = openil_dds_tests_passed + 1
    end
end

dx_tests = {
    { "Back_Alley_box _norm_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Back_Alley_box_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Back_Alley_Drum _norm_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Back_Alley_Drum.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "ball.dds",256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "bark_v1_tex.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "basket_map.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "brass.dds", 16, 16, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Broken_Pillar_Diff_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Broken_Pillar_Norm_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Catwalk_02_Diffuse512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Catwalk_03_Diffuse_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Catwalk_03_Normal_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "city.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "colorgradient.dds", 256, 1, 1, 1, false, "B8G8R8_UNORM"},
    { "column.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "command_a.dds", 768, 768, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "con_edge.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "container_grn_num.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "container_gry_num.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "container_hab_num.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "container_orn_num.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "cookie.dds", 512, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "crane_light.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crane_wheel.dds", 128, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_clamp_a.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_a.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_c.dds", 512, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_d.dds", 512, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_e.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_f.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_g.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "crn_pan_i.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "default.dds", 1, 1, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "desert_sky.dds", 2048, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Door_Diff_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Door_Norm_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "dry_flowers_v1_tex.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "dxutcontrols.dds", 256, 256, 1, 1, false, "A8B8G8R8_UNORM_PACK32"},
    { "ele_bot.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "ele_floor.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "ele_support.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "ele_track_a.dds", 256, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "fan_blde.dds", 256, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "fan_housing_b.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "fan_hub.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "floor_Diff_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "floor_Normal_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Font.dds", 950, 20, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "gameCrates_01_Diff_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "gameCrates_01_Nor_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "gameCrates_02_Diff_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "gameCrates_03_Diff_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "gameCrates_03_Nor_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Golfclub_dm_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Golfclub_nm_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "gr_trans_b.dds",256, 256, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "grass_guide_v3_tex.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "grass_turf_v2_tex.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "grass_v1_basic_tex.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "grass_v2_light_tex.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "grass_v3_dark_tex.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "gravel_a.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "gravel_c.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "ground_diff.dds", 1024, 1024, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "ground_norm.dds", 32, 32, 1, 1, false, "B8G8R8_UNORM"},
    { "grt_sm_a.dds", 256, 256, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "grt_sm_b.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Hanghing Light_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Hanghing Light_normal_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Hanging_bundle_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Hanging_bundle_marble_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Hanging_bundle_marble_normal_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Hanging_bundle_normal_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "hats_01_diff_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "hats_01_norm_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "hats_02_diff_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "hats_02_norm_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "head_diff.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "head_norm.dds", 2048, 2048, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "head_spec.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "hill_mound_b.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "holetex.dds", 512, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "hud.dds", 800, 600, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "hz_a.dds", 256, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "island_v1_tex.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "leaf_v3_dark_tex.dds", 512, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "leaf_v3_green_tex.dds", 512, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "leaf_v3_olive_tex.dds", 512, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "left_engine_diff.dds", 1024, 1024, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "left_engine_norm.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "LobbyCube.dds", 256, 256, 1, 6, true, "BC1_RGBA_UNORM_BLOCK"},
    { "marbel drum texture _Nrml_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "marbel drum texture_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "MarbleClouds.dds", 512, 512, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "mav_a_ring.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "mav_b_body.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "mav_b_lit.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_1_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_1_normal_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_2 1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_2_normal1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_3_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_3_2048.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Misc_Boss_3_normal_1024.dds", 1024, 1024, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "Misc_Boss_3_normal2048R.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "monsterfrog.dds", 512, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "msd_MicrosoftCharacterMaya100_heroChr_bodyCM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_bodyNM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_bodySM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_headCM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_HeadNM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_headSM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_mechanicalCM_tga_001.dds", 1024, 1024, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_mechanicalNM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "msd_MicrosoftCharacterMaya100_heroChr_mechanicalSM_tga_001.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "normtest.dds", 512, 512, 1, 1, false, "R32G32B32A32_SFLOAT"},
    { "pad_big_b.dds", 1280, 1280, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "pad_pan_a.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "particle.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "pillar_Diff_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "pillar_Norm_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "pipe_a.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "pipe_b.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "pipe_d.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "pipe_e.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "RaceCar_Strorage_Diff512.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "RaceCar_Strorage_Norm512.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "rail.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "re_bar_a.dds", 256, 256, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "re_bar_trans.dds", 256, 256, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "red_girder_a.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "RifleStock1.dds", 748, 600, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "RifleStock1Bump.dds", 748, 600, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "ring_a.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "road_end_a.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "road_end_b.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "road_end.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "road_loop_a.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "road_st_a.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Roof_Diff1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Roof_Normal1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "roomtex.dds", 1024, 1024, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "scanner.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "seafloor.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves2_diff_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves2_diff1_512.dds",512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves2_diff2_512.dds",512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves2_nm1_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves2_nm2_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves2_nor_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves3_diff_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "shelves3_nor_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "sky_v2b_tex.dds", 4096, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Sliding Steel Door_Diff_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Sliding Steel Door_Norm_512.dds", 512, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "sm_pan_a.dds", 256, 128, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "smokevol1.dds", 128, 128, 64, 1, false, "BC3_UNORM_BLOCK"},
    { "squard room platform_1_diff_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "squard room platform_1_norm_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "squard room platform_2_diff_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "squard room platform_2_norm_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "squard room platform_3_diff_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "squard room platform_3_norm_512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Stack_ Boxes_Diff01_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Stack_ Boxes_Diff02_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Stack_ Boxes_Diff03_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Stack_ Boxes_Nm01_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Stack_ Boxes_Nm02_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Stack_ Boxes_Nm03_1024.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "tank_side.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "tank_top.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "test_ground_b.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "Tiny_skin.dds", 256, 256, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "tow_rib_ a.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "tow_rib_c.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "trench_b.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "trench_end.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "trench_surround.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "truss_a.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "truss_end.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "turret_diff.dds", 1024, 1024, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "turret_norm.dds", 2048, 2048, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "tw_tex_a.dds", 1024, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "uffizi_cross.dds", 512, 512, 1, 6, true, "R16G16B16A16_SFLOAT"},
    { "uffizi_cross32.DDS", 512, 512, 1, 6, true, "R32G32B32A32_SFLOAT"},
    { "walkway_a.dds", 256, 256, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wall_tex_a.dds", 824, 824, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wall_tex_b.dds", 824, 824, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wall01_Diff_2048.dds", 2048, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wall01_Normal_2048.dds", 2048, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wall03_Diff_2048.dds", 2048, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wall03_Normal_2048.dds", 2048, 1024, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "wheel_house.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "white.dds", 16, 16, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "window_Diff512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "window_Norm512.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "yellow_girder_a.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
}
Xdx_tests = {
}

local dx_tests_count = 0
local dx_tests_passed = 0
for i,tex in ipairs(dx_tests) do

    local test = ImageLoadAndSimpleCheck("input/dx_examples/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
 --   test:saveAsDDS("artifacts/dx_examples/"..tex[1])
    dx_tests_count = dx_tests_count + 1

    if test then
        dx_tests_passed = dx_tests_passed + 1
    end
end

cubemapgen_tests = {
    { "Animus128.dds", 128, 128, 1, 6, true, "B8G8R8_UNORM"},
    { "AnimusSharp128.dds", 128, 128, 1, 6, true, "B8G8R8_UNORM"},
    { "BlueSky512.dds", 512, 512, 1, 6, true, "B8G8R8_UNORM"},
    { "Chrome128.dds", 128, 128, 1, 6, true, "B8G8R8_UNORM"},
    { "Dome128.dds", 128, 128, 1, 6, true, "B8G8R8_UNORM"},
    { "Earth_BurnishedLand.dds", 1024, 512, 1, 1, false, "A8R8G8B8_UNORM_PACK32"},
    { "GalileoConeFiltered.dds", 128, 128, 1, 6, true, "R16G16B16A16_UNORM"},
    { "RubyTestCube.dds", 128, 128, 1, 6, true, "B8G8R8_UNORM"},
    { "Showroom256.dds", 256, 256, 1, 6, true, "B8G8R8_UNORM"},
    { "ShowroomAlt256.dds", 256, 256, 1, 6, true, "B8G8R8_UNORM"},
    { "Sky128.dds", 128, 128, 1, 6, true, "B8G8R8_UNORM"},
    { "SkyBeamHDR512.dds", 512, 512, 1, 6, true, "R16G16B16A16_SFLOAT"},
    { "SpaceSky512.dds", 512, 512, 1, 6, true, "B8G8R8_UNORM"},
    { "Water256.dds", 256, 256, 1, 6, true, "B8G8R8_UNORM"},
    { "Wierd256.dds", 256, 256, 1, 6, true, "B8G8R8_UNORM"},
    { "WindowReflect256.dds", 256, 256, 1, 6, true, "B8G8R8_UNORM"},
}
Xcubemapgen_tests = {
}

local cubemapgen_tests_count = 0
local cubemapgen_tests_passed = 0

for i,tex in ipairs(cubemapgen_tests) do

    local test = ImageLoadAndSimpleCheck("input/cubemapgen/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
 --   test:saveAsDDS("artifacts/dx_examples/"..tex[1])
    cubemapgen_tests_count = cubemapgen_tests_count + 1

    if test then
        cubemapgen_tests_passed = cubemapgen_tests_passed + 1
    end
end

parse_dds_tests = {
    { "test-cube-dx10-rgba32f.dds", 128, 128, 1, 6, true, "R32G32B32A32_SFLOAT"},
    { "test-dxt1.dds", 512, 512, 1, 1, false, "BC1_RGBA_UNORM_BLOCK"},
    { "test-dxt5.dds", 512, 512, 1, 1, false, "BC3_UNORM_BLOCK"},
}

Xparse_dds_tests = {
}
local parse_dds_tests_count = 0
local parse_dds_tests_passed = 0

for i,tex in ipairs(parse_dds_tests) do

    local test = ImageLoadAndSimpleCheck("input/parse-dds/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
 --   test:saveAsDDS("artifacts/dx_examples/"..tex[1])
    parse_dds_tests_count = parse_dds_tests_count + 1
    if test then
        parse_dds_tests_passed = parse_dds_tests_passed + 1
    end
end
libddsimg_tests = {
    { "Col_Viper_Mk7e_Th11.dds", 512, 512, 1, 1, false, "BC3_UNORM_BLOCK"},
    { "DRADIS_Target.dds", 64, 64, 1, 1, false, "BC3_UNORM_BLOCK"},
}
Xlibddsimg_tests = {
}
local libddsimg_tests_count = 0
local libddsimg_tests_passed = 0

for i,tex in ipairs(libddsimg_tests) do

    local test = ImageLoadAndSimpleCheck("input/libddsimg/", tex[1], tex[2], tex[3], tex[4], tex[5], tex[6], tex[7])
 --   test:saveAsDDS("artifacts/dx_examples/"..tex[1])
    libddsimg_tests_count = libddsimg_tests_count + 1
    if test then
        libddsimg_tests_passed = libddsimg_tests_passed + 1
    end
end
print("tacit_texview_tests: " .. tacit_texview_tests_passed .. " passed out of " .. tacit_texview_tests_count)
print("block_compression_rs_tests: " .. block_compression_rs_tests_passed .. " passed out of " .. block_compression_rs_tests_count)
print("openil_dds_tests: " .. openil_dds_tests_passed .." passed out of " .. openil_dds_tests_count)
print("dx_tests: " .. dx_tests_passed .. " passed out of " .. dx_tests_count)
print("cubemapgen_tests: " .. cubemapgen_tests_passed .. " passed out of " .. cubemapgen_tests_count)
print("parse_dds_tests: " .. parse_dds_tests_passed .. " passed out of " .. parse_dds_tests_count)
print("libddsimg_tests: " .. libddsimg_tests_passed .. " passed out of " .. libddsimg_tests_count)