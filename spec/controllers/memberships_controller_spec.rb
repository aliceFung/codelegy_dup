require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  let!(:owner){create(:user)}
  let!(:member){create(:user)}
  let!(:project){create(:project)}
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

      it 'cannot request project membership for non-existant project' do
        expect do
          post :create, membership: attributes_for(:membership,
                        user_id:       member.id,
                        project_id:   project.id + 123), format: :json
        end.to change(Membership, :count).by(0)
      end

      it 'cannot make a second request if already requested' do
        expect do
          post :create, membership: attributes_for(:membership,
                        user_id:       member.id,
                        project_id:   project.id), format: :json
          post :create, membership: attributes_for(:membership,
                        user_id:       member.id,
                        project_id:   project.id), format: :json
        end.to change(Membership, :count).by(1)
      end

      it 'creates a delayed_job when project membership is requested' do
        expect do
          post :create, membership: attributes_for(:membership,
                        user_id:       member.id,
                        project_id:   project.id), format: :json
        end.to change(Delayed::Job, :count).by(1)
      end

      describe 'messaging' do
        it 'sends a message from the proper person to the proper target' do
          post :create, membership: attributes_for(:membership,
                          user_id:       member.id,
                          project_id:   project.id), format: :json
          expect(Mailboxer::Receipt.all[-2].receiver_id).to eq(owner.id)
        end

        it 'sends a message from the proper person to the proper target' do
          post :create, membership: attributes_for(:membership,
                          user_id:       member.id,
                          project_id:   project.id), format: :json
          expect(Mailboxer::Notification.last.sender_id).to eq(member.id)
        end

        it 'sends a message when project membership is requested' do
          expect do
            post :create, membership: attributes_for(:membership,
                          user_id:       member.id,
                          project_id:   project.id), format: :json
          end.to change(Mailboxer::Receipt, :count).by(2)
        end

        it 'does not send a message when project membership is already requested' do
          expect do
            post :create, membership: attributes_for(:membership,
                          user_id:       member.id,
                          project_id:   project.id), format: :json
            post :create, membership: attributes_for(:membership,
                          user_id:       member.id,
                          project_id:   project.id), format: :json
          end.to change(Mailboxer::Receipt, :count).by(2)
        end

      end


    end

    describe 'PATCH #update' do

      let!(:existing_membership){create(:membership,
                                    project: project, user: member)}
      describe 'Owner Paths' do
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

        it 'should not allow owner to change user_id' do
          allow(controller).to receive(:current_user) { owner }
          allow(controller).to receive(:authenticate_user!) { owner }

          post :update, id: existing_membership.id, format: :json,
                membership: attributes_for(:membership,
                                          user_id: 12345,
                                          id: existing_membership.id,
                                          participant_type: 'member')

          existing_membership.reload
          expect(existing_membership.user_id).to_not eq(12345)
        end

        it 'should not allow owner to change project_id' do
          allow(controller).to receive(:current_user) { owner }
          allow(controller).to receive(:authenticate_user!) { owner }

          post :update, id: existing_membership.id, format: :json,
                membership: attributes_for(:membership,
                                          project_id: 12345,
                                          id: existing_membership.id,
                                          participant_type: 'member')

          existing_membership.reload
          expect(existing_membership.project_id).to_not eq(12345)
        end
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
