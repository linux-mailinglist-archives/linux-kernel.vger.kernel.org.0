Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 763D78FDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfHPI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 04:27:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfHPI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:27:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E376FAFC3;
        Fri, 16 Aug 2019 08:27:39 +0000 (UTC)
Date:   Fri, 16 Aug 2019 10:27:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Wei Wang <wvw@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190816082738.GC27790@dhcp22.suse.cz>
References: <20190815132127.GI9477@dhcp22.suse.cz>
 <20190815141219.GF21596@ziepe.ca>
 <20190815155950.GN9477@dhcp22.suse.cz>
 <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-08-19 22:16:43, Daniel Vetter wrote:
> On Thu, Aug 15, 2019 at 9:35 PM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > > The last detail is I'm still unclear what a GFP flags a blockable
> > > invalidate_range_start() should use. Is GFP_KERNEL OK?
> >
> > I hope I will not make this muddy again ;)
> > invalidate_range_start in the blockable mode can use/depend on any sleepable
> > allocation allowed in the context it is called from. So in other words
> > it is no different from any other function in the kernel that calls into
> > allocator. As the API is missing gfp context then I hope it is not
> > called from any restricted contexts (except from the oom which we have
> > !blockable for).
> 
> Hm, that's new to me. I thought mmu notifiers very much can be called
> from direct reclaim paths, so you have to be extremely careful with
> getting back into that one.

Correct, I should have added that notifier callbacks ideally do not
allocate any memory. They can block and even that is quite a pain to be
honest.
-- 
Michal Hocko
SUSE Labs
