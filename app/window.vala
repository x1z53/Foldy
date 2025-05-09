/* Copyright 2024 Rirusha
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-only
 */

[GtkTemplate (ui = "/org/altlinux/Foldy/ui/window.ui")]
public sealed class Foldy.Window : Adw.ApplicationWindow {

    [GtkChild]
    unowned Adw.ToastOverlay toast_overlay;

    const ActionEntry[] ACTION_ENTRIES = {
        { "about", on_about_action },
        { "save-folders", on_save_folders },
        { "restore-folders", on_restore_folders },
    };

    public Window (Foldy.Application app) {
        Object (application: app);
    }

    construct {
        var settings = new Settings (Config.APP_ID_ORIG);

        add_action_entries (ACTION_ENTRIES, this);

        settings.bind ("window-width", this, "default-width", SettingsBindFlags.DEFAULT);
        settings.bind ("window-height", this, "default-height", SettingsBindFlags.DEFAULT);
        settings.bind ("window-maximized", this, "maximized", SettingsBindFlags.DEFAULT);

        if (Config.IS_DEVEL == true) {
            add_css_class ("devel");
        }
    }

    public void show_message (string message) {
        toast_overlay.add_toast (new Adw.Toast (message));
    }

    void on_about_action () {
        var about = new Adw.AboutDialog () {
            application_name = "Foldy",
            application_icon = Config.APP_ID,
            developer_name = "ALT Linux Team",
            artists = {
                "Arseniy Nechkin <krisgeniusnos@gmail.com>",
            },
            developers = {
                "Vladimir Vaskov <rirusha@altlinux.org>"
            },
            version = Config.VERSION,
            // Translators: NAME <EMAIL.COM> /n NAME <EMAIL.COM>
            translator_credits = _("translator-credits"),
            license_type = Gtk.License.GPL_3_0,
            copyright = "© 2024-2025 ALT Linux Team",
            release_notes_version = Config.VERSION
        };

        about.present (this);
    }

    void on_save_folders () {
        var dialog = new Gtk.FileDialog ();
        dialog.title = _("Save folders file");
        dialog.initial_name = "folders-" + Environment.get_user_name ();
        dialog.modal = true;
        dialog.save.begin (this, null, (obj, res) => {
            try {
                var file = ((Gtk.FileDialog) obj).save.end (res);
                save_folders (file.peek_path ());

            } catch (Error e) {
                show_message (e.message);
            }
        });
    }

    void on_restore_folders () {
        var dialog = new Gtk.FileDialog ();
        dialog.title = _("Open folders file");
        dialog.initial_name = "folders-" + Environment.get_user_name ();
        dialog.modal = true;
        dialog.open.begin (this, null, (obj, res) => {
            try {
                var file = ((Gtk.FileDialog) obj).open.end (res);
                restore_folders (file.peek_path (), true);

            } catch (Error e) {
                show_message (e.message);
            }
        });
    }
}
