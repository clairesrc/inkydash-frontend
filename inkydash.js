buildModule = (inkymodule) => `
    <div class="widget widget-name-${inkymodule.name}">
        <div class="label">
            ${inkymodule.label}
        </div>
        <div class="widget-content ${inkymodule.widgets ? "widgets-"+inkymodule.widgets.length : "widgets-0"}">
        ${buildWidgets(inkymodule)}
        </div>
    </div>`
    
buildWidgets = (inkymodule) => {
    if (typeof inkymodule.size == "undefined") {
        return inkymodule.widgets.reduce((widgetColumns, widgetColumn) => `
        ${widgetColumns}
        ${buildInnerWidget(widgetColumn.size, inkymodule.data[widgetColumn.name])}`, "")
    } else {
        return buildInnerWidget(inkymodule.size, inkymodule.data)
    }
}

buildInnerWidget = (size, data) => `
    <div class="widget-inner widget-size-${size}">
        <div class="data">
            <span>
                ${data}
            </span>
        </div>
    </div>`


const params = Object.fromEntries(new URLSearchParams(window.location.search).entries())
THEME=params.theme ? params.theme : 'default'
API_URL = params.api ? params.api : "http://inkydash:5000/data"
const wrap = document.getElementById("wrap")

// add theme css file to dom
wrap.innerHTML = `<link rel="stylesheet" href="themes/${THEME}.css" />`

// get data
fetch(`${API_URL}`)
.then(response => response.json())
.then(data => {
    data.map((inkymodule) => {
        wrap.append(new DOMParser().parseFromString(buildModule(inkymodule), "text/html").body.firstElementChild)
    })
})