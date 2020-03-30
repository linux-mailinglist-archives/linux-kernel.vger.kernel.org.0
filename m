Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55D198503
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgC3T64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 15:58:56 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:49340 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727311AbgC3T64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:58:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E51E6100E8429;
        Mon, 30 Mar 2020 19:58:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:2896:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:6120:7903:9036:10004:10400:10481:10848:11026:11232:11473:11658:11914:12043:12296:12297:12555:12679:12683:12760:13439:14181:14659:14721:14819:19900:21063:21080:21611:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fly44_309b3b9d6ae39
X-Filterd-Recvd-Size: 3647
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Mar 2020 19:58:53 +0000 (UTC)
Message-ID: <2e19547dcec386b47923211896f43053b60ebc60.camel@perches.com>
Subject: [RFC PATCH] mtd: lpddr: Fix bad logic in print_drs_error
From:   Joe Perches <joe@perches.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Mar 2020 12:56:59 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update logic for broken test.
Use a more common logging style.

Miscellanea:

o Coalesce formats

Signed-off-by: Joe Perches <joe@perches.com>
---

Found by inspection of include files using printk.

It appears the logic in this function is broken for the
consecutive tests of

	if (prog_status & 0x3)
		...
	else if (prog_status & 0x2)
		...
	else (prog_status & 0x1)
		...

Likely the first test should be

	if ((prog_status & 0x3) == 0x3)

And this function is only used in drivers/mtd/lpddr/lpddr_cmds.c
perhaps it should be moved there.

 include/linux/mtd/pfow.h | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
index 122f343..1c08e75 100644
--- a/include/linux/mtd/pfow.h
+++ b/include/linux/mtd/pfow.h
@@ -127,31 +127,28 @@ static inline void print_drs_error(unsigned dsr)
 	int prog_status = (dsr & DSR_RPS) >> 8;
 
 	if (!(dsr & DSR_AVAILABLE))
-		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
-	if (prog_status & 0x03)
-		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
-						"half with 41h command\n");
+		pr_notice("DSR.15: (0) Device not Available\n");
+
+	if ((prog_status & 0x03) == 0x03)
+		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
 	else if (prog_status & 0x02)
-		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
-					"in region with Control Mode data\n");
+		pr_notice("DSR.9,8: (10) Object Mode Program attempt in region with Control Mode data\n");
 	else if (prog_status &  0x01)
-		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
-						"with Object Mode data\n");
+		pr_notice("DSR.9,8: (01) Program attempt in region with Object Mode data\n");
+
 	if (!(dsr & DSR_READY_STATUS))
-		printk(KERN_NOTICE"DSR.7: (0) Device is Busy\n");
+		pr_notice("DSR.7: (0) Device is Busy\n");
 	if (dsr & DSR_ESS)
-		printk(KERN_NOTICE"DSR.6: (1) Erase Suspended\n");
+		pr_notice("DSR.6: (1) Erase Suspended\n");
 	if (dsr & DSR_ERASE_STATUS)
-		printk(KERN_NOTICE"DSR.5: (1) Erase/Blank check error\n");
+		pr_notice("DSR.5: (1) Erase/Blank check error\n");
 	if (dsr & DSR_PROGRAM_STATUS)
-		printk(KERN_NOTICE"DSR.4: (1) Program Error\n");
+		pr_notice("DSR.4: (1) Program Error\n");
 	if (dsr & DSR_VPPS)
-		printk(KERN_NOTICE"DSR.3: (1) Vpp low detect, operation "
-					"aborted\n");
+		pr_notice("DSR.3: (1) Vpp low detect, operation aborted\n");
 	if (dsr & DSR_PSS)
-		printk(KERN_NOTICE"DSR.2: (1) Program suspended\n");
+		pr_notice("DSR.2: (1) Program suspended\n");
 	if (dsr & DSR_DPS)
-		printk(KERN_NOTICE"DSR.1: (1) Aborted Erase/Program attempt "
-					"on locked block\n");
+		pr_notice("DSR.1: (1) Aborted Erase/Program attempt on locked block\n");
 }
 #endif /* __LINUX_MTD_PFOW_H */


