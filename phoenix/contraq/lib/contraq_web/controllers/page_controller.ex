defmodule ContraqWeb.PageController do
  use ContraqWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
