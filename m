Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8A189B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 12:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCRLsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 07:48:50 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54205 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgCRLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:48:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tsy98tl_1584532118;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Tsy98tl_1584532118)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 19:48:44 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH] include/linux: fix some typos
Date:   Wed, 18 Mar 2020 19:48:37 +0800
Message-Id: <20200318114837.159978-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Not/Note/

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 include/linux/list_nulls.h | 4 ++--
 include/linux/once.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fa6e8471bd22..c845761fe5de 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -60,7 +60,7 @@ static inline unsigned long get_nulls_value(const struct hlist_nulls_node *ptr)
  * hlist_nulls_unhashed - Has node been removed and reinitialized?
  * @h: Node to be checked
  *
- * Not that not all removal functions will leave a node in unhashed state.
+ * Note that not all removal functions will leave a node in unhashed state.
  * For example, hlist_del_init_rcu() leaves the node in unhashed state,
  * but hlist_nulls_del() does not.
  */
@@ -73,7 +73,7 @@ static inline int hlist_nulls_unhashed(const struct hlist_nulls_node *h)
  * hlist_nulls_unhashed_lockless - Has node been removed and reinitialized?
  * @h: Node to be checked
  *
- * Not that not all removal functions will leave a node in unhashed state.
+ * Note that not all removal functions will leave a node in unhashed state.
  * For example, hlist_del_init_rcu() leaves the node in unhashed state,
  * but hlist_nulls_del() does not.  Unlike hlist_nulls_unhashed(), this
  * function may be used locklessly.
diff --git a/include/linux/once.h b/include/linux/once.h
index 9225ee6d96c7..095c6debd63b 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -16,7 +16,7 @@ void __do_once_done(bool *done, struct static_key_true *once_key,
  * out the condition into a nop. DO_ONCE() guarantees type safety of
  * arguments!
  *
- * Not that the following is not equivalent ...
+ * Note that the following is not equivalent ...
  *
  *   DO_ONCE(func, arg);
  *   DO_ONCE(func, arg);
-- 
2.24.0.rc2

