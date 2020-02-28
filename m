Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4F1732FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 09:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1IeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 03:34:06 -0500
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:37464 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgB1IeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D02FD837F27B;
        Fri, 28 Feb 2020 08:34:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3867:5007:6261:7875:9592:10004:10848:11026:11232:11473:11658:11914:12297:12438:12555:12895:13894:14181:14394:14721:21080:21451:21627:21990:30029:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: crib27_7ab1dcd5f4e1a
X-Filterd-Recvd-Size: 3478
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] parport: daisy: Convert DPRINTK to pr_debug
Date:   Fri, 28 Feb 2020 00:32:14 -0800
Message-Id: <51af1a19f2457e38642401639cd66788d6dee846.1582878394.git.joe@perches.com>
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
 drivers/parport/daisy.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index f87cc80..6d78ec 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -30,12 +30,6 @@
 
 #undef DEBUG
 
-#ifdef DEBUG
-#define DPRINTK(stuff...) printk(stuff)
-#else
-#define DPRINTK(stuff...)
-#endif
-
 static struct daisydev {
 	struct daisydev *next;
 	struct parport *port;
@@ -321,8 +315,7 @@ static int cpp_daisy(struct parport *port, int cmd)
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: cpp_daisy: aa5500ff(%02x)\n", port->name, s);
 		return -ENXIO;
 	}
 
@@ -332,8 +325,7 @@ static int cpp_daisy(struct parport *port, int cmd)
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff87(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: cpp_daisy: aa5500ff87(%02x)\n", port->name, s);
 		return -ENXIO;
 	}
 
@@ -368,7 +360,7 @@ static int cpp_mux(struct parport *port, int cmd)
 
 	s = parport_read_status(port);
 	if (!(s & PARPORT_STATUS_ACK)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
+		pr_debug("%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
 			 port->name, cmd, s);
 		return -EIO;
 	}
@@ -454,8 +446,7 @@ static int assign_addrs(struct parport *port)
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: assign_addrs: aa5500ff(%02x)\n", port->name, s);
 		return 0;
 	}
 
@@ -465,8 +456,7 @@ static int assign_addrs(struct parport *port)
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff87(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: assign_addrs: aa5500ff87(%02x)\n", port->name, s);
 		return 0;
 	}
 
@@ -503,8 +493,7 @@ static int assign_addrs(struct parport *port)
 
 	parport_write_data(port, 0xff); udelay(2);
 	detected = numdevs - thisdev;
-	DPRINTK(KERN_DEBUG "%s: Found %d daisy-chained devices\n", port->name,
-		 detected);
+	pr_debug("%s: Found %d daisy-chained devices\n", port->name, detected);
 
 	/* Ask the new devices to introduce themselves. */
 	deviceid = kmalloc(1024, GFP_KERNEL);
-- 
2.24.0

