require 'rails_helper'

RSpec.feature "Tasks", type: :feature do

  before do
    visit new_task_path

    fill_in :task_title, with: 'Buy food'
    fill_in :task_description, with: 'meat'
    click_button I18n.t("submit")
  end

  scenario "Creates a new task" do
    visit new_task_path
    fill_in :task_title, with: 'Exercise'
    fill_in :task_description, with: 'swimming'
    click_button I18n.t("submit")

    expect(page).to have_text(I18n.t("Task_flash.success_created"))
  end

  scenario "Read a task" do
    visit tasks_path
    click_on 'Buy food'

    page.has_content?('Buy food')
    page.has_content?('meat')
  end
  
  scenario "Update a task" do
    visit tasks_path
    click_on 'Buy food'
    click_on I18n.t("Task.edit")
    fill_in :task_title, with: 'Buy seafood'
    fill_in :task_description, with: 'shrimp'
    click_button I18n.t("submit")

    expect(page).to have_text(I18n.t("Task_flash.success_updated"))

    visit tasks_path
    click_on 'Buy seafood'

    page.has_content?('Buy seafood')
    page.has_content?('shrimp')
  end

  scenario "Delete a task" do
    visit tasks_path
    click_on 'Buy food'
    click_on I18n.t("Task.delete")
   
    expect(page.driver.browser.switch_to.alert.text).to eq I18n.t("Task.delete_confirm")
    
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text(I18n.t("Task_flash.success_deleted"))

    visit tasks_path
    page.has_no_content?('Buy food')
  end

  scenario "Tasks ordered by created time descending" do
    visit new_task_path
    fill_in :task_title, with: 'Exercise'
    fill_in :task_description, with: 'swimming'
    click_button I18n.t("submit")

    expected_array = [ 'Exercise', 'Buy food' ]
    all('table a').map(&:text).should eq expected_array
  end
end
