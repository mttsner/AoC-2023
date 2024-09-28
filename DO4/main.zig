const std = @import("std");
const data = @embedFile("./input");

pub fn main() !void {
    // Split input by newline
    var lines = std.mem.tokenize(u8, data, "\n");
    // Collector variable for final result
    var total: i32 = 0;

    while (lines.next()) |line| {
        var items = std.mem.tokenizeAny(u8, line, ":|");
        // Skip card number
        _ = items.next() orelse unreachable;
        var winning = items.next() orelse unreachable;
        var win = std.mem.tokenize(u8, winning, " ");
        var map = std.StringHashMap(bool).init(std.heap.page_allocator);

        while (win.next()) |n| {
            try map.put(n, true);
        }

        var numbers = items.next() orelse unreachable;
        var num = std.mem.tokenize(u8, numbers, " ");
        var count: i32 = 0;
        
        while (num.next()) |n| {
            if (map.contains(n)) {
                count += 1;
            }
        }

        if (count > 0) {
            total += std.math.pow(i32, 2, count-1);
        }
    }
    // 25651
    std.debug.print("Total: {d}\n", .{total});
}
