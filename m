Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE12B8E718
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfHOIkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:40:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36256 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfHOIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:40:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hyBJC-0006KM-Hw; Thu, 15 Aug 2019 08:40:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix up indentation of a statement
Date:   Thu, 15 Aug 2019 09:40:34 +0100
Message-Id: <20190815084034.13885-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented one level too deeply, remove
the extraneous tab.

Addresses-Coverity: ("Identation does not match nesting level")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 92de92a3325a..0bedf88525cd 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -289,8 +289,8 @@ void phy_set_rf8256_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 			writeVal = 0x03030303;
 		} else {
 			writeVal = (byte3<<24) | (byte2<<16) | (byte1<<8) | byte0;
-			}
-			rtl8192_setBBreg(dev, RegOffset[index], 0x7f7f7f7f, writeVal);
+		}
+		rtl8192_setBBreg(dev, RegOffset[index], 0x7f7f7f7f, writeVal);
 	}
 	return;
 
-- 
2.20.1

