Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F410003C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKRIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 03:20:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:42894 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfKRIU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:20:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 00:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,319,1569308400"; 
   d="scan'208";a="209011529"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2019 00:20:25 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/2] mm/memory-failure.c: not necessary to recalculate hpage
Date:   Mon, 18 Nov 2019 16:20:03 +0800
Message-Id: <20191118082003.26240-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118082003.26240-1-richardw.yang@linux.intel.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hpage is not changed.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/memory-failure.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 392ac277b17d..9784f4339ae7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
 		}
 		unlock_page(p);
 		VM_BUG_ON_PAGE(!page_count(p), p);
-		hpage = compound_head(p);
 	}
 
 	/*
-- 
2.17.1

