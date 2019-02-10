public class PomodoroWindow : Gtk.ApplicationWindow, PomodoroView {
    Gtk.Stack pages = new Gtk.Stack ();

    Page running_page;
    Page done_page;

    public PomodoroWindow.with_factory (Gtk.Application application, ViewFactory factory) {
        this (application, factory.create_running_page () as Page, factory.create_done_page () as Page);

        var header_bar = new Gtk.HeaderBar ();
        header_bar.title = "Pomodoro";
        header_bar.show_close_button = true;
        header_bar.get_style_context ().add_class ("default-decoration");

        set_titlebar (header_bar);
    }

    public PomodoroWindow (Gtk.Application application, Page running, Page done) {
        Object (
            application: application,
            resizable: true,
            window_position: Gtk.WindowPosition.CENTER
        );

        set_default_size (240, 450);
        running_page = running;
        done_page = done;

        pages.add (running_page);
        pages.add (done_page);
        add (pages);
    }

    public void set_pomodoro_service (Pomodoro.Service pomodoro_service) {
        pomodoro_service.start.connect (on_pomodoro_service_started);
        pomodoro_service.stop.connect (on_pomodoro_service_stopped);
    }

    void on_pomodoro_service_started () {
        pages.visible_child = running_page;
    }

    void on_pomodoro_service_stopped () {
        pages.visible_child = done_page;
        display_window ();
    }

    private void display_window () {
        //  FIXME: Using present () method looks broken https://stackoverflow.com/questions/9054462/how-do-i-raise-a-window-that-is-minimized-or-covered-with-pygobject
        //  present ();

        set_keep_above (true);
        set_keep_above (false);
    }
}
