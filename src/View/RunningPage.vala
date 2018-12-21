public class RunningPage : Page, PomodoroView {
    PomodoroLabel state_label;
    TimerLabel timer_label;
    Cancellable cancellable;
    Pomodoro.Service? pomodoro_service;
    Gtk.Stack start_n_stop_stack;

    public RunningPage.with_factory (ViewFactory factory) {
        add_to_center (create_state_label ());
        add_to_center (create_timer_label ());
        add_to_center (create_time_left_label ());

        add_to_end (create_control_buttons_stack ());
        //  add_to_end (create_autostart_switch_box ());
    }

    public void set_pomodoro_service (Pomodoro.Service ps) {
        pomodoro_service = ps;
        pomodoro_service.start.connect (on_pomodoro_service_started);
        pomodoro_service.stop.connect (on_pomodoro_service_stopped);
    }

    void on_pomodoro_service_started (Pomodoro.State state) {
        state_label.set_pomodoro_state (state);

        cancellable = new Cancellable ();
        Timeout.add (500, () => {
            timer_label.set_time_in_seconds (pomodoro_service.timer.get_remaining_time ());
            return !cancellable.is_cancelled ();
        });

        print (@"Pomodoro started\n");
        start_n_stop_stack.visible_child_name = "stop-button";
    }

    void on_pomodoro_service_stopped () {
        cancellable.cancel ();
        start_n_stop_stack.visible_child_name = "start-button";
    }

    void on_start_button_clicked () {
        return_if_fail (pomodoro_service != null);
        pomodoro_service.start_next ();
    }

    void on_stop_button_clicked () {
        return_if_fail (pomodoro_service != null);
        pomodoro_service.stop ();
    }

    Gtk.Widget create_state_label () {
        state_label = new PomodoroLabel ();
        state_label.set_pomodoro_state (Pomodoro.State.WORKING);
        state_label.get_style_context ().add_class ("h1");

        return state_label;
    }

    Gtk.Widget create_timer_label () {
        timer_label = new TimerLabel ();
        timer_label.get_style_context ().add_class ("timer-label");
        timer_label.get_style_context ().add_class ("h2");
        timer_label.label = "00:00";

        return timer_label;
    }

    Gtk.Widget create_time_left_label () {
        var time_left_label = new Gtk.Label ("Left");
        time_left_label.get_style_context ().add_class ("h2");

        return time_left_label;
    }

    Gtk.Widget create_control_buttons_stack () {
        var start_button = new SegmentedButton (_("Start"), "tools-timer-symbolic");

        start_button.add_action ("Start working", "app.pomodoro-start-work");
        start_button.add_action ("Start short break", "app.pomodoro-start-break");
        start_button.add_action ("Start long break", "app.pomodoro-start-long-break");

        start_button.clicked.connect (on_start_button_clicked);

        var stop_button = new Gtk.Button.with_label (_("Stop"));
        stop_button.get_style_context ().add_class ("destructive-action");
        stop_button.clicked.connect (on_stop_button_clicked);

        start_n_stop_stack = new Gtk.Stack ();
        start_n_stop_stack.add_named (start_button, "start-button");
        start_n_stop_stack.add_named (stop_button, "stop-button");

        return start_n_stop_stack;
    }

    Gtk.Widget create_autostart_switch_box () {
        var autostart_switch_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5);
        autostart_switch_box.margin = 6;
        var autostart_switch = new Gtk.Switch ();
        autostart_switch_box.add (autostart_switch);
        autostart_switch_box.add (new Gtk.Label (_("Start running on app startup")));

        return autostart_switch_box;
    }
}
