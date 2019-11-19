Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB37E101D43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKSI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 03:27:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:36365 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKSI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:27:10 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAJ8QlIA018944, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (rsn1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAJ8QlIA018944
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Nov 2019 16:26:47 +0800
Received: from localhost (172.29.40.150) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 16:26:46 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH V2] misc: rtsx: Fix impossible condition
Date:   Tue, 19 Nov 2019 16:26:30 +0800
Message-ID: <1574151990-3335-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

A u8 can only go up to 255, condition n > 396 is
impossible, so change u8 to u16.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 32dcec2..bc4967a 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -628,7 +628,8 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk)
 {
 	int err, clk;
-	u8 n, clk_divider, mcu_cnt, div;
+	u16 n;
+	u8 clk_divider, mcu_cnt, div;
 	static const u8 depth[] = {
 		[RTSX_SSC_DEPTH_4M] = RTS5261_SSC_DEPTH_4M,
 		[RTSX_SSC_DEPTH_2M] = RTS5261_SSC_DEPTH_2M,
@@ -661,13 +662,13 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		return 0;
 
 	if (pcr->ops->conv_clk_and_div_n)
-		n = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
+		n = pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
 	else
-		n = (u8)(clk - 4);
+		n = clk - 4;
 	if ((clk <= 4) || (n > 396))
 		return -EINVAL;
 
-	mcu_cnt = (u8)(125/clk + 3);
+	mcu_cnt = 125/clk + 3;
 	if (mcu_cnt > 15)
 		mcu_cnt = 15;
 
@@ -676,7 +677,7 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		if (pcr->ops->conv_clk_and_div_n) {
 			int dbl_clk = pcr->ops->conv_clk_and_div_n(n,
 					DIV_N_TO_CLK) * 2;
-			n = (u8)pcr->ops->conv_clk_and_div_n(dbl_clk,
+			n = pcr->ops->conv_clk_and_div_n(dbl_clk,
 					CLK_TO_DIV_N);
 		} else {
 			n = (n + 4) * 2 - 4;
-- 
1.9.1

