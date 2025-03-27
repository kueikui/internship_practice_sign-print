<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="sign.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <div id="invoice">
                <h2>單據</h2>
                <p>客戶簽名：</p>
                <img id="signaturePreview" alt="簽名圖片載入中...">
                <br />
                <button onclick="printPage()">列印</button>
                <button onclick="goBack()">返回</button>
            </div>

        </div>
        <script>
            const img = localStorage.getItem("signatureImage");
            console.log(img);
            document.getElementById("signaturePreview").src = img;
        </script>
    </form>
</body>
</html>
