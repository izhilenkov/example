# coding: utf-8
class Auth
  def initialize(browser)
    @b = browser
  end
  def enter_button
    @b.link(:text => 'Войти')
  end
  def logout_button
    @b.link(:text => 'Выйти')
  end
  def user_snippet
    @b.link(:class => 'user')
  end
  def authorize(email, password)
    @email = email
    @password = password
    @b.text_field(:xpath => "//input[@type='email']").set @email
    @b.text_field(:name => 'user[password]').set @password
  end
  def submit
    @b.button(:id => 'submit')
  end
  def logout(base_url)
    @base_url = base_url
    if (self.user_snippet.exist?)
      @b.goto(@base_url + '/logout/')
    end
  end
  def log_in(email, password)
    @email = email
    @password = password
    if(self.enter_button.exist?)
      self.enter_button.click
      self.authorize(@email, @password)
      self.submit.click
    end
  end
  def auth_error
    @b.p(:text, 'Пользователя с таким e-mail нет или вы указали неправильный пароль').exist?
  end
end