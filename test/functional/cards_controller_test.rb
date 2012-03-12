require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get :index, :deck_id => decks(:one)
    assert_response :success
    assert_not_nil assigns(:cards)
  end

  test "should get new" do
    get :new, :deck_id => decks(:one)
    assert_response :success
  end

  test "should create card" do
    assert_difference('Card.count') do
      post :create, card: @card.attributes, :deck_id => decks(:one)
    end

    assert_redirected_to deck_card_path(assigns(:deck), assigns(:card))
  end

  test "should show card" do
    get :show, id: @card, :deck_id => decks(:one)
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @card, :deck_id => decks(:one)
    assert_response :success
  end
  
  test "should get move up" do
    get :move_up, deck_id: decks(:one), card_id: cards(:three)
    assert_not_nil assigns(:card)
    assert_redirected_to deck_reorder_path(decks(:one))
  end
  
  test "should get move down" do
    get :move_down, deck_id: decks(:one), card_id: cards(:three)
    assert_not_nil assigns(:card)
    assert_redirected_to deck_reorder_path(decks(:one))
  end

  test "should update card" do
    put :update, id: @card, card: @card.attributes, :deck_id => decks(:one)
    assert_redirected_to deck_card_path(assigns(:deck), assigns(:card))
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete :destroy, id: @card, :deck_id => decks(:one)
    end

    assert_redirected_to deck_cards_path(assigns(:deck))
  end
end