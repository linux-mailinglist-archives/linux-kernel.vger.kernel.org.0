Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9CAB0C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 05:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392075AbfIFDBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 23:01:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45206 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbfIFDBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:01:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id x3so2355305plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdtQHcHlOGfkgdoayOFupO26wYojQPptWdBT4QWZFV0=;
        b=qKDIxdaBOcENAQEPhYaySH0B5SQARhQhLC6br1u55nJm0eVwYM8SSQVmlFoHirjoub
         Q0JZknIUZ1KihMnJ+Y/QiW6S2D06im9oRco+h+YsqTvdg8pxq+y8iCrMrDOEZEZbIxig
         Ngr6Lv3il76BZi2EFjjXczMgUa5KVU0HK757M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdtQHcHlOGfkgdoayOFupO26wYojQPptWdBT4QWZFV0=;
        b=GveE7ji/S0GKpE4fQWoBe+UtYRfsKvnqyBthqB8B7wxVGnM4pXvGf2ki9EXqhIXwcY
         IGaPiNxRVtlF5im4x5wbHxENaRHhdiHu5mbUReH689p0XPSsta1M0Hu49KthZdxXV1c7
         Vb+kwJs03YUiWFdBjgr8+h92a8ap0NKcNAhFPOBDP8uDE9+Cgp4k9nNGP15uKtTRkNeX
         I4RyOqnkMgsiiFKPkB8me5j2nIsH7zsYbZXwXVf06/TqWcNBlwhFIzrb3FovybaduBXt
         aML12E6Ipfh+q1Vg9hypiEbKKoLQIJOoekDVVbdmAPYScvYa6jsg0YIoWSHjyiZSAIFU
         WrSQ==
X-Gm-Message-State: APjAAAUE9zDXXbX3tzdMyFrlq0ndCAiIxVy9//32F+W0WOUlWvrv7ZOt
        EjOWAO/lUA4cpM4XKnH7Hi1G5w==
X-Google-Smtp-Source: APXvYqwZPj7q8xJbbhNyAYHvgPo532plxc4r83loWDY18f56T55uFaXSHxe+m00EA+dA31PShWQEPQ==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr6912147plz.90.1567738904014;
        Thu, 05 Sep 2019 20:01:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d135sm4364879pfd.81.2019.09.05.20.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 20:01:43 -0700 (PDT)
Date:   Thu, 5 Sep 2019 23:01:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
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
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190906030142.GA29926@google.com>
References: <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz>
 <20190904162808.GO240514@google.com>
 <20190905144310.GA14491@dhcp22.suse.cz>
 <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
 <20190905133507.783c6c61@oasis.local.home>
 <CAKOZueuQpHDnk-3GrLdXH_N_5Z7FRSJu+cwKhHNMUyKRqvkzjA@mail.gmail.com>
 <20190906005904.GC224720@google.com>
 <CAKOZuevJyfZRFz3M5myLy+XpS=mAxYCf+oQ2csxCHh7VO-OrKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevJyfZRFz3M5myLy+XpS=mAxYCf+oQ2csxCHh7VO-OrKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 06:15:43PM -0700, Daniel Colascione wrote:
[snip]
> > > > > > > The bigger improvement with the threshold is the number of trace records are
> > > > > > > almost halved by using a threshold. The number of records went from 4.6K to
> > > > > > > 2.6K.
> > > > > >
> > > > > > Steven, would it be feasible to add a generic tracepoint throttling?
> > > > >
> > > > > I might misunderstand this but is the issue here actually throttling
> > > > > of the sheer number of trace records or tracing large enough changes
> > > > > to RSS that user might care about? Small changes happen all the time
> > > > > but we are likely not interested in those. Surely we could postprocess
> > > > > the traces to extract changes large enough to be interesting but why
> > > > > capture uninteresting information in the first place? IOW the
> > > > > throttling here should be based not on the time between traces but on
> > > > > the amount of change of the traced signal. Maybe a generic facility
> > > > > like that would be a good idea?
> > > >
> > > > You mean like add a trigger (or filter) that only traces if a field has
> > > > changed since the last time the trace was hit? Hmm, I think we could
> > > > possibly do that. Perhaps even now with histogram triggers?
> > >
> > > I was thinking along the same lines. The histogram subsystem seems
> > > like a very good fit here. Histogram triggers already let users talk
> > > about specific fields of trace events, aggregate them in configurable
> > > ways, and (importantly, IMHO) create synthetic new trace events that
> > > the kernel emits under configurable conditions.
> >
> > Hmm, I think this tracing feature will be a good idea. But in order not to
> > gate this patch, can we agree on keeping a temporary threshold for this
> > patch? Once such idea is implemented in trace subsystem, then we can remove
> > the temporary filter.
> >
> > As Tim said, we don't want our traces flooded and this is a very useful
> > tracepoint as proven in our internal usage at Android. The threshold filter
> > is just few lines of code.
> 
> I'm not sure the threshold filtering code you've added does the right
> thing: we don't keep state, so if a counter constantly flips between
> one "side" of the TRACE_MM_COUNTER_THRESHOLD and the other, we'll emit
> ftrace events at high frequency. More generally, this filtering
> couples the rate of counter logging to the *value* of the counter ---
> that is, we log ftrace events at different times depending on how much
> memory we happen to have used --- and that's not ideal from a
> predictability POV.
> 
> All things being equal, I'd prefer that we get things upstream as fast
> as possible. But in this case, I'd rather wait for a general-purpose
> filtering facility (whether that facility is based on histogram, eBPF,
> or something else) rather than hardcode one particular fixed filtering
> strategy (which might be suboptimal) for one particular kind of event.
> Is there some special urgency here?
> 
> How about we instead add non-filtered tracepoints for the mm counters?
> These tracepoints will still be free when turned off.
> 
> Having added the basic tracepoints, we can discuss separately how to
> do the rate limiting. Maybe instead of providing direct support for
> the algorithm that I described above, we can just use a BPF program as
> a yes/no predicate for whether to log to ftrace. That'd get us to the
> same place as this patch, but more flexibly, right?

Chatted with Daniel offline, we agreed on removing the threshold -- which
Michal also wants to be that way.

So I'll be resubmitting this patch with the threshold removed; and we'll work
on seeing to use filtering through other generic ways like BPF.

thanks all!

 - Joel

