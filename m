Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7FCE83A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfJGPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfJGPra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:30 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95A520684;
        Mon,  7 Oct 2019 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463250;
        bh=/Q2RDASp4LWo029qo5Z0BXaWm3f/sqVUqNcy83HqtT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQMLRuzE853fLqW7QH0vHuBklmJIYitIIucYTP/hAs/SYGblHtWU6UOIfpq8V46zE
         cuBEBi8a6hAQkpbnS8NKKFbS6iUP1+Hmfy7Kecdzs8b0MrNKggP7POhONyyM8QAKdl
         /GKYvtcXCoxk2K+5lcZ//hrfvx+d9AyXwrGquFWQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v3 10/10] drivers/lkdtm: Remove references to CONFIG_REFCOUNT_FULL
Date:   Mon,  7 Oct 2019 16:47:03 +0100
Message-Id: <20191007154703.5574-11-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
References: <20191007154703.5574-1-will@kernel.org>
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
2.23.0.581.g78d2f28ef7-goog

