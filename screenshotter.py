from Screenshot import Screenshot
from selenium.webdriver.common.by import By
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time


def screenshot(url):
    ob = Screenshot.Screenshot()
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-setuid-sandbox")
    chrome_options.add_argument("--window-size=600,488")

    d = DesiredCapabilities.CHROME
    d["loggingPrefs"] = {"browser": "ALL"}

    driver = webdriver.Chrome(options=chrome_options, desired_capabilities=d)
    driver.get(url)

    time.sleep(5)
    img_url = ob.full_Screenshot(driver, save_path=r".", image_name="screenshot.png")
    driver.close()
    driver.quit()
    return img_url
