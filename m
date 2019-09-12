Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50334B06FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfILCzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 22:55:33 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:49346 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729606AbfILCz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2630D8024DF6;
        Thu, 12 Sep 2019 02:55:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1539:1568:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3865:3866:3870:3871:4321:5007:6261:10004:10848:11026:11658:11914:12043:12048:12297:12438:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21627:30054:30070,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: crown88_87045049b360a
X-Filterd-Recvd-Size: 1614
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:27 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] nvdimm: namespace_devs: Change progess typo to progress
Date:   Wed, 11 Sep 2019 19:54:42 -0700
Message-Id: <1ae8fe1a3644c23afd01db23a373dd5de897c99f.1568256708.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typing is hard.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 7a16340f9853..253f07d97b73 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1718,7 +1718,7 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 			return ERR_PTR(-ENODEV);
 
 		/*
-		 * Flush any in-progess probes / removals in the driver
+		 * Flush any in-progress probes / removals in the driver
 		 * for the raw personality of this namespace.
 		 */
 		nd_device_lock(&ndns->dev);
-- 
2.15.0

