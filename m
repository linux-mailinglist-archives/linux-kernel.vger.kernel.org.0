Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9021051EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKUL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfKUL72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:59:28 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC4620872;
        Thu, 21 Nov 2019 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337568;
        bh=q4PVDG8jw34RjDKxPp2nT/hAOC7Wfja0Y9+ACVokqJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSnXJmWIUcA6HJ4ZX5wb59NdNbkAdPrQt4siX+/DLIYvAwXWkrFXbcVvBMomip1lw
         CPMzupczCLs1tHkSlfn0hQiuxDjvmdFXyigCtM6lhTCQtPjJm2lwk/NzLjExczlCit
         CblRXz2+Kf+leqIrV1/qyZ2ze3pNZQMZqtcb1LRU=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RESEND PATCH v4 10/10] drivers/lkdtm: Remove references to CONFIG_REFCOUNT_FULL
Date:   Thu, 21 Nov 2019 11:59:02 +0000
Message-Id: <20191121115902.2551-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121115902.2551-1-will@kernel.org>
References: <20191121115902.2551-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_REFCOUNT_FULL no longer exists, so remove all references to it.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/misc/lkdtm/refcount.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index abf3b7c1f686..de7c5ab528d9 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -119,7 +119,7 @@ void lkdtm_REFCOUNT_DEC_ZERO(void)
 static void check_negative(refcount_t *ref, int start)
 {
 	/*
-	 * CONFIG_REFCOUNT_FULL refuses to move a refcount at all on an
+	 * refcount_t refuses to move a refcount at all on an
 	 * over-sub, so we have to track our starting position instead of
 	 * looking only at zero-pinning.
 	 */
@@ -202,7 +202,6 @@ static void check_from_zero(refcount_t *ref)
 
 /*
  * A refcount_inc() from zero should pin to zero or saturate and may WARN.
- * Only CONFIG_REFCOUNT_FULL provides this protection currently.
  */
 void lkdtm_REFCOUNT_INC_ZERO(void)
 {
-- 
2.24.0.432.g9d3f5f5b63-goog

