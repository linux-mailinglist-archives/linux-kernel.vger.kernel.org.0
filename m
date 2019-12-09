Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5C11726D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 18:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLIRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 12:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfLIRGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:06:39 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300B620692;
        Mon,  9 Dec 2019 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575911198;
        bh=v5GquLWqYcVFJRWpVM06dta39hsoDvvuwBXAIdjEjhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqN8dzIzpX5nZdkEXiiNOuRSReAHO4X/0QwxgP4AqZgxJJuOgNerxMYjrDC3MtHMH
         XRVSHeYL8ktieQrAgY0zWEfoHxkK5Zg5CZZoRcIOiHXPo47RRxcOq3VO0bMNhWA3Ci
         zcDmZvLBj1fZB0+/QvAUo9ED5Iw5076l0HZ6czbs=
Date:   Mon, 9 Dec 2019 17:06:34 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>, notify@kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] Documentation/barriers/kokr: Remove references to
 [smp_]read_barrier_depends()
Message-ID: <20191209170633.GC7489@willie-the-truck>
References: <20191121193209.15687-1-sj38.park@gmail.com>
 <20191129180837.7233-1-sjpark@amazon.de>
 <CAEjAshpsnrfkb83738rtkPbQohoFP0LZbP_45rUqyBX-RvsVwg@mail.gmail.com>
 <20191206204406.GK2889@paulmck-ThinkPad-P72>
 <CAEjAshrGRafO4-k0tDD_XjC8EDq11AOh3PX+bPUhrjkuo+N76A@mail.gmail.com>
 <20191206220858.GL2889@paulmck-ThinkPad-P72>
 <CAEjAshosihoc7YR4WrseZDe_oquiJPeP+2yyCDRJuMJ4rzsp8w@mail.gmail.com>
 <20191206225156.GM2889@paulmck-ThinkPad-P72>
 <20191209094432.GA3306@willie-the-truck>
 <20191209170057.GH2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209170057.GH2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 09:00:57AM -0800, Paul E. McKenney wrote:
> On Mon, Dec 09, 2019 at 09:44:33AM +0000, Will Deacon wrote:
> > On Fri, Dec 06, 2019 at 02:51:56PM -0800, Paul E. McKenney wrote:
> > > On Fri, Dec 06, 2019 at 11:38:22PM +0100, SeongJae Park wrote:
> > > > On Fri, Dec 6, 2019 at 11:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > But since Jon seems to be taking these in his capacity and Documentation
> > > > > maintainer, could you please resend CCing him?  If we have these changes
> > > > > scattered across too many trees, someone is going to get confused,
> > > > > and it probably will be me.  ;-)
> > > > 
> > > > Agreed, CC-ing Jon to this mail.  That said, this is a followup of Will's
> > > > patch[1] and the patch is also not queued in Jon's tree.  So, I would like to
> > > > hear Will's opinion either, if possible.
> > > > 
> > > > [1]  https://lore.kernel.org/lkml/20191108170120.22331-10-will@kernel.org/
> > > 
> > > Ah, this one got caught out in the conversion from .html to .rst.
> > > 
> > > I did get an ack on one of those, and thus queued it.  I clearly need to
> > > take another look at Will's series, and thank you for the reminder!
> > 
> > I was planning to include this in the next posting of my series, but I was
> > waiting for the merge window to close first. Now that we have -rc1, I'll
> > post it this week, although the patches are also queued up in my tree here
> > [1] (warning -- rebasing development branch).
> > 
> > I'll leave the patches that are unrelated to smp_read_barrier_depends() to
> > Paul and Jon, unless they indicate a preference to the contrary.
> 
> I don't know about Jon, but I might need a reminder as to which patches
> those are.  ;-)

https://lore.kernel.org/lkml/20191121234125.28032-1-sj38.park@gmail.com

...but it actually looks like Jon picked those all up, so I think we're good.

SeongJae -- please shout if we've missed something (the link above, plus
this patch).

Will
