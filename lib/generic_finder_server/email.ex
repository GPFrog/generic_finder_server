defmodule GenericFinderServer.Email do
    defmodule Email do
    use Bamboo.Phoenix, view: GenericFinderServerWeb.Views.EmailView
    alias Randomizer

    #세션 결국 값 저장 불러오기 못함
    def make_email(conn, email_address) do
      code = Randomizer.randomizer(10)
      :ets.insert(:user, {code, email_address, NaiveDateTime.utc_now})
      get = :ets.lookup(:user, code)
      unless (get == []) do
        tuple = hd get
        # 여기서 if code랑 같은지 확인
        save_code = elem(tuple, 0)
        save_email = elem(tuple, 1)
        save_time = elem(tuple, 2)
        IO.puts save_code
        IO.puts save_email
        IO.puts save_time
      else 
        "incorrect code"
      end
      new_email(
        to: email_address,
        from: "tngh147258@gmail.com",
        subject: "Email_certification",
        html_body: "<strong>인증번호는 " <> code <> "입니다.</strong>",
        text_body: ""
      )
    end

    def send(conn, email_address) do
      GenericFinderServer.Email.Email.make_email(conn, email_address)   # Create your email
      |> GenericFinderServer.Mailer.deliver_now() # Send your email
    end

    def certification(conn, code) do
      get = :ets.lookup(:user, code)
      unless (get == []) do
        tuple = hd get
        save_code = elem(tuple, 0)
        save_email = elem(tuple, 1)
        save_time = elem(tuple, 2)
        if save_code == code do
          current_time = NaiveDateTime.utc_now
          diff_time = NaiveDateTime.diff(save_time, current_time)
          if(diff_time < 300) do
            "success"
          else
            "time over"
          end
        else
          "incorrect code"
        end
      else 
        "incorrect code"
      end
    end
  end
end