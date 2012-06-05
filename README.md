ans-generator
=============

rails3 用 view, rspec, feature の雛形を追加する


view
----

* 鋭意作成中


rspec
-----

以下のテンプレートを置き換える

* model
* and more...(鋭意作成中)


feature
-------

* 鋭意作成中


examples
--------

### rspec model ###

ネストした context の例

    describe Post, "summary" do
      subject{item.summary}

      let(:item){Post.find FactoryGirl.create(:post,
        title: title,
        body: body,
      )}
      let(:title){nil}
      let(:body){nil}

      context "タイトルが存在する場合" do
        let(:title){"タイトル"}

        context "本文が長く存在する場合" do
          let(:body){"長ーい本文"}
          it{should == "タイトル: 長ーい本..."}
        end
        context "本文が短く存在する場合" do
          let(:body){"短い本文"}
          it{should == "タイトル: 短い本文"}
        end
        context "本文が存在しない場合" do
          it{should == "タイトル"}
        end
      end

      context "タイトルが存在しない場合" do
        context "本文が長く存在する場合" do
          let(:body){"長ーい本文"}
          it{should == "タイトル: 長ーい本..."}
        end
        context "本文が短く存在する場合" do
          let(:body){"短い本文"}
          it{should == "タイトル: 短い本文"}
        end
        context "本文が存在しない場合" do
          it{should == ""}
        end
      end

    end

`shared_examples_for` の例

    describe Post, "trimed_content" do
      let(:item){Post.find FactoryGirl.create(:post,
        attr => content,
      )}
      let(:attr){nil}
      let(:content){nil}

      shared_examples_for "Post.trimed_content" do
        context "内容が長く存在する場合" do
          let(:content){"長ーい内容"}
          it{should == "長ーい内..."}
        end
        context "内容が短く存在する場合" do
          let(:content){"短い内容"}
          it{should == "短い内容"}
        end
        context "内容が存在しない場合" do
          it{should == ""}
        end
      end

      describe "trimed_title" do
        subject{item.trimed_title}
        let(:attr){:title}
        it_should_behave_like "Post.trimed_content"
      end

      describe "trimed_body" do
        subject{item.trimed_body}
        let(:attr){:body}
        it_should_behave_like "Post.trimed_content"
      end

    end

