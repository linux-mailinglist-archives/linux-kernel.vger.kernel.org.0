Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792FBCC125
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 18:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfJDQ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 12:57:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34140 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDQ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:57:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so4102640pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ab3tBPQ6Pcp75EMdc8QMkmhS5pFStOh5Ri4sl4H0v0g=;
        b=A0o11SDOPotJTR39eKw+j9HVUoXBtR1ABbHLNkbmlRtwrujglMKYkhg8twvkc7P2Le
         v2sVc0UTrpSc9iYrgLn5vrVaUFCXXiixLD+9uRCODWkid05wuRaj4ErKxYecnjytS/uc
         fzc6e76CBTvg/DKxKhQRJuDGDwx1H1unSKBOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ab3tBPQ6Pcp75EMdc8QMkmhS5pFStOh5Ri4sl4H0v0g=;
        b=muETvXk35cPiaeZDwJi0sPCqcPSlbsgvArSAejJhc+fPcA7guV71ltdXN09caKP9Ui
         FIGOTVqO+0ajOs/VOQL7z7Tti8CwDGdUNJGaTcZ7NnBjT/ZHcKzTthEKUQXhJvDkIIjf
         weps8xvQWcyMpt2eJ2Eg4em752j4WlzN098SOIa7CAbubhq2q9o2gfO6eqlydZ2G34Y7
         x5mhHfJgIZu0zeorLRgjUdSa+EbutzM+JvdZl54ctdL7WSZfNd/Sou2E6wbqVHQEFiFr
         UVE5u8vq63AMy9dENOk0jRI90PLr87J/59Cyek/Xuv8PW6q2Qf63inoM3bNv1t7Q3/ie
         hKQw==
X-Gm-Message-State: APjAAAXbATtQy9NitgdUjQDRc9QgJjTm96T2NSTa+Vnh8t2wr1x/8NUs
        Tf/TIY0DuieTDDj/XJTp4dXNhQF03gI=
X-Google-Smtp-Source: APXvYqz7IVKm+JhSRuBZ3wUloItdZybc2Y5fUZoUGymqB8pch0UB1ERtNv0AZobl/w8oQOideEBk6A==
X-Received: by 2002:aa7:8813:: with SMTP id c19mr18135534pfo.101.1570208257358;
        Fri, 04 Oct 2019 09:57:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t125sm8906818pfc.80.2019.10.04.09.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:57:36 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:57:36 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191004165736.GF253167@google.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com>
 <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <20191004164859.GD253167@google.com>
 <CACT4Y+bPZOb=h9m__Uo0feEshdGzPz0qGK7f2omsUc6-kEvwZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bPZOb=h9m__Uo0feEshdGzPz0qGK7f2omsUc6-kEvwZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 06:52:49PM +0200, Dmitry Vyukov wrote:
> On Fri, Oct 4, 2019 at 6:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Oct 02, 2019 at 09:51:58PM +0200, Marco Elver wrote:
> > > Hi Joel,
> > >
> > > On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > Hi all,
> > > > >
> > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > > >
> > > > > To those of you who we mentioned at LPC that we're working on a
> > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > > >
> > > > > In the coming weeks we're planning to:
> > > > > * Set up a syzkaller instance.
> > > > > * Share the dashboard so that you can see the races that are found.
> > > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > > point it out and we'll prioritize that).
> > > > >
> > > > > There are a few open questions:
> > > > > * The big one: most of the reported races are due to unmarked
> > > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > > to fix races might be required. Comments on how best to proceed are
> > > > > welcome. We're aware that these are issues that have recently received
> > > > > attention in the context of the LKMM
> > > > > (https://lwn.net/Articles/793253/).
> > > > > * How/when to upstream KCSAN?
> > > >
> > > > Looks exciting. I think based on our discussion at LPC, you mentioned
> > > > one way of pruning is if the compiler generated different code with _ONCE
> > > > annotations than what would have otherwise been generated. Is that still on
> > > > the table, for the purposing of pruning the reports?
> > >
> > > This might be interesting at first, but it's not entirely clear how
> > > feasible it is. It's also dangerous, because the real issue would be
> > > ignored. It may be that one compiler version on a particular
> > > architecture generates the same code, but any change in compiler or
> > > architecture and this would no longer be true. Let me know if you have
> > > any more ideas.
> >
> > My thought was this technique of looking at compiler generated code can be
> > used for prioritization of the reports.  Have you tested it though? I think
> > without testing such technique, we could not know how much of benefit (or
> > lack thereof) there is to the issue.
> >
> > In fact, IIRC, the compiler generating different code with _ONCE annotation
> > can be given as justification for patches doing such conversions.
> 
> 
> We also should not forget about "missed mutex" races (e.g. unprotected
> radix tree), which are much worse and higher priority than a missed
> atomic annotation. If we look at codegen we may discard most of them
> as non important.

Sure. I was not asking to look at codegen as the only signal. But to use the
signal for whatever it is worth.

thanks,

 - Joel

