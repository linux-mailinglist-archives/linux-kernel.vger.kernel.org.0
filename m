Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23EEAA7DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfIEQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 12:03:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38507 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389438AbfIEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:03:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so3720970wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xF5g9IO6jKnafhVzgDApXP2oM7DXnYkebnFH9y77eNE=;
        b=r9T1e6uWz1LE6nNNk8y0oqPRvd8zqa6gn7QDLNHiVCUH7vRly5jrqlmsPYtj9d1RKh
         v+3Esb1sjsGDRbND9GSNtycU3df7f7+1pEUYlkfnYh0Jripc/KwYnbfhlIbm982nC3Ev
         2R2yYm0BVRvJXOf4wvIf14T24AJ2P3aOei3lsX+3+tlRBZmQcprOacmv1tzWkgf6TGI3
         q6O9UGIv/4XF2K0O7xQ/SPUUjkipL3j/KcdRxrl9iSxEV8W5Do6YyDRK04T4DkGCS74o
         LimaWvMf0JtIOwj+brZ5XGVf7/gtJiq29j+6LA8fFMx8/NtiwAzun7s4pSONcQ1DkLWl
         pJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xF5g9IO6jKnafhVzgDApXP2oM7DXnYkebnFH9y77eNE=;
        b=D/4icUv9TkbLKmuTrZeLn5AvbK/IFqgqsm7u30eLxsFeMK1bZA71GRLcgleRPAE+Bi
         6PAdaLYaYZradwu40dq54GlF8rrp6iknJ3wDIfy9+fKcKNx1h5mDuiLc2B+OgzyCpOTX
         rjdx4NNKPvajFrXQ15XEU9Sm3sSoyLe5gTSf+6ol+bSE8aNo54R3c0Zz2ZbgeZshuDnY
         eXjM+3DOclITBT1TSP0usPOpqLmu4JUyLU0o16HXjYai2lxzpQLR7OiM1m1uzTavhkYG
         FpfosrW2BOSSlL2XTkfOOZdCQHbmdgcxNWH54bIxh7T+WYI4KcdUmwmOYqD1LjzBuHK8
         Rf5A==
X-Gm-Message-State: APjAAAXCtQsqQHZU62LYz/KzGmJ2eqVYom9CiBvtkxDNAQhxvpxKSfec
        VJjnJlFoOubqJq3Xe5VLSAcUPLcyp7PSM8qZdnvs8Q==
X-Google-Smtp-Source: APXvYqxn697f0MLbHLVLiNrv31ZON72Qw9YwLPyxM0jd0I67TVVrGvqak6f1I7B6szc8twvaNTAUZ5K2Mhj8xS132j0=
X-Received: by 2002:a1c:cfc9:: with SMTP id f192mr3378872wmg.85.1567699392897;
 Thu, 05 Sep 2019 09:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz> <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz> <20190904162808.GO240514@google.com> <20190905144310.GA14491@dhcp22.suse.cz>
In-Reply-To: <20190905144310.GA14491@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Sep 2019 09:03:01 -0700
Message-ID: <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 7:43 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> [Add Steven]
>
> On Wed 04-09-19 12:28:08, Joel Fernandes wrote:
> > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
> [...]
> > > > but also for reducing
> > > > tracing noise. Flooding the traces makes it less useful for long traces and
> > > > post-processing of traces. IOW, the overhead reduction is a bonus.
> > >
> > > This is not really anything special for this tracepoint though.
> > > Basically any tracepoint in a hot path is in the same situation and I do
> > > not see a point why each of them should really invent its own way to
> > > throttle. Maybe there is some way to do that in the tracing subsystem
> > > directly.
> >
> > I am not sure if there is a way to do this easily. Add to that, the fact that
> > you still have to call into trace events. Why call into it at all, if you can
> > filter in advance and have a sane filtering default?
> >
> > The bigger improvement with the threshold is the number of trace records are
> > almost halved by using a threshold. The number of records went from 4.6K to
> > 2.6K.
>
> Steven, would it be feasible to add a generic tracepoint throttling?

I might misunderstand this but is the issue here actually throttling
of the sheer number of trace records or tracing large enough changes
to RSS that user might care about? Small changes happen all the time
but we are likely not interested in those. Surely we could postprocess
the traces to extract changes large enough to be interesting but why
capture uninteresting information in the first place? IOW the
throttling here should be based not on the time between traces but on
the amount of change of the traced signal. Maybe a generic facility
like that would be a good idea?

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
