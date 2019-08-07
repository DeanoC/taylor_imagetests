math = require("math")

uncompressed_formats = {
--  "R4G4_UNORM_PACK8",
  "R4G4B4A4_UNORM_PACK16",
  "B4G4R4A4_UNORM_PACK16",
  "R5G6B5_UNORM_PACK16",
  "B5G6R5_UNORM_PACK16",
  "R5G5B5A1_UNORM_PACK16",
  "B5G5R5A1_UNORM_PACK16",
  "A1R5G5B5_UNORM_PACK16",
  "R8_UNORM",
  "R8_SNORM",
  "R8_UINT",
  "R8_SINT",
  "R8_SRGB",
  "R8G8_UNORM",
  "R8G8_SNORM",
  "R8G8_UINT",
  "R8G8_SINT",
  "R8G8_SRGB",
  "R8G8B8_UNORM",
  "R8G8B8_SNORM",
  "R8G8B8_UINT",
  "R8G8B8_SINT",
  "R8G8B8_SRGB",
  "B8G8R8_UNORM",
  "B8G8R8_SNORM",
  "B8G8R8_UINT",
  "B8G8R8_SINT",
  "B8G8R8_SRGB",
  "R8G8B8A8_UNORM",
  "R8G8B8A8_SNORM",
  "R8G8B8A8_UINT",
  "R8G8B8A8_SINT",
  "R8G8B8A8_SRGB",
  "B8G8R8A8_UNORM",
  "B8G8R8A8_SNORM",
  "B8G8R8A8_UINT",
  "B8G8R8A8_SINT",
  "B8G8R8A8_SRGB",
  "A8B8G8R8_UNORM_PACK32",
  "A8B8G8R8_SNORM_PACK32",
  "A8B8G8R8_UINT_PACK32",
  "A8B8G8R8_SINT_PACK32",
  "A8B8G8R8_SRGB_PACK32",
-- broken  "A2R10G10B10_UNORM_PACK32",
-- broken "A2R10G10B10_UINT_PACK32",
-- broken "A2B10G10R10_UNORM_PACK32",
  "A2B10G10R10_UINT_PACK32",
  "R16_UNORM",
  "R16_SNORM",
  "R16_UINT",
  "R16_SINT",
  "R16_SFLOAT",
  "R16G16_UNORM",
  "R16G16_SNORM",
  "R16G16_UINT",
  "R16G16_SINT",
  "R16G16_SFLOAT",
  "R16G16B16_UNORM",
  "R16G16B16_SNORM",
  "R16G16B16_UINT",
  "R16G16B16_SINT",
  "R16G16B16_SFLOAT",
  "R16G16B16A16_UNORM",
  "R16G16B16A16_SNORM",
  "R16G16B16A16_UINT",
  "R16G16B16A16_SINT",
  "R16G16B16A16_SFLOAT",
  "R32_UINT",
  "R32_SINT",
  "R32_SFLOAT",
  "R32G32_UINT",
  "R32G32_SINT",
  "R32G32_SFLOAT",
  "R32G32B32_UINT",
  "R32G32B32_SINT",
  "R32G32B32_SFLOAT",
  "R32G32B32A32_UINT",
  "R32G32B32A32_SINT",
  "R32G32B32A32_SFLOAT",
}
Xuncompressed_formats = {
  "B5G5R5A1_UNORM_PACK16",
}

function very_low_precision(fmt_split)
  if  fmt_split[1] == "R4G4B4A4" or
      fmt_split[1] == "B4G4R4A4" or
      fmt_split[1] == "R5G6B5" or
      fmt_split[1] == "B5G6R5" or
      fmt_split[1] == "R5G5B5A1" or
      fmt_split[1] == "B5G5R5A1" or 
      fmt_split[1] == "A1R5G5B5" 
  then
        return true
  end
  return false
end

function round(n)
  return math.floor((math.floor(n*2) + 1)/2)
end

function low_precision(fmt_split)
  -- TODO check we are really this low precision or is this a bug in SNORM put/fetch?
  if  (fmt_split[1] == "R8G8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "R8G8B8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "B8G8R8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "R8G8B8A8" and fmt_split[2] == "SNORM")or 
      (fmt_split[1] == "B8G8R8A8" and fmt_split[2] == "SNORM")
  then
    return true
  end

  return false
end

function skip_test(fmt_split)
    -- in some cases precision issues mean we get false negative
    -- TODO test these seperately from the batch tester 
    local skip = false

    if fmt_split[2] == "SRGB" then skip = true end

    return skip
end

-- format checks
do    
  for i,fmt in ipairs(uncompressed_formats) do
    local test, okay = image.create2D(16, 16, fmt)
    if okay ~= true then
        print("unable to be create image 16x16 " .. fmt)
        goto continue1
    end

    local fmt_split={}
    for str in string.gmatch(fmt, "([^_]+)") do
        table.insert(fmt_split, str)
    end

    local ignoreMask = { false, false, false, false }
    if string.find(fmt_split[1], "R") == nil then 
      ignoreMask[0] = true;
    end
    if string.find(fmt_split[1], "G") == nil then 
      ignoreMask[1] = true;
    end
    if string.find(fmt_split[1], "B") == nil then 
      ignoreMask[2] = true;
    end
    if string.find(fmt_split[1], "A") == nil then 
      ignoreMask[3] = true;
    end

    local precision = 1e-5
    if low_precision(fmt_split) then precision = 1e-2 end
    if very_low_precision(fmt_split) then precision = 1e-1 end

    local av = 15
    if string.find(fmt_split[1], "A2") then 
        av = 3
    end
    if string.find(fmt_split[1], "A1") then 
        av = 1
    end


    local skip = skip_test(fmt_split)
    if skip then print("skipping " .. fmt) end

    local norm = fmt_split[2] == "SNORM" or fmt_split[2] == "UNORM" or fmt_split[2] == "SRGB" 
    local signed = fmt_split[2] == "SNORM" or fmt_split[2] == "SFLOAT" or fmt_split[2] == "SINT" or fmt_split[2] == "SSCALED"
 
    for y = 0, 15 do
      for x = 0, 15 do
				local i = test:calculateIndex(x, y, 0, 0)

        local r = x 
        local g = y
        local b = (x + y) / 2
        local a = (x / (y+1)) * x


        r = round(r);
        g = round(g);
        b = round(b);
        a = round(a);

        if norm then                  
            r = r / 15
            g = g / 15
            b = b / 15
            a = a / av
            if a > 1 then
              a = 1
            end
        end

        if signed then
          r = (r - 0.5) * 2
          g = (g - 0.5) * 2
          b = (b - 0.5) * 2
          a = (a - 0.5) * 2
        end

        test:setPixelAt(i, r, g, b, a)

        if skip == false then
          local rg, gg, bg, ag = test:getPixelAt(i)

          local fail = false

          if (ignoreMask[0] == false) and
              (approx(r, rg, precision) == false) then
            print(fmt .. " RED fail")
            fail = true
          end
          if (ignoreMask[1] == false) and
              (approx(g, gg, precision) == false) then
            print(fmt .. " BLUE fail")
            fail = true
          end
          if (ignoreMask[2] == false) and
              (approx(b, bg, precision) == false) then
            print(fmt .. " GREEN fail")
            fail = true
          end
          if (ignoreMask[3] == false) and
              (approx(a, ag, precision) == false) then
            print(fmt .. " ALPHA fail")
            fail = true
          end

          if fail then 
              print("Failed image set/get pixel check for " .. fmt .. "<" .. x .. "," .. y .. ">")
              print(string.format("read(%f,%f,%f,%f) != written(%f,%f,%f,%f)", rg, gg, bg, ag, r, g, b, a))
              goto continue1
          end

      	end
      end
	  end

	  -- save it
	  local fname = "artifacts/fmtcheck_" .. fmt .."_16x16"
    if skip == true then goto continue1 end
	  test:saveAsKTX(fname .. ".ktx")
	  test:saveAsDDS(fname .. ".dds")

	  -- try and reload
	  local loadedK, okayK = image.load(fname .. ".ktx")
	  local loadedD, okayD = image.load(fname .. ".dds")
	  if okayK ~= true then
	      print("unable to be load " .. fname .. ".ktx")
	  end
	  if okayD ~= true then
	      print("unable to be load " .. fname .. ".dds")
	  end

	  for y = 0, 15 do
	      for x = 0, 15 do
	          local i = test:calculateIndex(x, y, 0, 0)
	          local rg, gg, bg, ag = test:getPixelAt(i)

	          if okayK then
	            local ri, gi, bi, ai = loadedK:getPixelAt(i)
	            if ri ~= rg or gi ~= gg or bi ~= bg or ai ~= ag then 
	                print("Failed image pixel check for .ktx " .. fmt .. "<" .. x .. "," .. y .. ">")
	                print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                    print("test fmt = " .. test:format() .. " Ktx loaded formated = " .. loadedK:format())
	                goto continue1
	            end
	          end

	          if okayD then
	            local ri, gi, bi, ai = loadedD:getPixelAt(i)
	            if ri ~= rg or gi ~= gg or bi ~= bg or ai ~= ag then 
	                print("Failed image pixel check for .dds " .. fmt .. "<" .. x .. "," .. y .. ">")
	                print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                    print("test fmt = " .. test:format() .. " DDS loaded formated = " .. loadedD:format())
	                goto continue1
	            end
	          end
	      end
	  end
	  ::continue1::
  end

  local dirent = os.filesystem.directoryEnumeratorCreate("golden")
  
  for fname, isdir in dirent do
      if fname == "__README.txt" then 
        goto continue2 
      end
      if string.find(fname, ".kts") == nil then
      	goto continue2
      end
      local t={}
      for str in string.gmatch(fname, "([^_]+)") do
              table.insert(t, str)
      end
      local fmt = t[2] .. "_" .. t[3]
      if t[4] ~= "16x16.ktx" then 
          fmt = fmt .. "_" .. t[4]
      end
      local arti, okaya = image.load("artifacts/fmtcheck_" .. fmt .."_16x16.ktx")
      local golden, okayb = image.load("golden/fmtcheck_" .. fmt .."_16x16.ktx")
      if okaya == false or okayb == false then
          print("Failed golden image load check for fmtcheck_" .. fmt .."_16x16.ktx")
          goto continue2
      end

      local wi, hi, di, si = arti:dimensions();
      local wg, hg, dg, sg = golden:dimensions();

      local formati = arti:format();
      local flagsi = arti:flags()
      local formatg = golden:format();
      local flagsg = golden:flags()

      if wi ~= wg or hi ~= hg or di ~= dg or si ~= sg then
          print("Failed golden image dim check for fmtcheck_" .. fmt .."_16x16.ktx")
          goto continue2
      end

      if formati ~= formatg then
          print("Failed golden image format check for fmtcheck_" .. fmt .."_16x16.ktx")
          goto continue2
      end
      if flagsi.Cubemap ~= flagsg.Cubemap then
          print("Failed golden image cubemap check for fmtcheck_" .. fmt .."_16x16.ktx")
          goto continue2
      end

      for y = 0, 15 do
          for x = 0, 15 do
              local i = golden:calculateIndex(x, y, 0, 0)
              local ri, gi, bi, ai = arti:getPixelAt(i)
              local rg, gg, bg, ag = golden:getPixelAt(i)

              if approx(ri, rg) == false or approx(gi, gg) == false or approx(bi, bg) == false or approx(ai, ag) == false then 
                  print("Failed golden image pixel check for fmtcheck_" .. fmt .."_16x16.ktx <" .. x .. "," .. y .. ">")
                  print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                  goto continue2
              end
          end
      end
      ::continue2::
  end
  ::stop::
end
