Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6630BB06FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 04:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfILCz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 22:55:27 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:51632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729489AbfILCz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E907C100E86C4;
        Thu, 12 Sep 2019 02:55:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:2919:3138:3139:3140:3141:3142:3352:3865:3871:4321:4605:5007:6119:6261:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12895:13069:13311:13357:14096:14181:14384:14394:14721:21080:21627:30012:30029:30054,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: girls87_86643b0d66e00
X-Filterd-Recvd-Size: 2319
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:23 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] nvdimm: namespace_devs: Move assignment operators
Date:   Wed, 11 Sep 2019 19:54:40 -0700
Message-Id: <95bbd3ef7a6b06384d1ec6f5bfd691a728b31831.1568256708.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel code uses assignment operators where the statement is split
on multiple lines on the first line.

Move 2 unusual uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/namespace_devs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 70e1d752c12c..8c75ef84bad7 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2023,8 +2023,8 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		nspm->lbasize = __le64_to_cpu(label0->lbasize);
 		ndd = to_ndd(nd_mapping);
 		if (namespace_label_has(ndd, abstraction_guid))
-			nspm->nsio.common.claim_class
-				= to_nvdimm_cclass(&label0->abstraction_guid);
+			nspm->nsio.common.claim_class =
+				to_nvdimm_cclass(&label0->abstraction_guid);
 	}
 
 	if (!nspm->alt_name || !nspm->uuid) {
@@ -2267,8 +2267,8 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	nsblk->uuid = kmemdup(nd_label->uuid, NSLABEL_UUID_LEN,
 			      GFP_KERNEL);
 	if (namespace_label_has(ndd, abstraction_guid))
-		nsblk->common.claim_class
-			= to_nvdimm_cclass(&nd_label->abstraction_guid);
+		nsblk->common.claim_class =
+			to_nvdimm_cclass(&nd_label->abstraction_guid);
 	if (!nsblk->uuid)
 		goto blk_err;
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
-- 
2.15.0

