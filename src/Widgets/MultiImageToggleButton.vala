public class MultiImageToggleButton : Gtk.Button {
    public signal void toggled ();

    bool _active;
    public bool active {
        get {
            return _active;
        }

        set {
            _active = value;
            toggled ();
        }
    }

    public Gtk.Image active_image { get; set; }
    public Gtk.Image inactive_image { get; set; }

    public MultiImageToggleButton.from_icon_names (string active_icon_name, string inactive_icon_name, Gtk.IconSize size = Gtk.IconSize.BUTTON) {
        get_style_context ().remove_class ("toggle");
        get_style_context ().remove_class ("checked");

        active_image = new Gtk.Image.from_icon_name (active_icon_name, size);
        inactive_image = new Gtk.Image.from_icon_name (inactive_icon_name, size);

        set_image_for_current_state ();
        notify["active"].connect (() => set_image_for_current_state ());
    }

    public override void clicked () {
        active = !active;
    }

    void set_image_for_current_state () {
        image = active ? active_image : inactive_image;
    }
}
