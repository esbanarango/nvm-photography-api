include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :photo do
    camara
		description "MyText"
		aperture "MyString"
		exposure "MyString"
		iso 1
		shutter_speed "MyString"
		color_space "MyString"
		focal_length 1
		took_at "2015-09-06 21:11:26"
		image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'tomster.jpg'), 'image/jpg') }

	  factory :invalid_photo do
			description nil
	  end

  end
end
