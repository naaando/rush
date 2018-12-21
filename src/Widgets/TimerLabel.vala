public class TimerLabel : Gtk.Label {
    public void set_time_in_seconds (uint _seconds, bool compact = true) {
        var hours = (int) (_seconds/3600); // 3600 == 1h
        var minutes = (int) (_seconds - (hours * 3600))/60;
        var seconds = (int) _seconds - (minutes * 60);

        if (compact) {
            label = "%.2i:%.2i".printf (minutes, seconds);
            if (hours > 0) {
                label = "%.2i:%.2i:%.2i".printf (hours, minutes, seconds);
            }

            return;
        }

        label = @"$hours " + _("hours") + @" $minutes " + _("minutes");
    }
}
