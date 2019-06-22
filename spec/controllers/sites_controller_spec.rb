require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      subject { post :create, params: { site: attributes_for(:site) } }
      
      it 'adds record to database' do
        expect{ subject }.to change(Site, :count).by(1)
      end

      it 'redirects to site info page' do
        expect(subject).to redirect_to(site_path(assigns(:site).id))
      end
    end

    context 'with invalid attributes' do
      subject { post :create, params: { site: attributes_for(:site, :invalid) } }

      it 'does not adds record to database' do
        expect{ subject }.to change(Site, :count).by(0)
      end

      it 'renders #index template' do
        expect(subject).to render_template :index
      end
    end
  end
end
