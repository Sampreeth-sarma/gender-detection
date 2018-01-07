


import webcolors
import sys
import os

def closest_colour(requested_colour):
    min_colours = {}
    for key, name in webcolors.css3_hex_to_names.items():
        r_c, g_c, b_c = webcolors.hex_to_rgb(key)
        rd = (r_c - requested_colour[0]) ** 2
        gd = (g_c - requested_colour[1]) ** 2
        bd = (b_c - requested_colour[2]) ** 2
        min_colours[(rd + gd + bd)] = name
    return min_colours[min(min_colours.keys())]

def get_colour_name(requested_colour):
    try:
        closest_name = actual_name = webcolors.rgb_to_name(requested_colour)
    except ValueError:
        closest_name = closest_colour(requested_colour)
        actual_name = None
    return actual_name, closest_name

def main():
    requested_colour = (int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]))
    #print sys.argv[1], sys.argv[2], sys.argv[3]
    #requested_colour = (113, 66, 22)
    #requested_colour = (int(r),int(g), int(b))
    actual_name, closest_name = get_colour_name(requested_colour)

    print "Actual colour name:", actual_name, ", closest colour name:", closest_name

    if closest_name.count('black') > 0 or closest_name.count('gray') or closest_name.count('grey'):
        print 'found a black or gray color'
        os.environ["isGrayOrBlack"] = "1"
        print os.environ["isGrayOrBlack"]
        f = open("C:\Users\Sravanthi\Desktop\data2.txt", "w")
        f.write("1")      # str() converts to string
        f.close()
    else:
        f = open("C:\Users\Sravanthi\Desktop\data2.txt", "w")
        f.write("0")      # str() converts to string
        f.close()
main()
