[image, descrips, locs] = sift('scene.pgm');
showkeys(image, locs);
match('scene.pgm','book.pgm');