require 'spec_helper'

describe UsersController do
  let (:users) { [FactoryGirl.create(:user), FactoryGirl.create(:user)] }
  let (:user) { users.first }

  describe "GET 'index'" do
    it "assigns to @users" do
      get 'index'
      assigns(:users).should =~ users
    end

    it 'orders them by name' do
      User.should_receive(:order).with(:name).and_return(User)
      get 'index'
    end

    it 'paginates the list of users' do
      User.stub(order: User)
      User.should_receive(:paginate)
      get 'index'
    end
  end

  describe "GET 'show'" do
    it "assigns to @user" do
      get 'show', id: user.id
      assigns(:user).should == user
    end

    it "assigns the user's ratings to @ratings" do
      ratings = [FactoryGirl.create(:rating, user: user), FactoryGirl.create(:rating, user: user)]
      get 'show', id: user.id
      assigns(:ratings).should =~ ratings
    end
  end

  describe "GET 'new'" do
    it "creates a new User" do
      get 'new'
      assigns(:user).should be_a_new User
    end
  end

  describe "POST 'create'" do
    context 'the user saves successfully' do
      before do
        User.any_instance.stub(save: true)
        User.stub(new: user)
      end

      it 'redirects to the user show page' do
        post 'create', user: {}
        response.should redirect_to user_url(user)
      end

      it 'sets the flash' do
        post 'create', user: {}
        flash[:notice].should == 'User created!'
      end
    end

    context 'the user fails to save' do
      before do
        User.any_instance.stub(save: false)
      end

      it 'renders the new template' do
        post 'create', user: {}
        response.should render_template :new
      end
    end
  end

  describe "GET 'edit'" do
    it "assigns the requested user to @user" do
      get 'edit', id: user.id
      assigns(:user).should == user
    end
  end

  describe "PUT 'update'" do
    context 'the user updates successfully' do
      before do
        User.any_instance.stub(update_attributes: true)
        User.stub(new: user)
      end

      it 'redirects to the user show page' do
        put 'update', id: user, user: {}
        response.should redirect_to user_url(user)
      end

      it 'sets the flash' do
        put 'update', id: user, user: {}
        flash[:notice].should == 'User updated!'
      end
    end

    context 'the user fails to save' do
      before do
        User.any_instance.stub(update_attributes: false)
      end

      it 'renders the edit template' do
        put 'update', id: user, user: {}
        response.should render_template :edit
      end
    end
  end

end
