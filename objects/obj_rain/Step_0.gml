if (obj_time_manager.current_phase == "day") {
    part_system_automatic_draw(self.part_system, false);
    part_system_clear(self.part_system);
} else {
    part_system_automatic_draw(self.part_system, true);
}