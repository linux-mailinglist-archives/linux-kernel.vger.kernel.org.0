Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2562082EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfHFJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 05:29:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfHFJ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:29:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF312AE6F;
        Tue,  6 Aug 2019 09:29:31 +0000 (UTC)
Date:   Tue, 6 Aug 2019 11:29:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190806092930.GO11812@dhcp22.suse.cz>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805133119.GO7597@dhcp22.suse.cz>
 <20190805185542.GA4128@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805185542.GA4128@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 14:55:42, Johannes Weiner wrote:
> On Mon, Aug 05, 2019 at 03:31:19PM +0200, Michal Hocko wrote:
> > On Mon 05-08-19 14:13:16, Vlastimil Babka wrote:
> > > On 8/4/19 11:23 AM, Artem S. Tashkinov wrote:
> > > > Hello,
> > > > 
> > > > There's this bug which has been bugging many people for many years
> > > > already and which is reproducible in less than a few minutes under the
> > > > latest and greatest kernel, 5.2.6. All the kernel parameters are set to
> > > > defaults.
> > > > 
> > > > Steps to reproduce:
> > > > 
> > > > 1) Boot with mem=4G
> > > > 2) Disable swap to make everything faster (sudo swapoff -a)
> > > > 3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
> > > > 4) Start opening tabs in either of them and watch your free RAM decrease
> > > > 
> > > > Once you hit a situation when opening a new tab requires more RAM than
> > > > is currently available, the system will stall hard. You will barely  be
> > > > able to move the mouse pointer. Your disk LED will be flashing
> > > > incessantly (I'm not entirely sure why). You will not be able to run new
> > > > applications or close currently running ones.
> > > 
> > > > This little crisis may continue for minutes or even longer. I think
> > > > that's not how the system should behave in this situation. I believe
> > > > something must be done about that to avoid this stall.
> > > 
> > > Yeah that's a known problem, made worse SSD's in fact, as they are able
> > > to keep refaulting the last remaining file pages fast enough, so there
> > > is still apparent progress in reclaim and OOM doesn't kick in.
> > > 
> > > At this point, the likely solution will be probably based on pressure
> > > stall monitoring (PSI). I don't know how far we are from a built-in
> > > monitor with reasonable defaults for a desktop workload, so CCing
> > > relevant folks.
> > 
> > Another potential approach would be to consider the refault information
> > we have already for file backed pages. Once we start reclaiming only
> > workingset pages then we should be trashing, right? It cannot be as
> > precise as the cost model which can be defined around PSI but it might
> > give us at least a fallback measure.
> 
> NAK, this does *not* work. Not even as fallback.
> 
> There is no amount of refaults for which you can say whether they are
> a problem or not. It depends on the disk speed (obvious) but also on
> the workload's memory access patterns (somewhat less obvious).
> 
> For example, we have workloads whose cache set doesn't quite fit into
> memory, but everything else is pretty much statically allocated and it
> rarely touches any new or one-off filesystem data. So there is always
> a steady rate of mostly uninterrupted refaults, however, most data
> accesses are hitting the cache! And we have fast SSDs that compensate
> for the refaults that do occur. The workload runs *completely fine*.

OK, thanks for this example. I can see how a constant working set
refault can work properly if the rate is slower than the overal IO
plus the allocation demand for other purpose.

Thanks!
-- 
Michal Hocko
SUSE Labs
