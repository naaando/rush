public class DonePage : Page, PomodoroView {
    Pomodoro.Service? pomodoro_service;
    Gtk.Button next_button;
    Gtk.Button continue_working_button;
    ReportsGrid reports;

    public DonePage.with_factory (ViewFactory factory) {
        add_to_center (create_done_label ());
        add_to_center (create_reports_label ());
        add_to_center (reports = factory.create_reports_view () as ReportsGrid);

        add_to_end (create_btn_box ());
        //  add_to_end (create_go_to_next_switch_box ());
    }

    public void set_pomodoro_service (Pomodoro.Service ps) {
        pomodoro_service = ps;
        pomodoro_service.stop.connect_after (on_pomodoro_service_after_stopped);
    }

    void on_next_button_clicked () {
        return_if_fail (pomodoro_service != null);
        pomodoro_service.start_next ();
    }

    void on_continue_working_button_clicked () {
        return_if_fail (pomodoro_service != null);
        pomodoro_service.start_work ();
    }

    void on_pomodoro_service_after_stopped () {
        reports.update_counter (pomodoro_service.count_state (Pomodoro.State.WORKING),
                                pomodoro_service.count_state (Pomodoro.State.SHORT_BREAK),
                                pomodoro_service.count_state (Pomodoro.State.LONG_BREAK));

        reports.update_times (pomodoro_service.count_time_per_state (Pomodoro.State.WORKING),
                              pomodoro_service.count_time_per_state (Pomodoro.State.SHORT_BREAK),
                              pomodoro_service.count_time_per_state (Pomodoro.State.LONG_BREAK));

        next_button.label = _("Proceed to") + " " + pomodoro_service.get_next_state ().to_string ();
    }

    Gtk.ButtonBox create_btn_box () {
        var continue_working_button = new Gtk.Button.with_label (_("Keep working"));
        continue_working_button.clicked.connect (on_continue_working_button_clicked);

        var next_button = new Gtk.Button.with_label (_("Next"));
        next_button.clicked.connect (on_next_button_clicked);
        next_button.get_style_context ().add_class ("suggested-action");

        var btn_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
        btn_box.set_layout (Gtk.ButtonBoxStyle.CENTER);
        btn_box.spacing = 12;

        btn_box.add (continue_working_button);
        btn_box.add (next_button);

        return btn_box;
    }

    Gtk.Widget create_done_label () {
        var done_label = new Gtk.Label ("Done");
        done_label.get_style_context ().add_class ("h1");
        done_label.get_style_context ().add_class ("done-label");

        return done_label;
    }

    Gtk.Widget create_reports_label () {
        var reports_label = new Gtk.Label ("Reports");
        reports_label.get_style_context ().add_class ("h2");
        reports_label.get_style_context ().add_class ("reports-label");

        return reports_label;
    }

    Gtk.Widget create_go_to_next_switch_box () {
        var go_to_next_switch_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5);
        go_to_next_switch_box.margin = 6;
        var _switch = new Gtk.Switch ();
        go_to_next_switch_box.add (_switch);
        go_to_next_switch_box.add (new Gtk.Label (_("Continue automatically to next pomodoro")));

        return go_to_next_switch_box;
    }
}
