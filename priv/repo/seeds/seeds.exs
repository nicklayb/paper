Code.load_file("./priv/repo/seeds/user_seed.exs")
Code.load_file("./priv/repo/seeds/article_seed.exs")

UserSeed.seed()
ArticleSeed.seed()
