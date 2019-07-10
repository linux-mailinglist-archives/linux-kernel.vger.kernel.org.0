Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501276404B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 07:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGJFF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 01:05:27 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:43576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbfGJFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A2F6B18224D97;
        Wed, 10 Jul 2019 05:04:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1539:1567:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3867:4321:5007:6261:6642:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12555:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627:30054,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: cast53_be22f579d301
X-Filterd-Recvd-Size: 1550
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] irqchip/gic-v3-its: Fix misuse of GENMASK macro
Date:   Tue,  9 Jul 2019 22:04:18 -0700
Message-Id: <ab5deb4fc3cd604cb620054770b7d00016d736bc.1562734889.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 35500801dc2b..730fbe0e2a9d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -185,7 +185,7 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 
 static struct its_collection *valid_col(struct its_collection *col)
 {
-	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(0, 15)))
+	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(15, 0)))
 		return NULL;
 
 	return col;
-- 
2.15.0

