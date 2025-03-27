<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="sign.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <style>
  #canvas-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: white;
  }
  .btn-wrapper{
     display: flex;
     justify-content: center;
     align-items: center;
     gap:10px;
  }
</style>

</head>
<body>
    <form id="form1" runat="server">
         <asp:Panel runat="server" class="result-box-right-mask" ID="pnlSign" Width="1000px"  BackColor="#FFCC66" style="display:block">
            <div id="canvas-wrapper">
                <canvas id="signatureCanvas" width="400" height="200" style="border: 1px solid black;">
                <!--長寬定義在css，滑鼠繪製的座標會錯誤-->
                </canvas>
            </div>
            <br />
                    <div class="btn-wrapper">
                        <button type="button" data-action="clear">全部清除</button>
                        <button type="button" data-action="undo">撤銷</button>
                        <button type="button" data-action="redo">還原</button>
                        <button type="button" data-action="change-color">更換筆色</button>
                        <button type="button" data-action="save">儲存</button>
                    </div>
             </asp:Panel>
        客戶確認簽名:<img id="signatureImg" src="images/BSY_logo.png" alt="12314" style="border-bottom:1px solid black; width:100px; height:auto;" />
                                
        <script src="Scripts/signature_pad.umd.min.js"></script>
        <script>
            let undoData = [];
            document.addEventListener("DOMContentLoaded", function () {
                const canvas = document.querySelector("#signatureCanvas");   
                const signaturePad = new SignaturePad(canvas, {
                    backgroundColor: 'rgb(255, 255, 255)',
                    penColor: "black"
                });

                // 當使用者畫新筆劃時，清除undoData
                signaturePad.addEventListener("endStroke", () => {
                    undoData = [];
                });

                // 全部清除
                document.querySelector("[data-action=clear]").addEventListener("click", function () {
                    signaturePad.clear();
                    undoData = [];
                });

                // 變更畫筆顏色
                document.querySelector("[data-action=change-color]").addEventListener("click", function () {
                    if (signaturePad.penColor == 'black') {
                        signaturePad.penColor = 'blue';
                    }
                    else{
                        signaturePad.penColor = 'black';
                    }
                });

                //撤銷
                document.querySelector("[data-action=undo]").addEventListener("click", function () {
                    const data = signaturePad.toData();
                    if (data.length > 0) {
                        const removed = data.pop();
                        undoData.push(removed)
                        signaturePad.fromData(data);
                        console.log(data);
                    }
                });

                //復原
                document.querySelector("[data-action=redo]").addEventListener("click", function () {
                    const data = signaturePad.toData();
                    if (undoData.length > 0) {
                        data.push(undoData.pop());
                        signaturePad.fromData(data);
                        console.log(data);
                    }
                });

                //儲存
                document.querySelector("[data-action=save]").addEventListener("click", function () {
                    if (signaturePad.isEmpty()) {
                        alert("請簽名");
                    }
                    else {
                        //const dataURL = signaturePad.toDataURL();
                        //download(dataURL, "signature.png");
                        console.log("儲存");
                        // 取得簽名的 Base64 圖片
                        const dataURL = signaturePad.toDataURL("image/png");

                        // 存入 localStorage (讓新頁面取得簽名)
                        localStorage.setItem("signatureImage", dataURL);

                        const img = localStorage.getItem("signatureImage");
                        console.log(img);
                        document.getElementById("signatureImg").src = img;

                        
                           
                            setTimeout(function () {
                                window.print();
                            }, 1000); // 讓頁面有時間重新整理

                        // 跳轉到「列印預覽」頁面
                        //window.location.href = "WebForm2.aspx";

                    }
                });
                function closePanel() {
                    var pnl = document.getElementById("pnlSign");
                    if (pnl.style.display == "none") {
                        pnl.style.display = "";
                    }
                    else {
                        pnl.style.display = "none";
                    }
                }
                //function download(dataURL, filename) {
                //    const sign = document.createElement("a");//創建一個 HTMLAnchorElement (超連結標籤 <a>)
                //    sign.href = dataURL;
                //    sign.download = filename;
                //    document.body.appendChild(a);
                //    a.click();
                //    document.body.removeChild(a);
                //}
            });
        </script>
    </form>
</body>
</html>
