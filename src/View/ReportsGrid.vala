public class ReportsGrid : DoubleColumnContainer {
    Gtk.Label working_counter;
    Gtk.Label breaks_counter;
    Gtk.Label long_breaks_counter;
    TimerLabel worked_time_label;
    TimerLabel break_time_label;
    TimerLabel total_time_label;

    public ReportsGrid () {
        hexpand = true;
        halign = Gtk.Align.CENTER;
        column_spacing = 12;
        row_spacing = 6;
        column_homogeneous = true;

        add_double_column (create_haligned_label (_("Working:"), Gtk.Align.END), working_counter = create_haligned_label (_("0 times"), Gtk.Align.START));
        add_double_column (create_haligned_label (_("Short breaks:"), Gtk.Align.END), breaks_counter = create_haligned_label (_("0 times"), Gtk.Align.START));
        add_double_column (create_haligned_label (_("Long breaks:"), Gtk.Align.END), long_breaks_counter = create_haligned_label (_("0 times"), Gtk.Align.START));

        add_single_column (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));

        add_double_column (create_haligned_label (_("Worked time:"), Gtk.Align.END), worked_time_label = new TimerLabel ());
        add_double_column (create_haligned_label (_("Time on breaks:"), Gtk.Align.END), break_time_label = new TimerLabel ());
        add_double_column (create_haligned_label (_("Total:"), Gtk.Align.END), total_time_label = new TimerLabel ());
    }

    public void update_counter (int working, int sb, int lb) {
        working_counter.label = @"$working times";
        breaks_counter.label = @"$sb times";
        long_breaks_counter.label = @"$lb times";
    }

    public void update_times (uint working_time, uint break_time, uint total_time) {
        worked_time_label.set_time_in_seconds (working_time, false);
        break_time_label.set_time_in_seconds (break_time, false);
        total_time_label.set_time_in_seconds (total_time, false);
    }

    Gtk.Label create_haligned_label (string text, Gtk.Align alignment) {
        var label = new Gtk.Label (text);
        label.halign = alignment;

        return label;
    }
}
