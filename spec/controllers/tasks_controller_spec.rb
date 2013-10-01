require 'spec_helper'

describe TasksController do

  it { subject.should respond_to :index }
  describe '#index' do

    it 'assigns @incomplete_tasks' do
      n = rand(10)
      tasks = create_list(:task, n)
      get :index
      expect(assigns(:incomplete_tasks)).to have(n).items
    end

    it 'assigns @complete_tasks' do
      n = rand(10)
      tasks = create_list(:completed_task, n)
      get :index
      expect(assigns(:complete_tasks)).to have(n).items
    end

  end

  it { subject.should respond_to :new }
  describe '#new' do

    let(:task) { create(:task) }

    it 'assigns @task' do
      get :new, id: task.id
      expect(assigns(:task)).to(be_a_new(Task))
    end

  end

  it { subject.should respond_to :create }
  describe '#create' do

    it 'assigns @task' do
      get :create, task: {}
      expect(assigns(:task)).to(be_a(Task))
    end

    context '@task is invalid' do

      before(:each) do
        post :create, { task: { name: nil } }
      end

      it 'does not save task' do
        expect(assigns(:task)).to_not(be_valid)
      end

      it { should redirect_to tasks_path }

    end

    context '@task is valid' do

      before(:each) do
        post :create, { task: { name: "Some unique task" } }
      end

      it 'saves @task' do
        expect(assigns(:task)).to(be_persisted)
      end

      it { should redirect_to tasks_path }

    end

  end

  it { subject.should respond_to :update }
  describe '#update' do

    let(:task) { create(:task, complete: false, created_at: 10.days.ago, updated_at: 10.days.ago) }

    before(:each) do
      Timecop.freeze
      put :update, id: task.id, task: { complete: true }
    end

    it 'updates @task' do
      expect(assigns(:task)).to(be_complete)
      expect(assigns(:task).updated_at).to eq Time.now
    end

  end

  it { subject.should respond_to :destroy }
  describe '#destroy' do

    let(:task) { create(:task) }

    before(:each) do
      delete :destroy, id: task.id
    end

    it 'destroys @task' do
      expect(assigns(:task)).to(be_destroyed)
    end

  end

end