require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Student.new(name: "John Cena", email: "ryanz201278@yahoo.com.vn",
                        password: "Rm!t2012781357", password_confirmation: "Rm!t2012781357", time_zone: "Hanoi")
  end

  test 'invalid passwords' do
    invalid_passwords = %w[hell 123213 !@#$% he!@# he1234 12#$ awds!@]
    invalid_passwords.each do |pwd|
      @user.password = @user.password_confirmation = pwd
      assert_not @user.valid?
    end
  end

  test 'valid passwords' do
    valid_passwords = %w[Rm!t201278 jkio12@# jhonSOn!7 !thenedisn3ar]
    valid_passwords.each do |pwd|
      @user.password = @user.password_confirmation = pwd
      assert @user.valid?, "#{pwd} should be valid"
    end
  end

  test 'valid time zones' do
    ActiveSupport::TimeZone.all.map(&:name).each do |name|
      @user.time_zone = name
      assert @user.valid?
    end
  end

  test 'invalid time zones' do
    ActiveSupport::TimeZone.all.map(&:name).each do |name|
      @user.time_zone = name + 'lololl'
      assert_not @user.valid?
    end
  end
end
