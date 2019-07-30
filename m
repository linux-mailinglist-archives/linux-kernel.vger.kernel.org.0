Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE43F7B553
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfG3Vz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 17:55:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32903 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfG3Vz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:55:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so30536168pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P02YqgmHTBcIJHjlAhI3pmvYr3xQglXD30+9G24hZL0=;
        b=JfqeC2g2V+5cIel4C2FBoEbpxuKdP1WCR6nuuJpKeOE5lUNbAcnSKyhgVsBPgPvYxj
         BGuMdnsVfIMqza6URp/OtMX07ffwcHo7pjG47MrUZuPdVku7xGc/lwpkgN8h2bE+POCX
         yExOFC9+ljlKCqhRyUtGSexJhAwo0bvtoBGierEFHkqPh2ji3HYElQaeoT7Fv+sDIl31
         Oq1WZvT9IDkEZESkkOh0MaXfIBO+IBjHX2kTSOYIjaFcBlIznK73joPITvFSEPf1gTUU
         FYji5mScVoZlCfWeeO4U82TWvEMtmh4YLgS3+Ype31zKA8EdfvUXzTiLyVvvVlgwpnjU
         1wow==
X-Gm-Message-State: APjAAAUdkvKzOF6EhTIAhLKPzCTw2H3FemVNzP09tRKegFWmj/j5O2+3
        zQwYAZg7WkoiU/ZIza1Q/94=
X-Google-Smtp-Source: APXvYqz8Qg9AJa69GLSc54Bruvm9B0nwsdP1exUGkKtJJa+hTb+D8UM8ML0vxMYEeIaRb8/cZOPIqA==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr31609955pjq.69.1564523758593;
        Tue, 30 Jul 2019 14:55:58 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:6988])
        by smtp.gmail.com with ESMTPSA id m101sm53084226pjb.7.2019.07.30.14.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 14:55:57 -0700 (PDT)
Date:   Tue, 30 Jul 2019 17:55:35 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
Message-ID: <20190730215535.GA67664@dennisz-mbp.dhcp.thefacebook.com>
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190730204643.tsxgc3n4adb63rlc@pc636>
 <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
 <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdd44c2-a10e-23f0-a71c-bf8f3e6fc384@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:13:25PM -0700, sathyanarayanan kuppuswamy wrote:
> 
> On 7/30/19 1:54 PM, Dave Hansen wrote:
> > On 7/30/19 1:46 PM, Uladzislau Rezki wrote:
> > > > +		/*
> > > > +		 * If required width exeeds current VA block, move
> > > > +		 * base downwards and then recheck.
> > > > +		 */
> > > > +		if (base + end > va->va_end) {
> > > > +			base = pvm_determine_end_from_reverse(&va, align) - end;
> > > > +			term_area = area;
> > > > +			continue;
> > > > +		}
> > > > +
> > > >   		/*
> > > >   		 * If this VA does not fit, move base downwards and recheck.
> > > >   		 */
> > > > -		if (base + start < va->va_start || base + end > va->va_end) {
> > > > +		if (base + start < va->va_start) {
> > > >   			va = node_to_va(rb_prev(&va->rb_node));
> > > >   			base = pvm_determine_end_from_reverse(&va, align) - end;
> > > >   			term_area = area;
> > > > -- 
> > > > 2.21.0
> > > > 
> > > I guess it is NUMA related issue, i mean when we have several
> > > areas/sizes/offsets. Is that correct?
> > I don't think NUMA has anything to do with it.  The vmalloc() area
> > itself doesn't have any NUMA properties I can think of.  We don't, for
> > instance, partition it into per-node areas that I know of.
> > 
> > I did encounter this issue on a system with ~100 logical CPUs, which is
> > a moderate amount these days.
> 
> I agree with Dave. I don't think this issue is related to NUMA. The problem
> here is about the logic we use to find appropriate vm_area that satisfies
> the offset and size requirements of pcpu memory allocator.
> 
> In my test case, I can reproduce this issue if we make request with offset
> (ffff000000) and size (600000).
> 
> > 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 

I misspoke earlier. I don't think it's numa related either, but I think
you could trigger this much more easily this way as it could skip more
viable vma space because it'd have to find more holes.

But it seems that pvm_determine_end_from_reverse() will return the free
vma below the address if it is aligned so:

    base + end > va->va_end

will always be true and then push down the searching va instead of using
that va first.

Thanks,
Dennis
