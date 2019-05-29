Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6E2D4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 07:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfE2FFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 01:05:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfE2FFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 01:05:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 434C4AD7E;
        Wed, 29 May 2019 05:05:47 +0000 (UTC)
Date:   Wed, 29 May 2019 07:05:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190529050545.GA18589@dhcp22.suse.cz>
References: <20190529024033.13500-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529024033.13500-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-05-19 10:40:33, Hillf Danton wrote:
> 
> On Wed, 29 May 2019 00:11:15 +0800 Michal Hocko wrote:
> > On Tue 28-05-19 23:38:11, Hillf Danton wrote:
> > > 
> > > In short, I prefer to skip IO mapping since any kind of address range
> > > can be expected from userspace, and it may probably cover an IO mapping.
> > > And things can get out of control, if we reclaim some IO pages while
> > > underlying device is trying to fill data into any of them, for instance.
> > 
> > What do you mean by IO pages why what is the actual problem?
> > 
> Io pages are the backing-store pages of a mapping whose vm_flags has
> VM_IO set, and the comment in mm/memory.c says:
>         /*
>          * Physically remapped pages are special. Tell the
>          * rest of the world about it:
>          *   VM_IO tells people not to look at these pages
>          *      (accesses can have side effects).
> 

OK, thanks for the clarification of the first part of the question. Now
to the second and the more important one. What is the actual concern?
AFAIK those pages shouldn't be on LRU list. If they are then they should
be safe to get reclaimed otherwise we would have a problem when
reclaiming them on the normal memory pressure. Why is this madvise any
different?
-- 
Michal Hocko
SUSE Labs
