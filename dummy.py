for alpha in "abcdefghijklmnopqrstuvwxyz":
    for i in range(1, 4):
        index = "%03d" % i
        filename = "{name}{index}.js".format(name=alpha, index=index)
        print(filename)
        with open(filename, "w") as f:
            f.write("")
