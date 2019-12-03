import karax / [kbase, vdom, kdom, vstyles, karax, karaxdsl, jdict, jstrutils, jjson, kajax]

var
  t: string

proc cb(httpStatus: int, response: cstring) =
  echo response
  echo "NG"
  t = "callback"

proc createDom(): VNode =
  result = buildHtml(tdiv):
    h1: text t
    h2: text t
    h3: text t
    h4: text t
    h5: text t
    h6: text t
    input(value = t):
      proc onkeyup(ev: Event, n: VNode) =
        echo "onkeyup"
        t = $n.value
    textarea(value = t):
      proc onkeyup(ev: Event, n: VNode) =
        echo "onkeyup"
        t = $n.value
    button:
      text "Press"
      proc onclick(ev: Event, n: VNode) =
        echo "clicked"
        t = "clicked"
        ajaxGet("https://ja.wikipedia.org/wiki/Nim",
          headers = @[],
          cont = cb)
    text t

setRenderer createDom
