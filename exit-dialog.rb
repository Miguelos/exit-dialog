#!/usr/bin/env ruby

require 'gtk2'

class ExitDialog < Gtk::Window

  def initialize
    super
    set_title "w"
    signal_connect "destroy" do 
        Gtk.main_quit 
    end
    set_default_size 500, 100
    set_window_position Gtk::Window::POS_CENTER

    ## button box
    button_box =  Gtk::HBox.new
    add button_box

    hibernate_button = Gtk::Button.new "Hibernate"	  
    hibernate_button.signal_connect "clicked" do 
        system 'dbus-send --print-reply --system --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Hibernate'
        Gtk.main_quit 
    end
    button_box.add hibernate_button

    suspend_button = Gtk::Button.new "Suspend"
    suspend_button.signal_connect "clicked" do 
        system 'dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend' 
        Gtk.main_quit
    end
    button_box.add suspend_button

    suspend_button = Gtk::Button.new "Reboot"
    suspend_button.signal_connect "clicked" do 
        system 'dbus-send --print-reply --system --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Reboot' 
    end
    button_box.add suspend_button

    suspend_button = Gtk::Button.new "Shutdown"
    suspend_button.signal_connect "clicked" do 
        system 'dbus-send --print-reply --system --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Shutdown' 
    end
    button_box.add suspend_button

    show_all
    end
end

Gtk.init
    window = ExitDialog.new

Gtk.main
