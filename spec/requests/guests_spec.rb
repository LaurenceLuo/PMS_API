# spec/requests/guests_spec.rb
require 'rails_helper'

RSpec.describe 'Guests API' do
    # Initialize the test data
    let!(:room) { create(:room) }
    let!(:guests) { create_list(:guest, 20, room_id: room.id) }
    let(:room_id) { room.id }
    let(:id) { guests.first.id }
    
    # Test suite for GET /rooms/:room_id/guests
    describe 'GET /rooms/:room_id/guests' do
        before { get "/rooms/#{room_id}/guests" }
        
        context 'when room exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
            
            it 'returns all room guests' do
                expect(json.size).to eq(20)
            end
        end
        
        context 'when room does not exist' do
            let(:room_id) { 0 }
            
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Room/)
                                               end
                                               end
                                               end
                                               
                                               # Test suite for GET /rooms/:room_id/guests/:id
                                               describe 'GET /rooms/:room_id/guests/:id' do
                                               before { get "/rooms/#{room_id}/guests/#{id}" }
                                               
                                               context 'when room guest exists' do
                                               it 'returns status code 200' do
                                               expect(response).to have_http_status(200)
                                               end
                                               
                                               it 'returns the guest' do
                                               expect(json['id']).to eq(id)
                                               end
                                               end
                                               
                                               context 'when room guest does not exist' do
                                               let(:id) { 0 }
                                               
                                               it 'returns status code 404' do
                                               expect(response).to have_http_status(404)
                                               end
                                               
                                               it 'returns a not found message' do
                                               expect(response.body).to match(/Couldn't find Guest/)
                                                                              end
                                                                              end
                                                                              end
                                                                              
                                                                              # Test suite for PUT /rooms/:room_id/guests
                                                                              describe 'POST /rooms/:room_id/guests' do
                                                                              let(:valid_attributes) { { name: 'Visit Narnia', done: false } }
                                                                              
                                                                              context 'when request attributes are valid' do
                                                                              before { post "/rooms/#{room_id}/guests", params: valid_attributes }
                                                                              
                                                                              it 'returns status code 201' do
                                                                              expect(response).to have_http_status(201)
                                                                              end
                                                                              end
                                                                              
                                                                              context 'when an invalid request' do
                                                                              before { post "/rooms/#{room_id}/guests", params: {} }
                                                                              
                                                                              it 'returns status code 422' do
                                                                              expect(response).to have_http_status(422)
                                                                              end
                                                                              
                                                                              it 'returns a failure message' do
                                                                              expect(response.body).to match(/Validation failed: Name can't be blank/)
                                                                                                             end
                                                                                                             end
                                                                                                             end
                                                                                                             
                                                                                                             # Test suite for PUT /rooms/:room_id/guests/:id
                                                                                                             describe 'PUT /rooms/:room_id/guests/:id' do
                                                                                                             let(:valid_attributes) { { name: 'Mozart' } }
                                                                                                             
                                                                                                             before { put "/rooms/#{room_id}/guests/#{id}", params: valid_attributes }
                                                                                                             
                                                                                                             context 'when guest exists' do
                                                                                                             it 'returns status code 204' do
                                                                                                             expect(response).to have_http_status(204)
                                                                                                             end
                                                                                                             
                                                                                                             it 'updates the guest' do
                                                                                                             updated_guest = Guest.find(id)
                                                                                                             expect(updated_guest.name).to match(/Mozart/)
                                                                                                             end
                                                                                                             end
                                                                                                             
                                                                                                             context 'when the guest does not exist' do
                                                                                                             let(:id) { 0 }
                                                                                                             
                                                                                                             it 'returns status code 404' do
                                                                                                             expect(response).to have_http_status(404)
                                                                                                             end
                                                                                                             
                                                                                                             it 'returns a not found message' do
                                                                                                             expect(response.body).to match(/Couldn't find Guest/)
                                                                                                                                            end
                                                                                                                                            end
                                                                                                                                            end
                                                                                                                                            
                                                                                                                                            # Test suite for DELETE /rooms/:id
                                                                                                                                            describe 'DELETE /rooms/:id' do
                                                                                                                                            before { delete "/rooms/#{room_id}/guests/#{id}" }
                                                                                                                                            
                                                                                                                                            it 'returns status code 204' do
                                                                                                                                            expect(response).to have_http_status(204)
                                                                                                                                            end
                                                                                                                                            end
                                                                                                                                            end
