Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962D0FC323
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfKNJ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:57:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfKNJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:57:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVBsp-0003TG-Me; Thu, 14 Nov 2019 09:57:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Javier F . Arias" <jarias.linux@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix indentation issue
Date:   Thu, 14 Nov 2019 09:57:47 +0000
Message-Id: <20191114095747.132407-1-colin.king@canonical.com>
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
 drivers/staging/rtl8723bs/core/rtw_security.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 5aa5910687d1..9c4607114cea 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1621,12 +1621,12 @@ static sint aes_decipher(u8 *key, uint	hdrlen,
 				      pn_vector, i + 1,
 				      frtype); /*  add for CONFIG_IEEE80211W, none 11w also can use */
 
-			aes128k128d(key, ctr_preload, aes_out);
-			bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
+		aes128k128d(key, ctr_preload, aes_out);
+		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
 
-			for (j = 0; j < 16; j++)
-				pframe[payload_index++] = chain_buffer[j];
-		}
+		for (j = 0; j < 16; j++)
+			pframe[payload_index++] = chain_buffer[j];
+	}
 
 	if (payload_remainder > 0) {
 		/* If there is a short final block, then pad it,*/
-- 
2.20.1

