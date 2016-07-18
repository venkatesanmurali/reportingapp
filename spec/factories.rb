FactoryGirl.define do
	factory :user do
		name "bill gates"
		email "bill@microsoft.com"
		password "foobar"
		password_confirmation "foobar"
	end
end