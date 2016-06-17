module LetUserHelper
  def create_current_user
    User.create(
      provider: "twitter",
      uid: "uid1",
      name: "bobby",
      token: "1234",
      secret: "abigsecret",
      profile_image: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end
end
