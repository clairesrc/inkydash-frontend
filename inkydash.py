#!/usr/bin/env python3
import os
import time
from inky import auto
from PIL import Image
from screenshotter import screenshot
from dotenv import load_dotenv

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
    load_dotenv()
    print(f"file://{os.getcwd()}/inkydash.html?api={os.getenv('INKYDASH_API_URL')}")
    filename = screenshot(
        f"file://{os.getcwd()}/inkydash.html?api={os.getenv('INKYDASH_API_URL')}"
    )
    print(filename)
    send_to_screen(filename)
    time.sleep(25)


if __name__ == "__main__":
    main()
