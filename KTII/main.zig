const std = @import("std");
const data = @embedFile("./input");

const max_red = 12;
const max_green = 13;
const max_blue = 14;

pub fn main() !void {
    // Split input by newline
    var lines = std.mem.tokenize(u8, data, "\n");

    while (lines.next()) |line| {
        var items = std.mem.tokenizeAny(u8, line, ":");

        _ = items.next() orelse unreachable;
        var rada = items.next() orelse unreachable;
        
        var things = std.mem.tokenizeAny(u8, rada, " ");
        
    
        while (things.next()) |item| {
            std.debug.print("{s} ", .{item});
            std.debug.print("{s} ", .{things.next() orelse unreachable});
            var num = try std.fmt.parseFloat(f32, things.next() orelse unreachable);
            std.debug.print("{d} ", .{num});
            std.debug.print("{d:.2}\n", .{num});
        }
    }
}
