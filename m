Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2BD18124C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgCKHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:47:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:47:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16D39AEAC;
        Wed, 11 Mar 2020 07:47:39 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: aat2870: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:47:38 +0100
Message-Id: <20200311074738.8679-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is still one call of sprintf() without checking the proper
buffer overflow in aat2870_dump_reg().  Replace it with scnprintf()
call for covering that.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/mfd/aat2870-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 78ee4b28fca2..a17cf759739d 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -221,7 +221,7 @@ static ssize_t aat2870_dump_reg(struct aat2870_data *aat2870, char *buf)
 
 	count += sprintf(buf, "aat2870 registers\n");
 	for (addr = 0; addr < AAT2870_REG_NUM; addr++) {
-		count += sprintf(buf + count, "0x%02x: ", addr);
+		count += snprintf(buf + count, PAGE_SIZE - count, "0x%02x: ", addr);
 		if (count >= PAGE_SIZE - 1)
 			break;
 
-- 
2.16.4

