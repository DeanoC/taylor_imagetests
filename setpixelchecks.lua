-- create a pow2 2D texture fill with set pixels save as ktx 
do
    local test, okay = image.create2D(16, 16, "R8G8B8A8_UNORM")
    if okay ~= true then
        error("create2D fail")
    end
    for y = 1, 16 do
        for x = 1, 16 do
            local i = (y-1) * 16 + (x-1)
            test:setPixelAt(i, (x-1.0)/15.0, (y-1.0)/15.0, (x-1.0)/15.0, 1.0)
        end
    end

    for y = 0, 15 do
        for x = 0, 15 do
            local i = y * 16 + x
            local r, g, b , a = test:getPixelAt(i)
            if not approx(r, x/15.0, 1e-5) or  not approx(g, y/15.0, 1e-5) or not approx(b, x/15.0, 1e-5) or not approx(a, 1.0, 1e-5) then 
                print("create2D get pixel failed <" .. x .. "," .. y .. ">")
                print(r .. "," .. g .. "," .. b .. "," .. a)
                print(x/15.0 .. "," .. y/15.0 .. "," .. x/15.0 .. "," .. 1.0)
                goto fail
            end
        end
    end
    test:saveAsKTX("artifacts/setpixel_rgba8_16x16.ktx")
::fail::
end
-- load 16x16 ktx with mipmaps from PVR Texture Tool, save as png and ktx
do
    local test, okay = image.load("input/pvtt_rgba8_mm_16x16.ktx")
    if okay ~= true then
        print("pvtt_rgba8_mm_16x16.ktx unable to be loaded")
    end

    test:saveAsPNG("artifacts/pvtt_rgba8_mm_16x16.png")
    test:saveAsKTX("artifacts/pvtt_rgba8_mm_16x16.ktx")
end

-- create a 256x256 image, set pixels save as png, reload and check every pixel was set and saved correctly
-- checks manual index calculations and calculateIndex function
do
    local test, okay = image.createNoClear(256, 256, 1, 1, "R8G8B8A8_UNORM")
    if test == nil then
        print("unable to be create image")
    end

    for y = 1, 256 do
        for x = 1, 256 do
            local i = (y-1) * 256 + (x-1)
            test:setPixelAt(i, (x-1.0)/255.0, (y-1.0)/255.0, (x-1.0)/255.0, (y-1.0)/255.0)
        end
    end
    test:saveAsPNG("artifacts/setpixel_rgba8_256x256.png")

    local loadtest, okay = image.load("artifacts/setpixel_rgba8_256x256.png")
    for y = 1, 256 do
        for x = 1, 256 do
            local i = (y-1) * 256 + (x-1)
            local r, g, b, a = loadtest:getPixelAt(i)
            if not approx(r, (x-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. r .. " red incorrect in setpixel_rgba8_256x256.png")
            end
            if not approx(g, (y-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. g .. " green incorrect in setpixel_rgba8_256x256.png")
            end
            if not approx(b, (x-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. b .. " blue incorrect in setpixel_rgba8_256x256.png")
            end
            if not approx(a, (y-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. a .. " alpha incorrect in setpixel_rgba8_256x256.png")
            end
        end
    end

    for y = 1, 256 do
        for x = 1, 256 do
            local i = loadtest:calculateIndex(x-1,y-1, 0, 0)

            local r, g, b, a = loadtest:getPixelAt(i)
            if not approx(r, (x-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. r .. " red incorrect in calculateIndex test")
            end
            if not approx(g, (y-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. g .. " green incorrect in calculateIndex test")
            end
            if not approx(b, (x-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. b .. " blue incorrect in calculateIndex test")
            end
            if not approx(a, (y-1.0)/255.0, 1e-5) then
                print( x .. ", " .. y .. ": " .. a .. " alpha incorrect in calculateIndex test")
            end
        end
    end
end
