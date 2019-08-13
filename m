Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBCC8C36D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfHMVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfHMVQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:16:31 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EA8205C9;
        Tue, 13 Aug 2019 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565730991;
        bh=5lO5nG45fLOHTgE1yvwYm5c55LUdkLb+cAFPTo7XcbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OkG7QgjoGy1/FLMnWjN6QVHtQGDQE7lx3AF09Wq1TzQirB9nW7PhsZgi97LYakzAS
         kpNmEhjjpIsqmSORExdEosdrLv2gJP/YeSBEFOMn1H5v5ee8hvFz/1qjptsMpcWS3X
         KSFzaA/tLs+FDl9iSVKMYNQ4/gNMWqHEiPVBbtww=
Date:   Tue, 13 Aug 2019 14:16:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, page_alloc: move_freepages should not examine
 struct page of reserved memory
Message-Id: <20190813141630.bd8cee48e6a83ca77eead6ad@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 20:37:11 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> After commit 907ec5fca3dc ("mm: zero remaining unavailable struct pages"),
> struct page of reserved memory is zeroed.  This causes page->flags to be 0
> and fixes issues related to reading /proc/kpageflags, for example, of
> reserved memory.
> 
> The VM_BUG_ON() in move_freepages_block(), however, assumes that
> page_zone() is meaningful even for reserved memory.  That assumption is no
> longer true after the aforementioned commit.
> 
> There's no reason why move_freepages_block() should be testing the
> legitimacy of page_zone() for reserved memory; its scope is limited only
> to pages on the zone's freelist.
> 
> Note that pfn_valid() can be true for reserved memory: there is a backing
> struct page.  The check for page_to_nid(page) is also buggy but reserved
> memory normally only appears on node 0 so the zeroing doesn't affect this.
> 
> Move the debug checks to after verifying PageBuddy is true.  This isolates
> the scope of the checks to only be for buddy pages which are on the zone's
> freelist which move_freepages_block() is operating on.  In this case, an
> incorrect node or zone is a bug worthy of being warned about (and the
> examination of struct page is acceptable bcause this memory is not
> reserved).

I'm thinking Fixes:907ec5fca3dc and Cc:stable?  But 907ec5fca3dc is
almost a year old, so you were doing something special to trigger this?

