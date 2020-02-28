Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F7173301
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgB1IeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 03:34:09 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:37469 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726838AbgB1IeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 58B36837F24D;
        Fri, 28 Feb 2020 08:34:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1431:1437:1515:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3876:3877:4250:5007:6114:6117:6119:6261:6642:9592:10004:10848:11026:11232:11658:11914:12043:12297:12555:12895:13894:14181:14394:14721:21080:21451:21627:21990:30046:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:60,LUA_SUMMARY:none
X-HE-Tag: knife95_7ae83cd90431d
X-Filterd-Recvd-Size: 3116
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:04 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] parport_amiga: Convert DPRINTK to pr_debug
Date:   Fri, 28 Feb 2020 00:32:15 -0800
Message-Id: <114e37a85c9be905dff7e9c211155d9c62e66022.1582878394.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582878393.git.joe@perches.com>
References: <cover.1582878393.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more common logging style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/parport/parport_amiga.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index 8c7a598a..1e88bc 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -28,16 +28,10 @@
 #include <asm/amigaints.h>
 
 #undef DEBUG
-#ifdef DEBUG
-#define DPRINTK printk
-#else
-#define DPRINTK(x...)	do { } while (0)
-#endif
-
 
 static void amiga_write_data(struct parport *p, unsigned char data)
 {
-	DPRINTK(KERN_DEBUG "write_data %c\n",data);
+	pr_debug("write_data %c\n", data);
 	/* Triggers also /STROBE. This behavior cannot be changed */
 	ciaa.prb = data;
 	mb();
@@ -59,13 +53,13 @@ static unsigned char control_amiga_to_pc(unsigned char control)
 
 static void amiga_write_control(struct parport *p, unsigned char control)
 {
-	DPRINTK(KERN_DEBUG "write_control %02x\n",control);
+	pr_debug("write_control %02x\n", control);
 	/* No implementation possible */
 }
 	
 static unsigned char amiga_read_control( struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "read_control \n");
+	pr_debug("read_control\n");
 	return control_amiga_to_pc(0);
 }
 
@@ -73,7 +67,7 @@ static unsigned char amiga_frob_control( struct parport *p, unsigned char mask,
 {
 	unsigned char old;
 
-	DPRINTK(KERN_DEBUG "frob_control mask %02x, value %02x\n",mask,val);
+	pr_debug("frob_control mask %02x, value %02x\n", mask, val);
 	old = amiga_read_control(p);
 	amiga_write_control(p, (old & ~mask) ^ val);
 	return old;
@@ -99,7 +93,7 @@ static unsigned char amiga_read_status(struct parport *p)
 	unsigned char status;
 
 	status = status_amiga_to_pc(ciab.pra & 7);
-	DPRINTK(KERN_DEBUG "read_status %02x\n", status);
+	pr_debug("read_status %02x\n", status);
 	return status;
 }
 
@@ -115,14 +109,14 @@ static void amiga_disable_irq(struct parport *p)
 
 static void amiga_data_forward(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "forward\n");
+	pr_debug("forward\n");
 	ciaa.ddrb = 0xff; /* all pins output */
 	mb();
 }
 
 static void amiga_data_reverse(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "reverse\n");
+	pr_debug("reverse\n");
 	ciaa.ddrb = 0; /* all pins input */
 	mb();
 }
-- 
2.24.0

