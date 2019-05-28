Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12D92D1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfE1WvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 18:51:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44289 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfE1WvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:51:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so216683pfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=A6/6R+/Nv8Z2SD4lbng0GBEtfji+apEvTNJOkbK6GWg=;
        b=EwqrM25HRiCV8Zp135cAoHA+lRXbI4GAuLpPpqX8uCzfL/n7tGDuJUOIUPCKYeB2Tc
         /V+xY4H9IfAlIJRmqyZmF9tHFP4Rep2+BetHX1DWAtE3rGGphIBq7Dok2SGBO/NZxeub
         lE5CAl4ad73BE4sVQEyj8dAayNrPl5FLEE5dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=A6/6R+/Nv8Z2SD4lbng0GBEtfji+apEvTNJOkbK6GWg=;
        b=Lx95PW+6vlLckAxJgEV9FWABtIjquy7ei6LDDhGWvp+NL1UlE/psY6GVrtJn5O+TJO
         axH4MctcxMyizTqAG7EYrwcYlm//PF5aPFGOSM2B1/C70vAZaWt9K3dSGQ/aYnXcVSkL
         gqz9fGO2I0vpNz8Numlsf7T4RmMLLpY5HxGEeWzKX1z8XkI7Rp/gS6WZcFuN6ikrS1mC
         RcirS5+QyHEK2gxtzE/NmdnTOtB/G3VMR+1qbiD2hDHb/9L6MNlr10TWQ2Ld1zKBb4ai
         3e8EKpakoikBLPd5tMXqSenCD4XFyNQIxAiywXdOMLHmIF+SMgncpp73+FkVyLb5qnzR
         jqtw==
X-Gm-Message-State: APjAAAWSB0fIJiWc6Fxm3JuZA+vq6l0Hm8OQypfzYJ3j55gXurTzElD8
        /AXWSKQaxigpuwTConWJWaOzuQ==
X-Google-Smtp-Source: APXvYqwkKxFrxo/V024VcvaZTgt6vqBl2H1V8LFW42AYAO3sxlSugYP/vJr2H5XG81zg8t10JoqphQ==
X-Received: by 2002:a17:90a:a00b:: with SMTP id q11mr8626964pjp.108.1559083872369;
        Tue, 28 May 2019 15:51:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm26920pfn.59.2019.05.28.15.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:51:11 -0700 (PDT)
Date:   Tue, 28 May 2019 15:51:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib: test_overflow: Avoid taining the kernel and fix wrap
 size
Message-ID: <201905281550.4E3CB258F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds __GFP_NOWARN to the kmalloc()-portions of the overflow test to
avoid tainting the kernel. Additionally fixes up the math on wrap size
to be architecture and page size agnostic.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_overflow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index fc680562d8b6..4b05143eb538 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -486,16 +486,17 @@ static int __init test_overflow_shift(void)
  * Deal with the various forms of allocator arguments. See comments above
  * the DEFINE_TEST_ALLOC() instances for mapping of the "bits".
  */
-#define alloc010(alloc, arg, sz) alloc(sz, GFP_KERNEL)
-#define alloc011(alloc, arg, sz) alloc(sz, GFP_KERNEL, NUMA_NO_NODE)
+#define alloc_GFP		 (GFP_KERNEL | __GFP_NOWARN)
+#define alloc010(alloc, arg, sz) alloc(sz, alloc_GFP)
+#define alloc011(alloc, arg, sz) alloc(sz, alloc_GFP, NUMA_NO_NODE)
 #define alloc000(alloc, arg, sz) alloc(sz)
 #define alloc001(alloc, arg, sz) alloc(sz, NUMA_NO_NODE)
-#define alloc110(alloc, arg, sz) alloc(arg, sz, GFP_KERNEL)
+#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP | __GFP_NOWARN)
 #define free0(free, arg, ptr)	 free(ptr)
 #define free1(free, arg, ptr)	 free(arg, ptr)
 
-/* Wrap around to 8K */
-#define TEST_SIZE		(9 << PAGE_SHIFT)
+/* Wrap around to 16K */
+#define TEST_SIZE		(5 * 4096)
 
 #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
 static int __init test_ ## func (void *arg)				\
-- 
2.17.1


-- 
Kees Cook
