#!/usr/bin/env python3
import os
from inky import auto
from PIL import Image

SCREEN_WIDTH = 600
SCREEN_HEIGHT = 488
FONT_FILENAME = "Pillow/Tests/fonts/NotoSansMono-Regular.ttf"


def send_to_screen():
    """Sends image file to Inky screen.
    Sets up Inky API, opens given filename, and draws image.
    """
    # setup
    inky = auto(ask_user=True, verbose=True)
    saturation = 0.5

    # open source image
    image = Image.open(os.getcwd() + "/screenshot.png")
    resizedimage = image.resize(inky.resolution)

    # draw image
    inky.set_image(resizedimage, saturation=saturation)
    inky.show()


def draw_image():
    os.system(
        f"firefox --headless --screenshot --window-size=600,448 file://{os.getcwd()}/inkydash.html"
    )


def main():
    draw_image()
    send_to_screen()


if __name__ == "__main__":
    main()
