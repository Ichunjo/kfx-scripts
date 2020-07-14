"""SAO A OP01"""
import math
import random
from typing import Any, List, Sequence, Tuple

from progress.bar import Bar
from pyonfx import Ass, Convert, FrameUtility, Line, Utils
from vsutil import core

IOS = [Ass("OP1_jap+fra.ass", "OP1_jap+fra_fx.ass"),
       Ass("OP1_jap+eng.ass", "OP1_jap+eng_fx.ass")]
WHITE_COLOR = str(Convert.coloralpha(*[255]*3))
BLACK_COLOR = str(Convert.coloralpha(*[0]*3))


def _varde_color_swap(timing, color_base, start_l, type_c):
    text = "\\%dc%s" % (type_c, color_base)
    if len(timing) > 0:
        for _, ele in enumerate(timing):
            if ele[0] - 20 - start_l == 0:
                start_l += 1
            text += "\\t(%d,%d,\\%dc%s)" % (
                ele[0] - 20 - start_l,
                ele[1] - 20 - start_l, type_c,
                ele[2])
    return text


def _swap_color_box(line: Line, color_base: str, color_change: str, nb_rom_l: int) -> Tuple[str, List[Any]]:
    if line.i+1 == 1+nb_rom_l:
        base = color_change
        timing = [[*[0]*2, color_base], [*[1752]*2, color_change],
                  [*[2169]*2, color_base]]
    elif line.i+1 == 2+nb_rom_l:
        base = color_base
        timing = [[*[927]*2, color_change], [*[1594]*2, color_base]]
    elif line.i+1 == 3+nb_rom_l:
        base = color_base
        timing = [[*[2174]*2, color_change], [*[2383]*2, color_base]]
    elif line.i+1 == 4+nb_rom_l:
        base = color_change
        timing = [[*[167]*2, color_base]]
    elif line.i+1 == 5+nb_rom_l:
        base = color_base
        timing = [[*[0]*2, color_change], [1836, 1920, color_base]]
    elif line.i+1 == 6+nb_rom_l:
        base = color_change
        timing = [[*[1046]*2, color_base]]
    elif line.i+1 == 8+nb_rom_l:
        base = color_base
        timing = [[*[7094]*2, color_change]]
    elif line.i+1 == 10+nb_rom_l:
        base = color_base
        timing = [[*[0]*2, color_change], [*[1051]*2, color_base]]
    elif line.i+1 == 11+nb_rom_l:
        base = color_base
        timing = [[*[0]*2, color_change], [*[1505]*2, color_base],
                  [*[2589]*2, color_change], [*[3590]*2, color_base],
                  [*[4091]*2, color_change], [*[5050]*2, color_base]]
    elif line.i+1 == 15+nb_rom_l:
        base = color_base
        timing = [[132, 341, color_change],
                  [1050, 1383, color_base],
                  [3511, 3594, color_change]]
    elif line.i+1 == 16+nb_rom_l:
        base = color_change
        timing = []
    elif line.i+1 == 17+nb_rom_l:
        base = color_change
        timing = [[*[1920]*2, color_change]]
    else:
        base = color_base
        timing = []

    return base, timing


def _swap_color_inline(line: Line, color_base: str, color_change: str, nb_rom_l: int) -> Tuple[str, List[Any]]:
    klein, leafa, silica, liz, sinon = "&H231C4D&", "&H76AD47&", "&H77AEB5&", "&H9B79A1&", "&H92B463&"
    if line.i+1 == 1+nb_rom_l:
        base = color_change
        timing = [[*[0]*2, color_base], [*[1752]*2, color_change],
                  [*[2169]*2, color_base]]
    elif line.i+1 == 2+nb_rom_l:
        base = color_base
        timing = [[*[927]*2, color_change], [*[1594]*2, color_base]]
    elif line.i+1 == 3+nb_rom_l:
        base = color_base
        timing = [[*[2174]*2, color_change], [*[2383]*2, color_base]]
    elif line.i+1 == 4+nb_rom_l:
        base = color_change
        timing = [[*[167]*2, color_base]]
    elif line.i+1 == 5+nb_rom_l:
        base = color_base
        timing = [[*[0]*2, color_change], [1836, 1920, color_base]]
    elif line.i+1 == 6+nb_rom_l:
        base = color_change
        timing = [[*[1046]*2, color_base], [*[2172]*2, klein]]
    elif line.i+1 == 7+nb_rom_l:
        base = klein
        timing = [[*[468]*2, leafa], [*[1135]*2, silica],
                  [1427, 1553, liz], [*[1761]*2, sinon]]
    elif line.i+1 == 8+nb_rom_l:
        base = sinon
        timing = [[212, 379, color_base], [*[7094]*2, color_change]]
    elif line.i+1 == 10+nb_rom_l:
        base = color_base
        timing = [[*[0]*2, color_change], [*[1051]*2, color_base]]
    elif line.i+1 == 11+nb_rom_l:
        base = color_base
        timing = [[*[0]*2, color_change], [*[1505]*2, color_base],
                  [*[2589]*2, color_change], [*[3590]*2, color_base],
                  [*[4091]*2, color_change], [*[5050]*2, color_base]]
    elif line.i+1 == 15+nb_rom_l:
        base = color_base
        timing = [[132, 341, color_change], [1050, 1383, color_base],
                  [3511, 3594, color_change]]
    elif line.i+1 == 16+nb_rom_l:
        base = color_change
        timing = []
    elif line.i+1 == 17+nb_rom_l:
        base = color_change
        timing = [[*[1920]*2, color_change]]
    else:
        base = color_base
        timing = []

    return base, timing


def roumaji(io: Ass, line: Line, l: Line, ms_from_frame: float) -> None:
    # Set vars
    leadin = 200
    l.start_time = line.start_time - leadin
    l.end_time = line.end_time
    dur = l.end_time - l.start_time

    speed = 250 / 10000  # pixels / ms
    distance = dur * speed
    left, right = line.left - distance/2 - line.width / 4, line.right + distance/2 + line.width/4
    top, bottom = line.top - 50, line.bottom + 50

    # Box
    color_base, timing = _swap_color_box(line, line.styleref.color3, BLACK_COLOR, 0)
    l.style = line.style + ' Box'
    l.text = '{\\an5\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\blur1\\1a&HFF&%s' \
        '\\clip(%.3f,%.3f,%.3f,%.3f)\\t(0,%d,\\clip(%.3f,%.3f,%.3f,%.3f))' \
        '\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))}%s' % (
            line.center + distance/2, line.middle, line.center - distance/2, line.middle, 0, dur,
            _varde_color_swap(timing, color_base, -leadin, 3),
            left, bottom, left, bottom, leadin, left, top, right, bottom,
            leadin, leadin, left - distance, top, right + distance, bottom,
            dur - 350, dur, right + distance, top, right + distance, top,
            line.text)
    io.write_line(l)

    l.style = line.style
    # Inline
    color_base, timing = _swap_color_inline(line, line.styleref.color1, "&HC3C0B8&", 0)
    for syl in Utils.all_non_empty(line.syls):
        l.start_time = line.start_time - leadin
        l.end_time = line.end_time
        dur = l.end_time - l.start_time

        distance = dur * speed
        # Set vars
        syl.start_time += leadin
        syl.end_time += leadin
        syldur = syl.end_time - syl.start_time

        fscx = line.styleref.scale_x
        fscy = line.styleref.scale_y

        l.text = '{\\an5\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\blur1%s' \
            '\\t(%.3f,%.3f,\\fscx%d,\\fscy%d)\\t(%.3f,%.3f,0.8,\\fscx%d,\\fscy%d)' \
            '\\clip(%.3f,%.3f,%.3f,%.3f)\\t(0,%d,\\clip(%.3f,%.3f,%.3f,%.3f))' \
            '\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))}%s' % (
                syl.center + distance/2, line.middle, syl.center - distance/2, line.middle, 0, dur,
                _varde_color_swap(timing, color_base, -leadin, 1),
                *[syl.start_time]*2, fscx*1.65, fscy*1.65, syl.start_time +
                syldur/8, syl.end_time, fscx, fscy,
                left, bottom, left, bottom, leadin, left, top, right, bottom,
                leadin, leadin, left - distance, top, right + distance, bottom,
                dur - 350, dur, right + distance, top, right + distance, top,
                syl.text)
        io.write_line(l)

    # Jitter syl
    for char in Utils.all_non_empty(line.chars):
        l.start_time = line.start_time - leadin
        l.end_time = line.end_time
        dur = l.end_time - l.start_time

        distance = dur * speed
        pos_x1, pox_x2 = char.center + distance/2, char.center - distance/2
        pos_y = line.middle

        for s, e, i, n in FrameUtility(l.start_time, l.end_time, ms_from_frame):
            l.start_time = s
            l.end_time = e

            frame_char_start_time = math.ceil(
                (char.start_time + leadin)/ms_from_frame)
            frame_char_end_time = math.ceil(
                (char.end_time + leadin)/ms_from_frame)

            if i in range(frame_char_start_time, frame_char_end_time+1):
                l.text = '{\\an5\\pos(%.3f,%.3f)\\bord0\\blur4\\c%s\\1a%s}%s' % (
                    pos_x1 + (pox_x2-pos_x1)*(i-1)/n + random.uniform(-75, 75), pos_y + random.uniform(-60, 60),
                    BLACK_COLOR, Convert.coloralpha(57),
                    char.text)
                io.write_line(l)
                l.text = '{\\an5\\pos(%.3f,%.3f)\\bord0\\blur4\\c%s\\1a%s}%s' % (
                    pos_x1 + (pox_x2-pos_x1)*(i-1)/n + random.uniform(-75, 75), pos_y + random.uniform(-60, 60),
                    WHITE_COLOR, Convert.coloralpha(92),
                    char.text)
                io.write_line(l)


def sub(io: Ass, line: Line, l: Line, nb_rom_l: int) -> None:
    # Set vars
    leadin = 200
    l.start_time = line.start_time - leadin
    l.end_time = line.end_time
    dur = l.end_time - l.start_time

    speed = 250 / 10000  # pixels / ms
    distance = dur * speed
    left, right = line.left - distance/2 - line.width / 4, line.right + distance/2 + line.width/4
    top, bottom = line.top - 50, line.bottom + 50

    # Box
    color_base, timing = _swap_color_box(line, line.styleref.color3, BLACK_COLOR, nb_rom_l)
    l.style = line.style + ' Box'
    l.text = '{\\an5\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\blur1\\1a&HFF&%s' \
        '\\clip(%.3f,%.3f,%.3f,%.3f)\\t(0,%d,\\clip(%.3f,%.3f,%.3f,%.3f))' \
        '\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))}%s' % (
            line.center - distance/2, line.middle, line.center + distance/2, line.middle, 0, dur,
            _varde_color_swap(timing, color_base, -leadin, 3),
            right, bottom, right, bottom, leadin, left, top, right, bottom,
            leadin, leadin, left - distance, top, right + distance, bottom,
            dur - 350, dur, left - distance, top, left - distance, top,
            line.text)
    io.write_line(l)

    # Inline
    l.style = line.style
    color_base, timing = _swap_color_inline(line, line.styleref.color1, "&HC3C0B8&", nb_rom_l)
    l.start_time = line.start_time - leadin
    l.end_time = line.end_time
    dur = l.end_time - l.start_time

    distance = dur * speed

    l.text = '{\\an5\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\blur1%s' \
        '\\clip(%.3f,%.3f,%.3f,%.3f)\\t(0,%d,\\clip(%.3f,%.3f,%.3f,%.3f))' \
        '\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))\\t(%d,%d,\\clip(%.3f,%.3f,%.3f,%.3f))}%s' % (
            line.center - distance/2, line.middle, line.center + distance/2, line.middle, 0, dur,
            _varde_color_swap(timing, color_base, -leadin, 1),
            right, bottom, right, bottom, leadin, left, top, right, bottom,
            leadin, leadin, left - distance, top, right + distance, bottom,
            dur - 350, dur, left - distance, top, left - distance, top,
            line.text)
    io.write_line(l)


def do_fx(ios: Sequence[Ass]) -> None:
    """main function"""
    for io in ios:
        meta, _, lines = io.get_data()
        video = core.ffms2.Source(meta.video)
        ms_from_frame = 1000 / (video.fps_num / video.fps_den)

        nb_rom_l = sum(line.styleref.alignment == 8 for line in lines)

        with Bar('Processing', max=len(lines), suffix='%(percent)d%%') as progress_bar:
            for line in lines:
                if line.comment is False:
                    if line.styleref.alignment == 8:
                        roumaji(io, line, line.copy(), ms_from_frame)
                    else:
                        sub(io, line, line.copy(), nb_rom_l)
                progress_bar.next()
            progress_bar.finish()
        io.save()
    # io.open_aegisub()
    # io.open_mpv(video_start='00:02:18', full_screen=False)


if __name__ == "__main__":
    do_fx(IOS)
