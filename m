Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB4816899A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgBUVxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:53:55 -0500
Received: from shelob.surriel.com ([96.67.55.147]:44772 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgBUVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:53:55 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j5GF1-0002PL-Ny; Fri, 21 Feb 2020 16:53:47 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org, riel@fb.com
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, vbabka@suse.cz, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/2] mm,compaction,cma: add alloc_contig flag to compact_control
Date:   Fri, 21 Feb 2020 16:53:42 -0500
Message-Id: <c21c46cb76de2d991fd23164489f763bb385c152.1582321645.git.riel@surriel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582321645.git.riel@surriel.com>
References: <cover.1582321645.git.riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information to struct compact_control to indicate that the allocator
would really like to clear out this specific part of memory, used by for
example CMA.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/internal.h   | 1 +
 mm/page_alloc.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..78492d9815b4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -206,6 +206,7 @@ struct compact_control {
 	bool whole_zone;		/* Whole zone should/has been scanned */
 	bool contended;			/* Signal lock or sched contention */
 	bool rescan;			/* Rescanning the same pageblock */
+	bool alloc_contig;		/* alloc_contig_range allocation */
 };
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..a36736812596 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8402,6 +8402,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
 		.gfp_mask = current_gfp_context(gfp_mask),
+		.alloc_contig = true,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
-- 
2.24.1

