require 'spec_helper'

feature 'person#new' do
  context 'without validation' do
    scenario 'new form' do
      visit '/people/new'
      page.should have_css('input#person_name')
      page.should_not have_css('input#person_name[required=required]')
    end

    scenario 'new_without_html5_validation form' do
      visit '/people/new_without_html5_validation'
      page.should have_css('input#person_email')
      page.should_not have_css('input#person_email[required=required]')
    end
  end

  context 'with required validation' do
    background do
      Person.validates_presence_of :name
    end
    after do
      Person._validators.clear
    end
    scenario 'new form' do
      visit '/people/new'
      page.should have_css('input#person_name')
      page.should have_css('input#person_name[required=required]')
    end
    scenario 'new_without_html5_validation form' do
      visit '/people/new_without_html5_validation'
      page.should have_css('input#person_name')
      page.should_not have_css('input#person_name[required=required]')
    end
  end
end