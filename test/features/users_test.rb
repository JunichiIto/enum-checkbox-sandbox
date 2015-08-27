require "test_helper"

class UsersTest < Capybara::Rails::TestCase
  test "User form" do
    visit new_user_path

    # 新規作成時、バリデーションエラーが起きても選択値が残っていること
    check 'toyota'
    check 'honda'
    click_on 'Create User'
    assert_content "Name can't be blank"
    assert_checked_field 'toyota'
    assert_unchecked_field 'nissan'
    assert_checked_field 'honda'

    # 新規作成時、選択値が正しく保存されること
    fill_in 'Name', with: 'Alice'
    click_on 'Create User'
    assert_content "User was successfully created."
    assert_content 'toyota'
    refute_content 'nissan'
    assert_content 'honda'
    click_on 'Edit'
    assert_checked_field 'toyota'
    assert_unchecked_field 'nissan'
    assert_checked_field 'honda'

    # 更新時、バリデーションエラーが起きても選択値が残っていること
    fill_in 'Name', with: ''
    uncheck 'toyota'
    check 'nissan'
    click_on 'Update User'
    assert_content "Name can't be blank"
    assert_unchecked_field 'toyota'
    assert_checked_field 'nissan'
    assert_checked_field 'honda'

    # 更新時、選択値が正しく保存されること
    fill_in 'Name', with: 'Alice'
    click_on 'Update User'
    assert_content "User was successfully updated."
    refute_content 'toyota'
    assert_content 'nissan'
    assert_content 'honda'

    # すべて未選択にしても正しく保存されること
    click_on 'Edit'
    uncheck 'nissan'
    uncheck 'honda'
    click_on 'Update User'
    assert_content "User was successfully updated."
    refute_content 'toyota'
    refute_content 'nissan'
    refute_content 'honda'

    # 念のため、CarSelectionのデータが存在しないことを確認
    user = User.find_by_name 'Alice'
    assert_empty user.car_selections
  end
end
