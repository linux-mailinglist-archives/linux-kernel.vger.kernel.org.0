Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21673D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbfGXUSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:18:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47049 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388998AbfGXUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:18:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so46771212qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWJ6DdSzX3UNH5IsBG0QIkcKoVJ3m7vBBB3d3WVZ5uE=;
        b=n3J+GAL+FB7VbB4RL6GVAirOAzlkzTHdeG1dUMoxA6P765HJ6vilINgoGfg1gmk1C2
         QeSv4gST+tMRdO9dLK69LLxfwyPsmiKfyvs3TUfCoqfmvKURPNG1u5ThxfSfZB/rAVJW
         lzianxfqFVnwvVRML7U80M5T1T+Rvr5AfzzqyvrySHXOSTaI+056H1I+ByDUtnJBhlEg
         xIezRDw+WneukJZqZHL6mhNX2cx/6DDLOuo7f4psXrJoTCceu3eN0GU9eB/Ur5nkuNRK
         9EMn6cOnl72B0kvwpSRZeH//s6PjsHVcKalg1f9Sgc0xqts4GjQ2MeeoyqGPz1aGpEOO
         krHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWJ6DdSzX3UNH5IsBG0QIkcKoVJ3m7vBBB3d3WVZ5uE=;
        b=X3046i2MJYOaAgghVjBRXvr1vUz6K9aJDZRRHpOayKzGVZaifSS3DlcD/WpNwwk06B
         1mxtdxzxt/9pDq5hkNqU1tapKruae7LysgnWH3KBTd4IwGERdOvbyFQzn5TDR4mZdKee
         Ggn+iV8pKJONFEAm8jDsPgb5a/TJ0dmRb2ZoHBhEgIKx5qwFHkw6jPcw9sB4nl1TNsVo
         Xe1d/m68VvwA2VNvb0MpQjN/m5ogHueg42P8MCa+L3ophqSWQkg4plqgwrkojb3DUoOc
         ZV/lrL1J3Pc5fE6eI0N8qre+lq43XwC2b9dwDXikQE14gvJcV16W6X3kTGrwIrbqUO9J
         Ekcw==
X-Gm-Message-State: APjAAAUpaQKgJaRmIK3ZYLAe9h0Ecv2Jp25PG7qUGjobzrKEkLTyh+7u
        gt2oGUiMSoZKttMZsvi6Wi/YDA==
X-Google-Smtp-Source: APXvYqy6Kd2FCXwA5ViOoNdVk66YE8CWdFXTM44KqYbLUvwUjmODvbZbHeyXtq/HnU0w/t05AaFPsA==
X-Received: by 2002:ac8:7b99:: with SMTP id p25mr59513506qtu.243.1563999514197;
        Wed, 24 Jul 2019 13:18:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v1sm21152817qkj.19.2019.07.24.13.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 13:18:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqNib-0007Qc-5i; Wed, 24 Jul 2019 17:18:33 -0300
Date:   Wed, 24 Jul 2019 17:18:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724201833.GI28493@ziepe.ca>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190724070553.GA2523@lst.de>
 <20190724152858.GB28493@ziepe.ca>
 <20190724175858.GC6410@dhcp22.suse.cz>
 <20190724180837.GF28493@ziepe.ca>
 <20190724185617.GE6410@dhcp22.suse.cz>
 <20190724185910.GF6410@dhcp22.suse.cz>
 <20190724192155.GG28493@ziepe.ca>
 <20190724194855.GA15029@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724194855.GA15029@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:48:55PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 04:21:55PM -0300, Jason Gunthorpe wrote:
> > If we change the register to keep the hlist sorted by address then we
> > can do a targetted 'undo' of past starts terminated by address
> > less-than comparison of the first failing struct mmu_notifier.
> > 
> > It relies on the fact that rcu is only used to remove items, the list
> > adds are all protected by mm locks, and the number of mmu notifiers is
> > very small.
> > 
> > This seems workable and does not need more driver review/update...
> > 
> > However, hmm's implementation still needs more fixing.
> 
> Can we take one step back, please?  The only reason why drivers
> implement both ->invalidate_range_start and ->invalidate_range_end and
> expect them to be called paired is to keep some form of counter of
> active invalidation "sections".  So instead of doctoring around
> undo schemes the only sane answer is to take such a counter into the
> core VM code instead of having each driver struggle with it.

This might work as a hybrid sort of idea, like what HMM tried to do
with the counter and valid together.

If we keep the counter global and then provide an 'all invalidates
finished' callback then the driver could potentially still ignore
invalidates that do not touch its ranges during its page fault path.

I'd have to sketch it..

I agree it would solve this problem as well and better advance the
goal to make mmu notifiers simpler to use.. 

But I didn't audit all the invalidate_end users to be sure :)

Jason
