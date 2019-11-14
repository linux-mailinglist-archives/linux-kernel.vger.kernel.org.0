Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51448FC315
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKNJyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:54:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34296 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfKNJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:54:33 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVBpf-0003KI-3E; Thu, 14 Nov 2019 09:54:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix indentation issue
Date:   Thu, 14 Nov 2019 09:54:30 +0000
Message-Id: <20191114095430.132120-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a block of statements that are indented
too deeply, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index e064f43fd8b6..bc98cdaf61ec 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -169,19 +169,20 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u16 tx_rate;
-		/* 87B have to S/W beacon for DTM encryption_cmn. */
-		if (priv->ieee80211->current_network.mode == IEEE_A ||
-		    priv->ieee80211->current_network.mode == IEEE_N_5G ||
-		    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
-		     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
-			tx_rate = 60;
-			DMESG("send beacon frame  tx rate is 6Mbpm\n");
-		} else {
-			tx_rate = 10;
-			DMESG("send beacon frame  tx rate is 1Mbpm\n");
-		}
 
-		rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
+	/* 87B have to S/W beacon for DTM encryption_cmn. */
+	if (priv->ieee80211->current_network.mode == IEEE_A ||
+	    priv->ieee80211->current_network.mode == IEEE_N_5G ||
+	    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
+	     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
+		tx_rate = 60;
+		DMESG("send beacon frame  tx rate is 6Mbpm\n");
+	} else {
+		tx_rate = 10;
+		DMESG("send beacon frame  tx rate is 1Mbpm\n");
+	}
+
+	rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
 }
 
 /*-----------------------------------------------------------------------------
-- 
2.20.1

