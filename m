Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D906EFFD56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 04:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfKRD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 22:29:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:22737 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfKRD3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:29:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 19:29:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,318,1569308400"; 
   d="scan'208";a="208717781"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2019 19:29:09 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] madvise: use PAGE_ALIGN[ED] for range checking
Date:   Mon, 18 Nov 2019 11:28:57 +0800
Message-Id: <20191118032857.22683-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability, no functional change.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2be9f3fdb05e..89913b545649 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1051,9 +1051,9 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	if (!madvise_behavior_valid(behavior))
 		return error;
 
-	if (start & ~PAGE_MASK)
+	if (!PAGE_ALIGNED(start))
 		return error;
-	len = (len_in + ~PAGE_MASK) & PAGE_MASK;
+	len = PAGE_ALIGN(len_in);
 
 	/* Check to see whether len was rounded up from small -ve to zero */
 	if (len_in && !len)
-- 
2.17.1

