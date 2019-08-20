Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9196C14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfHTWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 18:20:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbfHTWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z6ZVviRtuyf2TUYASfKOwbPfalJnz3NoFwMLit9B6E0=; b=g1gjiaVs4Puj+/mhPMATNXkaR
        jmIWbDo7zqvkJou0f1g3xQOpEFZgfod/Jw1CHF5ZD13xXs+n2SOiCDmUlT5CrcLMUcuqvdcNbhw8Z
        rCgkST4EiwHLwvk12cwyB/XXpG1tQCjq/tjxIYM4GiGGqIr+m8VaAn2s6u8yPBqr/XLZkEZsKrH/W
        AB4UXVg4DI2ItaU0UB7kGsg7xbGoPNSKMc+Qr3CqeBGdxmSzPfoTTGrqG1aVuLP3jAETItkT03aRz
        fYrDVMKXJg7H13nUA04J8WLFC+EOuCHwzAn4bHR4cajke+Cg0IcBGGf6yeihC3UwAgthgggBEJh1H
        rLOuXqtXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0CUV-0002Ar-Az; Tue, 20 Aug 2019 22:20:35 +0000
Date:   Tue, 20 Aug 2019 15:20:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, mhocko@suse.com,
        dan.j.williams@intel.com, Yu Zhao <yuzhao@google.com>,
        Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm: Proactive compaction
Message-ID: <20190820222035.GC4949@bombadil.infradead.org>
References: <20190816214413.15006-1-nigupta@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816214413.15006-1-nigupta@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 02:43:30PM -0700, Nitin Gupta wrote:
> Testing done (on x86):
>  - Set /sys/kernel/mm/compaction/order-9/extfrag_{low,high} = {25, 30}
>  respectively.
>  - Use a test program to fragment memory: the program allocates all memory
>  and then for each 2M aligned section, frees 3/4 of base pages using
>  munmap.
>  - kcompactd0 detects fragmentation for order-9 > extfrag_high and starts
>  compaction till extfrag < extfrag_low for order-9.

Your test program is a good idea, but I worry it may produce
unrealistically optimistic outcomes.  Page cache is readily reclaimable,
so you're setting up a situation where 2MB pages can once again be
produced.

How about this:

One program which creates a file several times the size of memory (or
several files which total the same amount).  Then read the file(s).  Maybe
by mmap(), and just do nice easy sequential accesses.

A second program which causes slab allocations.  eg

for (;;) {
	for (i = 0; i < n * 1000 * 1000; i++) {
		char fname[64];

		sprintf(fname, "/tmp/missing.%d", i);
		open(fname, O_RDWR);
	}
}

The first program should thrash the pagecache, causing pages to
continuously be allocated, reclaimed and freed.  The second will create
millions of dentries, causing the slab allocator to allocate a lot of
order-0 pages which are harder to free.  If you really want to make it
work hard, mix in opening some files whihc actually exist, preventing
the pages which contain those dentries from being evicted.

This feels like it's simulating a more normal workload than your test.
What do you think?
