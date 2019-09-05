Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90BAAA65
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbfIERvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 13:51:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37214 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391170AbfIERvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:51:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id s28so3069814otd.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9Pb/MqseZ7RlVVs3CNYNbMIo2YR/MhIel99V5tLuCc=;
        b=WHn/mLxT0ucnyH4gwmp/qpzJbEfaFthNeKdoZwnD/B6/MVQRQqb4wZywL53jq1qIaV
         gb+TdKsinHPlj+LQlhJoWRU/D7IK2UvLu1uZIbpc98h3j/SLg1FkucCLBSn6QE6a4xv4
         8A5stXVWsUc3IDcyzSxMHbj/jVhShunx3l22pRcWTxEOi/t6ar1ofl0voxcoIdRfl5r0
         JMwCWrcjsdNR+EnBKm+WG+n9gRil9h1uAYDHR5V3SPQZC5up027FI9BVXsnmIJn/wGLH
         a5ELOGPKH2gOOayWt8fPr7sEKLjPvuIF8jdNUuBz8MhE7vzVl2frNjh13WOdqLyRGTLI
         PW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9Pb/MqseZ7RlVVs3CNYNbMIo2YR/MhIel99V5tLuCc=;
        b=WsjnBBCyCXoVmDMSwAt1m8J8Uw1qmHt6VuistghjhwdXrSlfjJoYNk2hkWNDOht5Oi
         aGKFPkgxmD9MJ41WbOKs6iNUj1Zx+Jbv8xZ9vCBiwivvZRTalIljwyBLnabqhQbkv5im
         NJQgQ8qADE6ebkj3eMVHOn1AFBHpT+3uRNDw5qIgzMm0Ws/3ob9CkuCH04WBmxyjLESb
         cHMVtujgDP3zIeuAH9yrBS/jGS9zsT2WXIHhdj4m2smXFyW/LnVDZxV8MymIs10/BboF
         EM1y43gp+nlFWkydtWFxkf2er+gIFxbqsL1wvRr8t9eE+0bZWjnyuVWNsZoSFQfdaC+7
         lEAw==
X-Gm-Message-State: APjAAAXW9zdY2r2oEWp0sSovD+DSEzQFEH8zcPiWqZNDVQewYIPE+DMG
        M56zGtA1q3rrnfLtpNRMt59zCMbgbEnM1IT3QpVYyQ==
X-Google-Smtp-Source: APXvYqx+O95sXPOaTHKmmrEZVVL5eS8xtFX8KqFEqk0X7AW7J5pOo+WfqsgcGe3pEdAmKOQmEsoGk9XDlW0GP0jc0wc=
X-Received: by 2002:a9d:6189:: with SMTP id g9mr3419331otk.348.1567705863632;
 Thu, 05 Sep 2019 10:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz> <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz> <20190904162808.GO240514@google.com>
 <20190905144310.GA14491@dhcp22.suse.cz> <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
 <20190905133507.783c6c61@oasis.local.home>
In-Reply-To: <20190905133507.783c6c61@oasis.local.home>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 5 Sep 2019 10:50:27 -0700
Message-ID: <CAKOZueuQpHDnk-3GrLdXH_N_5Z7FRSJu+cwKhHNMUyKRqvkzjA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:35 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 5 Sep 2019 09:03:01 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Thu, Sep 5, 2019 at 7:43 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > [Add Steven]
> > >
> > > On Wed 04-09-19 12:28:08, Joel Fernandes wrote:
> > > > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
> > > [...]
> > > > > > but also for reducing
> > > > > > tracing noise. Flooding the traces makes it less useful for long traces and
> > > > > > post-processing of traces. IOW, the overhead reduction is a bonus.
> > > > >
> > > > > This is not really anything special for this tracepoint though.
> > > > > Basically any tracepoint in a hot path is in the same situation and I do
> > > > > not see a point why each of them should really invent its own way to
> > > > > throttle. Maybe there is some way to do that in the tracing subsystem
> > > > > directly.
> > > >
> > > > I am not sure if there is a way to do this easily. Add to that, the fact that
> > > > you still have to call into trace events. Why call into it at all, if you can
> > > > filter in advance and have a sane filtering default?
> > > >
> > > > The bigger improvement with the threshold is the number of trace records are
> > > > almost halved by using a threshold. The number of records went from 4.6K to
> > > > 2.6K.
> > >
> > > Steven, would it be feasible to add a generic tracepoint throttling?
> >
> > I might misunderstand this but is the issue here actually throttling
> > of the sheer number of trace records or tracing large enough changes
> > to RSS that user might care about? Small changes happen all the time
> > but we are likely not interested in those. Surely we could postprocess
> > the traces to extract changes large enough to be interesting but why
> > capture uninteresting information in the first place? IOW the
> > throttling here should be based not on the time between traces but on
> > the amount of change of the traced signal. Maybe a generic facility
> > like that would be a good idea?
>
> You mean like add a trigger (or filter) that only traces if a field has
> changed since the last time the trace was hit? Hmm, I think we could
> possibly do that. Perhaps even now with histogram triggers?

I was thinking along the same lines. The histogram subsystem seems
like a very good fit here. Histogram triggers already let users talk
about specific fields of trace events, aggregate them in configurable
ways, and (importantly, IMHO) create synthetic new trace events that
the kernel emits under configurable conditions.
