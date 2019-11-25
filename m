Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A061C108E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 14:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfKYNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 08:02:56 -0500
Received: from mail-eopbgr820051.outbound.protection.outlook.com ([40.107.82.51]:56880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfKYNC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:02:56 -0500
Received: from CH2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:610:4e::40)
 by BYAPR02MB5688.namprd02.prod.outlook.com (2603:10b6:a03:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Mon, 25 Nov
 2019 13:02:53 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CH2PR02CA0030.outlook.office365.com
 (2603:10b6:610:4e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21 via Frontend
 Transport; Mon, 25 Nov 2019 13:02:51 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:02:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0x-0008Av-2u; Mon, 25 Nov 2019 05:02:51 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0s-0008PM-0p; Mon, 25 Nov 2019 05:02:46 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0r-0008Ox-0S; Mon, 25 Nov 2019 05:02:45 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/3] serial: xilinx_uartps: Let get_mctrl return status
Date:   Mon, 25 Nov 2019 18:32:39 +0530
Message-Id: <1574686961-9588-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.851-7.0-31-1
X-imss-scan-details: No--1.851-7.0-31-1;No--1.851-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191605717521843;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(498600001)(9786002)(48376002)(55446002)(50466002)(6666004)(70206006)(6916009)(5660300002)(51416003)(16586007)(86362001)(14444005)(70586007)(8936002)(305945005)(316002)(356004)(2906002)(107886003)(26005)(4326008)(73392003)(54906003)(76482006)(50226002)(47776003)(81166006)(81156014)(61266001)(9686003)(8676002)(426003)(336012)(2361001)(2616005)(36756003)(2351001)(82202003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5688;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e02b8a-fd64-4331-812b-08d771a7c784
X-MS-TrafficTypeDiagnostic: BYAPR02MB5688:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5688F94FA11B6297DA41796D874A0@BYAPR02MB5688.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4knotTV8KuVgr7wgjVGgYsC1gqBHLceqXmgMlzbRAyTWP8Lh9UXPi3sLaAcCvYFjvTbPsWF27K2iBHPs20GXOktJs+O/hNvwlj6KDRBvYyOMcZuWZvIAi0v0T7TuUbCR3m8y4g6B09NejZD+hbGR1CXn+zrkVkDspXdisHexHtBGs1jxZ69C1HGyxjnxv+ZmiMojlzoSoZGSblkowzzxmOyR17WSIRqLWxipzZSOvuT731j3SPEK84V72tN8QEU5Of46sKQnCD59I8AvzS5HmvtSaeG5PomA4f47ZW/PG3gxtiZw1DFEmMh+LjulvNakUDCArlIxWg45Yd+Ql6VNCxz4OBWzPRAGzXVJ/lWKrWbxnMp9rHYCHXgyU7f1NkNBcuXMrlAQdG+XG65OHIBMS5xxmuK//skQJHxtJb73eTElDNub+wR7WNwtQ9kHI6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:02:51.5910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e02b8a-fd64-4331-812b-08d771a7c784
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten Brock <m.brock@vanmierlo.com>

Some of the applications like microcom do not work if
modem is disabled. To fix them we always return
TIOCM_CTS | TIOCM_DSR | TIOCM_CAR instead of 0 when
using cts_override. Make get_mctrl return actual status
when not using cts_override.

Signed-off-by: Maarten Brock <m.brock@vanmierlo.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e55bc3..9e12589 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -158,6 +158,26 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 #define CDNS_UART_MODEMCR_DTR	0x00000001 /* Data Terminal Ready */
 
 /*
+ * Modem Status register:
+ * The read/write Modem Status register reports the interface with the modem
+ * or data set, or a peripheral device emulating a modem.
+ */
+#define CDNS_UART_MODEMSR_DCD	BIT(7) /* Data Carrier Detect */
+#define CDNS_UART_MODEMSR_RI	BIT(6) /* Ting Indicator */
+#define CDNS_UART_MODEMSR_DSR	BIT(5) /* Data Set Ready */
+#define CDNS_UART_MODEMSR_CTS	BIT(4) /* Clear To Send */
+
+/*
+ * Modem Status register:
+ * The read/write Modem Status register reports the interface with the modem
+ * or data set, or a peripheral device emulating a modem.
+ */
+#define CDNS_UART_MODEMSR_DCD	BIT(7) /* Data Carrier Detect */
+#define CDNS_UART_MODEMSR_RI	BIT(6) /* Ting Indicator */
+#define CDNS_UART_MODEMSR_DSR	BIT(5) /* Data Set Ready */
+#define CDNS_UART_MODEMSR_CTS	BIT(4) /* Clear To Send */
+
+/*
  * Channel Status Register:
  * The channel status register (CSR) is provided to enable the control logic
  * to monitor the status of bits in the channel interrupt status register,
@@ -1007,12 +1027,24 @@ static void cdns_uart_config_port(struct uart_port *port, int flags)
  */
 static unsigned int cdns_uart_get_mctrl(struct uart_port *port)
 {
+	u32 val;
+	unsigned int mctrl = 0;
 	struct cdns_uart *cdns_uart_data = port->private_data;
 
 	if (cdns_uart_data->cts_override)
-		return 0;
-
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+		return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+
+	val = readl(port->membase + CDNS_UART_MODEMSR);
+	if (val & CDNS_UART_MODEMSR_CTS)
+		mctrl |= TIOCM_CTS;
+	if (val & CDNS_UART_MODEMSR_DSR)
+		mctrl |= TIOCM_DSR;
+	if (val & CDNS_UART_MODEMSR_RI)
+		mctrl |= TIOCM_RNG;
+	if (val & CDNS_UART_MODEMSR_DCD)
+		mctrl |= TIOCM_CAR;
+
+	return mctrl;
 }
 
 static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.1.1

