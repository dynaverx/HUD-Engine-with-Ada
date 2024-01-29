with Gtk.Window, Gtk.Handlers;
with Gtk.Drawing_Area;
with Cairo;
with Color; use Color;
package Hud_Cb is

   type Position is record
      X : Integer := 0;
      Y : Integer := 0;
   end record;

   procedure Draw_Rectangle (CR : Cairo.Cairo_Context; Pos : Position);

   procedure Draw_Hor_Pointer_R (CR : Cairo.Cairo_Context; Pos : Position);
   procedure Draw_Hor_Pointer_L (CR : Cairo.Cairo_Context; Pos : Position);

   --
   -- Procedure to set the color
   --
   function Set_Color(CR : Cairo.Cairo_Context; Color : RGB_color)
      return Boolean;

   --
   -- Procedure to draw whole HUD once for every cycle:
   --
   procedure Draw (CR : Cairo.Cairo_Context);

   package Window_Cb is new Gtk.Handlers.Return_Callback (
      Gtk.Window.Gtk_Window_Record,
      Boolean);

   function On_Main_Window_Delete_Event
     (Object : access Gtk.Window.Gtk_Window_Record'Class)
      return   Boolean;

   package Event_Cb is new Gtk.Handlers.Return_Callback (
      Gtk.Drawing_Area.Gtk_Drawing_Area_Record,
      Boolean);

   function Redraw
     (Area : access Gtk.Drawing_Area.Gtk_Drawing_Area_Record'Class;
      Cr   : Cairo.Cairo_Context)
      return Boolean;

   function Center_Text
      (Cr : Cairo.Cairo_Context;
        y : Float;
        text : String)
      return Boolean;
end Hud_Cb;
