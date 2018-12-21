public class ViewFactory {
    Pomodoro.Service ps;

    public ViewFactory (Pomodoro.Service service) {
        ps = service;
    }

    public void inject_pomodoro_service (PomodoroView view) {
        if (view != null) {
            view.set_pomodoro_service (ps);
        }
    }

    public Gtk.ApplicationWindow create_main_window (Gtk.Application application) {
        var pomodoro_window = new PomodoroWindow.with_factory (application, this);
        inject_pomodoro_service (pomodoro_window as PomodoroView);

        return pomodoro_window;
    }

    public Gtk.Widget create_running_page () {
        var running = new RunningPage.with_factory (this);
        inject_pomodoro_service (running as PomodoroView);

        return running;
    }

    public Gtk.Widget create_done_page () {
        var done = new DonePage.with_factory (this);
        inject_pomodoro_service (done as PomodoroView);

        return done;
    }

    public Gtk.Widget create_reports_view () {
        return new ReportsGrid ();
    }
}
