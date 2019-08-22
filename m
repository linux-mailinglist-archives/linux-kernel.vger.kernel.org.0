Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0098E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfHVIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 04:46:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56847 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbfHVIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:46:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i0ijS-0008Lu-43; Thu, 22 Aug 2019 08:46:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: remove redundant assignment to pointer crypt
Date:   Thu, 22 Aug 2019 09:46:09 +0100
Message-Id: <20190822084609.8971-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer crypt is being set with a value that is never read,
the assignment is redundant and hence can be removed.

Thanks to Dan Carpenter for sanity checking that this was indeed
redundant.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index e0da0900a4f7..33a6af7aad22 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -743,7 +743,6 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	if (ieee->short_slot && (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT))
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 
-	crypt = ieee->crypt[ieee->tx_keyidx];
 	if (encrypt)
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
-- 
2.20.1

