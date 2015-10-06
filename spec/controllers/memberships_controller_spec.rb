require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  let(:owner){create(:user)}
  let(:member){create(:user)}
  let(:project){create(:project)}
  let!(:owner_membership){create(:membership, project: project,
                            user: owner, participant_type: "owner")}

  context 'not logged in user' do

    it 'cannot see membership' do
      get :show, id: owner_membership.id, format: :json
      expect(response.status).to eq(401)
    end

  end

  context 'logged in user' do

    before do
      allow(controller).to receive(:current_user) { member }
      allow(controller).to receive(:authenticate_user!) { member }
    end

    describe 'POST #create' do

      it 'can request project membership' do
        expect do
          post :create, membership: attributes_for(:membership,
                        user_id:       member.id,
                        project_id:   project.id), format: :json
        end.to change(Membership, :count).by(1)
      end

    end

    describe 'PATCH #update' do

      let!(:existing_membership){create(:membership,
                                    project: project, user: member)}

      it 'project owner can update membership' do
        allow(controller).to receive(:current_user) { owner }
        allow(controller).to receive(:authenticate_user!) { owner }

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
