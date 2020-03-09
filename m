Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA317E80D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgCITF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbgCITEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19F924658;
        Mon,  9 Mar 2020 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780665;
        bh=XEjdlJtgaHhCYd7QOwSbHewIlN4Mq71jDXs0v9HV8Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIvCA7JDUyMEXIl38dzbb06OKGcjPAE1dkL1ntQ58q/KHZSL2XCS4OiZ0mvjRlQ1O
         NLY+aDgpm5PIT6YEIhZXLmVOBDdTyyLfSIpOOwWft8Ii4N9QbMnlaAXvgoDLdRfj1C
         0TXnOP3saXlVYf1MO+DfQumx6yzUX80796uMd83w=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 11/32] kcsan: Add docbook header for data_race()
Date:   Mon,  9 Mar 2020 12:03:59 -0700
Message-Id: <20200309190420.6100-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/compiler.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8c0beb1..c1bdf37 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -315,13 +315,15 @@ unsigned long read_word_at_a_time(const void *addr)
 
 #include <linux/kcsan.h>
 
-/*
- * data_race(): macro to document that accesses in an expression may conflict with
- * other concurrent accesses resulting in data races, but the resulting
- * behaviour is deemed safe regardless.
+/**
+ * data_race - mark an expression as containing intentional data races
+ *
+ * This data_race() macro is useful for situations in which data races
+ * should be forgiven.  One example is diagnostic code that accesses
+ * shared variables but is not a part of the core synchronization design.
  *
- * This macro *does not* affect normal code generation, but is a hint to tooling
- * that data races here should be ignored.
+ * This macro *does not* affect normal code generation, but is a hint
+ * to tooling that data races here are to be ignored.
  */
 #define data_race(expr)                                                        \
 	({                                                                     \
-- 
2.9.5

