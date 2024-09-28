const std = @import("std");
const data = @embedFile("./input");

fn isSymbol(c: u8) bool {
    return c >= '!' and c <= '/' and c != '.';
}

fn check(line: []const u8) bool {
    for (line) |c| {
        if (isSymbol(c)) {
            return true;
        }
    }
    return false;
}

const states = enum {
    LOOKING_NUM,
    LOOKING_SYMBOL,
};

pub fn main() !void {
    // Split input by newline
    var lines = std.mem.tokenize(u8, data, "\n");
    // Collector variable for final result
    var total: i32 = 0;
    var prev: []const u8 = "";
    // Loop over all lines in input
    while (lines.next()) |line| {
        var last: usize = 0;
        var state = states.LOOKING_NUM;

        for (line, 0..) |c, i| {

            if (state == states.LOOKING_NUM and std.ascii.isDigit(c)) {
                state = states.LOOKING_SYMBOL;
                last = i;
                continue;
            }

            if (state == states.LOOKING_NUM) {
                continue;
            }

            if (state == states.LOOKING_SYMBOL and std.ascii.isDigit(c)) {
                continue;
            } else {
                state = states.LOOKING_NUM;
            }
            
            var low: usize = 0;
            if (last != 0) {
                low = last - 1;
            }
            var up: usize = i;

            // Check if char before is symbol
            if (i != low and isSymbol(line[low])) {
                std.debug.print("1 {s}\n", .{line[last..i]});
                total += try std.fmt.parseInt(i32, line[last..i], 10);
                continue;
            }
            if (i != up ) {
                std.debug.print("{u}\n", .{line[up-1]});
            }
            // Check if char after is symbol, unless line ends
            if (i != up and isSymbol(line[up])) {
                std.debug.print("2 {s}\n", .{line[last..i]});
                total += try std.fmt.parseInt(i32, line[last..i], 10);
                continue;
            }
            // Check if previous line contains symbols, unless no previous line
            if (prev.len != 0 and check(prev[low..up])) {
                std.debug.print("3 {s}\n", .{line[last..i]});
                total += try std.fmt.parseInt(i32, line[last..i], 10);
                continue;
            }
            // Peek next line. If there isn't one, continue to last line
            var next = lines.peek() orelse continue;
            // Check if next line contains a symbol
            if (check(next[low..up])) {
                std.debug.print("4 {s}\n", .{line[last..i]});
                //std.debug.print("4 {s}\n", .{next[low..up]});
                total += try std.fmt.parseInt(i32, line[last..i], 10);
                continue;
            }
        }
        prev = line;
    }
    // Print result
    std.debug.print("Total: {d}\n", .{total});
}
