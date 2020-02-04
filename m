Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C615221F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 22:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBDVxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 16:53:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbgBDVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w6OXzP+HHp11meNIJ9sGsy1A1zoYw1xroawhHjswMtk=; b=qub5Y+M7Sgeh5dq3fj4fqTp0wS
        2CXcyu0en/Webtsc5wa4GheR5icm0dDqQcrUZB3sKHCdaOUprRTFOzcIcMZlLSJl+CQi3ICMrJqHx
        w+8MXUcwZmTGRj7S4DMk6lwTTxQxmnu5Y1lPcky0FjtScd77LH8mQLCxBURcc2rNOywvAbkaOCL94
        +7fmdTQG39YAVsUjwGQyv0JOfB9EMTKmejvt5DlN0Fi2j7aCuOq91CWMS4wekb4VjAzDGABbteRtz
        Gyp9kt1Ljl/KWsGxvIHOshoJZhfwSGh0p06PlJP/ElwWrMGpFaU8eprbb957DOzV5HSW1ehY3CWat
        FNK6ZBXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iz68F-0006V2-Ux; Tue, 04 Feb 2020 21:53:19 +0000
Date:   Tue, 4 Feb 2020 13:53:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
Message-ID: <20200204215319.GO8731@bombadil.infradead.org>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
 <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
 <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:42:43PM -0800, Mike Kravetz wrote:
> On 2/4/20 12:33 PM, David Rientjes wrote:
> > On Tue, 4 Feb 2020, Mike Kravetz wrote:
> > 
> > Hmm, if khugepaged_adjust_min_free_kbytes() increases min_free_kbytes for 
> > thp, then the user has no ability to override this increase by using 
> > vm.min_free_kbytes?
> > 
> > IIUC, with this change, it looks like memory hotplug events properly 
> > increase min_free_kbytes for thp optimization but also doesn't respect a 
> > previous user-defined value?
> 
> Good catch.
> 
> We should only call khugepaged_adjust_min_free_kbytes from the 'true'
> block of this if statement in init_per_zone_wmark_min.
> 
> 	if (new_min_free_kbytes > user_min_free_kbytes) {
> 		min_free_kbytes = new_min_free_kbytes;
> 		if (min_free_kbytes < 128)
> 			min_free_kbytes = 128;
> 		if (min_free_kbytes > 65536)
> 			min_free_kbytes = 65536;
> 	} else {
> 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
> 				new_min_free_kbytes, user_min_free_kbytes);
> 	}
> 
> In the existing code, a hotplug event will cause min_free_kbytes to overwrite
> the user defined value if the new value is greater.  However, you will get
> the warning message if the user defined value is greater.  I am not sure if
> this is the 'desired/expected' behavior?  We print a warning if the user value
> takes precedence over our calculated value.  However, we do not print a message
> if we overwrite the user defined value.  That doesn't seem right!
> 
> > So it looks like this is fixing an obvious correctness issue but also now 
> > requires users to rewrite the sysctl if they want to decrease the min 
> > watermark.
> 
> Moving the call to khugepaged_adjust_min_free_kbytes as described above
> would avoid the THP adjustment unless we were going to overwrite the
> user defined value.  Now, I am not sure overwriting the user defined value
> as is done today is actually the correct thing to do.
> 
> Thoughts?
> Perhaps we should never overwrite a user defined value?

We should certainly warn if we would have adjusted it, had they not
changed it!

I'm reluctant to suggest we do a more complex adjustment of the value
(eg figure out what the adjustment would have been, then apply some
fraction of that adjustment to keep the ratios in proportion) because
we don't really know why they adjusted it.

OTOH, we should adjust it if the user-set min_free_kbytes is now too
large for the amount of memory now in the machine.
