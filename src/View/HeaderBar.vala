public class HeaderBar : Gtk.HeaderBar {
    public HeaderBar () {
        title = "Pomodoro";
        show_close_button = true;
        get_style_context ().add_class ("default-decoration");

        pack_end (create_settings_button ());
        pack_end (create_sound_btn ());
    }

    Gtk.Widget create_settings_button () {
        var menu_btn = new Gtk.MenuButton ();
        menu_btn.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        menu_btn.popover = create_settings_popover ();
        return menu_btn;
    }

    Gtk.Popover create_settings_popover () {
        var grid = new Gtk.Grid ();
        grid.margin = 12;
        grid.column_spacing = grid.row_spacing = 12;

        SettingsBindGetMappingShared convert_seconds_to_minutes = (ret, val) => {
            ret = val.get_int32 () / 60;
            return true;
        };

        SettingsBindSetMappingShared convert_minutes_to_seconds = (val, expected_type) => {
            var secs = val.get_double () * 60;
            if (secs == 0) secs = 1;
            return new Variant ("i", (int) secs);
        };

        //  Work time
        var work_time_adjustment = new Gtk.Adjustment (0, 0.0, double.MAX, 1, 5, 0);
        var work_time_spin = new Gtk.SpinButton (work_time_adjustment, 4, 0);
        grid.attach (new Gtk.Label (_("Working:")), 0, 0);
        grid.attach (work_time_spin, 1, 0);
        Application.settings.bind_with_mapping ("interval-work", work_time_adjustment, "value", SettingsBindFlags.DEFAULT, convert_seconds_to_minutes, convert_minutes_to_seconds, null, null);

        //  Short break
        var short_break_adjustment = new Gtk.Adjustment (0, 0, double.MAX, 1, 5, 0);
        var short_break_spin = new Gtk.SpinButton (short_break_adjustment, 1, 0);
        grid.attach (new Gtk.Label (_("Short breaks:")), 0, 1);
        grid.attach (short_break_spin, 1, 1);
        Application.settings.bind_with_mapping ("interval-break", short_break_adjustment, "value", SettingsBindFlags.DEFAULT, convert_seconds_to_minutes, convert_minutes_to_seconds, null, null);

        //  Long break
        var long_break_adjustment = new Gtk.Adjustment (0, 0, double.MAX, 1, 5, 0);
        var long_break_spin = new Gtk.SpinButton (long_break_adjustment, 1, 0);
        grid.attach (new Gtk.Label (_("Long breaks:")), 0, 2);
        grid.attach (long_break_spin, 1, 2);
        Application.settings.bind_with_mapping ("interval-long-break", long_break_adjustment, "value", SettingsBindFlags.DEFAULT, convert_seconds_to_minutes, convert_minutes_to_seconds, null, null);

        //  Align labels to end
        grid.forall ((widget) => {
            if (widget is Gtk.Label) {
                widget.halign = Gtk.Align.END;
            }
        });

        var popover = new Gtk.Popover (null);
        popover.add (grid);
        grid.show_all ();
        return popover;
    }

    Gtk.Widget create_sound_btn () {
        var sound_btn = new MultiImageToggleButton.from_icon_names ("notification-symbolic", "notification-disabled-symbolic");
        Application.settings.bind ("emit-sound", sound_btn, "active", SettingsBindFlags.DEFAULT);
        return sound_btn;
    }
}
