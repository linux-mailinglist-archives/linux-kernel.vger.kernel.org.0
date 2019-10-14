Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEBFD60D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 13:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfJNLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 07:02:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfJNLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:02:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iJy6z-0003lu-93; Mon, 14 Oct 2019 11:02:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudiu Beznea <claudiu.beznea@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: fix exit return when sme->key_idx >= NUM_WEPKEYS
Date:   Mon, 14 Oct 2019 12:02:01 +0100
Message-Id: <20191014110201.9874-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the exit return path when sme->key_idx >= NUM_WEPKEYS is via
label 'exit' and this checks if result is non-zero, however result has
not been initialized and contains garbage.  Fix this by replacing the
goto with a return with the error code.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 0ca6d8e74489 ("Staging: wlan-ng: replace switch-case statements with macro")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index eee1998c4b18..fac38c842ac5 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -469,10 +469,8 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 	/* Set the encryption - we only support wep */
 	if (is_wep) {
 		if (sme->key) {
-			if (sme->key_idx >= NUM_WEPKEYS) {
-				err = -EINVAL;
-				goto exit;
-			}
+			if (sme->key_idx >= NUM_WEPKEYS)
+				return -EINVAL;
 
 			result = prism2_domibset_uint32(wlandev,
 				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
-- 
2.20.1

