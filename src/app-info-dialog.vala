/*
 * Copyright 2024 Rirusha
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

[GtkTemplate (ui = "/io/github/Rirusha/Foldy/ui/app-info-dialog.ui")]
public sealed class Foldy.AppInfoDialog : Adw.Dialog {

    [GtkChild]
    unowned Gtk.Image icon_image;
    [GtkChild]
    unowned Gtk.Label name_label;
    [GtkChild]
    unowned Gtk.Label id_label;
    [GtkChild]
    unowned Gtk.Label description_label;
    [GtkChild]
    unowned Gtk.Button launch_button;

    public AppInfo app_info { get; construct; }
    
    public AppInfoDialog (AppInfo app_info) {
        Object (app_info: app_info);
    }

    construct {
        icon_image.gicon = app_info.get_icon ();
        name_label.label = app_info.get_display_name ();
        id_label.label = app_info.get_id ();
        description_label.label = app_info.get_description ();
        
        launch_button.clicked.connect (() => {
            try {
                app_info.launch (null, null);

            } catch (Error e) {
                warning (e.message);
            }
        });
    }
}
