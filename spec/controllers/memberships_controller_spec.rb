require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  let(:owner){create(:user)}
  let(:member){create(:user)}
  let(:project){create(:project)}
  let!(:owner_membership){create(:membership, project: project,
                            user: owner, participant_type: "owner")}

  context 'not logged in user' do

    it 'cannot see membership' do
      allow(controller).to receive(:current_user) { nil }
      get :show, id: owner_membership.id, format: :json
      expect(response.status).to eq(401)
    end

  end

  context 'logged in user' do

    describe 'POST #create' do

      it 'project owner can create a membership' do
        allow(controller).to receive(:current_user) { owner }
        expect do
          post :create, membership: attributes_for(:membership,
                        user_id:       member,
                        project_id:   project), format: :json
        end.to change(Membership, :count).by(1)
      end

      it 'project member cannot create a membership' do
        allow(controller).to receive(:current_user) { member }
        new_member = create(:user)
        new_membership = create(:membership, project: project,
                                user: member)
        expect do
          post :create, membership: attributes_for(:membership,
                        user_id:       new_member,
                        project_id:   project), format: :json
        end.to change(Membership, :count).by(0)
      end
    end

    describe 'PATCH #update' do

      let!(:existing_membership){create(:membership,
                                    project: project, user: member)}

      it 'project owner can update membership' do
        allow(controller).to receive(:current_user) { owner }

        post :update, id: existing_membership.id, format: :json,
              membership: attributes_for(:membership,
                                        id: existing_membership.id,
                                        participant_type: 'member')

        existing_membership.reload
        expect(existing_membership.participant_type).to eq('member')
      end

      it "others cannot update membership" do
        allow(controller).to receive(:current_user) { member }

        post :update, id: existing_membership.id, format: :json,
                membership: attributes_for(:membership,
                                        id: existing_membership.id,
                                        participant_type: 'member')

        existing_membership.reload
        expect(existing_membership.participant_type).to_not eq('member')
      end

    end

  end #end context logged in user
end
