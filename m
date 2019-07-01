Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A6F45472
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfFNGCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 02:02:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:43420 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNGCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:02:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 23:02:13 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2019 23:02:11 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        jglisse@redhat.com, dave.jiang@intel.com, osalvador@suse.com,
        mhocko@suse.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] kernel/memremap.c: use ALIGN/ALIGN_DOWN to calculate align_start/end
Date:   Fri, 14 Jun 2019 14:01:43 +0800
Message-Id: <20190614060143.17867-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of align_start/end is to expand to SECTION boundary. Use
ALIGN/ALIGN_DOWN directly is more self-explain and clean.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 kernel/memremap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 1490e63f69a9..53cf751f0721 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -159,10 +159,9 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (!pgmap->ref || !pgmap->kill)
 		return ERR_PTR(-EINVAL);
 
-	align_start = res->start & ~(SECTION_SIZE - 1);
-	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
-		- align_start;
-	align_end = align_start + align_size - 1;
+	align_start = ALIGN_DOWN(res->start, SECTION_SIZE);
+	align_end = ALIGN(res->end, SECTION_SIZE) - 1;
+	align_size = align_end - align_start + 1;
 
 	conflict_pgmap = get_dev_pagemap(PHYS_PFN(align_start), NULL);
 	if (conflict_pgmap) {
-- 
2.19.1

