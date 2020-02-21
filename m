Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99CC168214
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgBUPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:44:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgBUPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:44:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id j8so2163997qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yRo7gnCIX0vM1nhTBOYfnL3fgUUwsg2PRm45MiUA12M=;
        b=cNgHmt+G+aB1RqDuQogKt3z4kavMJ3iwOoLCeGtOvqvI9O6MMwhckCrGnPWu6+6kj+
         /xVhL3VJapNayO2hjT3RlO764uSFYolv9KPfuVuDQv+0j/NSaPwjgBjM0MR10e92pZPi
         daufFVZFekeMneH8j6lPt0HUeVVTZC3byhwmAMFmquzltEWInzmvEqwjtgcx4IqEVLbI
         eTcjXl5g4RRc2A9l5QWNwOIGMj7exI0stfUDbrD/MRS4Urxklx/3Xvy0MZPk9JYhoIKl
         fKxSSew5FYfHwC8HeasOVg7ia9PDvu3ip6eqBbHvftBC6x12N+ehqIaDmXw9n7NIPXSX
         eN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRo7gnCIX0vM1nhTBOYfnL3fgUUwsg2PRm45MiUA12M=;
        b=mo8uvAJFP0kxi6/POKV+Swe3qtOqIchrjuQKtGP0QEY7cvS87Ihi+mevD/dCODsdnI
         PyDLBmtk7j+KGMsjOdpPQNByEZs3dGYNvYvTfD1o45UPNEaOef7b7SCHqqxfb+M21jxp
         dD2mN5Popw+IhqYq7hYJqstPocHwcYjrCBFXGtNqohOB1NlU+ejl3Q2VK8NdxFMBlqUL
         ebmr/dc4d0oTfE9YkNuQ53wFZvJzTv3fH3e9IbUnOGsl7jCA0d3CNv9MqR75vKAwD3QE
         9t7cGVXrkPpPCed112DVCvaKAuiajmqs9EBuE8shuWBGd7C6Ft58gvyEA9qhS9xxo42D
         swPA==
X-Gm-Message-State: APjAAAUH6NVyTH/KzdX8xt1RdgnCrHeWJkvEKUt2gCdMAUQwRLircV8/
        hHNfbk6AyWwY4H0ahC71YRJmeg==
X-Google-Smtp-Source: APXvYqzSR13L3ygyDhSBtYfnbXFXlvvJx9XRq7//ugzMuhmpGL2KoKkHUK/tyYSF4dbA9KJHc2HGEg==
X-Received: by 2002:a37:c49:: with SMTP id 70mr34890971qkm.12.1582299841244;
        Fri, 21 Feb 2020 07:44:01 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h14sm1612573qke.99.2020.02.21.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:44:00 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:43:59 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200221154359.GA70967@cmpxchg.org>
References: <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
 <20200214165311.GA253674@cmpxchg.org>
 <20200217084100.GE31531@dhcp22.suse.cz>
 <20200218195253.GA13406@cmpxchg.org>
 <20200221101147.GO20509@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221101147.GO20509@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:11:47AM +0100, Michal Hocko wrote:
> On Tue 18-02-20 14:52:53, Johannes Weiner wrote:
> > On Mon, Feb 17, 2020 at 09:41:00AM +0100, Michal Hocko wrote:
> > > On Fri 14-02-20 11:53:11, Johannes Weiner wrote:
> > > [...]
> > > > The proper solution to implement the kind of resource hierarchy you
> > > > want to express in cgroup2 is to reflect it in the cgroup tree. Yes,
> > > > the_workload might have been started by user 100 in session c2, but in
> > > > terms of resources, it's prioritized over system.slice and user.slice,
> > > > and so that's the level where it needs to sit:
> > > > 
> > > >                                root
> > > >                        /        |                 \
> > > >                system.slice  user.slice       the_workload
> > > >                /    |           |
> > > >            cron  journal     user-100.slice
> > > >                                 |
> > > >                              session-c2.scope
> > > >                                 |
> > > >                              misc
> > > > 
> > > > Then you can configure not just memory.low, but also a proper io
> > > > weight and a cpu weight. And the tree correctly reflects where the
> > > > workload is in the pecking order of who gets access to resources.
> > > 
> > > I have already mentioned that this would be the only solution when the
> > > protection would work, right. But I am also saying that this a trivial
> > > example where you simply _can_ move your workload to the 1st level. What
> > > about those that need to reflect organization into the hierarchy. Please
> > > have a look at http://lkml.kernel.org/r/20200214075916.GM31689@dhcp22.suse.cz
> > > Are you saying they are just not supported? Are they supposed to use
> > > cgroup v1 for the organization and v2 for the resource control?
> > 
> > >From that email:
> > 
> >     > Let me give you an example. Say you have a DB workload which is the
> >     > primary thing running on your system and which you want to protect from
> >     > an unrelated activity (backups, frontends, etc). Running it inside a
> >     > cgroup with memory.low while other components in other cgroups without
> >     > any protection achieves that. If those cgroups are top level then this
> >     > is simple and straightforward configuration.
> >     > 
> >     > Things would get much more tricky if you want run the same workload
> >     > deeper down the hierarchy - e.g. run it in a container. Now your
> >     > "root" has to use an explicit low protection as well and all other
> >     > potential cgroups that are in the same sub-hierarchy (read in the same
> >     > container) need to opt-out from the protection because they are not
> >     > meant to be protected.
> > 
> > You can't prioritize some parts of a cgroup higher than the outside of
> > the cgroup, and other parts lower than the outside. That's just not
> > something that can be sanely supported from the controller interface.
> 
> I am sorry but I do not follow. We do allow to opt out from the reclaim
> protection with the current semantic and it seems to be reasonably sane.

It's not a supported cgroup2 configuration, because the other
controllers do not support such opting out.

Again, you cannot prioritize memory without prioritizing IO, because a
lack of memory will immediately translate to an increase in paging.

The fundamental premise of cgroup2 is that unless you control *all*
contended resources, you are not controlling *any* of them. Years of
running containers in a large scale production environment have
reaffirmed and reinforced this point over and over. If you don't setup
coherent priority domains and control all resources simultaneously,
your workload *will* escape its containment and bring down the host or
other workloads, one way or the other.

The IO controller (as well as the CPU controller) cannot match this
concept of opting out of an assigned priority, so for real life setups
there is no supportable usecase for opting out of memory protection.

A usecase is only supported if all controllers support it.

> I also have hard time to grasp what you actually mean by the above.
> Let's say you have hiearchy where you split out low limit unevenly
>               root (5G of memory)
>              /    \
>    (low 3G) A      D (low 1,5G)
>            / \
>  (low 1G) B   C (low 2G)
>
> B gets lower priority than C and D while C gets higher priority than
> D? Is there any problem with such a configuration from the semantic
> point of view?

No, that's completely fine.

The thing that you cannot do is create the following setup:

                root
               /    \
        container1 container2
         /    \        |
     highpri  lowpri  midpri

and expect midpri to be always higher priority than lowpri. Because
prioritization is level-by-level: container1 has a relative priority
to container2, highpri has a relative priority to lowpri.

If you want highpri to have higher priority than midpri, you need to
give container1 a higher priority than container2. But what that also
means is that if highpri isn't using its share, then it goes to
lowpri. And then lowpri > midpri.

Think about how io and cpu weights are distributed in this tree and it
makes sense.

You can currently opt lowpri out of memory protection, but then it'll
just page and steal midpri's IO bandwidth, and you have the priority
inversion elsewhere.

The only way to actually implement the priorities as the names suggest
is this:

               root
          /     |    \
         c1    c2     c3
         |      |      |
      highpri midpri lowpri

> > However, that doesn't mean this usecase isn't supported. You *can*
> > always split cgroups for separate resource policies.
> 
> What if the split up is not possible or impractical. Let's say you want
> to control how much CPU share does your container workload get comparing
> to other containers running on the system? Or let's say you want to
> treat the whole container as a single entity from the OOM perspective
> (this would be an example of the logical organization constrain) because
> you do not want to leave any part of that workload lingering behind if
> the global OOM kicks in. I am pretty sure there are many other reasons
> to run related workload that doesn't really share the memory protection
> demand under a shared cgroup hierarchy.

The problem is that your "pretty sure" has been proven to be very
wrong in real life. And that's one reason why these arguments are so
frustrating: it's your intuition and gut feeling against the
experience of using this stuff hands-on in large scale production
deployments.

I'm telling you, orthogonal resource control hierarchies result in
priority inversions. Workloads interacting across different resource
domains result in priority inversions. It's the reason why there is a
single tree in cgroup2, and it's the reason why there is the concept
of all resources being combined into single priority buckets.

You cannot actually configure a system the way you claim people would
surely want to and get working resource isolation.

I really don't mind going into specifics and explaining my motivations
here. But you are drawing out the discussion by asserting hypothetical
scenarios that have been so properly refuted in the last decade that
we had to version and redo the entire interface geared toward these
concepts. Meanwhile my patches have been pending for three months with
acks from people who have extensively worked with this interface on
actual container stacks. I would ask you kindly not to do that.
