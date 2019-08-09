Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3788304
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406599AbfHISys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 14:54:48 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:50467 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726457AbfHISys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:54:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C882918011E51;
        Fri,  9 Aug 2019 18:54:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2898:3138:3139:3140:3141:3142:3352:3865:3867:4321:4385:4605:5007:7903:8603:10004:10400:10848:11026:11658:11914:12043:12296:12297:12438:12555:12679:12760:13019:13069:13311:13357:13439:14181:14394:14659:14721:21080:21433:21451:21627:30029:30054:30070,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: toes84_80e899a3be108
X-Filterd-Recvd-Size: 2907
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 18:54:45 +0000 (UTC)
Message-ID: <2a72a19c81b7e57c044c583452127b453a1a455c.camel@perches.com>
Subject: [PATCH] kernel/resource.c: Convert printks to pr_<level>
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 09 Aug 2019 11:54:44 -0700
In-Reply-To: <2e93e4057d1f95680bdd6f7f7d754800b7c87ac9.camel@perches.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
         <2e93e4057d1f95680bdd6f7f7d754800b7c87ac9.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_<level> to get the output prefixed by the existing #define pr_fmt

Miscellanea:

o Convert bare printk to pr_info
o Reduce printk(KERN_WARNING to pr_info as the log level seems better

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/resource.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 7ea4306503c5..59b89e40502a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -901,7 +901,8 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 		if (conflict->end > new->end)
 			new->end = conflict->end;
 
-		printk("Expanded resource %s due to conflict with %s\n", new->name, conflict->name);
+		pr_info("Expanded resource %s due to conflict with %s\n",
+			new->name, conflict->name);
 	}
 	write_unlock(&resource_lock);
 }
@@ -1223,9 +1224,8 @@ void __release_region(struct resource *parent, resource_size_t start,
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource "
-		"<%016llx-%016llx>\n", (unsigned long long)start,
-		(unsigned long long)end);
+	pr_warn("Trying to free nonexistent resource <%016llx-%016llx>\n",
+		(unsigned long long)start, (unsigned long long)end);
 }
 EXPORT_SYMBOL(__release_region);
 
@@ -1557,10 +1557,10 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 		if (p->flags & IORESOURCE_BUSY)
 			continue;
 
-		printk(KERN_WARNING "resource sanity check: requesting [mem %#010llx-%#010llx], which spans more than %s %pR\n",
-		       (unsigned long long)addr,
-		       (unsigned long long)(addr + size - 1),
-		       p->name, p);
+		pr_info("sanity check: requesting [mem %#010llx-%#010llx], which spans more than %s %pR\n",
+			(unsigned long long)addr,
+			(unsigned long long)(addr + size - 1),
+			p->name, p);
 		err = -1;
 		break;
 	}



