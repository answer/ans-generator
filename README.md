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

`shared_context` の例

    describe Post, "summary" do
      subject{item.summary}

      let(:item){Post.find FactoryGirl.create(:post,
        title: title,
        body: body,
      )}
      let(:title){nil}
      let(:body){nil}

      shared_context "Post.summary.title_exist", title: true do
        let(:title){"タイトル"}
      end
      shared_context "Post.summary.long_body", body: :long do
        let(:body){"長ーい本文"}
      end
      shared_context "Post.summary.short_body", body: :short do
        let(:body){"短い本文"}
      end

      context "タイトルが存在する場合", title: true do
        context "本文が長く存在する場合", body: :long do
          it{should == "タイトル: 長ーい本..."}
        end
        context "本文が短く存在する場合", body: :short do
          it{should == "タイトル: 短い本文"}
        end
        context "本文が存在しない場合" do
          it{should == "タイトル"}
        end
      end

      context "タイトルが存在しない場合" do
        context "本文が長く存在する場合", body: :long do
          it{should == "タイトル: 長ーい本..."}
        end
        context "本文が短く存在する場合", body: :short do
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

      shared_context "Post.trimed_content.long_content", content: :long do
        let(:content){"長ーい内容"}
      end
      shared_context "Post.trimed_content.short_content", content: :short do
        let(:content){"短い内容"}
      end

      shared_examples_for "Post.trimed_content" do
        context "内容が長く存在する場合", content: :long do
          it{should == "長ーい内..."}
        end
        context "内容が短く存在する場合", content: :short do
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

