Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E761B51D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfIQPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 11:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729780AbfIQPxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:53:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18177AEBB;
        Tue, 17 Sep 2019 15:38:31 +0000 (UTC)
Date:   Tue, 17 Sep 2019 17:38:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-ID: <20190917153830.GE1872@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 17:28:02, Heinrich Schuchardt wrote:
> 
> On 9/17/19 12:03 PM, Michal Hocko wrote:
> > Hi,
> > I have just stumbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
> > observe limits") and I am really wondering what is the motivation behind
> > the patch. We've had a customer noticing the threads_max autoscaling
> > differences btween 3.12 and 4.4 kernels and wanted to override the auto
> > tuning from the userspace, just to find out that this is not possible.
> 
> set_max_threads() sets the upper limit (max_threads_suggested) for
> threads such that at a maximum 1/8th of the total memory can be occupied
> by the thread's administrative data (of size THREADS_SIZE). On my 32 GiB
> system this results in 254313 threads.

This is quite arbitrary, isn't it? What would happen if the limit was
twice as large?

> With patch 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> a user cannot set an arbitrarily high number for
> /proc/sys/kernel/threads-max which could lead to a system stalling
> because the thread headers occupy all the memory.

This is still a decision of the admin to make.  You can consume the
memory by other means and that is why we have measures in place. E.g.
memcg accounting.

> When developing the patch I remarked that on a system where memory is
> installed dynamically it might be a good idea to recalculate this limit.
> If you have a system that boots with let's say 8 GiB and than
> dynamically installs a few TiB of RAM this might make sense. But such a
> dynamic update of thread_max_suggested was left out for the sake of
> simplicity.
> 
> Anyway if more than 100,000 threads are used on a system, I would wonder
> if the software should not be changed to use thread-pools instead.

You do not change the software to overcome artificial bounds based on
guessing.

So can we get back to the justification of the patch. What kind of
real life problem does it solve and why is it ok to override an admin
decision?
If there is no strong justification then the patch should be reverted
because from what I have heard it has been noticed and it has broken
a certain deployment. I am not really clear about technical details yet
but it seems that there are workloads that believe they need to touch
this tuning and complain if that is not possible.
-- 
Michal Hocko
SUSE Labs
