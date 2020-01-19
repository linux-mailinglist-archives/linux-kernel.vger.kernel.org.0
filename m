Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EDD141E17
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 14:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgASNOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 08:14:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:54272 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgASNOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:14:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 05:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,338,1574150400"; 
   d="scan'208";a="220464527"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2020 05:14:35 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 4/4] mm/page_alloc.c: bad_[reason|flags] is not necessary when PageHWPoison
Date:   Sun, 19 Jan 2020 21:14:08 +0800
Message-Id: <20200119131408.23247-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119131408.23247-1-richardw.yang@linux.intel.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function returns directly, bad_[reason|flags] is not used any
where.

This is a following cleanup for commit e570f56cccd21 ("mm:
check_new_page_bad() directly returns in __PG_HWPOISON case")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 87658a16af07..2b5e2e156dbf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2051,8 +2051,6 @@ static void check_new_page_bad(struct page *page)
 
 	bad_reason = __check_page(page);
 	if (unlikely(page->flags & __PG_HWPOISON)) {
-		bad_reason = "HWPoisoned (hardware-corrupted)";
-		bad_flags = __PG_HWPOISON;
 		/* Don't complain about hwpoisoned pages */
 		page_mapcount_reset(page); /* remove PageBuddy */
 		return;
-- 
2.17.1

