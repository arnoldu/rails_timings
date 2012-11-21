#
# Descriptive onedimensional statistics
# 
# (C) Arnold Ude, 2012

class DescriptStat
    def initialize
        @data = []
        @sorted_data = true
    end

    def add(newdatapoint)
        @data << newdatapoint
        @sorted_data = false
    end

    #
    # Number of data points stored
    #
    def n
        return @data.size
    end

    def size
        return n
    end

    def count
        return n
    end

    # 
    # Arithmetical sum of all data
    #
    def sum
        tmp = 0
        @data.each {|p| tmp += p }
        return tmp
    end

    #
    # Arithmetical average
    # 
    def average
        return sum / n
    end

    #
    # Min / Max / Mean
    #
    def min
        if size > 0
            sort
            return @data[0]
        else
            return nil
        end
    end

    def max
        if size > 0
            sort
            return @data[-1]
        else
            return nil
        end
    end

    def mean
        if size == 0
            return nil
        else
            if size % 2 == 1
                return @data[size / 2]
            else
                return 0.5 * (@data[(size / 2).to_i-1]+@data[(size/2).to_i])
            end
        end
    end

    def standard_deviation
        if size >= 2
            tmpsum = 0.0
            tmpavg = average
            @data.each { |xi| tmpsum += (xi-tmpavg) * (xi-tmpavg) }
            return Math.sqrt(tmpsum / (n-1))
        else
            return 0
        end
    end

    def ntile(divisions)
        tmp = []
        sort
        divisions.times do |i|
            dv = ((i * n ) / divisions).to_i - 1
            tmp << @data[dv]
        end
        return tmp
    end



    private
    def sort
        unless @sorted_data
            @data.sort!
        end
        @sorted_data = true
    end


end
