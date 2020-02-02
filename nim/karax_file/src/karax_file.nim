include karax / prelude

proc createDom(): VNode =
  result = buildHtml(tdiv):
    h1:
      text "hello world"
    input(`type`="file"):
      text "click here"
      proc onchange(ev: Event, n: VNode) =
        echo ev[]
        echo ev.target[]
        echo n[]

setRenderer createDom
