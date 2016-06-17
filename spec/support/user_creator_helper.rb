module UserCreatorHelper
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

  def create_second_user
    User.create(
      provider: 'twitter',
      uid: "165243",
      name: "Trey Farese",
      token: "15432",
      secret: "treysecret",
      profile_image: "http://img1.jurko.net/Godfather-Avatar2.gif"
    )
  end

  def create_third_user
    User.create(
      provider: 'twitter',
      uid: "342561",
      name: "Declan Farese",
      token: "23451",
      secret: "declansecret",
      profile_image: "http://img1.jurko.net/avatar_8755.jpg"
    )
  end
end
