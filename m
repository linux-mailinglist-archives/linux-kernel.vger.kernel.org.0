Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D6DC325
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408458AbfJRK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 06:56:21 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:42113 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408080AbfJRK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:56:10 -0400
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 0DCC212B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:56:09 +0100 (IST)
Received: (qmail 30826 invoked from network); 18 Oct 2019 10:56:08 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 18 Oct 2019 10:56:08 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] mm, pcpu: Make zone pcp updates and reset internal to the mm
Date:   Fri, 18 Oct 2019 11:56:06 +0100
Message-Id: <20191018105606.3249-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018105606.3249-1-mgorman@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory hotplug needs to be able to reset and reinit the pcpu allocator
batch and high limits but this action is internal to the VM. Move
the declaration to internal.h

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mm.h | 3 ---
 mm/internal.h      | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..22d6104f2341 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2219,9 +2219,6 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
 
 extern void setup_per_cpu_pageset(void);
 
-extern void zone_pcp_update(struct zone *zone);
-extern void zone_pcp_reset(struct zone *zone);
-
 /* page_alloc.c */
 extern int min_free_kbytes;
 extern int watermark_boost_factor;
diff --git a/mm/internal.h b/mm/internal.h
index 0d5f720c75ab..0a3d41c7b3c5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -165,6 +165,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
+extern void zone_pcp_update(struct zone *zone);
+extern void zone_pcp_reset(struct zone *zone);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
-- 
2.16.4

