module Paperclip
  class Rotator < Thumbnail
   # def transformation_command
    #   if rotate_command
    #     rotate_command
    #   else
    #     super
    #   end
    # end
    
    # def rotate_command
    #   src = @file
    #   dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
    #   dst.binmode
    #   # puts "***************@attachment"+@file.path.inspect
    #   # target = @attachment.instance
    #   # transbackgrd = "/home/mangospring/Projects/paperclip_poc/public/composite.png"
    #   # front_img_rotate = convert(parameters, :source => "#{File.expand_path(src.path)}#{'[0]' unless animated?}", :dest => File.expand_path(dst.path))
    #   success = Paperclip.run('convert' ,"'#{File.expand_path(src.path)}#{'[0]' unless animated?}' -transparent none -rotate -90 '#{File.expand_path(dst.path)}'")
    #   #success = convert("transparent none -rotate -30", :source => "#{File.expand_path(src.path)}#{'[0]' unless animated?}", :dest => File.expand_path(dst.path))
    #   puts "*******aaaaaaaaaa"+success.inspect
    #   puts "dstdstdstdst"+dst.inspect
    #  # front_img_rotate = Paperclip.run('convert' ,"-size 600x600 xc:transparent composite.png")
      
    #  #   " -rotate 120"
    # end


    def make( *args )
      src = @file
      bckgrnd_canvas = Tempfile.new(['bckgrnd1_canvas','.png'])
      Paperclip.run("convert -size 300x300 xc:none #{File.expand_path(bckgrnd_canvas.path)}")

      #transbackgrd = "/home/mangospring/Projects/paperclip_poc/public/composite1.png"
      transbackgrd = File.expand_path(bckgrnd_canvas.path)
      rotated_fdst = Tempfile.new([@basename+"_rotated", ""])
      file_png = File.basename(@file.path,File.extname(@file.path))
      trans_fdst = Tempfile.new([file_png,".png"])
      final = Tempfile.new([file_png+"_final",".png"])
      rotated_fdst.binmode
      trans_fdst.binmode
      final.binmode


      resize_str = '-resize "110x110>" '
      Paperclip.run('convert',"'#{File.expand_path(src.path)}#{'[0]'}' -auto-orient #{resize_str} '#{File.expand_path(rotated_fdst.path)}'")
      Paperclip.run('convert' ,"'#{File.expand_path(rotated_fdst.path)}' -transparent none -rotate 30 '#{File.expand_path(rotated_fdst.path)}'")
      Paperclip.run('convert' ,"'#{File.expand_path(rotated_fdst.path)}' -bordercolor white -border 1x1 -alpha set -channel RGBA -fuzz 20% -fill none -floodfill +0+0 white -shave 1x1 '#{File.expand_path(trans_fdst.path)}'")
      Paperclip.run('composite' ,"-geometry  +100+100 '#{File.expand_path(trans_fdst.path)}' #{transbackgrd} '#{File.expand_path(final.path)}'")
      return final
    end
  end
end