Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78DE17F53B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 11:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 06:41:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46069 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCJKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:41:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id e18so13495182ljn.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0vZawaTqWCz2V8Z7mamXXKPhhUtkT0sw/sdFRGO2vlw=;
        b=rfN6Lx7BOmqQhhOcLZn74EbzqdvStmveWhgz/2wPqRS6Vsou7fptHHWEIrnS4TE5yp
         JTpNP9cVTh9+ScV8dItrwHNxAxXeH2M366CwIpOP/wfCYI8Lr6gWHzuSx2wtV3+CotGf
         vS8wvdPooB2/guIp7F2u9RYKDRt/5+8VJfG61EPWc1IiA6LEanZkA62sFK/IyPHDj3c4
         XISld2tme2+mLRcphKCh3phxQo89djJLpcsShu4ldtlDr+zRUmlW7K6sHnBNcoi5Waik
         td79ng96wZGYcrIub2d9UrMG4QLXkEFBlTDCdk8EaNGbiEKhTJBuuRRONadmzh/i9mG0
         Nigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0vZawaTqWCz2V8Z7mamXXKPhhUtkT0sw/sdFRGO2vlw=;
        b=rERfqqY47m741s0nGuloNo5MEpDyJIqpz8KeNZBFCdpMYDRfatOP+OXil839K/8jHV
         KuQmhXPo9yY7m3VCY8DXLxRia08kPuAeQfOwAdZcyX2n9FcijF9afpaWX0oGjqP0ngdP
         ZuOTz42jTgyRFc9hXtXCGdyxZ1g/BpvGSjwdIc/hFikAv51PGTEW8E2rONqPZQzEHmwG
         73bhNFxfwQ4X82T7Pdui4PbJ9ik/CJKipowDtL/xxq8krhWXm6HCQDRrbiADM+Ig64z7
         JGJpOVlceZAlCsU6Kz7VZR0p4lUxRPp006pjPWO1wKoUvwP1MyJTM50s5XRB/hDo3pbX
         Fy1g==
X-Gm-Message-State: ANhLgQ2VGUGKFveM8EK7GCUBNPRI07ndVAl7n6fLA/ki6IJMLM4xJB0U
        euKJ5g8XDuv7LQhRhRgMmChLmA==
X-Google-Smtp-Source: ADFU+vtWe5qAVNKXwQBYPCtcvZJH5it9LZ15Lowysh7WzMF8KSRZeQGnQWR4Gbgv9g0YFkPOui+jIA==
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr12742730ljc.104.1583836909643;
        Tue, 10 Mar 2020 03:41:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h2sm2079300ljm.103.2020.03.10.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 03:41:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 27FEF1013FA; Tue, 10 Mar 2020 13:41:49 +0300 (+03)
Date:   Tue, 10 Mar 2020 13:41:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     brookxu <brookxu.cn@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <20200310104149.5c3pc75y6ny5hixb@box>
References: <077a6f67-aefa-4591-efec-f2f3af2b0b02@gmail.com>
 <20200310094836.GD8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310094836.GD8447@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:48:36AM +0100, Michal Hocko wrote:
> [Cc Kirill, I didn't realize he has implemented this code]

My first non-trivial mm contribution :P

> On Fri 06-03-20 09:02:02, brookxu wrote:
> > From: Chunguang Xu <brookxu@tencent.com>
> > 
> > An eventfd monitors multiple memory thresholds of the cgroup, closes them,
> > the kernel deletes all events related to this eventfd. Before all events
> > are deleted, another eventfd monitors the memory threshold of this cgroup,
> > leading to a crash:
> > 
> > [� 135.675108] BUG: kernel NULL pointer dereference, address: 0000000000000004
> > [� 135.675350] #PF: supervisor write access in kernel mode
> > [� 135.675579] #PF: error_code(0x0002) - not-present page
> > [� 135.675816] PGD 800000033058e067 P4D 800000033058e067 PUD 3355ce067 PMD 0
> > [� 135.676080] Oops: 0002 [#1] SMP PTI
> > [� 135.676332] CPU: 2 PID: 14012 Comm: kworker/2:6 Kdump: loaded Not tainted 5.6.0-rc4 #3
> > [� 135.676610] Hardware name: LENOVO 20AWS01K00/20AWS01K00, BIOS GLET70WW (2.24 ) 05/21/2014
> > [� 135.676909] Workqueue: events memcg_event_remove
> > [� 135.677192] RIP: 0010:__mem_cgroup_usage_unregister_event+0xb3/0x190
> > [� 135.677825] RSP: 0018:ffffb47e01c4fe18 EFLAGS: 00010202
> > [� 135.678186] RAX: 0000000000000001 RBX: ffff8bb223a8a000 RCX: 0000000000000001
> > [� 135.678548] RDX: 0000000000000001 RSI: ffff8bb22fb83540 RDI: 0000000000000001
> > [� 135.678912] RBP: ffffb47e01c4fe48 R08: 0000000000000000 R09: 0000000000000010
> > [� 135.679287] R10: 000000000000000c R11: 071c71c71c71c71c R12: ffff8bb226aba880
> > [� 135.679670] R13: ffff8bb223a8a480 R14: 0000000000000000 R15: 0000000000000000
> > [� 135.680066] FS:� 0000000000000000(0000) GS:ffff8bb242680000(0000) knlGS:0000000000000000
> > [� 135.680475] CS:� 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [� 135.680894] CR2: 0000000000000004 CR3: 000000032c29c003 CR4: 00000000001606e0
> > [� 135.681325] Call Trace:
> > [� 135.681763]� memcg_event_remove+0x32/0x90
> > [� 135.682209]� process_one_work+0x172/0x380
> > [� 135.682657]� worker_thread+0x49/0x3f0
> > [� 135.683111]� kthread+0xf8/0x130
> > [� 135.683570]� ? max_active_store+0x80/0x80
> > [� 135.684034]� ? kthread_bind+0x10/0x10
> > [� 135.684506]� ret_from_fork+0x35/0x40
> > [� 135.689733] CR2: 0000000000000004
> > 
> > We can reproduce this problem in the following ways:
> > �
> > 1. We create a new cgroup subdirectory and a new eventfd, and then we
> > �� monitor multiple memory thresholds of the cgroup through this eventfd.
> > 2. closing this eventfd, and __mem_cgroup_usage_unregister_event () will be
> > �� called multiple times to delete all events related to this eventfd.
> > 
> > The first time __mem_cgroup_usage_unregister_event() is called, the kernel
> > will clear all items related to this eventfd in thresholds-> primary.Since
> > there is currently only one eventfd, thresholds-> primary becomes empty,
> > so the kernel will set thresholds-> primary and hresholds-> spare to NULL.

						    ^ typo

> > If at this time, the user creates a new eventfd and monitor the memory
> > threshold of this cgroup, kernel will re-initialize thresholds-> primary.
> > Then when __mem_cgroup_usage_unregister_event () is called for the second
> > time, because thresholds-> primary is not empty, the system will access
> > thresholds-> spare, but thresholds-> spare is NULL, which will trigger a
> > crash.
> > 
> > In general, the longer it takes to delete all events related to this
> > eventfd, the easier it is to trigger this problem.
> > 
> > The solution is to check whether the thresholds associated with the eventfd
> > has been cleared when deleting the event. If so, we do nothing.
> > 
> > Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> The fix looks reasonable to me
> Acked-by: Michal Hocko <mhocko@suse.com>

Agreed. Two typos have to be addressed.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> It seems that the code has been broken since 2c488db27b61 ("memcg: clean
> up memory thresholds"). We've had 371528caec55 ("mm: memcg: Correct
> unregistring of events attached to the same eventfd") but it didn't
> catch this case for some reason. Unless I am missing something the code
> was broken back then already. Kirill please double check after me.

I think the issue exitsted before 2c488db27b61. The fields had different
names back then.

The logic to make unregister never-fail is added in 907860ed381a
("cgroups: make cftype.unregister_event() void-returning"). I believe the
Fixes should point there.

> 
> So if I am not wrong then we want
> Fixes: 2c488db27b61 ("memcg: clean up memory thresholds")
> Cc: stable
> 
> sounds appropriate because this seems to be user trigerable.
> 
> Thanks for preparing the patch!
> 
> Btw. you should double check your email sender because it seemed to
> whitespace damaged the patch (\t -> spaces). Please use git send-email
> instead.
> 
> > ---
> > �mm/memcontrol.c | 10 ++++++++--
> > �1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d09776c..4575a58 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4027,7 +4027,7 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> > ���� struct mem_cgroup_thresholds *thresholds;
> > ���� struct mem_cgroup_threshold_ary *new;
> > ���� unsigned long usage;
> > -��� int i, j, size;
> > +��� int i, j, size, entries;
> > �
> > ���� mutex_lock(&memcg->thresholds_lock);
> > �
> > @@ -4047,12 +4047,18 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> > ���� __mem_cgroup_threshold(memcg, type == _MEMSWAP);
> > �
> > ���� /* Calculate new number of threshold */
> > -��� size = 0;
> > +��� size = entries = 0;
> > ���� for (i = 0; i < thresholds->primary->size; i++) {
> > ���� ��� if (thresholds->primary->entries[i].eventfd != eventfd)
> > ���� ��� ��� size++;
> > +��� ��� else
> > +��� ��� ��� entries++;
> > ���� }
> > �
> > +��� /* If items related to eventfd have been cleared, nothing to do */

	       ^ "no items" ?

> > +��� if (!entries)
> > +��� ��� goto unlock;
> > +
> > ���� new = thresholds->spare;
> > �
> > ���� /* Set thresholds array to NULL if we don't have thresholds */
> > -- 
> > 1.8.3.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
 Kirill A. Shutemov
