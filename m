Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45E6CBA83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfJDMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:33:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfJDMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:33:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78C55B052;
        Fri,  4 Oct 2019 12:33:50 +0000 (UTC)
Date:   Fri, 4 Oct 2019 14:33:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Qian Cai <cai@lca.pw>, Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
Message-ID: <20191004123349.GB10845@dhcp22.suse.cz>
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
 <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-10-19 19:08:16, Daniel Colascione wrote:
> On Wed, Oct 2, 2019 at 6:56 PM Qian Cai <cai@lca.pw> wrote:
> > > On Oct 2, 2019, at 4:29 PM, Daniel Colascione <dancol@google.com> wrote:
> > >
> > > Adding the correct linux-mm address.
> > >
> > >
> > >> +config SPLIT_RSS_COUNTING
> > >> +       bool "Per-thread mm counter caching"
> > >> +       depends on MMU
> > >> +       default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
> > >> +       help
> > >> +         Cache mm counter updates in thread structures and
> > >> +         flush them to visible per-process statistics in batches.
> > >> +         Say Y here to slightly reduce cache contention in processes
> > >> +         with many threads at the expense of decreasing the accuracy
> > >> +         of memory statistics in /proc.
> > >> +
> > >> endmenu
> >
> > All those vague words are going to make developers almost impossible to decide the right selection here. It sounds like we should kill SPLIT_RSS_COUNTING at all to simplify the code as the benefit is so small vs the side-effect?
> 
> Killing SPLIT_RSS_COUNTING would be my first choice; IME, on mobile
> and a basic desktop, it doesn't make a difference. I figured making it
> a knob would help allay concerns about the performance impact in more
> extreme configurations.

I do agree with Qian. Either it is really helpful (is it? probably on
the number of cpus) and it should be auto-enabled or it should be
dropped altogether. You cannot really expect people know how to enable
this without a deep understanding of the MM internals. Not to mention
all those users using distro kernels/configs.

A config option sounds like a bad way forward.

-- 
Michal Hocko
SUSE Labs
