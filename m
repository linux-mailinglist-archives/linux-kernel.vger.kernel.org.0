Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7CAAA15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbfIERfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 13:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfIERfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:35:17 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2B3206A5;
        Thu,  5 Sep 2019 17:35:13 +0000 (UTC)
Date:   Thu, 5 Sep 2019 13:35:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Daniel Colascione <dancol@google.com>,
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
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190905133507.783c6c61@oasis.local.home>
In-Reply-To: <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
References: <20190903200905.198642-1-joel@joelfernandes.org>
        <20190904084508.GL3838@dhcp22.suse.cz>
        <20190904153258.GH240514@google.com>
        <20190904153759.GC3838@dhcp22.suse.cz>
        <20190904162808.GO240514@google.com>
        <20190905144310.GA14491@dhcp22.suse.cz>
        <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



[ Added Tom ]

On Thu, 5 Sep 2019 09:03:01 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> On Thu, Sep 5, 2019 at 7:43 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > [Add Steven]
> >
> > On Wed 04-09-19 12:28:08, Joel Fernandes wrote:  
> > > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:  
> > > >
> > > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:  
> > [...]  
> > > > > but also for reducing
> > > > > tracing noise. Flooding the traces makes it less useful for long traces and
> > > > > post-processing of traces. IOW, the overhead reduction is a bonus.  
> > > >
> > > > This is not really anything special for this tracepoint though.
> > > > Basically any tracepoint in a hot path is in the same situation and I do
> > > > not see a point why each of them should really invent its own way to
> > > > throttle. Maybe there is some way to do that in the tracing subsystem
> > > > directly.  
> > >
> > > I am not sure if there is a way to do this easily. Add to that, the fact that
> > > you still have to call into trace events. Why call into it at all, if you can
> > > filter in advance and have a sane filtering default?
> > >
> > > The bigger improvement with the threshold is the number of trace records are
> > > almost halved by using a threshold. The number of records went from 4.6K to
> > > 2.6K.  
> >
> > Steven, would it be feasible to add a generic tracepoint throttling?  
> 
> I might misunderstand this but is the issue here actually throttling
> of the sheer number of trace records or tracing large enough changes
> to RSS that user might care about? Small changes happen all the time
> but we are likely not interested in those. Surely we could postprocess
> the traces to extract changes large enough to be interesting but why
> capture uninteresting information in the first place? IOW the
> throttling here should be based not on the time between traces but on
> the amount of change of the traced signal. Maybe a generic facility
> like that would be a good idea?

You mean like add a trigger (or filter) that only traces if a field has
changed since the last time the trace was hit? Hmm, I think we could
possibly do that. Perhaps even now with histogram triggers?

-- Steve

