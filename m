Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6F9A412
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfHVXs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfHVXs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:48:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 365AC233A0;
        Thu, 22 Aug 2019 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566517738;
        bh=trAvxIds03qyczpKRNMmw+JkjF/vubiWJu0COHu1Ixw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hgj0cXSFqi7crwfzIP24q8ZxyUF3OWheAjO98TmG6zmRb0uc5k+GVwz4bGdc4Iit9
         gFIZU2zVa2WmObx7zaBrmwiGqoSHGHxMrnsQ6gxovyD8HAegKL3nFmZOSWwY6yXAd7
         zw0eSgnfNNSsrdou2B5m67VspZsqbJ+zBUhrSIvA=
Date:   Thu, 22 Aug 2019 16:48:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] lib/test_kasan: add roundtrip tests
Message-Id: <20190822164857.460353a8195bfd5ddb3d5f50@linux-foundation.org>
In-Reply-To: <20190819161449.30248-1-mark.rutland@arm.com>
References: <20190819161449.30248-1-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 17:14:49 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> In several places we need to be able to operate on pointers which have
> gone via a roundtrip:
> 
> 	virt -> {phys,page} -> virt
> 
> With KASAN_SW_TAGS, we can't preserve the tag for SLUB objects, and the
> {phys,page} -> virt conversion will use KASAN_TAG_KERNEL.
> 
> This patch adds tests to ensure that this works as expected, without
> false positives which have recently been spotted [1,2] in testing.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20190819114420.2535-1-walter-zh.wu@mediatek.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20190819132347.GB9927@lakrids.cambridge.arm.com/
> 
>
> ...
>

The only change I'm seeing from v1 is:

--- a/lib/test_kasan.c~lib-test_kasan-add-roundtrip-tests-v2
+++ a/lib/test_kasan.c
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
-#include <asm/io.h>
 #include <asm/page.h>
 
 /*

which is really kinda wrong.  We should strictly include linux/io.h for
things like virt_to_phys().

So I think I'll stick with v1 plus my fixlet:

--- a/lib/test_kasan.c~lib-test_kasan-add-roundtrip-tests-checkpatch-fixes
+++ a/lib/test_kasan.c
@@ -18,8 +18,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/page.h>
 
 /*

> Since v1:
> * Spin as a separate patch
> * Fix typo
> * Note examples in commit message.

So I'm not sure what happened to these things.  Did you send the correct
patch?

