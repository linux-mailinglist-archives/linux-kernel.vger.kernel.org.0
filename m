Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF1600EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 08:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfGEGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 02:13:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfGEGM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:12:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE148360;
        Thu,  4 Jul 2019 23:12:58 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B6353F246;
        Thu,  4 Jul 2019 23:14:50 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/isolate: Drop pre-validating migrate type in undo_isolate_page_range()
Date:   Fri,  5 Jul 2019 11:42:41 +0530
Message-Id: <1562307161-30554-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unset_migratetype_isolate() already validates under zone lock that a given
page has already been isolated as MIGRATE_ISOLATE. There is no need for
another check before. Hence just drop this redundant validation.

Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Is there any particular reason to do this migratetype pre-check without zone
lock before calling unsert_migrate_isolate() ? If not this should be removed.

 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e3638a5bafff..f529d250c8a5 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -243,7 +243,7 @@ int undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn < end_pfn;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (!page || !is_migrate_isolate_page(page))
+		if (!page)
 			continue;
 		unset_migratetype_isolate(page, migratetype);
 	}
-- 
2.20.1

