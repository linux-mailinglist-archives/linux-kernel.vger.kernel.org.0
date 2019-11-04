Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29CFEE5EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 18:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfKDRZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 12:25:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbfKDRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:25:33 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC5162BC5EFDC1B2CBAA;
        Tue,  5 Nov 2019 01:25:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 01:25:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 3/5] bus: hisi_lpc: Clean some types
Date:   Tue, 5 Nov 2019 01:22:17 +0800
Message-ID: <1572888139-47298-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains of these:
drivers/bus/hisi_lpc.c:82:38: warning: incorrect type in argument 1 (different address spaces)
drivers/bus/hisi_lpc.c:82:38:    expected void const volatile [noderef] <asn:2>*addr
drivers/bus/hisi_lpc.c:82:38:    got unsigned char *
drivers/bus/hisi_lpc.c:131:35: warning: incorrect type in argument 1 (different address spaces)
drivers/bus/hisi_lpc.c:131:35:    expected unsigned char *mbase
drivers/bus/hisi_lpc.c:131:35:    got void [noderef] <asn:2>*membase
drivers/bus/hisi_lpc.c:186:35: warning: incorrect type in argument 1 (different address spaces)
drivers/bus/hisi_lpc.c:186:35:    expected unsigned char *mbase
drivers/bus/hisi_lpc.c:186:35:    got void [noderef] <asn:2>*membase
drivers/bus/hisi_lpc.c:228:16: warning: cast to restricted __le32
drivers/bus/hisi_lpc.c:251:13: warning: incorrect type in assignment (different base types)
drivers/bus/hisi_lpc.c:251:13:    expected unsigned int [unsigned] [usertype] val
drivers/bus/hisi_lpc.c:251:13:    got restricted __le32 [usertype] <noident>

Clean them up.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 20c957185af2..8101df901830 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -74,7 +74,7 @@ struct hisi_lpc_dev {
 /* About 10us. This is specific for single IO operations, such as inb */
 #define LPC_PEROP_WAITCNT	100
 
-static int wait_lpc_idle(unsigned char *mbase, unsigned int waitcnt)
+static int wait_lpc_idle(void __iomem *mbase, unsigned int waitcnt)
 {
 	u32 status;
 
@@ -209,7 +209,7 @@ static u32 hisi_lpc_comm_in(void *hostdata, unsigned long pio, size_t dwidth)
 	struct hisi_lpc_dev *lpcdev = hostdata;
 	struct lpc_cycle_para iopara;
 	unsigned long addr;
-	u32 rd_data = 0;
+	__le32 rd_data = 0;
 	int ret;
 
 	if (!lpcdev || !dwidth || dwidth > LPC_MAX_DWIDTH)
@@ -244,13 +244,12 @@ static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
 	struct lpc_cycle_para iopara;
 	const unsigned char *buf;
 	unsigned long addr;
+	__le32 _val = cpu_to_le32(val);
 
 	if (!lpcdev || !dwidth || dwidth > LPC_MAX_DWIDTH)
 		return;
 
-	val = cpu_to_le32(val);
-
-	buf = (const unsigned char *)&val;
+	buf = (const unsigned char *)&_val;
 	addr = hisi_lpc_pio_to_addr(lpcdev, pio);
 
 	iopara.opflags = FG_INCRADDR_LPC;
-- 
2.17.1

