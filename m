Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43D17F4C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392254AbfHBKKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:10:20 -0400
Received: from foss.arm.com ([217.140.110.172]:48918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392227AbfHBKKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:10:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36B9C16A3;
        Fri,  2 Aug 2019 03:10:15 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1B373F71F;
        Fri,  2 Aug 2019 03:10:13 -0700 (PDT)
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH 6/6] lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
Date:   Fri,  2 Aug 2019 11:10:00 +0100
Message-Id: <20190802101000.12958-7-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190802101000.12958-1-will@kernel.org>
References: <20190802101000.12958-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions of REFCOUNT_MAX and REFCOUNT_SATURATED are the same,
regardless of CONFIG_REFCOUNT_FULL, so consolidate them into a single
pair of definitions.

Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index eea17f39c4df..814131d492e9 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -22,6 +22,8 @@ typedef struct refcount_struct {
 } refcount_t;
 
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 /**
  * refcount_set - set a refcount's value
@@ -47,9 +49,6 @@ static inline unsigned int refcount_read(const refcount_t *r)
 #ifdef CONFIG_REFCOUNT_FULL
 #include <linux/bug.h>
 
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
 /*
  * Variant of atomic_t specialized for reference counts.
  *
@@ -261,10 +260,6 @@ static inline void refcount_dec(refcount_t *r)
 	}
 }
 #else /* CONFIG_REFCOUNT_FULL */
-
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
 # ifdef CONFIG_ARCH_HAS_REFCOUNT
 #  include <asm/refcount.h>
 # else
-- 
2.11.0

