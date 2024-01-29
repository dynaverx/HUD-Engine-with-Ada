with Gtk.Drawing_Area;
with Cairo;
package Color is

 type RGB_color is
      record
         R : Cairo.Color_Range;
         G : Cairo.Color_Range;
         B : Cairo.Color_Range;
      end record;
   color_black : constant RGB_color := (others => 0.0);
   color_white : constant RGB_color := (others => 1.0);

   --
   -- Named colors
   --

   color_red : constant RGB_color := (R => 1.0, others => 0.0);
   color_blue : constant RGB_color := (B => 1.0, others => 0.0);
   color_green : constant RGB_color := (G => 1.0, others => 0.0);

   color_green3 : constant RGB_color := (G => 0.3, others => 0.0);
   color_green4 : constant RGB_color := (G => 0.4, others => 0.0);
   color_green5 : constant RGB_color := (G => 0.5, others => 0.0);
   color_green9 : constant RGB_color := (G => 0.9, others => 0.0);

end Color;
