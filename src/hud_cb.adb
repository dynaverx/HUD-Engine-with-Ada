with Gtk.Main;
with Glib; use type Glib.Gdouble;
with Ada.Numerics; use Ada.Numerics;
package body Hud_Cb is
   ticks      : Integer;
   status     : boolean ;
   tmp        :  float := 0.0;

   procedure Draw_Rectangle (Cr : Cairo.Cairo_Context; Pos : Position) is
   begin
      Cairo.Rectangle (Cr     => Cr,
                       X      => Glib.Gdouble (Pos.X),
                       Y      => Glib.Gdouble (Pos.Y),
                       Width  => Glib.Gdouble (20),
                       Height => Glib.Gdouble (12));
      --Cairo.Fill_Preserve (Cr);
   end Draw_Rectangle;

   procedure Draw_Hor_Pointer_L (Cr : Cairo.Cairo_Context; Pos : Position) is
   begin
      Cairo.Move_To(CR, Glib.Gdouble (Pos.X), Glib.Gdouble (Pos.Y));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) + Glib.Gdouble (25),Glib.Gdouble (Pos.Y));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) + Glib.Gdouble (25) + Glib.Gdouble (5), Glib.Gdouble (Pos.Y)+ Glib.Gdouble (5));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) + Glib.Gdouble (25),Glib.Gdouble (Pos.Y)+ Glib.Gdouble (5)+ Glib.Gdouble (5));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) , Glib.Gdouble (Pos.Y)+ Glib.Gdouble (5)+ Glib.Gdouble (5));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) , Glib.Gdouble (Pos.Y));
      --Cairo.Fill_Preserve (Cr);
   end Draw_Hor_Pointer_L;

   procedure Draw_Hor_Pointer_R (Cr : Cairo.Cairo_Context; Pos : Position) is
   begin
      Cairo.Move_To(CR, Glib.Gdouble (Pos.X), Glib.Gdouble (Pos.Y));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) - Glib.Gdouble (25), Glib.Gdouble (Pos.Y));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) - Glib.Gdouble (25) - Glib.Gdouble (5), Glib.Gdouble (Pos.Y) + Glib.Gdouble (5));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) - Glib.Gdouble (25), Glib.Gdouble (Pos.Y) + Glib.Gdouble (5) + Glib.Gdouble (5));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) , Glib.Gdouble (Pos.Y) + Glib.Gdouble (5) + Glib.Gdouble (5));
      Cairo.Line_To(CR, Glib.Gdouble (Pos.X) , Glib.Gdouble (Pos.Y));
      --Cairo.Fill_Preserve (Cr);
   end Draw_Hor_Pointer_R;


   procedure Draw (CR : Cairo.Cairo_Context) is
   begin


      Cairo.Save (CR);
      Cairo.Translate (CR, 400.0, 400.0);
      Cairo.Scale (CR, 800.0/300.0, 800.0/300.0);
      Cairo.Set_Font_Size (CR, 5.0);
      status := Set_Color(CR,color_black);
      Cairo.Paint(CR);



      --
      -- Draw flight path vector
      --

      Cairo.Set_Line_Width(CR, 0.85);
      Cairo.Set_Font_Size(CR, 9.0);
      status := Set_Color(CR,color_green);
      Cairo.Arc(CR, 0.0, -75.0, 6.0, 0.0, Glib.Gdouble(2.0*Ada.Numerics.Pi));

      --
      -- Move to the right side of the circle while
      -- pointing to the center of the circle horizontally
      --

      Cairo.Move_To(CR, 6.0, -75.0-0.0);

      --
      -- Draw line up to the point where the total line
      -- length should be equal to the radius+2 of the circle
      --

      Cairo.Line_To(CR, 14.0, -75.0-0.0);

      -- Draw line to the opposite side of the circle

      Cairo.Move_To(CR, -6.0, -75.0-0.0);
      Cairo.Line_To(CR, -14.0, -75.0-0.0);

      -- Move to the top of the circle

      Cairo.Move_To(CR,  0.0, -75.0-6.0);

      --
      -- Draw line up to the point where the total line
      -- length should be equal to the radius of the circle
      --

      Cairo.Line_To(CR, 0.0, -75.0-6.0-6.0);

      --
      -- Draw Altitude Gauge
      --

      ticks := 4;
      for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, 60.0, -80.0+Glib.Gdouble(2.0*tmp));
         Cairo.Line_To(CR, 70.0, -80.0+Glib.Gdouble(2.0*tmp));
         tmp := tmp+10.0;
      end loop;

      tmp := 0.0;
      ticks := 17;
      for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, 65.0, -80.0+Glib.Gdouble(0.5*tmp));
         Cairo.Line_To(CR, 60.0, -80.0+Glib.Gdouble(0.5*tmp));
         tmp := tmp+10.0;
      end loop;

      tmp := 0.0;
      ticks := 2;
       for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, 72.0, -75.0+Glib.Gdouble(4.0*tmp));
         Cairo.Show_Text(CR, "05.5");
         tmp := tmp+10.0;
       end loop;

       --
       -- Draw Altitude pointer
       --

       Draw_Hor_Pointer_R(CR, (X=> 100 , Y => -40-10));
       Cairo.Move_To(CR, 75.0, -42.0);
       Cairo.Show_Text(CR, "4.870");

      --
      -- Draw Airspeed Gauge
      --

      tmp := 0.0;
      ticks := 4;
      for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, -60.0, -80.0+Glib.Gdouble(2.0*tmp));
         Cairo.Line_To(CR, -70.0, -80.0+Glib.Gdouble(2.0*tmp));
         tmp := tmp+10.0;
      end loop;

      tmp := 0.0;
      ticks := 17;
      for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, -65.0, -80.0+Glib.Gdouble(0.5*tmp));
         Cairo.Line_To(CR, -60.0, -80.0+Glib.Gdouble(0.5*tmp));
         tmp := tmp+10.0;
      end loop;

      ticks := 2;
      tmp := 0.0;
       for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, -82.0, -75.0+Glib.Gdouble(4.0*tmp));
         Cairo.Show_Text(CR, "45");
         tmp := tmp+10.0;
       end loop;

       --
       -- Draw Airspeed pointer
       --

       Draw_Hor_Pointer_L(CR, (X=> -100 , Y => -40-10));
       Cairo.Move_To(CR, -95.0, -42.0);
       Cairo.Show_Text(CR, "445");

      --
      -- Draw Load Factor Value
      --

      Cairo.Move_To(CR, -59.0, -85.0);
      Cairo.Show_Text(CR, "G0.9");
      Cairo.Stroke(CR);

      --
      -- Draw Mach#
      --

      Cairo.Move_To(CR, -59.0, -85.0 + 96.0);
      Cairo.Show_Text(CR, "0.75");
      Cairo.Stroke(CR);

      --
      -- Draw Radar Altimeter Value
      --

      Cairo.Move_To(CR, 59.0-12.0, -85.0 + 96.0);
      Cairo.Show_Text(CR, "R 0.444");
      Cairo.Move_To(CR, 59.0-12.0, -85.0 + 96.0 + 11.0);
      Cairo.Show_Text(CR, "AL200");
      Cairo.Stroke(CR);
      Cairo.Stroke(CR);

      --
      -- Draw Heading Gauge
      --

      tmp := 0.0;
      ticks := 4;
      for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, -30.0 + Glib.Gdouble(2.0*tmp), 25.0);
         Cairo.Line_To(CR, -30.0 + Glib.Gdouble(2.0*tmp), 30.0);
         tmp := tmp+10.0;
      end loop;

      tmp := 0.0;
      ticks := 13;
      for x in 0 .. (ticks - 1) loop
         Cairo.Move_To(CR, -30.0 + Glib.Gdouble(0.5*tmp), 28.0);
         Cairo.Line_To(CR, -30.0 + Glib.Gdouble(0.5*tmp), 30.0);
         tmp := tmp+10.0;
      end loop;

      Draw_Rectangle(CR, (X=> -10 , Y => 35));
      Cairo.Move_To(CR, -8.0, 35.0 + 9.0);
      Cairo.Show_Text(CR, "238");
      Cairo.Move_To(CR, -28.0, 35.0 + 9.0);
      Cairo.Show_Text(CR, "23");
      Cairo.Move_To(CR, 20.0, 35.0 + 9.0);
      Cairo.Show_Text(CR, "24");


      --
      -- Draw Horizon Line
      --

      Cairo.Move_To(CR, -120.0, -40.0);
      Cairo.Line_To(CR, -20.0, -32.0);
      Cairo.Move_To(CR,  20.0, -29.0);
      Cairo.Line_To(CR, 120.0, -22.0);

      --
      -- Draw Pitch Ladder
      --

      Cairo.Move_To(CR, -50.0, -110.0);
      Cairo.Line_To(CR, -20.0, -108.0);
      Cairo.Line_To(CR, -20.2, -105.0);

      Cairo.Move_To(CR,  20.0, -103.0);
      Cairo.Line_To(CR, 50.0, -101.0);
      Cairo.Move_To(CR,  20.0, -103.0);
      Cairo.Line_To(CR, 19.8, -101.0);
      Cairo.Stroke(CR);
      Cairo.Restore (CR);
   end Draw;

   function On_Main_Window_Delete_Event
               (Object : access Gtk.Window.Gtk_Window_Record'Class)
      return   Boolean
   is
      pragma Unreferenced (Object);
   begin
      Gtk.Main.Main_Quit;
      return True;
   end On_Main_Window_Delete_Event;

   function Redraw
               (Area : access Gtk.Drawing_Area.Gtk_Drawing_Area_Record'Class;
                Cr   : Cairo.Cairo_Context)
      return Boolean
   is
      pragma Unreferenced (Area);
   begin
      Draw (Cr);
      return False;
   end Redraw;

   function Center_Text
               (Cr : Cairo.Cairo_Context;
                y : Float;
                text : String)
   return boolean is
   begin
      Cairo.Move_To(Cr, 0.0, Glib.Gdouble(y));
      Cairo.Show_Text(Cr, text);
      return True;
   end Center_Text;

   function Set_Color(
                        Cr : Cairo.Cairo_Context;
                        Color : RGB_color)
   return boolean is
   begin
      Cairo.Set_Source_Rgb(Cr, Color.R, Color.G, Color.B);
      return True;
   end;

end Hud_Cb;
