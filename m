Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C073A58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391475AbfGXTtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 15:49:02 -0400
Received: from verein.lst.de ([213.95.11.211]:53836 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391456AbfGXTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:48:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E520F68B20; Wed, 24 Jul 2019 21:48:55 +0200 (CEST)
Date:   Wed, 24 Jul 2019 21:48:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724194855.GA15029@lst.de>
References: <20190723210506.25127-1-rcampbell@nvidia.com> <20190724070553.GA2523@lst.de> <20190724152858.GB28493@ziepe.ca> <20190724175858.GC6410@dhcp22.suse.cz> <20190724180837.GF28493@ziepe.ca> <20190724185617.GE6410@dhcp22.suse.cz> <20190724185910.GF6410@dhcp22.suse.cz> <20190724192155.GG28493@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724192155.GG28493@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:21:55PM -0300, Jason Gunthorpe wrote:
> If we change the register to keep the hlist sorted by address then we
> can do a targetted 'undo' of past starts terminated by address
> less-than comparison of the first failing struct mmu_notifier.
> 
> It relies on the fact that rcu is only used to remove items, the list
> adds are all protected by mm locks, and the number of mmu notifiers is
> very small.
> 
> This seems workable and does not need more driver review/update...
> 
> However, hmm's implementation still needs more fixing.

Can we take one step back, please?  The only reason why drivers
implement both ->invalidate_range_start and ->invalidate_range_end and
expect them to be called paired is to keep some form of counter of
active invalidation "sections".  So instead of doctoring around
undo schemes the only sane answer is to take such a counter into the
core VM code instead of having each driver struggle with it.
