public abstract class Page : Gtk.Box {
    protected Gtk.Box? center_box;
    protected Gtk.Box? end_box;

    protected Page () {
        orientation = Gtk.Orientation.VERTICAL;
        margin = 6;
        spacing = 6;
        vexpand = true;
        homogeneous = false;
        baseline_position = Gtk.BaselinePosition.CENTER;
    }

    public void add_to_center (Gtk.Widget widget) {
        if (center_box == null) {
            center_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            center_box.halign = Gtk.Align.CENTER;
            center_box.valign = Gtk.Align.CENTER;
            center_box.vexpand = true;
            center_box.spacing = 6;
            add (center_box);
        }

        center_box.add (widget);
    }

    public void add_to_end (Gtk.Widget widget) {
        if (end_box == null) {
            end_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            end_box.halign = Gtk.Align.FILL;
            end_box.hexpand = true;
            end_box.valign = Gtk.Align.END;
            end_box.vexpand = false;
            end_box.spacing = 6;
            end_box.margin = 12;
            add (end_box);
        }

        end_box.add (widget);
    }
}
