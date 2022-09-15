from Screenshot import Screenshot
from selenium.webdriver.common.by import By
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def screenshot(url):
    ob = Screenshot.Screenshot()
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-setuid-sandbox")
    chrome_options.add_argument("--window-size=600,488")
    driver = webdriver.Chrome(options=chrome_options)
    driver.get(url)

    element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CLASS_NAME, "widget"))
    )
    img_url = ob.full_Screenshot(driver, save_path=r".", image_name="screenshot.png")
    driver.close()
    driver.quit()
    return img_url
