Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF296133D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 09:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAHIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 03:25:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35814 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:25:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so2424723lja.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMcLTHW8cZctFyBZGG7eo9eE4pSXDwYJU/MLgq8ne48=;
        b=PNIxz+3+jPFg8P05WTF5ho6o97q2YlrNjJygH/455HDa0oGlY0D6zz7krTvG0kczrf
         91KmpR/rbmQ9dsupi+LLMKkCv3UlNpdl/DPI5KCugFPgR88o3xXlervn8bz1egHF+5eW
         Q9wjJG8vGwvisPBDL8LnZI1VPQ4r7lqr0gOzoElj52MrrhoqBxLVWFYPT+nU07ty8ETf
         hzHJxi5Ho369CwPFKdRXETWD0Z21LfSNKjMwgLNUeOo3Fbuh3Qu0UTVnyN1Ovk0ZwXCb
         E0VBoudj1WonQ3xespGD7MfyWII48rL6SplU+LCxnlHRqyWyNvrGeT9zuEn9eiICRkXd
         yfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMcLTHW8cZctFyBZGG7eo9eE4pSXDwYJU/MLgq8ne48=;
        b=cvN/tv4qv9FFZgfAM8r3RMsXt3W16TpyUGwFmFewDlQll15FqP90HCNIgmpBQGzUcZ
         Qm6dD1lu1dRwe3XuqtWH1IiQ01sUw0QgR+A6oQevihNHPVWJmLuqmJ6Y1Zx1dOBQR4/2
         a6gFwSm3M3bDME0+q16FmQFbebOKqzses7Bz3PZzdV+5uximCMZYoecTdjxkdWlLBBNt
         V1sUV7/1lZ9RdF8SiaoVnKeBACxxQngYbZv7Nzxman+ABA6Eu6ggRg9ey0V9xPzst7gg
         vpCAsbVg5Rmv1K9i4iQSYmfyzCOLCdw9cPQTcfuvIXDuqrj7DokWHd5PgHwVcsd8Bm/a
         u9Ww==
X-Gm-Message-State: APjAAAV3TxePBPazVFMEs4miTt/J8K4hMi6yeIj0tl8uTt1xS8jxhqVU
        wJe7rTKtyPM7eIwIsVK3njz3RkwKIOlhFmDAFbhM0w==
X-Google-Smtp-Source: APXvYqy8XSk5wuR+FpBaJtOkizaPcSg4hgOWXVxA55gCQfE59eHhG27B0+Ks32ksoA5ZgLvg5FzJj3i/HyG6MPwtUA8=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr2320998ljn.48.1578471950356;
 Wed, 08 Jan 2020 00:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20191220084252.GL3178@techsingularity.net> <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net> <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net> <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net> <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
 <20200107115646.GI3466@techsingularity.net> <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
 <20200107202406.GJ3466@techsingularity.net>
In-Reply-To: <20200107202406.GJ3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Jan 2020 09:25:38 +0100
Message-ID: <CAKfTPtCos6ESBdKtKrdawnnwPyH8-Lrie5o1kpiFAod66Yqo5A@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 21:24, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Jan 07, 2020 at 05:00:29PM +0100, Vincent Guittot wrote:
> > > > Taking into account child domain makes sense to me, but shouldn't we
> > > > take into account the number of child group instead ? This should
> > > > reflect the number of different LLC caches.
> > >
> > > I guess it would but why is it inherently better? The number of domains
> > > would yield a similar result if we assume that all the lower domains
> > > have equal weight so it simply because the weight of the SD_NUMA domain
> > > divided by the number of child domains.
> >
> > but that's not what you are doing in your proposal. You are using
> > directly child->span_weight which reflects the number of CPUs in the
> > child and not the number of group
> >
> > you should do something like  sds->busiest->span_weight /
> > sds->busiest->child->span_weight which gives you an approximation of
> > the number of independent group inside the busiest numa node from a
> > shared resource pov
> >
>
> Now I get you, but unfortunately it also would not work out. The number
> of groups is not related to the LLC except in some specific cases.
> It's possible to use the first CPU to find the size of an LLC but now I
> worry that it would lead to unpredictable behaviour. AMD has different
> numbers of LLCs per node depending on the CPU family and while Intel
> generally has one LLC per node, I imagine there are counter examples.
> This means that load balancing on different machines with similar core
> counts will behave differently due to the LLC size. It might be possible

But the degree of allowed imbalance is related to this topology so
using the same value for those different machine will generate a
different behavior because they don't have the same HW topology but we
use the same threshold

> to infer it if the intermediate domain was DIE instead of MC but I doubt
> that's guaranteed and it would still be unpredictable. It may be the type
> of complexity that should only be introduced with a separate patch with
> clear rationale as to why it's necessary and we are not at that threshold
> so I withdraw the suggestion.

The problem is that you proposal is not aligned to what you would like
to do: You want to take into account the number of groups but you use
the number of CPUs per group instead

Vincent
>
> --
> Mel Gorman
> SUSE Labs
