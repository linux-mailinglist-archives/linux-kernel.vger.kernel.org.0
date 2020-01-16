Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3013DCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 15:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAPOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 09:05:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37455 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:05:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so3948560wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZwALC55EJePLunJ1kHrliV8F9jlgC0n9J9o4VvIiFIM=;
        b=LBeTSF1WmzdVlRy1n6Jwjzn3Pk20usSi6wYYB0UvKVzUUitMwzY/OzhBPqiHYDuBLe
         ZYRuQ6Z6XrzV2hXNbcXGMAAt0lvNUnJXYl+i6fwc7HKdxvX78ZqyZDG/KECuiXziR/Hi
         L0LCGVrL+c1XmRp3hedLlRcoPquCqN626/PTuyidjLHSboD5ShypYAV2Axtc5KirsJwK
         08GOiWfa/nXRgbaCR6Tv88wjUns8Sm1t+5rbUwfTqclqxp5QMs+g5wsOpIZ35WUOg2Cq
         FP7eSendvazVwyXAO3NZu+xDZrwAnhJUu2OgV9qxH+CB6SkIJXR/Lop9eCGJVEIxStda
         eUJw==
X-Gm-Message-State: APjAAAVehky0tcX1nuwT7c5qPCVooltaFrCcCtXxxN/BjHyQ4tgqjWJ4
        tanQtPo+IgDR6QfJHJHw9iE=
X-Google-Smtp-Source: APXvYqzxXuC6zAOHxXzNnRm5v9JBsHVdf4kat/zEboNhrnbA9r+i5/5h4VAMcW70a2QSIn1e8D3aBA==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr6204156wmi.118.1579183547433;
        Thu, 16 Jan 2020 06:05:47 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l17sm28217436wro.77.2020.01.16.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 06:05:46 -0800 (PST)
Date:   Thu, 16 Jan 2020 15:05:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, yang.shi@linux.alibaba.com
Subject: Re: [PATCH] mm/mempolicy.c: Fix out of bounds write in
 mpol_parse_str()
Message-ID: <20200116140545.GT19428@dhcp22.suse.cz>
References: <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
 <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz>
 <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
 <20200115190528.GJ19428@dhcp22.suse.cz>
 <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
 <20200116073922.GL19428@dhcp22.suse.cz>
 <CACT4Y+aWNQxSMSnHn6ORkBNM2wWp_K6tPxthj=_FmnyOfO5huA@mail.gmail.com>
 <20200116115123.GR19428@dhcp22.suse.cz>
 <CACT4Y+b_ybuMRJBtqFnttTv+vfNVKivUH-UmhHtuHh06tVxB_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b_ybuMRJBtqFnttTv+vfNVKivUH-UmhHtuHh06tVxB_g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 13:41:39, Dmitry Vyukov wrote:
> On Thu, Jan 16, 2020 at 12:51 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 16-01-20 11:13:09, Dmitry Vyukov wrote:
> > > On Thu, Jan 16, 2020 at 8:39 AM Michal Hocko <mhocko@kernel.org> wrote:
> > [...]
> > > > > $ grep vmalloc\( net/netfilter/*.c
> > > > > net/netfilter/nf_tables_api.c: return kvmalloc(alloc, GFP_KERNEL);
> > > > > net/netfilter/x_tables.c: xt[af].compat_tab = vmalloc(mem);
> > > > > net/netfilter/x_tables.c: mem = vmalloc(len);
> > > > > net/netfilter/x_tables.c: info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
> > > > > net/netfilter/xt_hashlimit.c: /* FIXME: don't use vmalloc() here or
> > > > > anywhere else -HW */
> > > > > net/netfilter/xt_hashlimit.c: hinfo = vmalloc(struct_size(hinfo, hash, size));
> > > > >
> > > > > These are not bound to processes/threads as namespaces are orthogonal to tasks.
> > > >
> > > > I cannot really comment on those. This is for networking people to
> > > > examine and find out whether they allow an untrusted user to runaway.
> > >
> > > Unless I am missing an elephant in this whole picture, kernel code
> > > contains 20K+ unaccounted allocations and if I am not mistaken few of
> > > them were audited and are intentionally unaccounted rather than
> > > unaccounted just because it's the default. So if we want DoS
> > > protection, it's really for every kernel developer/maintainer to audit
> > > and fix these allocation sites. And since we have a unikernel, a
> > > single unaccounted allocation may compromise the whole kernel. I
> > > assume we would need something like GFP_UNACCOUNTED to mark audited
> > > allocations that don't need accounting and then slowly reduce number
> > > of allocations without both ACCOUNTED and UNACCOUNTED.
> >
> > This is the original approach which led to all sorts of problems and so
> > we switched the opt-out to opt-in. Have a look at a9bb7e620efd ("memcg:
> > only account kmem allocations marked as __GFP_ACCOUNT").
> > Our protection will never be perfect because that would require to
> > design the system with the protection in mind.
> 
> I don't mean to switch the default. I mean adding a way to distinguish
> between reviewed and intentionally unaccounted allocation and
> unreviewed allocation which is unaccounted just because that's the
> default. This would allow to progress incrementally, rather than redo
> the same work again and again.

I am not really sure this would be viable just because of the sheer
number of allocations we have in the kernel. But I would be more than
happy to be proven wrong ;)

> > > > > Somebody told me that it's not good to use GFP_ACCOUNT if the
> > > > > allocation is not tied to the lifetime of the process. Is it still
> > > > > true?
> > > >
> > > > Those are more tricky. Mostly because there is no way to reclaim the
> > > > memory once the hard limit is hit. Even the memcg oom killer will not
> > > > help much. So a care should be taken when adding GFP_ACCOUNT for those.
> > > > On the other hand it would prevent an unbounded allocations at least
> > > > so the DoS would be reduced to the hard limited memcg.
> > >
> > > What exactly is this care in practice?
> > > It seems that in a148ce15375fc664ad64762c751c0c2aecb2cafe you just
> > > added it and the allocation is not tied to the process. At least I
> > > don't see any explanation as to why that one is safe, while accounting
> > > other similar allocation is not...
> >
> > My memory is dim but AFAIR the memcg accounting was compromise between
> > usability and the whole system stability. Really large tables could be
> > allocated by untrusted users and that was seen as a _real_ problem. The
> > previous solution added _some_ protection which led to regressions
> > even for reasonable cases though. Memcg accounting was deemed as
> > reasonable middle ground.
> >
> > The result is that a completely depleted memcg requires an admin
> > intervention and the admin has to know what to do to tear it down.
> > Kernel cannot do anything about that. And that is the trickiness I've
> > had in mind. Listing page tables is something admins can do quite
> > easily, right? There are many other objects which are much harder to act
> > about. E.g. what are you going to do with tmpfs mounts? Are you going to
> > remove them and cause potential data loss? That being said some objects
> > really have to be limited even before they start consuming memory IMHO.
> 
> Interesting. But there is really no admin today, or at least nothing
> should rely on one in any way. Either because of the scale (you have
> thousands/millions of machines and spending human time on each of them
> individually is not going to fly) and/or because there is nobody
> qualified enough around (e.g. who is an admin of a median android
> phone? and what does they know about tearing down namespaces and
> mounts) or there is nobody interested enough (it's fun sometimes, but
> not always)...

If there is nobody in control then there should be a reasonably safe
policy defined at least. This is what I mentioned earlier when saying
that not all objects can be easily accounted. There has to be a strategy
defined for corner cases. And user namespaces seem to really beg for
that when you are allowed to control resources like tmpfs and others
alike.

> but I agree that retrofitting this level of resource
> control into a large existing complex system is close to impossible.
> 
> Thank a lot for bearing with me and answering my questions. I have a
> better understanding of this now.

I am glad I could help.

Thanks for giving some scary examples ;)
-- 
Michal Hocko
SUSE Labs
