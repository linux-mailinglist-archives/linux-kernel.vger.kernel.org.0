Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75ADBDBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfIYKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 06:03:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:32838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfIYKDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:03:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52C46B114;
        Wed, 25 Sep 2019 10:03:18 +0000 (UTC)
Date:   Wed, 25 Sep 2019 12:03:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190925100316.GI23050@dhcp22.suse.cz>
References: <20190924143615.19628-1-david@redhat.com>
 <1569337401.5576.217.camel@lca.pw>
 <20190924151147.GB23050@dhcp22.suse.cz>
 <1569351244.5576.219.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569351244.5576.219.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 14:54:04, Qian Cai wrote:
> On Tue, 2019-09-24 at 17:11 +0200, Michal Hocko wrote:
> > On Tue 24-09-19 11:03:21, Qian Cai wrote:
> > [...]
> > > While at it, it might be a good time to rethink the whole locking over there, as
> > > it right now read files under /sys/kernel/slab/ could trigger a possible
> > > deadlock anyway.
> > > 
> > 
> > [...]
> > > [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
> > > [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
> > > [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
> > > [  442.469930][ T5224]        lock_acquire+0x31c/0x360
> > > [  442.474803][ T5224]        get_online_mems+0x54/0x150
> > > [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
> > > [  442.485072][ T5224]        total_objects_show+0x28/0x34
> > > [  442.490292][ T5224]        slab_attr_show+0x38/0x54
> > > [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
> > > [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
> > > [  442.505433][ T5224]        seq_read+0x30c/0x8a8
> > > [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
> > > [  442.515007][ T5224]        __vfs_read+0x88/0x20c
> > > [  442.519620][ T5224]        vfs_read+0xd8/0x10c
> > > [  442.524060][ T5224]        ksys_read+0xb0/0x120
> > > [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
> > > [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
> > > [  442.538768][ T5224]        el0_svc+0x8/0xc
> > 
> > I believe the lock is not really needed here. We do not deallocated
> > pgdat of a hotremoved node nor destroy the slab state because an
> > existing slabs would prevent hotremove to continue in the first place.
> > 
> > There are likely details to be checked of course but the lock just seems
> > bogus.
> 
> Check 03afc0e25f7f ("slab: get_online_mems for
> kmem_cache_{create,destroy,shrink}"). It actually talk about the races during
> memory as well cpu hotplug, so it might even that cpu_hotplug_lock removal is
> problematic?

I have to refresh my memory there but the changlog claims:
"To avoid issues like that we should hold get/put_online_mems() during
the whole kmem cache creation/destruction/shrink paths" and
show_slab_objects doesn't fall into any of those categories.

Anyway this seems unrelated to the original thread so I would recommend
discussing in its own thread for clarity.

-- 
Michal Hocko
SUSE Labs
