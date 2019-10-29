Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C65E8D84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbfJ2RAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 13:00:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40287 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfJ2RAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:00:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id u22so16094616lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FxpLHlDzv8M6ObvTdSa66rmeXf+xPk+EZI1zfuUIzs=;
        b=hV5mvHy9FmQvKLIZ/KgLfWNeJhv7lQtUl/+gBNqCdrQdmsyoKWWYcKnkdVhhnGieTx
         gdvHJZdsBeL/l9y2QlnsBrJbD5O/3R9jaLVuW+sernlNZkAznmPRnjw/Iqv8DnYHvrEA
         e/HLHMTYYNz5eoV2INetYd1x96lVkR+kwq25spK4r5HR4Ns/7oB2NLZ/l2DFFuSSC0z1
         U0gM8vjUWrkNOWDsuJrzLAHOlo7juGToRd8FSHyL/Xfz6vXv9FVYNfRMXZoLp5Qlzz04
         Lbp8boh+3rL3K25KVX6d6xjLdfDW/7IrBHo7QBe1QYRH1DB+jLTIcntu5a6e522+OmPi
         6uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FxpLHlDzv8M6ObvTdSa66rmeXf+xPk+EZI1zfuUIzs=;
        b=NTCfJ2Ws5mPEAu2pqp4UXChlt6gInUPjx6qdGsoX4dzIZKDhtX8RnEDJo93D7mWfgf
         bq7Pb1CKReyf80ZnhtdcJqtR9Mm4VeULR2KmPJD2xPBiYbSAR7ElzXUTaxr6DhEOAObc
         GHen0nOgQifmGecOVYBl7zfd/YbkuObb9BcXNQJwNNPju65+X9MK+vrOsNZyboxVPu1I
         gkFewABnezfKHlo/4p76wjNPS8E4ANuD4aj1kFcrylgZlpYtlqA4lE7KqlkaIAdUX2hm
         RCpuU0vx/T4Xnhu0gDYaYnGw+xq9Tpkm/GJnxWqAyx41szhZTe5aTtfscPjz3P1+Xm1D
         g30A==
X-Gm-Message-State: APjAAAV8L8pRaHTIa+xVyyet3VnzXZ0rFtoKd8CEipR1ff/xl14pi6WS
        EHu6YzeHcTmhUIn+v3uRNpqb4Ju8TDUmQBl0GYyA/Q==
X-Google-Smtp-Source: APXvYqxQIBIX6xYztYQ7HhEDUrTMEXPxnhZukfX5NCbh3AkQKGiao83yymjgFYBSbDc0KnbFjtMG7foFEJdr77C+BYQ=
X-Received: by 2002:a2e:a16d:: with SMTP id u13mr3560452ljl.214.1572368435760;
 Tue, 29 Oct 2019 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029153615.GP4114@hirez.programming.kicks-ass.net>
 <CAKfTPtD79VE+gqffpBAGd39bJKe7ao+jbmVSQ7PtS=dky0Wx6g@mail.gmail.com> <20191029164955.GO4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191029164955.GO4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 18:00:24 +0100
Message-ID: <CAKfTPtDByO5xZaA1zHb-0WLq3PaodByfbnH0RkJjf+jn0O81-Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 17:50, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 29, 2019 at 05:20:56PM +0100, Vincent Guittot wrote:
> > On Tue, 29 Oct 2019 at 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Oct 29, 2019 at 07:55:26AM -0700, Doug Smythies wrote:
> > >
> > > > I only know that the call to the intel_pstate driver doesn't
> > > > happen, and that it is because cfs_rq_is_decayed returns TRUE.
> > > > So, I am asserting that the request is not actually decayed, and
> > > > should not have been deleted.
> > >
> > > So what cfs_rq_is_decayed() does is allow a cgroup's cfs_rq to be
> > > removed from the list.
> > >
> > > Once it is removed, that cfs_rq will no longer be checked in the
> > > update_blocked_averages() loop. Which means done has less chance of
> > > getting false. Which in turn means that it's more likely
> > > rq->has_blocked_load becomes 0.
> > >
> > > Which all sounds good.
> > >
> > > Can you please trace what keeps the CPU awake?
> >
> > I think that the sequence below is what intel pstate driver was using
> >
> > rt/dl task wakes up and run for some times
> > rt/dl pelt signal is no more null so periodic decay happens.
> >
> > before optimization update_cfs_rq_load_avg() for root cfs_rq was
> > called even if pelt was null,
> > which calls cfs_rq_util_change,  which calls intel pstate
> >
> > after optimization its no more called.
>
> Not calling cfs_rq_util_change() when it doesn't change, seems like the
> right thing. Why would intel_pstate want it called when it doesn't
> change?

Yes I agree

My original thought was that either irq/rt ordl pelt signals was used
to set frequency and it needs to be called to decrease this freq while
pelt signals was decaying but it doesn't seem to use it but only needs
to be called from time to time
