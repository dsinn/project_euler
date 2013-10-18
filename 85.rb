t0 = Time.now

triangle_num = 1
triangle_inc = 1
height = 1
target = 2000000
target_f = target.to_f

min_diff = target
area = -1

while true
    width_float = (Math.sqrt((target_f / triangle_num) * 8 + 1) - 1) / 2 # Solve n(n + 1)/2 = 2 * 10^6 / triangle_num
    if height > width_float
        break
    end
    
    [width_float.floor, width_float.ceil].each do |width|
        rectangles = width * (width + 1) / 2 * triangle_num
        diff = (rectangles - target).abs
        if min_diff > diff
            min_diff = diff
            area = height * width
            puts height.to_s + ' x ' + width.to_s + ' = ' + area.to_s + ' ; ' + rectangles.to_s + ' rects'
        end
    end

    height += 1
    triangle_inc += 1
    triangle_num += triangle_inc
end

puts area
puts (Time.now - t0).to_s + ' s'