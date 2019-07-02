-- Used to figure out why a golden image is borked put the broken ones in uncompressed_formats and debug away
local image = require "image"
local os = require "al2o3.os"

uncompressed_formats = {
	"R32G32_SFLOAT"
}

-- format checks
do
    for i,fmt in ipairs(uncompressed_formats) do
        local test, okay = image.createNoClear(16, 16, 1, 1, fmt)
        if okay ~= true then
            print("unable to be create image")
        end

        for y = 0, 15 do
            for x = 0, 15 do
                local i = test:calculateIndex(x, y,0,0)
                test:setPixelAt(i, x/15.0, y/15.0, x/15.0, 1.0)
            end
        end
        test:saveAsKTX("artifacts/borked_fmtcheck_" .. fmt .."_16x16.ktx")
    end
    
    for i,fmt in ipairs(uncompressed_formats) do
        local arti, okaya = image.load("artifacts/borked_fmtcheck_" .. fmt .."_16x16.ktx")
        local golden, okayb = image.load("golden/fmtcheck_" .. fmt .."_16x16.ktx")

        if okaya == false or okayb == false then
            print("Failed golden image load check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end

        local wi, hi, di, si = arti:dimensions();
        local wg, hg, dg, sg = golden:dimensions();

        local formati = arti:format();
        local flagsi = arti:flags()
        local formatg = golden:format();
        local flagsg = golden:flags()

        if wi ~= wg or hi ~= hg or di ~= dg or si ~= sg then
            print("Failed golden image dim check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end

        if formati ~= formatg then
            print("Failed golden image format check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end
        if flagsi.Cubemap ~= flagsg.Cubemap then
            print("Failed golden image cubemap check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end


    for y = 0, 15 do
        for x = 0, 15 do
            local i = y * 16 + x
            local ri, gi, bi , ai = arti:getPixelAt(i)
            local rg, gg, bg , ag = golden:getPixelAt(i)
            if ri ~= rg or gi ~= gg or bi ~= bg or ai ~= ag then 
            print("Failed golden image cubemap check for fmtcheck_" .. fmt .."_16x16.ktx <" .. x .. "," .. y .. ">")
            end
        end
    end

        ::continue::
    end
end


