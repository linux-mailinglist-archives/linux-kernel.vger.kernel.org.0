Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707DA1150FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 14:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfLFN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 08:27:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42185 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLFN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:27:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so5238834lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 05:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeXvuvB0hn6bb0z+1r7xsz+8D19t/t8TtKT2Dzq/n6c=;
        b=QUjBL/z198c1YK0n8DhRDpY8Ef9/jrpreH0g7hF9T3hCo+JZbOLgvg3KQKY+U5gnHn
         TBCGsqWjfLTG5FDIwQ9mkzFMW5SO0oUfRhSkTfAkWQ+5rBFRgwxdL9sWKRgtxwGmAcoI
         JIhmLxjPDhBr5Eu2KhbnHK8Ifsm5EtAwvRaLPNVeotDkujlu26qsnLD/li1R27kf0iZK
         aSLbdCtdiJD0eS8qEgkiK2M3HdJW8hvJCxQzU/Ci0YIOftX+44k2xodopTiC7Y388MWP
         d9aTLMnvlpb02a70TF0KEgq5EJ7pYYST59ySnnpLDcEQCKABBGiIsy+b1DCqLvSC+1iA
         MScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeXvuvB0hn6bb0z+1r7xsz+8D19t/t8TtKT2Dzq/n6c=;
        b=obeGuC+060vHrhsaoT096EePb0X4cmGox7dRbm5GoGfzItaHg4m95qztZqtNirs4uX
         e5dNf3UU4HvARg2MErUSwl2Q24hDH8rQkPOLTxHjuI4b0FRerCGyOe5qDQPsyREv94Pf
         UlGtQSCArotDc3uPdQtqm+SLamJMKjVk1p9uwmD6AJXNZQtE7ZK9OvWC25wQeshFcht7
         xqBEjPGEzhII3zqC6OlaXRr8yGV0zgSQOvceDJVRIB+qqRHR1cLJGqyPC06qPy0LH0vG
         xcsgN9ps008QWdYUBxKaHWHnkPtNK1Xii4MkgSHB1tT4/2gUwUEG2oQNpkWxeWBlRLi0
         co1A==
X-Gm-Message-State: APjAAAW7WvbqeSSNFbfb8glAZJJrtcKPz5+7MnrfOgSAjfAN1YDdNQSg
        1BC+sjugXa6kMMf+uIPcZZHlLEkeFQpUdiXgM9TRxA==
X-Google-Smtp-Source: APXvYqxZjOylslLYa1Gz22nM5bkQM3su985aYkb30gMg+t0PPd0geubYJ527GRiUdF1W/al8+sk6v/AncY8nWSRoSDI=
X-Received: by 2002:a19:4b87:: with SMTP id y129mr1718253lfa.32.1575638849486;
 Fri, 06 Dec 2019 05:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtBH9ff=efTeJbM4UdzrHCXZs7wwn=pdE4As8pB859e++Q@mail.gmail.com>
 <20191205175153.GA14172@linux.vnet.ibm.com> <CAKfTPtDp097ww0war7H1THtRxDWzA3CDuokDQSUoqzRDcD1d3g@mail.gmail.com>
 <20191206081654.GA22330@linux.vnet.ibm.com>
In-Reply-To: <20191206081654.GA22330@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Dec 2019 14:27:17 +0100
Message-ID: <CAKfTPtBOVe+-fMBd+oHxZ51q5GtaxR6uyYep+a+NWJArbV9EcQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 at 09:17, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2019-12-05 19:52:40]:
>
> > On Thu, 5 Dec 2019 at 18:52, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > * Vincent Guittot <vincent.guittot@linaro.org> [2019-12-05 18:27:51]:
> > >
> > > > Hi Srikar,
> > > >
> > > > On Thu, 5 Dec 2019 at 18:23, Srikar Dronamraju
> > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > >
> > > > > Currently we loop through all threads of a core to evaluate if the core
> > > > > is idle or not. This is unnecessary. If a thread of a core is not
> > > > > idle, skip evaluating other threads of a core.
> > > >
> > > > I think that the goal is also to clear all CPUs of the core from the
> > > > cpumask  of the loop above so it will not try the same core next time
> > > >
> > > > >
> > >
> > > That goal we still continue to maintain by the way of cpumask_andnot.
> > > i.e instead of clearing CPUs one at a time, we clear all the CPUs in the
> > > core at one shot.
> >
> > ah yes sorry, I have been to quick and overlooked the cpumask_andnot line
> >
>
> Just to reiterate why this is necessary.
> Currently, even if the first thread of a core is not idle, we iterate
> through all threads of the core and individually clear the CPU from the core
> mask.
>
> Collecting ticks on a Power 9 SMT 8 system around select_idle_core
> while running schbench shows us that
>
> (units are in ticks, hence lesser is better)
> Without patch
>     N           Min           Max        Median           Avg        Stddev
> x 130           151          1083           284     322.72308     144.41494
>
>
> With patch
>     N           Min           Max        Median           Avg        Stddev   Improvement
> x 164            88           610           201     225.79268     106.78943        30.03%

Thanks for the figures. Might be good to include them in the commit message

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


>
> --
> Thanks and Regards
> Srikar Dronamraju
>
