Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7691421D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 04:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgATDE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 22:04:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:51507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:04:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 19:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="306802502"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2020 19:04:24 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, richardw.yang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
Subject: [Patch v2 2/4] mm/page_alloc.c: bad_[reason|flags] is not necessary when PageHWPoison
Date:   Mon, 20 Jan 2020 11:04:13 +0800
Message-Id: <20200120030415.15925-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120030415.15925-1-richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function returns directly, bad_[reason|flags] is not used any
where.

This is a following cleanup for commit e570f56cccd21 ("mm:
check_new_page_bad() directly returns in __PG_HWPOISON case")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0cf6218aaba7..a43b9d2482f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2051,8 +2051,6 @@ static void check_new_page_bad(struct page *page)
 	if (unlikely(page_ref_count(page) != 0))
 		bad_reason = "nonzero _refcount";
 	if (unlikely(page->flags & __PG_HWPOISON)) {
-		bad_reason = "HWPoisoned (hardware-corrupted)";
-		bad_flags = __PG_HWPOISON;
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
 		return;
-- 
2.17.1

