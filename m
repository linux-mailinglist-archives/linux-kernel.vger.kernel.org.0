Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC23E9D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfJ3ObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfJ3Oa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:58 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750D7218DE;
        Wed, 30 Oct 2019 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445858;
        bh=anQ8BmNsLbZC9C3E4/e7uqqMgjGG4zo6LrF/1NkOv8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFzFYPsX3+jD60zLsjzbnRAtWIk1QwDj+hSbupKMr/MqBmdvr0OeNYrxOBvSTkEEa
         MyCEMmAxFw78gxYBor/NCXaDR1LYxGDdUEf034CZZR0700OzDcHa91RbT5IS/p7y2I
         18MPDd6w/Ej0eG7i76xCzMFPtibNUMsg9bjEOUR0=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 07/10] lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
Date:   Wed, 30 Oct 2019 14:30:32 +0000
Message-Id: <20191030143035.19440-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
References: <20191030143035.19440-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions of REFCOUNT_MAX and REFCOUNT_SATURATED are the same,
regardless of CONFIG_REFCOUNT_FULL, so consolidate them into a single
pair of definitions.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 1cd0a876a789..757d4630115c 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -22,6 +22,8 @@ typedef struct refcount_struct {
 } refcount_t;
 
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 enum refcount_saturation_type {
 	REFCOUNT_ADD_NOT_ZERO_OVF,
@@ -57,9 +59,6 @@ static inline unsigned int refcount_read(const refcount_t *r)
 #ifdef CONFIG_REFCOUNT_FULL
 #include <linux/bug.h>
 
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
 /*
  * Variant of atomic_t specialized for reference counts.
  *
@@ -300,10 +299,6 @@ static inline void refcount_dec(refcount_t *r)
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
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
2.24.0.rc0.303.g954a862665-goog

