Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5951732FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1IeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 03:34:13 -0500
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:52676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726907AbgB1IeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1E292181D3025;
        Fri, 28 Feb 2020 08:34:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3868:4321:4605:5007:6261:7904:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12679:12895:13894:14181:14394:14721:21080:21451:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: bat74_7b8fc09646c23
X-Filterd-Recvd-Size: 3343
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] parport: Standardize use of printmode
Date:   Fri, 28 Feb 2020 00:32:18 -0800
Message-Id: <7cf26906db4976a5455de5776c8a220fb37d37cb.1582878394.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582878393.git.joe@perches.com>
References: <cover.1582878393.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the define and the uses of printmode.

Miscellanea:

o Add missing statement termination ; where necessary

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/parport/parport_gsc.c |  8 ++++++--
 drivers/parport/parport_pc.c  | 14 ++++++--------
 drivers/parport/procfs.c      |  6 +++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index cb6a08..9228e8 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -299,12 +299,16 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 		p->dma = PARPORT_DMA_NONE;
 
 	pr_cont(" [");
-#define printmode(x) {if(p->modes&PARPORT_MODE_##x){pr_cont("%s%s",f?",":"",#x);f++;}}
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 	{
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-		printmode(COMPAT)
+		printmode(COMPAT);
 		printmode(EPP);
 //		printmode(ECP);
 //		printmode(DMA);
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index aae03b..77e37e3 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2134,19 +2134,17 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 
 	pr_cont(" [");
 
-#define printmode(x) \
-	{\
-		if (p->modes & PARPORT_MODE_##x) {\
-			pr_cont("%s%s", f ? "," : "", #x);	\
-			f++;\
-		} \
-	}
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 
 	{
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-		printmode(COMPAT)
+		printmode(COMPAT);
 		printmode(EPP);
 		printmode(ECP);
 		printmode(DMA);
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 488040..e957be 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -213,7 +213,11 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 		return -EACCES;
 
 	{
-#define printmode(x) {if(port->modes&PARPORT_MODE_##x){len+=sprintf(buffer+len,"%s%s",f?",":"",#x);f++;}}
+#define printmode(x)							\
+do {									\
+	if (port->modes & PARPORT_MODE_##x)				\
+		len += sprintf(buffer + len, "%s%s", f++ ? "," : "", #x); \
+} while (0)
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-- 
2.24.0

