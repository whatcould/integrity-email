require File.dirname(__FILE__) + "/test_helper"

class MailTest < Test::Unit::TestCase
  include NotifierHelpers

  def notifier
    "Email"
  end

  def test_configuration_form
    assert_form_have_tag "h3", :content => "SMTP Server Configuration"

    assert_form_have_option "to",    "foo@example.org"
    assert_form_have_option "from",  "bar@example.org"
    assert_form_have_option "host",  "foobarhost.biz"
    assert_form_have_option "user",  "foobaruser"
    assert_form_have_option "pass",  "secret"
    assert_form_have_option "auth",  "plain"
    assert_form_have_option "pass",  "secret"
    assert_form_have_option "domain","localhost"
  end

  def test_notification_content
    assert notification.include?("Build")
    assert notification.include?("Build #{commit.identifier} was successful")
    assert notification.include?(commit.author.name)
    assert notification.include?(commit.output)
  end
end
