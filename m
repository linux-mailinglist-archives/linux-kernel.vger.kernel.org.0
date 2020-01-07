Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873D1132D99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgAGRwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 12:52:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60981 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:52:36 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iot1u-00082s-Hf; Tue, 07 Jan 2020 17:52:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: tsl2550: remove redundant initialization to variable r
Date:   Tue,  7 Jan 2020 17:52:34 +0000
Message-Id: <20200107175234.121298-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable r is being initialized with a value that is never
read and it is being updated later with a new value. Remove
the redundant initialization and move the declaration into a
deeper code block.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/tsl2550.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 09db397df287..6d71865c8042 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -148,16 +148,14 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 	u16 c0 = count_lut[ch0];
 	u16 c1 = count_lut[ch1];
 
-	/*
-	 * Calculate ratio.
-	 * Note: the "128" is a scaling factor
-	 */
-	u8 r = 128;
-
 	/* Avoid division by 0 and count 1 cannot be greater than count 0 */
 	if (c1 <= c0)
 		if (c0) {
-			r = c1 * 128 / c0;
+			/*
+			 * Calculate ratio.
+			 * Note: the "128" is a scaling factor
+			 */
+			u8 r = c1 * 128 / c0;
 
 			/* Calculate LUX */
 			lux = ((c0 - c1) * ratio_lut[r]) / 256;
-- 
2.24.0

