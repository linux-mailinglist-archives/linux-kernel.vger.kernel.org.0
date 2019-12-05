Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF74113BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 07:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLEGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 01:37:42 -0500
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:58084
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfLEGhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:37:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2brJ/HPiV9E+ykRe/DzkpdjdtERdGJlT5wqWQJWENvOxpo8v0OiZ1B7TDRs67b7CnXh+aVgbKJroIUrNj0Y+YGXAHg+1m0JGOnJW7HMlU1/m/ga7BA7hY14gG8++sC+87hMQP2RzVcE69Bo0l0h74ktXSzhW5gHNCzD1vS9dN4gnOTIJ+UTxdCbs5Cj7qdzTmvaa5YigAeVm4EzoCJlLX3IXZQ5cCJNYth3u54Paoh7V01yOIJ3cA2+8GY4JWD3GVocOJAleajqT5Yxd4pxA2Ih0ezfNP7sIuFzvLWRh7pPZJFQ8/FGCZ3MI1zxYeq4wApgudasseIfWBhFADzKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKxWj3qsVG6zfdAsWNxAoo1z1VXi0/nfZCtWcP1myN4=;
 b=f2S2cfig4ByROChbO8mEFLxk1w/vQk5GJOuGNoJQp6HAl2m785u62mHur53JiC6lnQ9XfrFp6tXSFmReJMVTonuaLw5lAfcRZqsLV8O5eXF2K/1wwKpqr0DFRzxMPGn/PUicikvMCmbxVbhk294xiHOuQefoBFfXzQ013wAz+m/YZxoruPdfs9iECGrvhNy2MLS1ocGjIrVFBVcUG7vB/lzUaWK8gBtvy0ttW98Jegpu/7cga5WVswHjKI9HEM4w+DSVmqpJRIcVUEB9FWjiHZ3qLdD3x4sLp/eefwucZIb+tplVnFsnjZOqIrSkidmFB2fF4Dd64i1GXRio88Dm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKxWj3qsVG6zfdAsWNxAoo1z1VXi0/nfZCtWcP1myN4=;
 b=aAnVo1iSWpRq+wsqzUnuCeQCLb6gB66sZF0gSgOS7wYhRriG6pvwkieqiyajGOV4BYO/H5zhPmLtGCBHY8DafR5FRgUj5y4YzzTA6jNmwvYuU9yCwBQrl73alz+svH3rNphHVoWiD6nuvqGA1s/KmUD8k3HtKWljv1Tv1xgoMw4=
Received: from SN4PR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:803:2e::12) by DM6PR02MB6667.namprd02.prod.outlook.com
 (2603:10b6:5:219::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Thu, 5 Dec
 2019 06:37:35 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0026.outlook.office365.com
 (2603:10b6:803:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 06:37:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 5 Dec 2019 06:37:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ickla-0000xK-Ig; Wed, 04 Dec 2019 22:37:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklV-0000XV-FW; Wed, 04 Dec 2019 22:37:29 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB56bK8u010331;
        Wed, 4 Dec 2019 22:37:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklL-0000WL-Uz; Wed, 04 Dec 2019 22:37:20 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 4/6] clk: zynqmp: Add support for get max divider
Date:   Wed,  4 Dec 2019 22:35:57 -0800
Message-Id: <1575527759-26452-5-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(478600001)(36756003)(4326008)(51416003)(7696005)(426003)(107886003)(81166006)(11346002)(36386004)(76176011)(336012)(2906002)(70586007)(6666004)(305945005)(356004)(70206006)(16586007)(186003)(2616005)(26005)(14444005)(316002)(8936002)(7416002)(48376002)(50466002)(9786002)(81156014)(44832011)(50226002)(8676002)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6667;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee9976ae-beb4-4142-0cb1-08d7794d9d30
X-MS-TrafficTypeDiagnostic: DM6PR02MB6667:
X-Microsoft-Antispam-PRVS: <DM6PR02MB66673AE57002BAB78B39C7C7B75C0@DM6PR02MB6667.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksD+71lyAahsHsEm5JHYL64QnXrPJwIPRVtrRL7YMS4AD6gNm7MWdQzFObIHxWGIo3SBYpVtdKgqmDMOlCunzc2vbCR9Q7pYuoO2jGKk2wUyET8aeA3z2Xe25dEsEcYTiAscvRoIWcp5wdIPJ14cZJF7PQCz32ZE9mJ62XnPh/stmL1q8Kp3LXOczTU/EFYznzL5CeGhmV0W+2fQBGSAjKKCeKEJpz87Y+QoCgqra0lPHMtj0IvXatxh2uO6j8Z1SSpzj0fQJUBTJH2KeGrGhS/FtkX5vsvitNWImKQDFHm8DVDWnPCB35agwntQplYsdzaVZzo1Dqo5jcoWZCt68JIHsWG7+mGqrq3CMAuxEjzSL0RJ0umq7STl83xsuj/albUp3I+AzquuhUEQaKRk4+J13nXJhoDPFXq8LThCuVBVFjhl0ePnCECMf0nVJ1OWj3cPazv4WNfM7zO/JheBarLXmXjt2FnX/GGftd+x5AHz2Bb+HKkMMQdQTwT7EsQK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 06:37:35.1347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9976ae-beb4-4142-0cb1-08d7794d9d30
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To achieve best possible rate, maximum limit of divider is required
while computation. Get maximum supported divisor from firmware. To
maintain backward compatibility assign maximum possible value(0xFFFF)
if query for max divisor is not successful.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
Changes in v2:
 - Add helper function to get maximum divisor of a clock from firmware.
---
 drivers/clk/zynqmp/divider.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index d8f5b70d..aea52cd 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -41,6 +41,7 @@ struct zynqmp_clk_divider {
 	bool is_frac;
 	u32 clk_id;
 	u32 div_type;
+	u16 max_div;
 };
 
 static inline int zynqmp_divider_get_val(unsigned long parent_rate,
@@ -176,6 +177,35 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
 };
 
 /**
+ * zynqmp_clk_get_max_divisor() - Get maximum supported divisor from firmware.
+ * @clk_id:		Id of clock
+ * @type:		Divider type
+ *
+ * Return: Maximum divisor of a clock if query data is successful
+ *	   U16_MAX in case of query data is not success
+ */
+u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	qdata.qid = PM_QID_CLOCK_GET_MAX_DIVISOR;
+	qdata.arg1 = clk_id;
+	qdata.arg2 = type;
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	/*
+	 * To maintain backward compatibility return maximum possible value
+	 * (0xFFFF) if query for max divisor is not successful.
+	 */
+	if (ret)
+		return U16_MAX;
+	else
+		return ret_payload[1];
+}
+
+/**
  * zynqmp_clk_register_divider() - Register a divider clock
  * @name:		Name of this clock
  * @clk_id:		Id of clock
@@ -215,6 +245,12 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	div->clk_id = clk_id;
 	div->div_type = nodes->type;
 
+	/*
+	 * To achieve best possible rate, maximum limit of divider is required
+	 * while computation.
+	 */
+	div->max_div = zynqmp_clk_get_max_divisor(clk_id, nodes->type);
+
 	hw = &div->hw;
 	ret = clk_hw_register(NULL, hw);
 	if (ret) {
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a3b0a39..74d710d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -107,6 +107,7 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_PARENTS,
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
+	PM_QID_CLOCK_GET_MAX_DIVISOR,
 };
 
 enum zynqmp_pm_reset_action {
-- 
2.7.4

