#!/usr/bin/env python3
import os
from inky import auto
from PIL import Image
from screenshotter import screenshot

SCREEN_WIDTH = 600
SCREEN_HEIGHT = 488
FONT_FILENAME = "Pillow/Tests/fonts/NotoSansMono-Regular.ttf"


def send_to_screen(filename):
    """Sends image file to Inky screen.
    Sets up Inky API, opens given filename, and draws image.
    """
    # setup
    inky = auto(ask_user=True, verbose=True)
    saturation = 0.5

    # open source image
    image = Image.open(filename)
    resizedimage = image.resize(inky.resolution)

    # draw image
    inky.set_image(resizedimage, saturation=saturation)
    inky.show()


def main():
    filename = screenshot(
        f"file://${os.getcwd()}/${os.getenv('INKYDASH_CLIENT_FILENAME')}"
    )
    # print(filename)
    send_to_screen(filename)


if __name__ == "__main__":
    main()
