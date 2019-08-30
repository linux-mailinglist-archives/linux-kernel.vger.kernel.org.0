Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B1A3D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH3Ru4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 13:50:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36603 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Ruz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:50:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i3l2w-0008Qk-Mu; Fri, 30 Aug 2019 17:50:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: check for null return from call to FAT_getblk
Date:   Fri, 30 Aug 2019 18:50:50 +0100
Message-Id: <20190830175050.12706-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A call to FAT_getblk is missing a null return check which can
lead to a null pointer dereference.  Fix this by adding a null
check to match all the other FAT_getblk return sanity checks.

Addresses-Coverity: ("Dereference null return")
Fixes: c48c9f7ff32b ("staging: exfat: add exfat filesystem code to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/exfat/exfat_cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index f05d692c2b1e..1565ce65d39f 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -369,6 +369,8 @@ static s32 __FAT_write(struct super_block *sb, u32 loc, u32 content)
 				FAT_modify(sb, sec);
 
 				fat_sector = FAT_getblk(sb, ++sec);
+				if (!fat_sector)
+					return -1;
 				fat_sector[0] = (u8)((fat_sector[0] & 0xF0) |
 						     (content >> 8));
 			} else {
-- 
2.20.1

