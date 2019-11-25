Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF131091E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 17:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfKYQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 11:34:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:46556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728683AbfKYQen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:34:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCE8DAF42;
        Mon, 25 Nov 2019 16:34:41 +0000 (UTC)
Date:   Mon, 25 Nov 2019 16:34:38 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [GIT PULL] scheduler changes for v5.5
Message-ID: <20191125163438.GL28938@suse.de>
References: <20191125125944.GA22218@gmail.com>
 <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
 <20191125150811.GA116487@gmail.com>
 <d2312678-f3a1-9e22-0c95-2a161cd67bd7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d2312678-f3a1-9e22-0c95-2a161cd67bd7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 04:20:21PM +0000, Valentin Schneider wrote:
> On 25/11/2019 15:08, Ingo Molnar wrote:
> > We can give testers a linearized tree for testing, should this come up 
> > (which I doubt it will ...), ok?
> > 
> 
> My worry (and I think Mel's) is on performance bisection of the mainline
> tree (not specifically on the load balancer rework), by LKP or else. It's
> not something I personally do (nor expect to do in the foreseeable future),
> so Mel is much better positioned than I to argue for/against this.
> 

This was a concern. If there is a regression then a bisection may point to
one of the earlier patches. That will be ok as long as people remember
to look at the whole series instead of just the patch the bisection
identifies.  The second source of confusion may be that LKP reports
a regression followed by a gain that will lack a comparison with the
baseline so we may not be able to rely on LKP to detect regressions/gains
from the series. It's inconvenient but not critical enough to dump the
testing the existing branch has.

-- 
Mel Gorman
SUSE Labs
