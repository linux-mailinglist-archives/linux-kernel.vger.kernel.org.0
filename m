Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC027115
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfEVUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 16:51:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:49324 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbfEVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:58 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id CD9A812B3;
        Wed, 22 May 2019 20:50:57 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, George Spelvin <lkml@sdf.org>
Subject: [PATCH 4/8] lib/list_sort: fix kerneldoc build error
Date:   Wed, 22 May 2019 14:50:30 -0600
Message-Id: <20190522205034.25724-5-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 043b3f7b6388 ("lib/list_sort: simplify and remove
MAX_LIST_LENGTH_BITS") added some useful kerneldoc info, but also broke the
docs build:

  ./lib/list_sort.c:128: WARNING: Definition list ends without a blank line; unexpected unindent.
  ./lib/list_sort.c:161: WARNING: Unexpected indentation.
  ./lib/list_sort.c:162: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix the offending literal block and make the error go away.

Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
Cc: George Spelvin <lkml@sdf.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 lib/list_sort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 06e900c5587b..712ed1f4eb64 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -120,7 +120,8 @@ static void merge_final(void *priv, cmp_func cmp, struct list_head *head,
  * The latter offers a chance to save a few cycles in the comparison
  * (which is used by e.g. plug_ctx_cmp() in block/blk-mq.c).
  *
- * A good way to write a multi-word comparison is
+ * A good way to write a multi-word comparison is::
+ *
  *	if (a->high != b->high)
  *		return a->high > b->high;
  *	if (a->middle != b->middle)
-- 
2.21.0

