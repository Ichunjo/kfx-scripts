#! by Vardë en copiant des morceaux de tsuku tehe pero

FadeTime = 300
minTransitionTime = 300

function sub(line, l)

    transitionTime = minTransitionTime < line.duration and minTransitionTime or
                         line.duration

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

    tts = transitionTime + infad
    tte = transitionTime + outfad
    lWidthS = lines[line.i].width <
                  lines[math.trim(line.i - 1, 1, #lines)].width and
                  lines[math.trim(line.i - 1, 1, #lines)].width or
                  lines[line.i].width
    lLeftS =
        lines[line.i].width < lines[math.trim(line.i - 1, 1, #lines)].width and
            lines[math.trim(line.i - 1, 1, #lines)].left or lines[line.i].left
    lWidthE = lines[line.i].width <
                  lines[math.trim(line.i + 1, 1, #lines)].width and
                  lines[math.trim(line.i + 1, 1, #lines)].width or
                  lines[line.i].width
    lLeftE =
        lines[line.i].width < lines[math.trim(line.i + 1, 1, #lines)].width and
            lines[math.trim(line.i + 1, 1, #lines)].left or lines[line.i].left

    if string.find(line.actor, "gauche") then
        xshift = -540
    elseif string.find(line.actor, "droite") then
        xshift = 328
    else
        xshift = 0
    end

    if string.find(line.actor, "two") then
        yshift = line.height
    else
        yshift = 0
    end

    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then

            l.start_time = line.start_time - infad / 2 - tts / 2 + tts *
                               ((char.center - lLeftS) / lWidthS)
            l.end_time = line.end_time + outfad / 2 - tte / 2 + tte *
                             ((char.center - lLeftE) / lWidthE)

            l.layer = 0
            l.text = string.format(
                         "{\\an5\\pos(%.3f,%.3f)\\bord4\\blur15\\alpha&HA0&\\fad(240,240)}%s",
                         char.center + xshift, line.middle - yshift, char.text)
            io.write_line(l);
            l.layer = 1
            l.text = string.format(
                         "{\\an5\\pos(%.3f,%.3f)\\bord3\\blur3.5\\c&HFFFFFF&\\fad(240,240)}%s",
                         char.center + xshift, line.middle - yshift, char.text)
            io.write_line(l);
            l.layer = 2
            l.text = string.format(
                         "{\\an5\\pos(%.3f,%.3f)\\bord0\\blur0.5\\fad(240,240)}%s",
                         char.center + xshift, line.middle - yshift, char.text)
            io.write_line(l);
        end
    end
end

-- Roumaji
function roumaji(line, l)

    l.start_time = line.start_time
    l.end_time = line.end_time
    transitionTime = minTransitionTime < line.duration and minTransitionTime or line.duration
    infad = FadeTime < math.abs(line.infade) and FadeTime or line.infade
    outfad = FadeTime < math.abs(line.outfade) and FadeTime or line.outfade
    tts = transitionTime+infad
    tte = transitionTime+outfad
    lWidthS = lines[line.i].width < lines[math.trim(line.i-1,1,#lines)].width and lines[math.trim(line.i-1,1,#lines)].width or lines[line.i].width
    lLeftS = lines[line.i].width < lines[math.trim(line.i-1,1,#lines)].width and lines[math.trim(line.i-1,1,#lines)].left or lines[line.i].left
    lWidthE = lines[line.i].width < lines[math.trim(line.i+1,1,#lines)].width and lines[math.trim(line.i+1,1,#lines)].width or lines[line.i].width
    lLeftE = lines[line.i].width < lines[math.trim(line.i+1,1,#lines)].width and lines[math.trim(line.i+1,1,#lines)].left or lines[line.i].left

    if line.actor == "gauche" then
        xshift = -540
    elseif line.actor == "droite" then
        xshift = 328
    else
        xshift = 0
    end

    for si, syl in ipairs(line.syls) do
        if syl.text ~= "" then
            if syl.duration ~= 0 then

                -- start2syl
                l.start_time = line.start_time - infad / 2 - tts / 2 + tts *
                                   ((syl.x - lLeftS) / lWidthS)
                l.end_time = line.start_time + syl.start_time

                if line.actor ~= "echo" then
                    l.layer = 0
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord4\\blur15\\alpha&HA0&\\fad(240,0)}%s",
                                 syl.x + xshift, syl.middle, syl.text)
                    io.write_line(l);
                    l.layer = 1
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord3\\blur3.5\\c&HFFFFFF&\\fad(240,0)}%s",
                                 syl.x + xshift, syl.middle, syl.text)
                    io.write_line(l);
                    l.layer = 2
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord0\\blur0.5\\fad(240,0)}%s",
                                 syl.x + xshift, syl.middle, syl.text)
                    io.write_line(l);
                end

                -- syl
                l.start_time = line.start_time + syl.start_time
                l.end_time = line.start_time + syl.end_time

                if line.actor == "echo" then
                    l.layer = 6
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord0\\c&HFFFFFF&\\blur3\\t(%d,%d,\\frz-8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\frz8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\fscx140\\fscy140)\\t(%d,%d,\\fscx100\\fscy100)\\fad(%d,%d)}%s",
                                 syl.x, syl.middle, 0, syl.duration / 4,
                                 syl.duration / 4, syl.duration / 2,
                                 syl.duration / 2,
                                 syl.duration - syl.duration / 4,
                                 syl.duration - syl.duration / 4, syl.duration,
                                 0, syl.duration / 3, syl.duration / 3,
                                 syl.duration, syl.duration / 8,
                                 syl.duration - syl.duration / 4, syl.text)
                    io.write_line(l);
                else
                    l.layer = 3
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord4\\blur15\\alpha&HA0&\\t(%d,%d,\\frz-8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\frz8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\fscx140\\fscy140)\\t(%d,%d,\\fscx100\\fscy100)}%s",
                                 syl.x + xshift, syl.middle, 0,
                                 syl.duration / 4, syl.duration / 4,
                                 syl.duration / 2, syl.duration / 2,
                                 syl.duration - syl.duration / 4,
                                 syl.duration - syl.duration / 4, syl.duration,
                                 0, syl.duration / 3, syl.duration / 3,
                                 syl.duration, syl.text)
                    io.write_line(l);
                    l.layer = 4
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord3\\blur3.5\\c&HFFFFFF&\\t(%d,%d,\\frz-8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\frz8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\fscx140\\fscy140)\\t(%d,%d,\\fscx100\\fscy100)}%s",
                                 syl.x + xshift, syl.middle, 0,
                                 syl.duration / 4, syl.duration / 4,
                                 syl.duration / 2, syl.duration / 2,
                                 syl.duration - syl.duration / 4,
                                 syl.duration - syl.duration / 4, syl.duration,
                                 0, syl.duration / 3, syl.duration / 3,
                                 syl.duration, syl.text)
                    io.write_line(l);
                    l.layer = 5
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord0\\blur0.5\\t(%d,%d,\\frz-8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\frz8)\\t(%d,%d,\\frz0)\\t(%d,%d,\\fscx140\\fscy140)\\t(%d,%d,\\fscx100\\fscy100)}%s",
                                 syl.x + xshift, syl.middle, 0,
                                 syl.duration / 4, syl.duration / 4,
                                 syl.duration / 2, syl.duration / 2,
                                 syl.duration - syl.duration / 4,
                                 syl.duration - syl.duration / 4, syl.duration,
                                 0, syl.duration / 3, syl.duration / 3,
                                 syl.duration, syl.text)
                    io.write_line(l);
                end

                -- syl2end
                l.start_time = line.start_time + syl.end_time
                l.end_time = line.end_time + outfad / 2 - tte / 2 + tte *((syl.x - lLeftE) / lWidthE)

                if line.actor ~= "echo" then
                    l.layer = 0
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord4\\blur15\\alpha&HA0&\\fad(0,240)}%s",
                                 syl.x + xshift, syl.middle, syl.text)
                    io.write_line(l);
                    l.layer = 1
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord3\\blur3.5\\c&HFFFFFF&\\fad(0,240)}%s",
                                 syl.x + xshift, syl.middle, syl.text)
                    io.write_line(l);
                    l.layer = 2
                    l.text = string.format(
                                 "{\\an5\\pos(%.3f,%.3f)\\bord0\\blur0.5\\fad(0,240)}%s",
                                 syl.x + xshift, syl.middle, syl.text)
                    io.write_line(l);
                end
            end
        end
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
