function[] = saveFrame(fileName)
    frame = getframe;
    imwrite(frame.cdata,fileName);
end
