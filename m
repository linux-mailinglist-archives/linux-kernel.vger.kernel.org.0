Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92291DE874
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfJUJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 05:48:20 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:58151 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfJUJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:48:13 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id AB9F61C285D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:48:11 +0100 (IST)
Received: (qmail 32640 invoked from network); 21 Oct 2019 09:48:11 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 21 Oct 2019 09:48:11 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] mm, pcpu: Make zone pcp updates and reset internal to the mm
Date:   Mon, 21 Oct 2019 10:48:08 +0100
Message-Id: <20191021094808.28824-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021094808.28824-1-mgorman@techsingularity.net>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory hotplug needs to be able to reset and reinit the pcpu allocator
batch and high limits but this action is internal to the VM. Move
the declaration to internal.h

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Michal Hocko <mhocko@suse.com>
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

