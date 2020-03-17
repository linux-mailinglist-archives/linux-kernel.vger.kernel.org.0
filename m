Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EEC188D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCQTEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 15:04:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khnnmus/Nw8g+jmOk6DqGCz4HgnMXtLLc28X6KhT4xs=; b=LPEYR6SpHd8AlzlAbmcrvhd20f
        vB2eBNRehKh7EGkvCr7Nl1qwVa0AMHNkR+xIl9wzmj/hbuauMkH3PMmJvx0k+KKIfHPjjju/Qj0Jq
        gwWC7D0QHECsDmasY2BWWW58eoNQtrXoTC7yKl7tfePHU6b76X66dtMSa9vfGWGXjWvUVqDdOAHxf
        7/fpRokeF9ZoAYhgSkUM5/EeOIn9aHB9h6jK1iQ378K1HAhcD+/MEqEZz1KNUOl/b2gCBZT43uTEA
        8PfuM1tkmkDI1nn5nJcCESC7t2TDGnzHRL9ng4JRnyMLbNUTW+FiHENzuhm1w9xKpx8jMWCAYzOdt
        Chfi9BKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEHVb-0003C6-RE; Tue, 17 Mar 2020 19:04:11 +0000
Date:   Tue, 17 Mar 2020 12:04:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: swap: make page_evictable() inline
Message-ID: <20200317190411.GD22433@bombadil.infradead.org>
References: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 01:42:50AM +0800, Yang Shi wrote:
> v3: * Fixed the build error reported by lkp.

I'm not terribly enthusiastic about including pagemap.h from swap.h.
It's a discussion that reasonable people can disagree about, so let's
set it up:

This patch adds inline bool page_evictable(struct page *page) to swap.h.
page_evictable() uses mapping_evictable() which is in pagemap.h.
mapping_evictable() uses AS_UNEVICTABLE which is also in pagemap.h.

We could move mapping_evictable() and friends to fs.h (already included
by swap.h).  But how about just moving page_evictable() to pagemap.h?
pagemap.h is already included by mm/mlock.c, mm/swap.c and mm/vmscan.c,
which are the only three current callers of page_evictable().

In fact, since it's only called by those three files, perhaps it should
be in mm/internal.h?  I don't see it becoming a terribly popular function
to call outside of the core mm code.

I think I have a mild preference for it being in pagemap.h, since I don't
have a hard time convincing myself that it's part of the page cache API,
but I definitely prefer internal.h over swap.h.

