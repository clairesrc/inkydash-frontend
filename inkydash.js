const buildModule = (inkymodule) => `
    <div class="widget widget-name-${inkymodule.name}">
        <div class="label">
            ${inkymodule.label}
        </div>
        <div class="widget-content ${inkymodule.widgets ? "widgets-"+inkymodule.widgets.length : "widgets-0"}">
        ${buildWidgets(inkymodule)}
        </div>
    </div>`
    
const buildWidgets = (inkymodule) => {
    if (typeof inkymodule.size == "undefined") {
        return inkymodule.widgets.reduce((widgetColumns, widgetColumn) => `
        ${widgetColumns}
        ${buildInnerWidget(widgetColumn.size, inkymodule.data[widgetColumn.name])}`, "")
    } else {
        return buildInnerWidget(inkymodule.size, inkymodule.data)
    }
}

const buildInnerWidget = (size, data) => `
    <div class="widget-inner widget-size-${size}">
        <div class="data">
            <span>
                ${data}
            </span>
        </div>
    </div>`

const addToNode = (node, html, append = false) => {
    parsed = new DOMParser().parseFromString(html, "text/html").body.firstElementChild
    if (append) {
        node.append(parsed)
        return
    }
    node.prepend(parsed)
}

const debug = (wrap, params) => {
    addToNode(wrap,`<div id="debug">${JSON.stringify(params)}</div>`)
}


const wrap = document.getElementById("wrap")
const params = Object.fromEntries(new URLSearchParams(window.location.search).entries())
THEME=params.theme ? params.theme : 'default'
API_URL = params.api ? params.api : "http://inkydash:5000/data"
DEBUG = params.debug ? true : false

// add theme css file to dom
wrap.innerHTML = `<link rel="stylesheet" href="themes/${THEME}.css" />`

if (DEBUG) {
    debug(wrap, params)
}

// get data
fetch(`${API_URL}`)
.then(response => response.json())
.then(data => {
    data.map((inkymodule) => {
        addToNode(wrap, buildModule(inkymodule), true)
    })
})