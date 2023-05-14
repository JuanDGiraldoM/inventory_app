defmodule InventoryWeb.Router do
  use InventoryWeb, :router

  alias InventoryWeb.UserController
  alias InventoryWeb.ItemController
  alias InventoryWeb.OrderController
  alias InventoryWeb.InventoryController
  alias InventoryWeb.SalesController

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    resources "/accounts", UserController, except: [:new, :edit, :update]
    put "/accounts/:id", UserController, :update

    resources "/products", ItemController, except: [:new, :edit, :update]
    put "/products/:id", ItemController, :update

    resources "/purchases", OrderController, except: [:new, :edit, :update]
    put "/purchases/:id", OrderController, :update

    get "/inventory", InventoryController, :index
    get "/sales", SalesController, :index
  end
end
