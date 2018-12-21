public class SegmentedButton : Gtk.Box {
    public signal void clicked (Gtk.Button button);
    public signal void clicked_primary (Gtk.Button button);
    public signal void clicked_secondary (Gtk.Button button);

    Gtk.Button primary_button;
    Gtk.MenuButton menu_button;
    GLib.Menu menu;

    public SegmentedButton (string label, string icon_name) {
        get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);

        primary_button = new Gtk.Button.with_label (label);
        primary_button.hexpand = true;
        primary_button.clicked.connect ((button) => on_primary_button_clicked (button));

        menu = new GLib.Menu ();

        menu_button = new Gtk.MenuButton ();
        menu_button.image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);
        menu_button.set_menu_model (menu);

        add (primary_button);
        add (menu_button);
    }

    public SegmentedButton.from_menu_model (string label, string icon_name, MenuModel menu_model) {
        this (label, icon_name);

        menu_button.set_menu_model (menu_model);
    }

    public void add_action (string label, string action_name) {
        if (!("." in action_name)) {
            warning ("Check action namespace, if your action is on GLib.Application, it's name should look like app.action-name");
        }

        menu.append (label, action_name);
    }

    public void add_menu_item (MenuItem item) {
        menu.append_item (item);
    }

    public GLib.Menu get_menu () {
        return menu;
    }

    void on_primary_button_clicked (Gtk.Button button) {
        clicked (button);
    }
}
