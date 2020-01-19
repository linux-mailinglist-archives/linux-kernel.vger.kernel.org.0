Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2249A141E18
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 14:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgASNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 08:14:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:54272 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgASNOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:14:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 05:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,338,1574150400"; 
   d="scan'208";a="220464498"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2020 05:14:32 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/4] mm/page_alloc.c: rename free_pages_check_bad() to check_free_page_bad()
Date:   Sun, 19 Jan 2020 21:14:06 +0800
Message-Id: <20200119131408.23247-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119131408.23247-1-richardw.yang@linux.intel.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pages_check_bad() is the counterpart of check_new_page_bad(), while
their naming convention is a little different.

Use verb at first and singular form.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8cd06729169f..e2324df1b261 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,7 +1042,7 @@ static inline const char *__check_page(struct page *page)
 	return bad_reason;
 }
 
-static void free_pages_check_bad(struct page *page)
+static void check_free_page_bad(struct page *page)
 {
 	const char *bad_reason = NULL;
 	unsigned long bad_flags = 0;
@@ -1061,7 +1061,7 @@ static inline int free_pages_check(struct page *page)
 		return 0;
 
 	/* Something has gone sideways, find it */
-	free_pages_check_bad(page);
+	check_free_page_bad(page);
 	return 1;
 }
 
-- 
2.17.1

