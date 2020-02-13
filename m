Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C5715C973
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 18:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBMRdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 12:33:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgBMRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=whraMTwc8On7BKF2JC4K/arVk0mDU/m6cHTFea+NUR0=; b=XWkJf5iybNTydVvdsrDgSB3md4
        8QcEa9s+tWWkAHtvdiFJobYxqE9WTegIcYBXKBzKuTfj6TExcWRqPXmuuKr1Rd08a2Hi1zxLEo4rj
        39lgcoJX2qUChbosAc7D8JChqdlWzpUAHNZ57cNbz1Df3jQ0vDASgWugf4oSigGkhm5eHLAchJyZR
        47gZ74c7cxX1Y9Oje9xvu63MXWHOuw5HH+7qWD/W7U96hKmkvzb7Ztyle/koANfYlzNK9+VVAn6J8
        rVyotH23Y0HCZXs/pWrAgiVzgIQ32406LRIAtmp01rUPsV8trq59NL0z3/5AuRBQw8HpfiLhUrW4b
        k7T0TaLQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2IN2-0007am-Lw; Thu, 13 Feb 2020 17:33:48 +0000
Date:   Thu, 13 Feb 2020 09:33:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Why PageReadahead is not migrated by migration code?
Message-ID: <20200213173348.GS7778@bombadil.infradead.org>
References: <7691ab12-2e84-2531-f27d-2fae9045576d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7691ab12-2e84-2531-f27d-2fae9045576d@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:06:58AM -0800, Yang Shi wrote:
> Recently we saw some PageReadahead related bugs, so I did a quick check
> about the use of PageReadahead. I just found the state is *not* migrated by
> migrate_page_states().
> 
> Since migrate_page() won't migrate writeback page, so if PageReadahead is
> set it should just mean PG_readahead rather than PG_reclaim. So, I didn't
> think of why it is not migrated.
> 
> I dig into the history a little bit, but the change in migration code is too
> overwhelming. But, it looks PG_readahead was added after migration was
> introduced. Is it just a simple omission?

It's probably more that it just doesn't matter enough.  If the Readahead
flag is missing on a page then the application will perform slightly worse
for a few pages as it ramps its readahead back up again.  On the other
hand, you just migrated its pages to a different NUMA node, so chances
are there are bigger perofmrance problems happening at this moment anyway.

I think we probably should migrate it, but I can understand why nobody's
noticed it before.
