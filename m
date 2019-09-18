Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E632DB634C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfIRMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 08:33:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfIRMdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E333AD4E;
        Wed, 18 Sep 2019 12:33:43 +0000 (UTC)
Date:   Wed, 18 Sep 2019 14:33:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lin Feng <linf@wangsu.com>, corbet@lwn.net, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, keescook@chromium.org,
        mchehab+samsung@kernel.org, mgorman@techsingularity.net,
        vbabka@suse.cz, ktkhai@virtuozzo.com, hannes@cmpxchg.org
Subject: Re: [PATCH] [RFC] vmscan.c: add a sysctl entry for controlling
 memory reclaim IO congestion_wait length
Message-ID: <20190918123342.GF12770@dhcp22.suse.cz>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917120646.GT29434@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 05:06:46, Matthew Wilcox wrote:
> On Tue, Sep 17, 2019 at 07:58:24PM +0800, Lin Feng wrote:
[...]
> > +mm_reclaim_congestion_wait_jiffies
> > +==========
> > +
> > +This control is used to define how long kernel will wait/sleep while
> > +system memory is under pressure and memroy reclaim is relatively active.
> > +Lower values will decrease the kernel wait/sleep time.
> > +
> > +It's suggested to lower this value on high-end box that system is under memory
> > +pressure but with low storage IO utils and high CPU iowait, which could also
> > +potentially decrease user application response time in this case.
> > +
> > +Keep this control as it were if your box are not above case.
> > +
> > +The default value is HZ/10, which is of equal value to 100ms independ of how
> > +many HZ is defined.
> 
> Adding a new tunable is not the right solution.  The right way is
> to make Linux auto-tune itself to avoid the problem.

I absolutely agree here. From you changelog it is also not clear what is
the underlying problem. Both congestion_wait and wait_iff_congested
should wake up early if the congestion is handled. Is this not the case?
Why? Are you sure a shorter timeout is not just going to cause problems
elsewhere. These sleeps are used to throttle the reclaim. I do agree
there is no great deal of design behind them so they are more of "let's
hope it works" kinda thing but making their timeout configurable just
doesn't solve this at all. You are effectively exporting a very subtle
implementation detail into the userspace.
-- 
Michal Hocko
SUSE Labs
