Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E06BFAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 23:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfIZVg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 17:36:57 -0400
Received: from varys.harry.pm ([206.189.117.216]:39136 "EHLO varys.harry.pm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZVg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:36:56 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 17:36:56 EDT
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by varys.harry.pm (Postfix) with ESMTPA id A262C68868;
        Thu, 26 Sep 2019 21:30:32 +0000 (UTC)
From:   Harry Jeffery <me@harry.pm>
To:     linux-kernel@vger.kernel.org
Cc:     Harry Jeffery <me@harry.pm>
Subject: [PATCH] btree: Remove custom MAX macro
Date:   Thu, 26 Sep 2019 22:34:05 +0100
Message-Id: <20190926213405.91757-1-me@harry.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
Authentication-Results: varys.harry.pm;
        auth=pass smtp.auth=me@harry.pm smtp.mailfrom=me@harry.pm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The btree implementation defines its own MAX macro, whilst also
including kernel.h, which already defines a max macro. This removes the
custom implementation in favour of the standard one provided in kernel.h

Signed-off-by: Harry Jeffery <me@harry.pm>
---
 lib/btree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/btree.c b/lib/btree.c
index b4cf08a5c267..4b5968b6167b 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -43,8 +43,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#define NODESIZE MAX(L1_CACHE_BYTES, 128)
+#define NODESIZE max(L1_CACHE_BYTES, 128)
 
 struct btree_geo {
 	int keylen;
-- 
2.23.0

