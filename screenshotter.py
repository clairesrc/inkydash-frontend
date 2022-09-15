from Screenshot import Screenshot
from selenium import webdriver


def screenshot(url):
    ob = Screenshot.Screenshot()
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-setuid-sandbox")
    driver = webdriver.Chrome(options=chrome_options)
    driver.get(url)
    img_url = ob.full_Screenshot(driver, save_path=r".", image_name="screenshot.png")
    driver.close()

    driver.quit()
    return img_url
