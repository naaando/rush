public class Pomodoro.DefaultTimer : Object, Timer {
    uint interval_in_seconds;
    TimeoutSource source;

    public DefaultTimer (uint seconds) {
        set_interval (seconds);
    }

    public void set_interval (uint seconds) {
        interval_in_seconds = seconds;
    }

    public uint get_elapsed_time () {
        return interval_in_seconds - get_remaining_time ();
    }

    public uint get_remaining_time () {
        var rem = nanoseconds_to_seconds (source.get_ready_time () - source.get_time ());
        return rem > 0 ? rem : 0;
    }

    public uint get_total_time () {
        return interval_in_seconds;
    }

    public void start () {
        if (source == null) {
            source = create_source ();
        }
    }

    public void cancel () {
        source.destroy ();
    }

    int nanoseconds_to_seconds (int64 ns) {
        return (int) (ns / (1000 * 1000));
    }

    private TimeoutSource create_source () {
        var s = new TimeoutSource.seconds (interval_in_seconds);
        s.set_callback (() => { finished (); return false; });
        s.attach (MainContext.get_thread_default ());
        return s;
    }
}
