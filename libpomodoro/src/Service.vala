public class Pomodoro.Service : Object {
    public Pomodoro? current_pomodoro { get; private set; }
    public Timer? timer { get; private set; }
    public bool running = false;
    public int work_interval { get; set; default = 1500; }
    public int short_break_interval { get; set; default = 300; }
    public int long_break_interval { get; set; default = 900; }
    public int normal_breaks_before_long_break { get; set; }

    Sequencer seq;
    TimeStatistics statistics = new TimeStatistics ();

    public Service (Sequencer sequencer = new DefaultSequencer ()) {
        seq = sequencer;
        bind_property ("normal-breaks-before-long-break", seq, "normal-breaks-before-long-break", BindingFlags.DEFAULT);
    }

    public State get_next_state () {
        return seq.next_state ();
    }

    public int count_state (State state) {
        return seq.count_states (state, seq.states_history ());
    }

    public uint count_time_per_state (State state) {
        return statistics.get_time_in_ms (state);
    }

    public void start_next () { start (seq.next_state ()); }

    public void start_work () { start (State.WORKING); }
    public void start_short_break () { start (State.SHORT_BREAK); }
    public void start_long_break () { start (State.LONG_BREAK); }

    public virtual signal void start (State state = State.WORKING) {
        running = true;

        if (current_pomodoro != null) {
            current_pomodoro.end ();
        }

        current_pomodoro = new Pomodoro (state);
        seq.push_state (state);

        if (timer != null) {
            timer.cancel ();
        }

        timer = create_timer (state);
        timer.finished.connect (() => stop ());
        timer.start ();
    }

    public void pause () {
        warning (_("Pause not implemented"));
    }

    public virtual signal void stop (bool was_canceled = false) {
        running = false;

        statistics.add (current_pomodoro.state, timer.get_elapsed_time ());
        current_pomodoro.end ();
        timer.cancel ();

        if (was_canceled) {
            seq.pop_state ();
        }
    }

    protected virtual Timer create_timer (State state) {
        switch (state) {
            case State.WORKING:
                return new DefaultTimer (work_interval);
            case State.SHORT_BREAK:
                return new DefaultTimer (short_break_interval);
            case State.LONG_BREAK:
                return new DefaultTimer (long_break_interval);
            default:
                return new DefaultTimer (1);
        }
    }
}
