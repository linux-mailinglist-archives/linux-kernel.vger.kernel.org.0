Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C28141CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgASG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 01:57:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:30046 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgASG5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 01:57:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 22:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,337,1574150400"; 
   d="scan'208";a="399072950"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2020 22:57:51 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        jhubbard@nvidia.com, vbabka@suse.cz, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2] mm/migrate.c: also overwrite error when it is bigger than zero
Date:   Sun, 19 Jan 2020 14:57:53 +0800
Message-Id: <20200119065753.21694-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get here after successfully adding page to list, err would be
1 to indicate the page is queued in the list.

Current code has two problems:

  * on success, 0 is not returned
  * on error, if add_page_for_migratioin() return 1, and the following err1
    from do_move_pages_to_node() is set, the err1 is not returned since err
    is 1

And these behaviors break the user interface.

Fixes: e0153fc2c760 ("mm: move_pages: return valid node id in status if the
page is already on the target node").
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2:
  * put more words to explain the error case
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 86873b6f38a7..430fdccc733e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1676,7 +1676,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
 	if (!err1)
 		err1 = store_status(status, start, current_node, i - start);
-	if (!err)
+	if (err >= 0)
 		err = err1;
 out:
 	return err;
-- 
2.17.1

