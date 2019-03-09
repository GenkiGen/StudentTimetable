class PasswordValidator < ActiveModel::Validator
    def validate(record)
        unless check_length(record.password)
            record.errors.add(:password, 'Password must be longer than 5')
        end

        unless check_digit(record.password)
            record.errors.add(:password, 'Password must contain a digit')
        end

        unless check_normal_char(record.password)
            record.errors.add(:password, 'Password must contain a normal character')
        end

        unless check_special_char(record.password)
            record.errors.add(:password, 'Password must contains a special character')
        end
    end

    private
        def check_length(password)
            return password.length > 5
        end

        def check_normal_char(password)
            return password.chars.any? { |char| /\A[A-z]\z/i.match(char) }
        end

        def check_digit(password)
            return password.chars.any? { |char| /\A[0-9]\z/i.match(char) }
        end

        def check_special_char(password)
            return password.chars.any? { |char| /\A[\~\`\!\@\#\$\%\^\&\*\(\(\-\_\+\=\{\}\[\]\|\\\:\;\"\'\<\,\>\.\?\/]\z/i.match(char) }
        end
end