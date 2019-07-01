Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C028D48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 00:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfEWWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 18:37:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:15749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387845AbfEWWhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:37:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 15:37:10 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2019 15:37:10 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] mm/swap: Fix release_pages() when releasing devmap pages
Date:   Thu, 23 May 2019 15:37:46 -0700
Message-Id: <20190523223746.4982-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Device pages can be more than type MEMORY_DEVICE_PUBLIC.

Handle all device pages within release_pages()

This was found via code inspection while determining if release_pages()
and the new put_user_pages() could be interchangeable.

Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/swap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3a75722e68a9..d1e8122568d0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -739,15 +739,14 @@ void release_pages(struct page **pages, int nr)
 		if (is_huge_zero_page(page))
 			continue;
 
-		/* Device public page can not be huge page */
-		if (is_device_public_page(page)) {
+		if (is_zone_device_page(page)) {
 			if (locked_pgdat) {
 				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
 						       flags);
 				locked_pgdat = NULL;
 			}
-			put_devmap_managed_page(page);
-			continue;
+			if (put_devmap_managed_page(page))
+				continue;
 		}
 
 		page = compound_head(page);
-- 
2.20.1

