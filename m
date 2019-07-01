Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40804CB21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfFTJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 05:41:34 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2498 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfFTJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:41:30 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d0b54b9ee7-aa075; Thu, 20 Jun 2019 17:41:13 +0800 (CST)
X-RM-TRANSID: 2ee55d0b54b9ee7-aa075
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d0b54b833c-25d6d;
        Thu, 20 Jun 2019 17:41:13 +0800 (CST)
X-RM-TRANSID: 2ee65d0b54b833c-25d6d
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fireware: Remove always true condition
Date:   Thu, 20 Jun 2019 17:40:17 +0800
Message-Id: <1561023617-2218-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The range of max_hops is 0~15 and gap_count_table size is 16,
so the condition is always true, just remove it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/firewire/core-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 54be881..3489d00 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -462,8 +462,7 @@ static void bm_work(struct work_struct *work)
 	 * Pick a gap count from 1394a table E-1.  The table doesn't cover
 	 * the typically much larger 1394b beta repeater delays though.
 	 */
-	if (!card->beta_repeaters_present &&
-	    root_node->max_hops < ARRAY_SIZE(gap_count_table))
+	if (!card->beta_repeaters_present)
 		gap_count = gap_count_table[root_node->max_hops];
 	else
 		gap_count = 63;
-- 
1.9.1



