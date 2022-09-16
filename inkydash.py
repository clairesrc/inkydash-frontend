#!/usr/bin/env python3
import os
import time
from inky import auto
from PIL import Image
from screenshotter import screenshot
from dotenv import load_dotenv
import hitherdither

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
    thresholds = [64, 64, 64]

    # open source image
    image = Image.open(filename).convert("RGB")
    resizedimage = image.resize(inky.resolution)

    palette = hitherdither.palette.Palette(
        inky._palette_blend(saturation, dtype="uint24")
    )
    image_dithered = hitherdither.ordered.bayer.bayer_dithering(
        resizedimage, palette, thresholds, order=8
    )

    # draw image
    inky.set_image(image_dithered, saturation=saturation)
    inky.show()


def main():
    load_dotenv()
    print(
        f"file://{os.getcwd()}/inkydash.html?api={os.getenv('INKYDASH_API_URL')}&theme={os.getenv('INKYDASH_THEME')}"
    )
    filename = screenshot(
        f"file://{os.getcwd()}/inkydash.html?api={os.getenv('INKYDASH_API_URL')}"
    )
    print(filename)
    send_to_screen(filename)
    time.sleep(25)


if __name__ == "__main__":
    main()
