public class DoubleColumnContainer : Gtk.Grid {
    int column = 0;

    public void add_single_column (Gtk.Widget widget) {
        attach (widget, 0, column, 2, 1);
        column++;
    }

    public void add_double_column (Gtk.Widget widget1, Gtk.Widget widget2) {
        attach (widget1, 0, column, 1, 1);
        attach (widget2, 1, column, 1, 1);
        column++;
    }
}
