Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1785A47B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfF1Srd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 14:47:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfF1Srb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:47:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F534AEAF;
        Fri, 28 Jun 2019 18:47:30 +0000 (UTC)
Date:   Fri, 28 Jun 2019 20:47:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix regression with deferred struct page init
Message-ID: <20190628184729.GJ2751@dhcp22.suse.cz>
References: <20190620160821.4210-1-jgross@suse.com>
 <20190628151749.GA2880@dhcp22.suse.cz>
 <52a8e6d9-003e-c802-b8ff-327a8c7913a5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a8e6d9-003e-c802-b8ff-327a8c7913a5@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-06-19 19:38:13, Juergen Gross wrote:
> On 28.06.19 17:17, Michal Hocko wrote:
> > On Thu 20-06-19 18:08:21, Juergen Gross wrote:
> > > Commit 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time
> > > instead of doing larger sections") is causing a regression on some
> > > systems when the kernel is booted as Xen dom0.
> > > 
> > > The system will just hang in early boot.
> > > 
> > > Reason is an endless loop in get_page_from_freelist() in case the first
> > > zone looked at has no free memory. deferred_grow_zone() is always
> > 
> > Could you explain how we ended up with the zone having no memory? Is
> > xen "stealing" memblock memory without adding it to memory.reserved?
> > In other words, how do we end up with an empty zone that has non zero
> > end_pfn?
> 
> Why do you think Xen is stealing the memory in an odd way?
> 
> Doesn't deferred_init_mem_pfn_range_in_zone() return false when no free
> memory is found? So exactly if the memory was added to memory.reserved
> that will happen.

You are right. I managed to confuse myself and thought that __next_mem_range
return index to both memblock types. But I am wrong here and it excludes
type_b regions. I should have read the documentation. My bad and sorry
for the confusion.
-- 
Michal Hocko
SUSE Labs
