Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B601D7755
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfJONUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 09:20:37 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47663 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfJONUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:20:37 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKMkd-0002yw-J3; Tue, 15 Oct 2019 14:20:35 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKMkd-00024u-4e; Tue, 15 Oct 2019 14:20:35 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] userns: do not export uidhash_table
Date:   Tue, 15 Oct 2019 14:20:32 +0100
Message-Id: <20191015132032.7943-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uidhash_table is not exported from this file, so
make it static to avoid the following sparse warning:

kernel/user.c:85:19: warning: symbol 'uidhash_table' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-kernel@vger.kernel.org
---
 kernel/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/user.c b/kernel/user.c
index 5235d7f49982..b1635d94a1f2 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
 #define uidhashentry(uid)	(uidhash_table + __uidhashfn((__kuid_val(uid))))
 
 static struct kmem_cache *uid_cachep;
-struct hlist_head uidhash_table[UIDHASH_SZ];
+static struct hlist_head uidhash_table[UIDHASH_SZ];
 
 /*
  * The uidhash_lock is mostly taken from process context, but it is
-- 
2.23.0

