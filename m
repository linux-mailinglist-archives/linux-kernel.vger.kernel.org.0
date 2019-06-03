Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265EF330AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfFCNKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:10:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:10:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DA1mR605130
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:10:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DA1mR605130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567402;
        bh=HY6f/+mZ5Od0OcAK8g1VxqUNqDW/sB+3kAXaViohMBY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Tv/nvtmFGB75Zlg6s+sILG6Xs/9BYjYnxv2fisD5thc8j5OopdoUtPW+ORLl4wtmL
         XWxsPCX2WgoOyPEUa8Z2qWUdgzGKbP8p/UtiUCnbi+zsuhX8EWBIxzH4uLjDeeOSEk
         /tzlg6hnfkHlQswofyWotw2XZK1iUP/hlh+w9zK1UYY39+HmRsiv74Z/i5oUPZVjnZ
         ncSCdWCZVrM4Fnn2bZge8riY8YP9VACaiTrGdY95xbwgDDX8Jux2na573274tssCRE
         9D/rSnT1fRl2q/uBawbZXtgzDTntMh61nanffW8TBizyv+B2l3L7B6d1C/gpE8e4/u
         /a5Xs0HT31JCw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D9xnh605127;
        Mon, 3 Jun 2019 06:09:59 -0700
Date:   Mon, 3 Jun 2019 06:09:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-d16dbd1b8a29bb9f8aca2c2f3bd1a0d2b7621126@git.kernel.org>
Cc:     torvalds@linux-foundation.org, duyuyang@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, peterz@infradead.org, duyuyang@gmail.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190506081939.74287-7-duyuyang@gmail.com>
References: <20190506081939.74287-7-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Update obsolete struct field
 description
Git-Commit-ID: d16dbd1b8a29bb9f8aca2c2f3bd1a0d2b7621126
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d16dbd1b8a29bb9f8aca2c2f3bd1a0d2b7621126
Gitweb:     https://git.kernel.org/tip/d16dbd1b8a29bb9f8aca2c2f3bd1a0d2b7621126
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:22 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:41 +0200

locking/lockdep: Update obsolete struct field description

The lock_chain struct definition has outdated comment, update it and add
struct member description.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-7-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6e2377e6c1d6..851d44fa5457 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -203,11 +203,17 @@ struct lock_list {
 	struct lock_list		*parent;
 };
 
-/*
- * We record lock dependency chains, so that we can cache them:
+/**
+ * struct lock_chain - lock dependency chain record
+ *
+ * @irq_context: the same as irq_context in held_lock below
+ * @depth:       the number of held locks in this chain
+ * @base:        the index in chain_hlocks for this chain
+ * @entry:       the collided lock chains in lock_chain hash list
+ * @chain_key:   the hash key of this lock_chain
  */
 struct lock_chain {
-	/* see BUILD_BUG_ON()s in lookup_chain_cache() */
+	/* see BUILD_BUG_ON()s in add_chain_cache() */
 	unsigned int			irq_context :  2,
 					depth       :  6,
 					base	    : 24;
