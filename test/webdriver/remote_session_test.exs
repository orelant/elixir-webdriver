Code.require_file "../test_helper.exs", __DIR__
Code.require_file "test_server.exs", __DIR__
defmodule WebDriverRemoteSessionTest do
  use ExUnit.Case

  setup_all do
    {:ok, []}
  end

  setup do
    on_exit fn ->
      WebDriver.stop_browser :remote_test_browser
      WebDriver.stop_session :remote_session
    end
  end

  test "can start a remote 'browser'" do
    config = %WebDriver.Config{browser: :remote, name: :remote_test_browser,
      root_url: "http://localhost:4444/wd/hub"}
    assert {:ok, _} = WebDriver.start_browser config
  end

  test "can start a session on a remote browser" do
    config = %WebDriver.Config{browser: :remote, name: :remote_test_browser,
      root_url: "http://localhost:4444/wd/hub"}
    assert {:ok, _} = WebDriver.start_browser config
    assert {:ok, _} = WebDriver.start_session :remote_test_browser, :remote_session, %{browserName: "chrome"}
  end

  test "can do a url command" do
    config = %WebDriver.Config{browser: :remote, name: :remote_test_browser,
      root_url: "http://localhost:4444/wd/hub"}
    {:ok, _} = WebDriver.start_browser config
    {:ok, _} = WebDriver.start_session :remote_test_browser, :remote_session, %{browserName: "chrome"}
    WebDriver.Session.url :remote_session, "http://elixir-lang.org"
    assert WebDriver.Session.url(:remote_session) == "http://elixir-lang.org/"
  end
end
