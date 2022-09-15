from Screenshot import Screenshot
from selenium import webdriver


def screenshot(url):
    ob = Screenshot.Screenshot()
    driver = webdriver.Chrome()
    driver.get(url)
    img_url = ob.full_Screenshot(driver, save_path=r".", image_name="screenshot.png")
    driver.close()

    driver.quit()
    return img_url
