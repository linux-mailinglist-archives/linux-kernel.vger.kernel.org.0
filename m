Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DF3D423
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 19:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406002AbfFKR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 13:29:58 -0400
Received: from mail-eopbgr760055.outbound.protection.outlook.com ([40.107.76.55]:43727
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406080AbfFKR3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKUnyAGVOBwCjqCCOyaCMEvRa5Iy0nPjSo/g5nwJUCw=;
 b=G40SQZo3yHcdJZ/TNbRl/dGlVNXrVqMo3KBajgmwgn2Elyn4oQslii33qkpItT2SSzC/IiMVPBb86PRzUt7xAnsoAOZpoeY5c5HSmj/5GgwYE7k0ac1ooYwEZJwu42hXyD0dKkHV1saYqbt71mvtIlsdgkOMaJ7qt06VvBJj4p8=
Received: from BN6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:405:60::30)
 by BYAPR02MB4935.namprd02.prod.outlook.com (2603:10b6:a03:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.10; Tue, 11 Jun
 2019 17:29:50 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR02CA0089.outlook.office365.com
 (2603:10b6:405:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Tue, 11 Jun 2019 17:29:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Tue, 11 Jun 2019 17:29:49 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Jun 2019 18:29:48 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Jun 2019 18:29:48 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 mark.rutland@arm.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=50346 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hakai-0002MF-Mj; Tue, 11 Jun 2019 18:29:48 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V7 03/11] misc: xilinx_sdfec: Add CCF support
Date:   Tue, 11 Jun 2019 18:29:37 +0100
Message-ID: <1560274185-264438-4-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(8676002)(7636002)(305945005)(71366001)(110136005)(54906003)(16586007)(316002)(60926002)(26826003)(246002)(478600001)(36906005)(50226002)(356004)(8936002)(6666004)(47776003)(5660300002)(50466002)(48376002)(14444005)(476003)(426003)(70586007)(126002)(36756003)(70206006)(486006)(446003)(11346002)(956004)(2616005)(336012)(76130400001)(76176011)(7696005)(51416003)(26005)(9786002)(4326008)(44832011)(186003)(2906002)(107886003)(2201001)(28376004)(106002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4935;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05474269-310a-4105-bcbf-08d6ee92681e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR02MB4935;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4935:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB49355309070489B0C516A217CBED0@BYAPR02MB4935.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bSWt0/6qhvpoRor3vLU424iYabU3JK1WS6nAy65mpcsPj0oF0DH6luZ0KrjKsh6Z8SDjllobfPL3kUnNStxnVGJ3Gv1UlkapwWR+/BJimNDh3duT/yVMN4fgmgiY1ORrg4NrhAQQdymqC7LILTh77kL3C/7985aetc+31lr5iPnaTgMc6r7EHH5Xd4cLGTLJRnTKf7cgMkubmseBaNHb2Bx+uWDeUG5BPCNIxR0LwAYevYqC0otUYOKpwv5Pv3/0MyJJPaR8cRnFhgvUIj5Zt23xszkZc6eneU9Fo28MX0T6SfugKIvvdSbOkVVBzBlzOZpLhFIOrSzBgSjttMnxVqw7yOiIPrNCixF0H5mTkDFia3XFXOPI4HwghxkqQTKRlETuencv8QbBAFLVKBQYrc2Zlb01k8BpsnuXNgLUZEE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 17:29:49.7373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05474269-310a-4105-bcbf-08d6ee92681e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for Linux Clock Control Framework (CCF).
Registers and enables clocks with the Clock Control
Framework (CCF), to prevent shared clocks from been
disabled.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c | 193 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 188 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index ff0704b..f257d38 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -26,11 +26,34 @@ static struct idr dev_idr;
 static struct mutex dev_idr_lock;
 
 /**
+ * struct xsdfec_clks - For managing SD-FEC clocks
+ * @core_clk: Main processing clock for core
+ * @axi_clk: AXI4-Lite memory-mapped clock
+ * @din_words_clk: DIN Words AXI4-Stream Slave clock
+ * @din_clk: DIN AXI4-Stream Slave clock
+ * @dout_clk: DOUT Words AXI4-Stream Slave clock
+ * @dout_words_clk: DOUT AXI4-Stream Slave clock
+ * @ctrl_clk: Control AXI4-Stream Slave clock
+ * @status_clk: Status AXI4-Stream Slave clock
+ */
+struct xsdfec_clks {
+	struct clk *core_clk;
+	struct clk *axi_clk;
+	struct clk *din_words_clk;
+	struct clk *din_clk;
+	struct clk *dout_clk;
+	struct clk *dout_words_clk;
+	struct clk *ctrl_clk;
+	struct clk *status_clk;
+};
+
+/**
  * struct xsdfec_dev - Driver data for SDFEC
  * @regs: device physical base address
  * @dev: pointer to device struct
  * @miscdev: Misc device handle
  * @error_data_lock: Error counter and states spinlock
+ * @clks: Clocks managed by the SDFEC driver
  * @dev_name: Device name
  * @dev_id: Device ID
  *
@@ -42,6 +65,7 @@ struct xsdfec_dev {
 	struct miscdevice miscdev;
 	/* Spinlock to protect state_updated and stats_updated */
 	spinlock_t error_data_lock;
+	struct xsdfec_clks clks;
 	char dev_name[DEV_NAME_LEN];
 	int dev_id;
 };
@@ -50,6 +74,159 @@ static const struct file_operations xsdfec_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int xsdfec_clk_init(struct platform_device *pdev,
+			   struct xsdfec_clks *clks)
+{
+	int err;
+
+	clks->core_clk = devm_clk_get(&pdev->dev, "core_clk");
+	if (IS_ERR(clks->core_clk)) {
+		dev_err(&pdev->dev, "failed to get core_clk");
+		return PTR_ERR(clks->core_clk);
+	}
+
+	clks->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(clks->axi_clk)) {
+		dev_err(&pdev->dev, "failed to get axi_clk");
+		return PTR_ERR(clks->axi_clk);
+	}
+
+	clks->din_words_clk = devm_clk_get(&pdev->dev, "s_axis_din_words_aclk");
+	if (IS_ERR(clks->din_words_clk)) {
+		if (PTR_ERR(clks->din_words_clk) != -ENOENT) {
+			err = PTR_ERR(clks->din_words_clk);
+			return err;
+		}
+		clks->din_words_clk = NULL;
+	}
+
+	clks->din_clk = devm_clk_get(&pdev->dev, "s_axis_din_aclk");
+	if (IS_ERR(clks->din_clk)) {
+		if (PTR_ERR(clks->din_clk) != -ENOENT) {
+			err = PTR_ERR(clks->din_clk);
+			return err;
+		}
+		clks->din_clk = NULL;
+	}
+
+	clks->dout_clk = devm_clk_get(&pdev->dev, "m_axis_dout_aclk");
+	if (IS_ERR(clks->dout_clk)) {
+		if (PTR_ERR(clks->dout_clk) != -ENOENT) {
+			err = PTR_ERR(clks->dout_clk);
+			return err;
+		}
+		clks->dout_clk = NULL;
+	}
+
+	clks->dout_words_clk =
+		devm_clk_get(&pdev->dev, "s_axis_dout_words_aclk");
+	if (IS_ERR(clks->dout_words_clk)) {
+		if (PTR_ERR(clks->dout_words_clk) != -ENOENT) {
+			err = PTR_ERR(clks->dout_words_clk);
+			return err;
+		}
+		clks->dout_words_clk = NULL;
+	}
+
+	clks->ctrl_clk = devm_clk_get(&pdev->dev, "s_axis_ctrl_aclk");
+	if (IS_ERR(clks->ctrl_clk)) {
+		if (PTR_ERR(clks->ctrl_clk) != -ENOENT) {
+			err = PTR_ERR(clks->ctrl_clk);
+			return err;
+		}
+		clks->ctrl_clk = NULL;
+	}
+
+	clks->status_clk = devm_clk_get(&pdev->dev, "m_axis_status_aclk");
+	if (IS_ERR(clks->status_clk)) {
+		if (PTR_ERR(clks->status_clk) != -ENOENT) {
+			err = PTR_ERR(clks->status_clk);
+			return err;
+		}
+		clks->status_clk = NULL;
+	}
+
+	err = clk_prepare_enable(clks->core_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable core_clk (%d)", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(clks->axi_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable axi_clk (%d)", err);
+		goto err_disable_core_clk;
+	}
+
+	err = clk_prepare_enable(clks->din_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable din_clk (%d)", err);
+		goto err_disable_axi_clk;
+	}
+
+	err = clk_prepare_enable(clks->din_words_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable din_words_clk (%d)", err);
+		goto err_disable_din_clk;
+	}
+
+	err = clk_prepare_enable(clks->dout_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable dout_clk (%d)", err);
+		goto err_disable_din_words_clk;
+	}
+
+	err = clk_prepare_enable(clks->dout_words_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable dout_words_clk (%d)",
+			err);
+		goto err_disable_dout_clk;
+	}
+
+	err = clk_prepare_enable(clks->ctrl_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable ctrl_clk (%d)", err);
+		goto err_disable_dout_words_clk;
+	}
+
+	err = clk_prepare_enable(clks->status_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable status_clk (%d)\n", err);
+		goto err_disable_ctrl_clk;
+	}
+
+	return err;
+
+err_disable_ctrl_clk:
+	clk_disable_unprepare(clks->ctrl_clk);
+err_disable_dout_words_clk:
+	clk_disable_unprepare(clks->dout_words_clk);
+err_disable_dout_clk:
+	clk_disable_unprepare(clks->dout_clk);
+err_disable_din_words_clk:
+	clk_disable_unprepare(clks->din_words_clk);
+err_disable_din_clk:
+	clk_disable_unprepare(clks->din_clk);
+err_disable_axi_clk:
+	clk_disable_unprepare(clks->axi_clk);
+err_disable_core_clk:
+	clk_disable_unprepare(clks->core_clk);
+
+	return err;
+}
+
+static void xsdfec_disable_all_clks(struct xsdfec_clks *clks)
+{
+	clk_disable_unprepare(clks->status_clk);
+	clk_disable_unprepare(clks->ctrl_clk);
+	clk_disable_unprepare(clks->dout_words_clk);
+	clk_disable_unprepare(clks->dout_clk);
+	clk_disable_unprepare(clks->din_words_clk);
+	clk_disable_unprepare(clks->din_clk);
+	clk_disable_unprepare(clks->core_clk);
+	clk_disable_unprepare(clks->axi_clk);
+}
+
 static void xsdfec_idr_remove(struct xsdfec_dev *xsdfec)
 {
 	mutex_lock(&dev_idr_lock);
@@ -71,12 +248,16 @@ static int xsdfec_probe(struct platform_device *pdev)
 	xsdfec->dev = &pdev->dev;
 	spin_lock_init(&xsdfec->error_data_lock);
 
+	err = xsdfec_clk_init(pdev, &xsdfec->clks);
+	if (err)
+		return err;
+
 	dev = xsdfec->dev;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	xsdfec->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(xsdfec->regs)) {
 		err = PTR_ERR(xsdfec->regs);
-		return err;
+		goto err_xsdfec_dev;
 	}
 
 	/* Save driver private data */
@@ -86,7 +267,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 	err = idr_alloc(&dev_idr, xsdfec->dev_name, 0, 0, GFP_KERNEL);
 	mutex_unlock(&dev_idr_lock);
 	if (err < 0)
-		goto err_xsddev_idr;
+		goto err_xsdfec_dev;
 	xsdfec->dev_id = err;
 
 	snprintf(xsdfec->dev_name, DEV_NAME_LEN, "xsdfec%d", xsdfec->dev_id);
@@ -97,13 +278,14 @@ static int xsdfec_probe(struct platform_device *pdev)
 	err = misc_register(&xsdfec->miscdev);
 	if (err) {
 		dev_err(dev, "error:%d. Unable to register device", err);
-		return err;
+		goto err_xsdfec_idr;
 	}
 	return 0;
 
-err_xsddev_idr:
+err_xsdfec_idr:
 	xsdfec_idr_remove(xsdfec);
-
+err_xsdfec_dev:
+	xsdfec_disable_all_clks(&xsdfec->clks);
 	return err;
 }
 
@@ -114,6 +296,7 @@ static int xsdfec_remove(struct platform_device *pdev)
 	xsdfec = platform_get_drvdata(pdev);
 	misc_deregister(&xsdfec->miscdev);
 	xsdfec_idr_remove(xsdfec);
+	xsdfec_disable_all_clks(&xsdfec->clks);
 	return 0;
 }
 
-- 
2.7.4

