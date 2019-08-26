Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2D9CAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfHZHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728168AbfHZHde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:33:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 619A4AEBF;
        Mon, 26 Aug 2019 07:33:33 +0000 (UTC)
Date:   Mon, 26 Aug 2019 09:33:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 0/3] vmstats/vmevents flushing
Message-ID: <20190826073332.GA7659@dhcp22.suse.cz>
References: <20190819230054.779745-1-guro@fb.com>
 <20190822162709.fa100ba6c58e15ea35670616@linux-foundation.org>
 <20190823003347.GA4252@castle>
 <20190824135339.46da90b968d92529641b3ed2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824135339.46da90b968d92529641b3ed2@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 24-08-19 13:53:39, Andrew Morton wrote:
> On Fri, 23 Aug 2019 00:33:51 +0000 Roman Gushchin <guro@fb.com> wrote:
> 
> > On Thu, Aug 22, 2019 at 04:27:09PM -0700, Andrew Morton wrote:
> > > On Mon, 19 Aug 2019 16:00:51 -0700 Roman Gushchin <guro@fb.com> wrote:
> > > 
> > > > v3:
> > > >   1) rearranged patches [2/3] and [3/3] to make [1/2] and [2/2] suitable
> > > >   for stable backporting
> > > > 
> > > > v2:
> > > >   1) fixed !CONFIG_MEMCG_KMEM build by moving memcg_flush_percpu_vmstats()
> > > >   and memcg_flush_percpu_vmevents() out of CONFIG_MEMCG_KMEM
> > > >   2) merged add-comments-to-slab-enums-definition patch in
> > > > 
> > > > Thanks!
> > > > 
> > > > Roman Gushchin (3):
> > > >   mm: memcontrol: flush percpu vmstats before releasing memcg
> > > >   mm: memcontrol: flush percpu vmevents before releasing memcg
> > > >   mm: memcontrol: flush percpu slab vmstats on kmem offlining
> > > > 
> > > 
> > > Can you please explain why the first two patches were cc:stable but not
> > > the third?
> > > 
> > > 
> > 
> > Because [1] and [2] are fixing commit 42a300353577 ("mm: memcontrol: fix
> > recursive statistics correctness & scalabilty"), which has been merged into 5.2.
> > 
> > And [3] fixes commit fb2f2b0adb98 ("mm: memcg/slab: reparent memcg kmem_caches
> > on cgroup removal"), which is in not yet released 5.3, so stable backport isn't
> > required.
> 
> OK, thanks.  Patches 1 & 2 are good to go but I don't think that #3 has
> had suitable review and I have a note here that Michal has concerns
> with it.

My concern was http://lkml.kernel.org/r/20190814113242.GV17933@dhcp22.suse.cz
so more of a code style kinda thing. Roman has chosen to stay with his
original form and added a comment that NR_SLAB_{UN}RECLAIMABLE are
magic. This is something I can live with even though I would have
preferred it a different way. Nothing serious enough to Nack or insist.
-- 
Michal Hocko
SUSE Labs
