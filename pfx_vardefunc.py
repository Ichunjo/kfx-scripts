"""Various functions for pyonfx"""
__author__ = 'Vardë'

from typing import Tuple

import math
from pyonfx import Convert, Shape

# pylint: disable=invalid-name


class ConvertColor:
    """
    This class is a collection of static methods that will help
    the user to convert everything needed to the ASS format.
    """
    @staticmethod
    def rgb_to_hsl(r: int, g: int, b: int)-> Tuple[int, int, int]:
        """Converts RGB color to HSL color

        Args:
            r (int): Must be in range 0-255
            g (int): Must be in range 0-255
            b (int): Must be in range 0-255

        Returns:
            Tuple[int]: HSL int data
        """
        r_, g_, b_ = [c/255 for c in [r, g, b]]
        c_max, c_min = max(r_, g_, b_), min(r_, g_, b_)
        delta = c_max - c_min

        l = (c_max + c_min) / 2

        if delta != 0:
            s = delta / (1 - abs(2*l-1))
        else:
            s = 0

        if delta == 0:
            h = 0.0
        elif c_max == r_:
            h = 60 * (((g_ - b_)/delta) % 6)
        elif c_max == g_:
            h = 60 * ((b_ - r_)/delta + 2)
        elif c_max == b_:
            h = 60 * ((r_ - g_)/delta + 4)

        return round(h*255/360), math.floor(s*255), math.floor(l*255)

    @staticmethod
    def hsl_to_rgb(h: int, s: int, l: int)-> Tuple[int, int, int]:
        """Converts HSL color to RGB color

        Args:
            h (int): Must be in range 0-255
            s (int): Must be in range 0-255
            l (int): Must be in range 0-255

        Returns:
            Tuple[int]: RGB int data
        """
        h_, s_, l_ = min(359, h*360/255), s/255, l/255

        c = (1 - abs(2*l_ - 1)) * s_
        x = c * (1 - abs((h_ / 60) % 2 - 1))
        m = l_ - c/2

        if h_ < 360:
            r_, g_, b_ = c, 0.0, x
        if h_ < 300:
            r_, g_, b_ = x, 0.0, c
        if h_ < 240:
            r_, g_, b_ = 0.0, x, c
        if h_ < 180:
            r_, g_, b_ = 0.0, c, x
        if h_ < 120:
            r_, g_, b_ = x, c, 0.0
        if h_ < 60:
            r_, g_, b_ = c, x, 0.0

        r, g, b = (r_ + m)*255, (g_ + m)*255, (b_ + m)*255
        r, g, b = [max(0, math.floor(x)) for x in [r, g, b]]
        return r, g, b

    @staticmethod
    def rgb_to_hsv(r: int, g: int, b: int)-> Tuple[int, int, int]:
        """Converts RGB color to HSV color

        Args:
            r (int): Must be in range 0-255
            g (int): Must be in range 0-255
            b (int): Must be in range 0-255

        Returns:
            Tuple[int]: HSV int data
        """
        r_, g_, b_ = [c/255 for c in [r, g, b]]
        c_max, c_min = max(r_, g_, b_), min(r_, g_, b_)
        delta = c_max - c_min

        if delta == 0:
            h = 0.0
        elif c_max == r_:
            h = 60 * (((g_ - b_)%6)/delta)
        elif c_max == g_:
            h = 60 * ((b_ - r_)/delta + 2)
        elif c_max == b_:
            h = 60 * ((r_ - g_)/delta + 4)

        if c_max == 0:
            s = 0.0
        else:
            s = delta/c_max

        v = c_max

        return round(h*255/360), math.floor(s*255), math.floor(v*255)

    @staticmethod
    def hsv_to_rgb(h: int, s: int, v: int)-> Tuple[int, int, int]:
        """Converts HSV color to RGB color

        Args:
            h (int): Must be in range 0-255
            s (int): Must be in range 0-255
            v (int): Must be in range 0-255

        Returns:
            Tuple[int]: RGB int data
        """
        h_, s_, v_ = min(359, h*360/255), s/255, v/255
        c = v_ * s_
        x = c * (1 - abs((h_ / 60) % 2 - 1))
        m = v_ - c

        if h_ < 360:
            r_, g_, b_ = c, 0.0, x
        if h_ < 300:
            r_, g_, b_ = x, 0.0, c
        if h_ < 240:
            r_, g_, b_ = 0.0, x, c
        if h_ < 180:
            r_, g_, b_ = 0.0, c, x
        if h_ < 120:
            r_, g_, b_ = x, c, 0.0
        if h_ < 60:
            r_, g_, b_ = c, x, 0.0

        r, g, b = (r_ + m)*255, (g_ + m)*255, (b_ + m)*255

        return math.floor(r), math.floor(g), math.floor(b)

    @staticmethod
    def ass_to_hsl(ass: str)-> Tuple[int, int, int]:
        """Converts ASS color to HSL color
           Wrapper function for convenience

        Args:
            ass (str): ASS string

        Returns:
            Tuple[int]: HSL int data
        """
        rgb = Convert.coloralpha(ass)
        hsl = ConvertColor.rgb_to_hsl(*rgb)
        return hsl

    @staticmethod
    def hsl_to_ass(h: int, s: int, l: int)-> str:
        """Converts HSL color to ASS color

        Args:
            h ([type]): Must be in range 0-255
            s ([type]): Must be in range 0-255
            l ([type]): Must be in range 0-255

        Returns:
            str: ASS string
        """
        rgb = ConvertColor.hsl_to_rgb(h, s, l)
        ass = Convert.coloralpha(*rgb)
        return ass

    @staticmethod
    def ass_to_hsv(ass: str)-> Tuple[int, int, int]:
        """Converts ASS color to HSV color

        Args:
            ass (str): ASS string

        Returns:
            Tuple[int]: HSV int data
        """
        rgb = Convert.coloralpha(ass)
        hsv = ConvertColor.rgb_to_hsv(*rgb)
        return hsv

    @staticmethod
    def hsv_to_ass(h: int, s: int, v: int)-> str:
        """Converts HSV color to ASS color

        Args:
            h (int): Must be in range 0-255
            s (int): Must be in range 0-255
            v (int): Must be in range 0-255

        Returns:
            str: ASS string
        """
        rgb = ConvertColor.hsv_to_rgb(h, s, v)
        ass = Convert.coloralpha(*rgb)
        return ass

class ShapeHandling:
    """
    This class is a collection of static methods that will help
    the user to make changes on shapes.
    """
    @staticmethod
    def rotate_shape_rand(shape: Shape, rotation: float, zerop_x: float, zerop_y: float)-> Shape:
        """Roate a shape by giving rotation parameter

        Args:
            shape (Shape): Your shape to rotate
            rotation (float): Rotation in degree

        Returns:
            Shape: Your shape rotated
        """
        def _eucl_dist(x1, x2, y1, y2):
            return math.sqrt(abs(x1 - x2)**2 + abs(y1 - y2)**2)

        def _calc(x, y, rot, zpx, zpy):
            mx, my = x, y

            # Distance to zero-point
            zpd = _eucl_dist(zpx, mx, zpy, my)

            # Rotation angle – degree to radian
            torot = math.radians(rot)

            # Current angle
            relx = x - zpx
            rely = y - zpy
            curot = math.atan2(relx, rely)

            # New coordinates
            rx = zpd * math.sin(curot + torot) + zpx
            ry = zpd * math.cos(curot + torot) + zpy

            return rx, ry

        return shape.map(lambda x, y: _calc(x, y, rotation, zerop_x, zerop_y))
