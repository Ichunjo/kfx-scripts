#! by Vardë

ms_per_frame = 1000 / 23.976

function sub(line, l)
    l.start_time = line.start_time
    l.end_time = line.end_time
    if line.i < 7 then
        l.layer = 0
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\3c&H2C2C2C&\\blur6\\alpha&H80&\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     line.middle, line.bottom, 
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);

        l.layer = 1
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\3c&H2C2C2C&\\c&H2C2C2C&\\blur3\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     line.middle, line.bottom, 
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);

        l.layer = 2
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\bord0\\blur0.3\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     line.middle, line.bottom, 
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);
    elseif line.i < 47 then
        l.layer = 0
        l.text = string.format(
                     "{\\pos(556,268)\\3c&H2C2C2C&\\blur6\\alpha&H80&\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);

        l.layer = 1
        l.text = string.format(
                     "{\\pos(556,268)\\3c&H2C2C2C&\\c&H2C2C2C&\\blur3\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);

        l.layer = 2
        l.text = string.format(
                     "{\\pos(556,268)\\bord0\\blur0.3\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);
    else
        l.layer = 0
        l.text = string.format(
                     "{\\pos(556,805)\\3c&H2C2C2C&\\blur6\\alpha&H80&\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);

        l.layer = 1
        l.text = string.format(
                     "{\\pos(556,805)\\3c&H2C2C2C&\\c&H2C2C2C&\\blur3\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);

        l.layer = 2
        l.text = string.format(
                     "{\\pos(556,805)\\bord0\\blur0.3\\fscx98\\fscy95\\t(0,%.3f,\\fscx%s\\fscy%s)\\t(%.3f,%.3f,\\fscx98\\fscy95)\\fad(%.3f,%.3f)}%s",
                     ms_per_frame * 4, line.styleref.scale_x, line.styleref.scale_y,
                     line.duration - ms_per_frame * 5, line.duration,
                     ms_per_frame * 4, ms_per_frame * 5, line.text)
        io.write_line(l);
    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        sub(line, table.copy(line))
    end
    io.progressbar(li / #lines)
end
