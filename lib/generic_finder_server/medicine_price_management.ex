defmodule GenericFinderServer.MedicinePriceManagement do
    defmodule PriceEnroll do
        def priceEnroll(email, medicine_code, price, bussiness_number) do
            current_time = NaiveDateTime.utc_now |> NaiveDateTime.to_date |> Date.to_string()

            query = Ecto.Adapters.SQL.query!(
                GenericFinderServer.Repo,
                "INSERT INTO User_has_Medicine(User_eMail, Medicine_code, price, registeredDate, Pharmacy_bussinessNumber) VALUES (\'" <> email <> "\', " <> medicine_code <> ", " <> price <> ", \'" <> current_time <> "\', " <> bussiness_number <> ")",
                []
            )
            %MyXQL.Result{num_rows: distinct} = query
            IO.puts distinct
            if distinct == 0 do
                # 실패
                "fail"
            else
                # 성공
                "success"
            end
        end
    end

    # defmodule PriceDelete do
    #     def priceDelete(email, medicine_code, bussiness_number) do
    #         #중복확인
    #         query = Ecto.Adapters.SQL.query!(
    #             GenericFinderServer.Repo,
    #             "SELECT * FROM User WHERE eMail = \"" <> id <> "\" AND passwd = \"" <> password <> "\"",
    #             []
    #         )
                        
    #         %MyXQL.Result{num_rows: distinct} = query
            
    #         IO.puts distinct
            
    #         unless distinct == 0 do
    #             # 이미 존재
    #             "duplication"
    #         else
    #             # 존재하지 않음
    #             query = Ecto.Adapters.SQL.query!(
    #                 GenericFinderServer.Repo,
    #                 "INSERT INTO User(eMail, passwd, authority) VALUES (\""<> id <> "\", \""<> password <>"\", 1)",
    #                 []
    #             )
    #             "ok"
    #         end
    #     end
    # end


    # request 약 이름
    # response 약국이름, 가격, 사용자이메일
    # defmodule PriceLookup do
    #     def priceLookup(medicineName) do
    #         query1 = Ecto.Adapters.SQL.query!(
    #             GenericFinderServer.Repo,
    #             "SELECT code FROM Medicine WHERE name=\"" <> medicineName <> "\"",
    #             []
    #         )
    #         %MyXQL.Result{num_rows: distinct, rows: row} = query
    #         val = hd row |> hd


    #         query2 = Ecto.Adapters.SQL.query!(
    #             GenericFinderServer.Repo,
    #             "SELECT Pharmacy_bussinessNumber, price, User_eMail FROM User_has_Medicine WHERE Medicine_code = ",
    #             []
    #         )
    #     end
    # end
end