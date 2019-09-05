Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B07A9A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfIEFWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 01:22:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33912 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfIEFWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:22:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x855M2vq018985, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x855M2vq018985
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 5 Sep 2019 13:22:02 +0800
Received: from localhost.localdomain (172.21.83.238) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 5 Sep 2019 13:22:01 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alex_lu@realsil.com.cn>, <max.chou@realtek.com>
Subject: [PATCH v2] Bluetooth: btrtl: Fix an issue that failing to download the FW which size is over 32K bytes
Date:   Thu, 5 Sep 2019 13:21:57 +0800
Message-ID: <20190905052157.2052-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.83.238]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

Fix the issue that when the FW size is 32K+, it will fail for the download
process because of the incorrect index.

When firmware patch length is over 32K, "dl_cmd->index" may >= 0x80. It
will be thought as "data end" that download process will not complete.
However, driver should recount the index from 1.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
Changes in v2:
- Added the comment for commit message
- Remove the extra variable

 drivers/bluetooth/btrtl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 0354e93e7a7c..bf3c02be6930 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -401,7 +401,11 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 
 		BT_DBG("download fw (%d/%d)", i, frag_num);
 
-		dl_cmd->index = i;
+		if (i > 0x7f)
+			dl_cmd->index = (i & 0x7f) + 1;
+		else
+			dl_cmd->index = i;
+
 		if (i == (frag_num - 1)) {
 			dl_cmd->index |= 0x80; /* data end */
 			frag_len = fw_len % RTL_FRAG_LEN;
-- 
2.17.1

