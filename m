Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66742141B60
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 04:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgASDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 22:07:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:14153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgASDHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 19:07:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="258308778"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2020 19:07:22 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 3/8] mm/migrate.c: reform the last call on do_move_pages_to_node()
Date:   Sun, 19 Jan 2020 11:06:31 +0800
Message-Id: <20200119030636.11899-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030636.11899-1-richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, just reform it to make it as the same shape as
other calls on do_move_pages_to_node().

This is a preparation for further cleanup.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c3ef70de5876..4a63fb8fbb6d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1675,8 +1675,12 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 
 	/* Make sure we do not overwrite the existing error */
 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
-	if (!err1)
-		err1 = store_status(status, start, current_node, i - start);
+	if (err1) {
+		if (err >= 0)
+			err = err1;
+		goto out;
+	}
+	err1 = store_status(status, start, current_node, i - start);
 	if (err >= 0)
 		err = err1;
 out:
-- 
2.17.1

