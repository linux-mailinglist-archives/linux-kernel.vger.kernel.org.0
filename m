Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2485159553
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgBKQr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:47:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39803 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgBKQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:47:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so4418455wme.4;
        Tue, 11 Feb 2020 08:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMl+mRO9Zvf2SDJ75RJRDZjMrbhk+aBHXg/UK4B09DA=;
        b=dChStUK8diMq2NGB+3sU0pNMSbHY4g8JxRBOwn5oxx2J07qo9MeLYByf3n2AYIWRFr
         RizTB4uBHV/59FlSEW3G5ZfUNi8AvMm2Qxng4EhZXH8bHw0rZ9dlq7PTV5g4S2R4SWXY
         fOtUnLqRP/0xV1+Xxwz8ReYJiNeDJHZ58J9JV2GPNPlitMCdz8WH3pPp5tBiTH2KvIOy
         LocKwZIrMfFyMe6qnSpeD2Q2U5YdGYqZ/btVr78opI43VCF7CEWcyLQF/6DcUPdXbIaj
         4WP981yYPv/AKOSUZRWPj5V2bySp9w+l2bojOgr6ao6jGrA9JgD4nk59HXleEbYE+Lr8
         sOSA==
X-Gm-Message-State: APjAAAVijj2Mrx3D+YElmZOGTWyWaXtqHqDRS4/cie6JTBUDbSKHQchA
        n0RPlk7Qx7ad3CMPb++tdf83tBld
X-Google-Smtp-Source: APXvYqyRmpnV0x90UnxeJU/1d5i6cXU6wvw0RqwIVycsFRl5ODFQlgFraCMrIyXLjxV9s936/PfKjA==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr6892696wmf.133.1581439676118;
        Tue, 11 Feb 2020 08:47:56 -0800 (PST)
Received: from localhost (ip-37-188-227-72.eurotel.cz. [37.188.227.72])
        by smtp.gmail.com with ESMTPSA id x11sm4418883wmg.46.2020.02.11.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 08:47:55 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:47:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200211164753.GQ10636@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203215201.GD6380@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-02-20 16:52:01, Johannes Weiner wrote:
> On Thu, Jan 30, 2020 at 06:00:20PM +0100, Michal Hocko wrote:
> > On Thu 19-12-19 15:07:18, Johannes Weiner wrote:
> > > Right now, the effective protection of any given cgroup is capped by
> > > its own explicit memory.low setting, regardless of what the parent
> > > says. The reasons for this are mostly historical and ease of
> > > implementation: to make delegation of memory.low safe, effective
> > > protection is the min() of all memory.low up the tree.
> > > 
> > > Unfortunately, this limitation makes it impossible to protect an
> > > entire subtree from another without forcing the user to make explicit
> > > protection allocations all the way to the leaf cgroups - something
> > > that is highly undesirable in real life scenarios.
> > > 
> > > Consider memory in a data center host. At the cgroup top level, we
> > > have a distinction between system management software and the actual
> > > workload the system is executing. Both branches are further subdivided
> > > into individual services, job components etc.
> > > 
> > > We want to protect the workload as a whole from the system management
> > > software, but that doesn't mean we want to protect and prioritize
> > > individual workload wrt each other. Their memory demand can vary over
> > > time, and we'd want the VM to simply cache the hottest data within the
> > > workload subtree. Yet, the current memory.low limitations force us to
> > > allocate a fixed amount of protection to each workload component in
> > > order to get protection from system management software in
> > > general. This results in very inefficient resource distribution.
> > 
> > I do agree that configuring the reclaim protection is not an easy task.
> > Especially in a deeper reclaim hierarchy. systemd tends to create a deep
> > and commonly shared subtrees. So having a protected workload really
> > requires to be put directly into a new first level cgroup in practice
> > AFAICT. That is a simpler example though. Just imagine you want to
> > protect a certain user slice.
> 
> Can you elaborate a bit on this? I don't quite understand the two
> usecases you are contrasting here.

Essentially this is about two different usecases. The first one is about
protecting a hierarchy and spreading the protection among different
workloads and the second is how to protect an inner memcg without
configuring protection all the way up the hierarchy.
 
> > You seem to be facing a different problem though IIUC. You know how much
> > memory you want to protect and you do not have to care about the cgroup
> > hierarchy up but you do not know/care how to distribute that protection
> > among workloads running under that protection. I agree that this is a
> > reasonable usecase.
> 
> I'm not sure I'm parsing this right, but the use case is this:
> 
> When I'm running a multi-component workload on a host without any
> cgrouping, the individual components compete over the host's memory
> based on rate of allocation, how often they reference their memory and
> so forth. It's a need-based distribution of pages, and the weight can
> change as demand changes throughout the life of the workload.
> 
> If I now stick several of such workloads into a containerized
> environment, I want to use memory.low to assign each workload as a
> whole a chunk of memory it can use - I don't want to assign fixed-size
> subchunks to each individual component of each workload! I want the
> same free competition *within* the workload while setting clear rules
> for competition *between* the different workloads.

Yeah, that matches my understanding of the problem your are trying to
solve here.
> 
> [ What I can do today to achieve this is disable the memory controller
>   for the subgroups. When I do this, all pages of the workload are on
>   one single LRU that is protected by one single memory.low.
> 
>   But obviously I lose any detailed accounting as well.
> 
>   This patch allows me to have the same recursive protection semantics
>   while retaining accounting. ]
> 
> > Those both problems however show that we have a more general
> > configurability problem for both leaf and intermediate nodes. They are
> > both a result of strong requirements imposed by delegation as you have
> > noted above. I am thinking didn't we just go too rigid here?
> 
> The requirement for delegation is that child groups cannot claim more
> than the parent affords. Is that the restriction you are referring to?

yes.

> > Delegation points are certainly a security boundary and they should
> > be treated like that but do we really need a strong containment when
> > the reclaim protection is under admin full control? Does the admin
> > really have to reconfigure a large part of the hierarchy to protect a
> > particular subtree?
> > 
> > I do not have a great answer on how to implement this unfortunately. The
> > best I could come up with was to add a "$inherited_protection" magic
> > value to distinguish from an explicit >=0 protection. What's the
> > difference? $inherited_protection would be a default and it would always
> > refer to the closest explicit protection up the hierarchy (with 0 as a
> > default if there is none defined).
> >         A
> >        / \
> >       B   C (low=10G)
> >          / \
> >         D   E (low = 5G)
> > 
> > A, B don't get any protection (low=0). C gets protection (10G) and
> > distributes the pressure to D, E when in excess. D inherits (low=10G)
> > and E overrides the protection to 5G.
> > 
> > That would help both usecases AFAICS while the delegation should be
> > still possible (configure the delegation point with an explicit
> > value). I have very likely not thought that through completely.  Does
> > that sound like a completely insane idea?
> > 
> > Or do you think that the two usecases are simply impossible to handle
> > at the same time?
> 
> Doesn't my patch accomplish this?

Unless I am missing something then I am afraid it doesn't. Say you have a
default systemd cgroup deployment (aka deeper cgroup hierarchy with
slices and scopes) and now you want to grant a reclaim protection on a
leaf cgroup (or even a whole slice that is not really important). All the
hierarchy up the tree has the protection set to 0 by default, right? You
simply cannot get that protection. You would need to configure the
protection up the hierarchy and that is really cumbersome.

> Any cgroup or group of cgroups still cannot claim more than the
> ancestral protection for the subtree. If a cgroup says 10G, the sum of
> all children's protection will never exceed that. This ensures
> delegation is safe.

Right. And delegation usecase really requres that. No question about
that. I am merely arguing that if you do not delegate then this is way
too strict.
-- 
Michal Hocko
SUSE Labs
