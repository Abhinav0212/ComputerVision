function[] = saveFrame(fileName)
    fig = gcf;
    frame = getframe(fig);
    imwrite(frame.cdata,fileName);
end
