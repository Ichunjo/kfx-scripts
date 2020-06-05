#! by Vardë

color_tablo = {"\\c&H4AC2C9&\\3c&H4AC2C9&","\\c&HDB60D9&\\3c&HDB60D9&","\\c&HD6D02B&\\3c&HD6D02B&","\\c&H4642F3&\\3c&H4642F3&"}

function char_counter(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            compteur = compteur + 1
        end
    end
    return compteur
end

FadeTime = 300
minTransitionTime = 300

function roumaji(line, l)
    l.effect = "Popipa fx"

    -- By tsukuri
    transitionTime = minTransitionTime < line.duration and minTransitionTime or line.duration
    infad = FadeTime < math.abs(line.infade) and FadeTime or line.infade
    outfad = FadeTime < math.abs(line.outfade) and FadeTime or line.outfade
    tts = transitionTime+infad
    tte = transitionTime+outfad
    lWidthS = lines[line.i].width < lines[math.trim(line.i-1,1,#lines)].width and lines[math.trim(line.i-1,1,#lines)].width or lines[line.i].width
    lLeftS = lines[line.i].width < lines[math.trim(line.i-1,1,#lines)].width and lines[math.trim(line.i-1,1,#lines)].left or lines[line.i].left
    lWidthE = lines[line.i].width < lines[math.trim(line.i+1,1,#lines)].width and lines[math.trim(line.i+1,1,#lines)].width or lines[line.i].width
    lLeftE = lines[line.i].width < lines[math.trim(line.i+1,1,#lines)].width and lines[math.trim(line.i+1,1,#lines)].left or lines[line.i].left

    
    -- Clignotement
    start_line = 0
    end_line = 0
    v = 0
    for si, syl in ipairs(line.syls) do
        if syl.text ~= "" then
            if syl.duration ~= 0 then
                start_line = line.start_time - infad/2 - tts/2 + tts*((syl.center-lLeftS)/lWidthS)
                v = v + 1
                if v == 1 then
                    end_line = line.end_time + outfad/2 - tte/2 + tte*((syl.center-lLeftE)/lWidthE)
                end
            end
        end
    end

    if line.i ~= 10 or line.i ~= 11 or line.i ~= 18 or line.i ~= 19 or line.i ~= 34 or line.i ~= 35 or line.i ~= 43 or line.i ~= 44 or line.i ~= 58 or line.i ~= 59 or line.i ~= 68 or line.i ~= 69 or line.i ~= 67 or line.i ~= 68 or line.i ~= 69 then
        longueur = 1269.84 / 2
        count = math.ceil(line.duration/longueur)
        autotag = ""
        interval = 0
        enplus = longueur / 4
        for i = 1, count do
            autotag = autotag..string.format("\\t(%d,%d,%s)\\t(%d,%d,%s)\\t(%d,%d,%s)\\t(%d,%d,%s)", interval, interval+enplus, color_tablo[1], interval+enplus, interval+enplus*2, color_tablo[2], interval+enplus*2, interval+enplus*3, color_tablo[3], interval+enplus*3, interval+enplus*4, color_tablo[4])
            interval = interval + longueur
        end
    
        l.start_time = start_line
        l.end_time = end_line
    
        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\bord16\\blur10\\alpha&H53&%s\\fad(84,84)}%s", 
                        line.center, line.middle, autotag, line.text)
        io.write_line(l);
    end


    for si, syl in ipairs(line.syls) do
        if syl.text ~= "" then
            if syl.duration ~= 0 then
                if line.i ~= 10 or line.i ~= 11 or line.i ~= 18 or line.i ~= 19 or line.i ~= 34 or line.i ~= 35 or line.i ~= 43 or line.i ~= 44 or line.i ~= 58 or line.i ~= 59 or line.i ~= 68 or line.i ~= 69 then
                    l.start_time = line.start_time - infad/2 - tts/2 + tts*((syl.center-lLeftS)/lWidthS)
                    l.end_time = line.start_time + syl.start_time
                    l.layer = 1
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                                    syl.center, syl.middle,
                                    syl.text)
                    io.write_line(l);
                    l.layer = 2
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                                    syl.center, syl.middle,
                                    syl.text)
                    io.write_line(l);
                    l.layer = 3
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                                    syl.center, syl.middle,
                                    syl.text)
                    io.write_line(l);
                    l.layer = 4
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                                    syl.center, syl.middle, 
                                    syl.text)
                    io.write_line(l);
                end

                l.start_time = line.start_time + syl.start_time
                l.end_time = line.start_time + syl.end_time
                l.layer = 1
                l.text = string.format(
                                "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\t(0,%.6f,0.85,\\fscx145\\fscy145)\\t(%.6f,%.6f,0.85,\\fscx100\\fscy100)\\alpha&H64&}%s",
                                syl.center, syl.middle, syl.duration / 20, syl.duration / 10.5, syl.duration,
                                syl.text)
                io.write_line(l);
                l.layer = 6
                l.text = string.format(
                                "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\t(0,%.6f,0.85,\\fscx145\\fscy145)\\t(%.6f,%.6f,0.85,\\fscx100\\fscy100)}%s",
                                syl.center, syl.middle, syl.duration / 20, syl.duration / 10.5, syl.duration,
                                syl.text)
                io.write_line(l);
                l.layer = 7
                l.text = string.format(
                                "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\t(0,%.6f,0.85,\\fscx145\\fscy145)\\t(%.6f,%.6f,0.85,\\fscx100\\fscy100)}%s",
                                syl.center, syl.middle, syl.duration / 20, syl.duration / 10.5, syl.duration,
                                syl.text)
                io.write_line(l);
                l.layer = 8
                l.text = string.format(
                                "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\t(0,%.6f,0.85,\\fscx145\\fscy145)\\t(%.6f,%.6f,0.85,\\fscx100\\fscy100)}%s",
                                syl.center, syl.middle, syl.duration / 20, syl.duration / 10.5, syl.duration,
                                syl.text)
                io.write_line(l);


                if line.i ~= 10 or line.i ~= 11 or line.i ~= 18 or line.i ~= 19 or line.i ~= 34 or line.i ~= 35 or line.i ~= 43 or line.i ~= 44 or line.i ~= 58 or line.i ~= 59 or line.i ~= 68 or line.i ~= 69 then
                    l.start_time = line.start_time + syl.end_time
                    l.end_time = line.end_time + outfad/2 - tte/2 + tte*((syl.center-lLeftE)/lWidthE)
                    duration = l.end_time - l.start_time
                    l.layer = 1
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                                    syl.center, syl.middle, duration - 252, duration - 126, duration - 126, 0,
                                    syl.text)
                    io.write_line(l);
                    l.layer = 2
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                                    syl.center, syl.middle, duration - 252, duration - 126, duration - 126, 0,
                                    syl.text)
                    io.write_line(l);
                    l.layer = 3
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                                    syl.center, syl.middle, duration - 252, duration - 126, duration - 126, 0,
                                    syl.text)
                    io.write_line(l);
                    l.layer = 4
                    l.text = string.format(
                                    "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                                    syl.center, syl.middle, duration - 252, duration - 126, duration - 126, 0,
                                    syl.text)
                    io.write_line(l);
                end
            end
        end
    end
end

function sub(line, l)
    l.effect = "Popipa fx"

    -- By tsukuri
    transitionTime = minTransitionTime < line.duration and minTransitionTime or line.duration
    if string.find(lines[line.i - 1].actor, "two") then
        infad = FadeTime < math.abs(lines[line.i - 1].infade) and FadeTime or
                    lines[line.i - 1].infade
        outfad = FadeTime < math.abs(lines[line.i].outfade) and FadeTime or
                     lines[line.i].outfade
    elseif string.find(lines[line.i].actor, "two") then
        infad = FadeTime < math.abs(lines[line.i].infade) and FadeTime or
                    lines[line.i].infade
        outfad = FadeTime < math.abs(lines[line.i + 1].outfade) and FadeTime or
                     lines[line.i + 1].outfade
    else
        infad = FadeTime < math.abs(line.infade) and FadeTime or line.infade
        outfad = FadeTime < math.abs(line.outfade) and FadeTime or line.outfade
    end
    tts = transitionTime+infad
    tte = transitionTime+outfad
    lWidthS = lines[line.i].width < lines[math.trim(line.i-1,1,#lines)].width and lines[math.trim(line.i-1,1,#lines)].width or lines[line.i].width
    lLeftS = lines[line.i].width < lines[math.trim(line.i-1,1,#lines)].width and lines[math.trim(line.i-1,1,#lines)].left or lines[line.i].left
    lWidthE = lines[line.i].width < lines[math.trim(line.i+1,1,#lines)].width and lines[math.trim(line.i+1,1,#lines)].width or lines[line.i].width
    lLeftE = lines[line.i].width < lines[math.trim(line.i+1,1,#lines)].width and lines[math.trim(line.i+1,1,#lines)].left or lines[line.i].left

    
    if string.find(line.actor, "two") then
        yshift = line.height
    else
        yshift = 0
    end

    -- Clignotement
    start_line = 0
    end_line = 0
    v = 0
    for wo, word in ipairs(line.words) do
        start_line = line.start_time - infad/2 - tts/2 + tts*((word.center-lLeftS)/lWidthS)
        v = v + 1
        if v == 1 then
            end_line = line.end_time + outfad/2 - tte/2 + tte*((word.center-lLeftE)/lWidthE)
        end
    end

    longueur = 1269.84 / 2
    count = math.ceil(line.duration/longueur)
    autotag = ""
    interval = 0
    enplus = longueur / 4
    for i = 1, count do
        autotag = autotag..string.format("\\t(%d,%d,%s)\\t(%d,%d,%s)\\t(%d,%d,%s)\\t(%d,%d,%s)", interval, interval+enplus, color_tablo[1], interval+enplus, interval+enplus*2, color_tablo[2], interval+enplus*2, interval+enplus*3, color_tablo[3], interval+enplus*3, interval+enplus*4, color_tablo[4])
        interval = interval + longueur
    end

    l.start_time = start_line
    l.end_time = end_line

    if line.i ~= 138 then
        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\bord16\\blur10\\alpha&H53&%s\\fad(84,84)}%s", 
                        line.center, line.middle - yshift, autotag, line.text)
        io.write_line(l);
    end

    l.start_time = start_line
    l.end_time = end_line

    l.layer = 0
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord16\\blur10\\alpha&H53&%s\\fad(84,84)}%s", 
                    line.center, line.middle - yshift, autotag, line.text)
    io.write_line(l);

    for wo, word in ipairs(line.words) do
        l.start_time = line.start_time - infad/2 - tts/2 + tts*((word.center-lLeftS)/lWidthS)
        l.end_time = line.start_time + line.duration / 2
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                        word.center, word.middle - yshift,
                        word.text)
        io.write_line(l);
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                        word.center, word.middle - yshift,
                        word.text)
        io.write_line(l);
        l.layer = 3
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                        word.center, word.middle - yshift,
                        word.text)
        io.write_line(l);
        l.layer = 4
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\fscx80\\fscy80\\t(0,126,\\fscx120\\fscy120)\\t(126,252,\\fscx100\\fscy100)\\fad(120,0)}%s",
                        word.center, word.middle - yshift, 
                        word.text)
        io.write_line(l);


        l.start_time = line.start_time + line.duration / 2
        l.end_time = line.end_time + outfad/2 - tte/2 + tte*((word.center-lLeftE)/lWidthE)
        duration = l.end_time - l.start_time
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                        word.center, word.middle - yshift, duration - 252, duration - 126, duration - 126, 0,
                        word.text)
        io.write_line(l);
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                        word.center, word.middle - yshift, duration - 252, duration - 126, duration - 126, 0,
                        word.text)
        io.write_line(l);
        l.layer = 3
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                        word.center, word.middle - yshift, duration - 252, duration - 126, duration - 126, 0,
                        word.text)
        io.write_line(l);
        l.layer = 4
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\fscx100\\fscy100\\t(%.6f,%.6f,\\fscx80\\fscy80)\\t(%.6f,%.6f,\\fscx120\\fscy120)\\fad(0,160)}%s",
                        word.center, word.middle - yshift, duration - 252, duration - 126, duration - 126, 0,
                        word.text)
        io.write_line(l);
    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        if line.styleref.alignment == 8 then
            roumaji(line, table.copy(line))
        else
            sub(line, table.copy(line))
        end
    end
    io.progressbar(li / #lines)
end