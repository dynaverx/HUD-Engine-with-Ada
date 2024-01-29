with Gtk.Widget;          use Gtk.Widget;
with Gtk.Main;
with Gtk.Window;          use Gtk.Window;
with Glib;                use type Glib.Gdouble;
with Cairo;
with Cairo.Image_Surface;
with Cairo.Surface;
with Gtk.Drawing_Area;    use Gtk.Drawing_Area;
with Hud_Cb;      use Hud_Cb;

procedure Main is
   Win       : Gtk_Window;
   Area_Draw : Gtk.Drawing_Area.Gtk_Drawing_Area;

begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   --  Create a window with a size of 800x800
   Gtk_New (Win);
   Win.Set_Default_Size (800, 800);
   Gtk.Drawing_Area.Gtk_New (Area_Draw);
   Win.Add (Area_Draw);

   Event_Cb.Connect
     (Area_Draw,
      Signal_Draw,
      Event_Cb.To_Marshaller (Redraw'Access));
   Window_Cb.Connect
     (Win,
      Signal_Delete_Event,
      Window_Cb.To_Marshaller (On_Main_Window_Delete_Event'Access));

   --  Show the window
   Win.Show_All;


   --  Start the Gtk+ main loop
   Gtk.Main.Main;
end Main;
