Code.require_file "../../test_helper.exs", __DIR__

defmodule FirefoxProfileTest do
  use ExUnit.Case

  alias WebDriver.Firefox.Profile

  setup do
    tempdir = Profile.make_temp_directory
    on_exit fn ->
      File.rm_rf tempdir

      System.cmd("killall", ["--quiet", "firefox-bin", "firefox"])
    end
    {:ok, [tempdir: tempdir]}
  end

  test "set port sets the port key correctly" do
    profile = Profile.set_port Profile.default_profile, 6666
    assert 6666 == Map.get(profile, "webdriver_firefox_port")
  end

  test "cannot set the port to an invalid value" do
    profile = Profile.set_port Profile.default_profile, -2
    assert Map.get(profile, "webdriver_firefox_port") == nil
    profile = Profile.set_port Profile.default_profile, "6666"
    assert Map.get(profile, "webdriver_firefox_port") == nil
  end

  test "to_user_js is the correct format" do
    assert Regex.match? ~r/^(user_pref\("[^"]+",[^)]+\);\n?)+$/, Profile.to_user_js Profile.default_profile
  end

  test "write_profile writes the profile to a tempfile", meta do
    assert File.exists?(Profile.write_profile(Profile.default_profile, meta[:tempdir]))
  end

  test "tells me that I need to fetch webdriver.xpi", meta  do
    assert_raise RuntimeError, fn -> Profile.install_extension meta[:tempdir], __DIR__ end
  end

  test "install extension unzips the webdriver.xpi to the directory", meta do
    Profile.install_extension meta[:tempdir]
    assert File.exists?(Path.join([meta[:tempdir],
       "extensions","fxdriver@googlecode.com","install.rdf"]))
  end
end
