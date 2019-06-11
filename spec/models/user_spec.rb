require_relative '../rails_helper'
# require_relative '../../app/models/user'

describe User do
  context 'associations' do
    it { should have_many(:videos) }
  end

  context 'verifies presence' do
    it 'verifies presence of username' do
      u = User.new
      u.email = 'ion@mail.com'
      u.password = 'parola'
      u.username = ''
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Username can't be blank"]
    end

    it 'verifies presence of email' do
      u = User.new
      u.password = 'parola'
      u.username = 'fghgfh'
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Email can't be blank"]
    end

    it 'verifies presence of password' do
      u = User.new
      u. email = 'ion@mail.com'
      u.password = ''
      u.username = 'fghgfh'
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Password can't be blank"]
    end

    it 'verifies presence of password and username' do
      u = User.new
      u.email = 'ion@mail.com'
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Password can't be blank", "Username can't be blank"]
    end

    it 'verifies presence of password and email' do
      u = User.new
      u.username = 'derfgdrfg'
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Email can't be blank", "Password can't be blank"]
    end

    it 'verifies presence of username and email' do
      u = User.new
      u.password = 'parola'
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Email can't be blank", "Username can't be blank"]
    end

    it 'verifies presence of password, username and email' do
      u = User.new
      u.password = ''
      expect(u.valid?).to eq false
      expect(u.errors.full_messages).to eq ["Email can't be blank", "Password can't be blank", "Username can't be blank"]
    end
  end

  # it "verifies email length" do
  #   u = User.new
  #   u.password = 'parola'
  #   u.username = 'Ion'
  #   u.email = "a" * 999999 + "@example.com"
  #   puts "#{u.email}"
  #   expect(u.valid?).to eq false
  #   expect(u.errors.full_messages).to eq []
  # end

  it "verifies if email is unique" do
    u1 = User.new
    u1.email = "ion@mail.com"
    u1.password = 'orice123'
    u1.username = 'Ion'
    u1.save

    u = User.new
    u.email = "ion@mail.com"
    u.password = 'oricee'
    u.username = 'Ioana'
    u.save
    expect(u.valid?).to eq false
    expect(u.errors.full_messages).to eq ["Email has already been taken"]

    # u1 = FactoryGirl user_ion_sorin
    # u2 = FactoryGirl user_ioana_x
    # u2.email = 'ion@sorin.com'
    # u2.save
    # ... expect ...

  end

  it 'is database authenticable' do
    u = User.create(
        email: 'test@mail.com',
        password: 'password123',
        password_confirmation: 'password123'
    )
    expect(u.valid_password?('password123')).to be_truthy
  end

  context 'with valid role and user' do
    before :each do
      @r = Role.new
      @r.name = "Trial User"
      @r.save

      # @r = FactoryGirl role_trial_user
      #
      # FactoryGirl role_trial_user, class Role
      #   name = "Trial User"
      #   save
      # end
    end

    it 'verifies the default role' do
      u = User.new
      u.set_default_role
      u = User.allocate
      u.send(:initialize)
      expect(u.role).not_to be_nil
      expect(u.role).to eq(@r)
      expect(@r).to eq(Role.find_by_name 'Trial User')

      r2 = Role.new
      r2.name = "Another user"
      r2.save

      expect(u.role).not_to eq(Role.find_by_name 'Another user')
      expect_any_instance_of(User).to receive(:set_default_role)
      User.new
    end
  end

  it 'verifies the destroy method on users' do
    u = User.new
    u.save
    u = User.allocate
    u.send(:initialize)
    expect(u.destroy).not_to be_nil
    u.destroy
  end

  it 'verifies if email is case sensitive' do
    u = User.new
    u.email = 'ION@MAIL.COM'
    u.password = 'parola'
    u.username = 'ion'
    expect(u.valid?).to eq true
  end

  context 'email' do
    before :each do
      @u = User.new
      @u.password = 'parola'
      @u.username = 'ion'
    end

    it 'verifies email with letters only' do
      @u.email = 'drfghgfhgfhgfh'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies email with digits only' do
      @u.email = '23232323232'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies email with digits only but correct format' do
      @u.email = '2323@2323.232'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies email with digits only but with @ character' do
      @u.email = '2323@2323'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies email with digits only but with . character' do
      @u.email = '23232.323'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies email with digits only but incorrect format' do
      @u.email = '23.2323@23'
      @u.email = '23@23232.3'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies email with letters, but incorrect order of . and @ characters' do
      @u.email = 'ion.sorin@com'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies minim number of characters for email' do
      @u.email = 'a@b.c'
      expect(@u.valid?).to eq true
    end

    it 'verifies format: info+mail.com' do
      @u.email = 'info+mail.com'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies format: o`relly@mail.com' do
      @u.email = 'o`relly@mail.com'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies format: test@test@example.com' do
      @u.email = 'test@test@example.com'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'verifies format: lol!`+=?><#$%^&*()@gmail.com' do
      @u.email = 'lol!`+=?><#$%^&*()@gmail.com'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'has no errors for valid email format' do
      @u.email = 'test@gmail.com'
      expect(@u.valid?).to eq true
    end

    it 'strip_whitespace_keys' do
      @u.email = 'f fffff@ma il.c om'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

     it 'a.b.c' do
       @u.email = 'a.b.c'
       expect(@u.valid?).to eq false
       expect(@u.errors.full_messages).to eq ["Email is invalid"]
     end

    it 'a..b' do
      @u.email = 'a..b'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'a.b@c.d' do
      @u.email = 'a.b@c.d'
      expect(@u.valid?).to eq true
    end

    it 'a@a.b.c' do
      @u.email = 'a@a.b.c'
      expect(@u.valid?).to eq true
    end

    it 'a_b@c_d' do
      @u.email = 'a_b@c_d'
      expect(@u.valid?).to eq false
      expect(@u.errors.full_messages).to eq ["Email is invalid"]
    end

    it 'a_b@c.d' do
      @u.email = 'a_b@c.d'
      expect(@u.valid?).to eq true
    end
  end # end-ul contextului



end

