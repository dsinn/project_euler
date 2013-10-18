t0 = Time.now

def encode(input)
    r = case input[0]
    when 'T'
        10
    when 'J'
        11
    when 'Q'
        12
    when 'K'
        13
    when 'A'
        14
    else
        input[0].ord - 48
    end

    s = case input[1]
    when 'C'
        0
    when 'D'
        1
    when 'H'
        2
    when 'S'
        3
    end

    (r << 2) + s
end

def rank(x)
    x >> 2
end

def suit(x)
    x & 3
end

def straight?(r)
    if r[4] == 14 and r[0] == 2 and r[1] == 3 and r[2] == 4 and r[3] == 5
        # Ace-low straight
        r.delete_at(4)
        r.insert(0, 1)
        true
    else
        r[0] + 1 == (temp = r[1]) and temp + 1 == (temp2 = r[2]) and temp2 + 1 == (temp = r[3]) and temp + 1 == r[4]
    end
end

def flush?(h)
    temp = suit(h[0])
    temp == suit(h[1]) and temp == suit(h[2]) and temp == suit(h[3]) and temp == suit(h[4])
end

def ranks_value(ranks)
    v = 0
    ranks.each_with_index do |r, i|
        v += r << (i << 2)
    end
    v
end

def hand_value(h)
=begin
0 High card
1 One pair
2 Two pairs
3 Three of a kind
4 Straight
5 Flush
6 Full house
7 Four of a kind
8 Straight flush
=end
    r = h.map { |card| rank(card) }
    if straight? r
        if flush? h
            (8 << 20) + ranks_value(r)
        else
            (4 << 20) + ranks_value(r)
        end
    elsif flush? h
        (5 << 20) + ranks_value(r)
    else
        streak = 1
        for i in 0 .. 3
            if r[i] == r[i + 1]
                streak += 1
            elsif streak > 1
                break
            end
        end

        if streak == 1
            # No streaks => no cards with matching rank
            ranks_value(r)
        elsif streak == 2
            if i == 1 and r[2] == r[3] and r[2] == r[4]
                # Full house
                (6 << 20) + (r[2] << 4) + r[0]
            elsif i < 3
                # Two pairs?
                two_pairs = false
                for j in i .. 3
                    if r[j] == r[j + 1]
                        two_pairs = true
                        break
                    end
                end
                # i < 3 means one of those cards is at index 1
                if two_pairs
                    pairs = [r[i], r[j]]
                    r.delete_at(j)
                    r.delete_at(i)
                    (2 << 20) + (pairs.max << 8) + (pairs.min << 4) + r[0]
                else
                    temp = r[i]
                    r.slice!(i - 1 .. i)[0]
                    (1 << 20) + (temp << 12) + ranks_value(r)
                end
            else
                temp = r[i]
                r.slice!(i - 1 .. i)[0]
                (1 << 20) + (temp << 12) + ranks_value(r)
            end
        elsif streak == 3
            if i == 2 and r[3] == r[4]
                # Full house
                (6 << 20) + (r[0] << 4) + r[3]
            else
                # Three of a kind
                temp = r[i]
                r.slice!(i - 2 .. i)[0]
                (3 << 20) + (temp << 8) + ranks_value(r)
            end
        elsif streak == 4
            # Four of a kind
            (7 << 20) + (r[2] << 4) + (r[0] == r[2] ? r[4] : r[0])
        end
    end
end

count = 0
hands = IO.readlines('poker.txt')
hands.each do |hand|
    p1 = hand.split(' ').map! { |card| encode(card) }
    p2 = p1.slice!(5 .. 9).sort
    p1 = p1.sort
    if hand_value(p1) > hand_value(p2)
        count += 1
    end
end

puts count
puts (Time.now - t0).to_s + ' s'

def print_hand(hand)
    hand.each do |card|
            print case r = rank(card)
            when 10
                10
            when 11
                ' J'
            when 12
                ' Q'
            when 13
                ' K'
            when 14
                ' A'
            else
                ' ' + r.to_s
            end

            print case suit(card)
            when 0
                'C'
            when 1
                'D'
            when 2
                'H'
            when 3
                'S'
            end
            print ' '
        end
        hv = hand_value(hand)
        print '- '
        puts case hv >> 20
        when 0
            'High card'
        when 1
            'One pair'
        when 2
            'Two pairs'
        when 3
            'Three of a kind'
        when 4
            'Straight'
        when 5
            'Flush'
        when 6
            'Full house'
        when 7
            'Four of a kind'
        when 8
            'Straight flush'
        end
end
