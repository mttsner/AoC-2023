const std = @import("std");
const data = @embedFile("./input");

pub fn main() !void {
    // Split input by newline
    var lines = std.mem.tokenize(u8, data, "\n");
    // Collector variable for final result
    var total: i32 = 0;
    // Loop over all lines in input
    while (lines.next()) |line| {
        // 2 character array for first and last number
        var nums = [2]u8{ 0, 0 };
        // Loop over each char in line
        for (line) |ch| {
            // Check if char is a number
            if (std.ascii.isDigit(ch)) {
                if (nums[0] == 0) { // First number not set?
                    nums[0] = ch; // Set both numbers to first found number
                    nums[1] = ch;
                } else {
                    nums[1] = ch; // Set last number
                }
            }
        }
        // Parse the two chars into a number and add to total
        total += try std.fmt.parseInt(i32, &nums, 10);
    }
    // Print result
    std.debug.print("Total: {d}\n", .{total});
}
