Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A975737C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 21:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfGXTV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 15:21:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37116 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:21:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so34596669qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q7VJ5lbRcag+sb2GFiCBi0ogY7ktByen10i6R5SYdYM=;
        b=ZyJ3zgq6h4cja/hdaLrA6IkzBFDVRDUJUFtWz1fzLJwFO3+4I4Mk/FCq69MWFKhPkn
         VmJtaQRVCCbTW4B/7vtp3EFV7mKQ0Du9zN1ddOb32MyshNPl6WhBSEDHrm+k6o2CyMMO
         4KyPGLB4T/6MfLf1NsYTF9rAzr1pU8FsMWEvqr8KtU1D2GgXOl729S0aNG0wyoeil1db
         UU7GVtf1oaMsSE860psV8LYDQAfcq3WrN/GcPafu+19PCrIlmB/lcCJJ/hsWVBf9sq/S
         3j9mLwgItOsVezznIUV4U2H56ZO80MnsJTCG1n8+5OJ16YnPZyPc+ck/lacJ5FRZiPcz
         PO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q7VJ5lbRcag+sb2GFiCBi0ogY7ktByen10i6R5SYdYM=;
        b=na7fuOC2l2TZNckpq6wNCXkWW6KwpXMA7TW2OzjQFjxuDqF0FZBkVWf0pvmsnmkLAO
         bgizRmEhNzwClRXo0GrSZnM5YL3FdOGhxaVA9CaxD1xHVyzZWS/Ow1lavJTp/WCYiLP9
         HmJv4M4tyisFnWkkZEPP+LucK8jHGa0ctVnrUUrQ1yMpZv2UpERXYPDrJ3xarY3+DlO2
         Lw2k57AWVAW2xwChKCxqX94WEu+C3ObBhZ9rmuANDiYZ+N/HuR3kV7g6SWvnWMyAvrg0
         3p2JB9V3zFxTM8dntvWtyOfTGDEI93yU6dlcMPklnCtJXAIth9s5f2v2wpudn/r4gAZF
         CXUQ==
X-Gm-Message-State: APjAAAWviNie/HEjurBD2qaEeBMKefF5uZEUv5EizySW1dQ3Qx7vgGTS
        rWY8eVxl5kyazwGrvj2cYFdhFQ==
X-Google-Smtp-Source: APXvYqxIqRA+0VLqS5/ktYsyx1BSHKocPYVvc0BAedibqfRz0wbPwwvU+Y1GIKj2RSb05TRVjFqKEg==
X-Received: by 2002:a05:620a:1425:: with SMTP id k5mr56337391qkj.146.1563996116084;
        Wed, 24 Jul 2019 12:21:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l19sm27634792qtb.6.2019.07.24.12.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:21:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqMpn-0006gr-3W; Wed, 24 Jul 2019 16:21:55 -0300
Date:   Wed, 24 Jul 2019 16:21:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724192155.GG28493@ziepe.ca>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190724070553.GA2523@lst.de>
 <20190724152858.GB28493@ziepe.ca>
 <20190724175858.GC6410@dhcp22.suse.cz>
 <20190724180837.GF28493@ziepe.ca>
 <20190724185617.GE6410@dhcp22.suse.cz>
 <20190724185910.GF6410@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724185910.GF6410@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 08:59:10PM +0200, Michal Hocko wrote:
> On Wed 24-07-19 20:56:17, Michal Hocko wrote:
> > On Wed 24-07-19 15:08:37, Jason Gunthorpe wrote:
> > > On Wed, Jul 24, 2019 at 07:58:58PM +0200, Michal Hocko wrote:
> > [...]
> > > > Maybe new users have started relying on a new semantic in the meantime,
> > > > back then, none of the notifier has even started any action in blocking
> > > > mode on a EAGAIN bailout. Most of them simply did trylock early in the
> > > > process and bailed out so there was nothing to do for the range_end
> > > > callback.
> > > 
> > > Single notifiers are not the problem. I tried to make this clear in
> > > the commit message, but lets be more explicit.
> > > 
> > > We have *two* notifiers registered to the mm, A and B:
> > > 
> > > A invalidate_range_start: (has no blocking)
> > >     spin_lock()
> > >     counter++
> > >     spin_unlock()
> > > 
> > > A invalidate_range_end:
> > >     spin_lock()
> > >     counter--
> > >     spin_unlock()
> > > 
> > > And this one:
> > > 
> > > B invalidate_range_start: (has blocking)
> > >     if (!try_mutex_lock())
> > >         return -EAGAIN;
> > >     counter++
> > >     mutex_unlock()
> > > 
> > > B invalidate_range_end:
> > >     spin_lock()
> > >     counter--
> > >     spin_unlock()
> > > 
> > > So now the oom path does:
> > > 
> > > invalidate_range_start_non_blocking:
> > >  for each mn:
> > >    a->invalidate_range_start
> > >    b->invalidate_range_start
> > >    rc = EAGAIN
> > > 
> > > Now we SKIP A's invalidate_range_end even though A had no idea this
> > > would happen has state that needs to be unwound. A is broken.
> > > 
> > > B survived just fine.
> > > 
> > > A and B *alone* work fine, combined they fail.
> > 
> > But that requires that they share some state, right?
> > 
> > > When the commit was landed you can use KVM as an example of A and RDMA
> > > ODP as an example of B
> > 
> > Could you point me where those two share the state please? KVM seems to
> > be using kvm->mmu_notifier_count but I do not know where to look for the
> > RDMA...
> 
> Scratch that. ELONGDAY... I can see your point. It is all or nothing
> that doesn't really work here. Looking back at your patch it seems
> reasonable but I am not sure what is supposed to be a behavior for
> notifiers that failed.

Okay, good to know I'm not missing something. The idea was the failed
notifier would have to handle the mandatory _end callback.

I've reflected on it some more, and I have a scheme to be able to
'undo' that is safe against concurrent hlist_del_rcu.

If we change the register to keep the hlist sorted by address then we
can do a targetted 'undo' of past starts terminated by address
less-than comparison of the first failing struct mmu_notifier.

It relies on the fact that rcu is only used to remove items, the list
adds are all protected by mm locks, and the number of mmu notifiers is
very small.

This seems workable and does not need more driver review/update...

However, hmm's implementation still needs more fixing.

Thanks,
Jason
