const std = @import("std");
const data = @embedFile("./input");

const max_red = 12;
const max_green = 13;
const max_blue = 14;

pub fn main() !void {
    // Split input by newline
    var lines = std.mem.tokenize(u8, data, "\n");
    var total: i32 = 0;

    while (lines.next()) |line| {
        var items = std.mem.tokenizeAny(u8, line, ":");
        // Skip 'Game '
        items.index += 5;

        var game = items.next() orelse unreachable;
        var num = std.fmt.parseInt(i32, game, 10) catch unreachable;
        var success = true;
        // Skip whitespace
        items.index += 2;
        var values = items.next() orelse unreachable;
        var tokens = std.mem.tokenizeSequence(u8, values, "; ");
        while (tokens.next()) |item| {
            var colors = std.mem.tokenizeAny(u8, item, ", ");

             var red: i32 = 0;
             var green: i32 = 0;
             var blue: i32 = 0;
            
             while (colors.next()) |color| {
                 var n = std.fmt.parseInt(i32, color, 10) catch unreachable;
                 var t = colors.next() orelse unreachable;

                 if (std.mem.eql(u8, t, "red")) {
                     red += n;
                 } else if (std.mem.eql(u8, t, "green")) {
                     green += n;
                 } else if (std.mem.eql(u8, t, "blue")) {
                     blue += n;
                 }
             }
             if (red > max_red or green > max_green or blue > max_blue) {
                success = false;
             }
        }
        if (success) {
            std.debug.print("Success: {d}\n", .{num});
            total += num;
        }
    }
    std.debug.print("Total: {d}\n", .{total});
}
