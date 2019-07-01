Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287CC2D1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 00:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfE1Wr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 18:47:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33458 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1Wrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:47:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so94648pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MAoBZADCEd0vPKJ49AgS6iE1e+falhQ3CjJBnG9r8fg=;
        b=GtcPmsPKw91P6kvxeDWttl7qxUivQqZl/WB5Gh5hZdnm+5yIO2uZ2t/OSX0OmzEOCy
         sF29tnbeJ8Wm4VkzDktqcRMz5/Pr407jXYYeK2nL1WUL/rdyKRFJ5Lb8dgxEMFjnUV1P
         eERSQVTPegq8oQgSLIS8R6qnR18reixRSXg4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MAoBZADCEd0vPKJ49AgS6iE1e+falhQ3CjJBnG9r8fg=;
        b=H+t3Mxg6TVRBNoVmK2VqVDn8B93OLCglUks/jzwkpTbx8l2Enwq/exFr48VrNgDvZt
         P14NbEswBPf6HKGCT1HmTqZQsYQhDjBwHlN8YKNDUARNCneD9VQbBPCRzyhhKftXRDr4
         LVa5sAGX1P0uGIKQKJmw9u4IRMKqKGycdnYrtvqohogCrGXFe1kxPDhQYUVlxRdTx4TK
         NA5f8v3BmTB4mg2Ed8D47lT+JRRsg0acIcZwN/WMUmJTuKoHPJh7svIXhl6241qsR3tt
         ZAdMjG7KyWH2kMUcZUHP5PQKJEcIM2klXLg4MXPSHCsPgEKGyUk4IIl14vJpDwfpZhb+
         CvgA==
X-Gm-Message-State: APjAAAX6S7mww/wGE46w0P9ouTj2GgdMXIxOGRBw7c8zp/g9nbVSfzIy
        LzDerOl7Edktg0CSYzqbNF0iog==
X-Google-Smtp-Source: APXvYqw3mv+G541iuDOvP4AUa0q98ok84G11/maYW6QsZbQDV/zVxM/YOwu8VcFjLQuOGKLVHdTGXw==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr8607798pjq.61.1559083674993;
        Tue, 28 May 2019 15:47:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm3450567pju.19.2019.05.28.15.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:47:54 -0700 (PDT)
Date:   Tue, 28 May 2019 15:47:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: lib/test_overflow.c causes WARNING and tainted kernel
Message-ID: <201905281518.756178E7@keescook>
References: <9fa84db9-084b-cf7f-6c13-06131efb0cfa@infradead.org>
 <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
 <e2646ac0-c194-4397-c021-a64fa2935388@infradead.org>
 <97c4b023-06fe-2ec3-86c4-bfdb5505bf6d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c4b023-06fe-2ec3-86c4-bfdb5505bf6d@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 09:53:33AM +0200, Rasmus Villemoes wrote:
> On 25/05/2019 17.33, Randy Dunlap wrote:
> > On 3/13/19 7:53 PM, Kees Cook wrote:
> >> Hi!
> >>
> >> On Wed, Mar 13, 2019 at 2:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>
> >>> This is v5.0-11053-gebc551f2b8f9, MAR-12 around 4:00pm PT.
> >>>
> >>> In the first test_kmalloc() in test_overflow_allocation():
> >>>
> >>> [54375.073895] test_overflow: ok: (s64)(0 << 63) == 0
> >>> [54375.074228] WARNING: CPU: 2 PID: 5462 at ../mm/page_alloc.c:4584 __alloc_pages_nodemask+0x33f/0x540
> >>> [...]
> >>> [54375.079236] ---[ end trace 754acb68d8d1a1cb ]---
> >>> [54375.079313] test_overflow: kmalloc detected saturation
> >>
> >> Yup! This is expected and operating as intended: it is exercising the
> >> allocator's detection of insane allocation sizes. :)
> >>
> >> If we want to make it less noisy, perhaps we could add a global flag
> >> the allocators could check before doing their WARNs?
> >>
> >> -Kees
> > 
> > I didn't like that global flag idea.  I also don't like the kernel becoming
> > tainted by this test.
> 
> Me neither. Can't we pass __GFP_NOWARN from the testcases, perhaps with
> a module parameter to opt-in to not pass that flag? That way one can
> make the overflow module built-in (and thus run at boot) without
> automatically tainting the kernel.
> 
> The vmalloc cases do not take gfp_t, would they still cause a warning?

They still warn, but they don't seem to taint. I.e. this patch:

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index fc680562d8b6..c922f0d86181 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -486,11 +486,12 @@ static int __init test_overflow_shift(void)
  * Deal with the various forms of allocator arguments. See comments above
  * the DEFINE_TEST_ALLOC() instances for mapping of the "bits".
  */
-#define alloc010(alloc, arg, sz) alloc(sz, GFP_KERNEL)
-#define alloc011(alloc, arg, sz) alloc(sz, GFP_KERNEL, NUMA_NO_NODE)
+#define alloc_GFP	(GFP_KERNEL | __GFP_NOWARN)
+#define alloc010(alloc, arg, sz) alloc(sz, alloc_GFP)
+#define alloc011(alloc, arg, sz) alloc(sz, alloc_GFP, NUMA_NO_NODE)
 #define alloc000(alloc, arg, sz) alloc(sz)
 #define alloc001(alloc, arg, sz) alloc(sz, NUMA_NO_NODE)
-#define alloc110(alloc, arg, sz) alloc(arg, sz, GFP_KERNEL)
+#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP | __GFP_NOWARN)
 #define free0(free, arg, ptr)	 free(ptr)
 #define free1(free, arg, ptr)	 free(arg, ptr)
 
will remove the tainting behavior but is still a bit "noisy". I can't
find a way to pass __GFP_NOWARN to a vmalloc-based allocation, though.

Randy, is removing taint sufficient for you?

> BTW, I noticed that the 'wrap to 8K' depends on 64 bit and
> pagesize==4096; for 32 bit the result is 20K, while if the pagesize is
> 64K one gets 128K and 512K for 32/64 bit size_t, respectively. Don't
> know if that's a problem, but it's easy enough to make it independent of
> pagesize (just make it 9*4096 explicitly), and if we use 5 instead of 9
> it also becomes independent of sizeof(size_t) (wrapping to 16K).

Ah! Yes, all excellent points. I've adjusted that too now. I'll send
the result to Andrew.

Thanks!

-- 
Kees Cook
