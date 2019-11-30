import karax / [kbase, vdom, kdom, vstyles, karax, karaxdsl, jdict, jstrutils, jjson, kajax]

var
  t: string

proc createDom(): VNode =
  result = buildHtml(tdiv):
    input(value = t):
      proc onkeyup(ev: Event, n: VNode) =
        echo "onkeyup"
        t = $n.value
    button:
      text "Press"
      proc onclick(ev: Event, n: VNode) =
        echo "clicked"
        t = "clicked"
    text t

setRenderer createDom
