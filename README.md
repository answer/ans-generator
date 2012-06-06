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

      context "title: タイトル" do
        let(:title){"タイトル"}

        context "body: 長い本文" do
          let(:body){"長ーい本文"}
          it{should == "タイトル: 長ーい本..."}
        end
        context "body: 短い本文" do
          let(:body){"短い本文"}
          it{should == "タイトル: 短い本文"}
        end
        context "body: null" do
          let(:body){}
          it{should == "タイトル"}
        end
      end

      context "title: null" do
        let(:title){}

        context "body: 長い本文" do
          let(:body){"長ーい本文"}
          it{should == "長ーい本..."}
        end
        context "body: 短い本文" do
          let(:body){"短い本文"}
          it{should == "短い本文"}
        end
        context "body: null の場合" do
          let(:body){}
          it{should == ""}
        end
      end

    end

