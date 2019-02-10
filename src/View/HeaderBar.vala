public class HeaderBar : Gtk.HeaderBar {
    Settings settings = Application.settings;

    public HeaderBar () {
        title = "Pomodoro";
        show_close_button = true;
        get_style_context ().add_class ("default-decoration");

        pack_end (create_sound_btn ());
    }

    Gtk.Widget create_sound_btn () {
        var sound_btn = new MultiImageToggleButton.from_icon_names ("notification-symbolic", "notification-disabled-symbolic");
        settings.bind ("emit-sound", sound_btn, "active", SettingsBindFlags.DEFAULT);
        return sound_btn;
    }
}
