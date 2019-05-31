Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB830AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfEaJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 05:03:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaJDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53E5DAF61;
        Fri, 31 May 2019 09:03:08 +0000 (UTC)
Date:   Fri, 31 May 2019 11:03:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190531090307.GL6896@dhcp22.suse.cz>
References: <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw>
 <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw>
 <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz>
 <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
 <20190528182011.GG1658@dhcp22.suse.cz>
 <CAFgQCTtD5OYuDwRx1uE7R9N+qYf5k_e=OxajpPWZWb70+QgBvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtD5OYuDwRx1uE7R9N+qYf5k_e=OxajpPWZWb70+QgBvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-05-19 20:55:32, Pingfan Liu wrote:
> On Wed, May 29, 2019 at 2:20 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > [Sorry for a late reply]
> >
> > On Thu 23-05-19 11:58:45, Pingfan Liu wrote:
> > > On Wed, May 22, 2019 at 7:16 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Wed 22-05-19 15:12:16, Pingfan Liu wrote:
> > [...]
> > > > > But in fact, we already have for_each_node_state(nid, N_MEMORY) to
> > > > > cover this purpose.
> > > >
> > > > I do not really think we want to spread N_MEMORY outside of the core MM.
> > > > It is quite confusing IMHO.
> > > > .
> > > But it has already like this. Just git grep N_MEMORY.
> >
> > I might be wrong but I suspect a closer review would reveal that the use
> > will be inconsistent or dubious so following the existing users is not
> > the best approach.
> >
> > > > > Furthermore, changing the definition of online may
> > > > > break something in the scheduler, e.g. in task_numa_migrate(), where
> > > > > it calls for_each_online_node.
> > > >
> > > > Could you be more specific please? Why should numa balancing consider
> > > > nodes without any memory?
> > > >
> > > As my understanding, the destination cpu can be on a memory less node.
> > > BTW, there are several functions in the scheduler facing the same
> > > scenario, task_numa_migrate() is an example.
> >
> > Even if the destination node is memoryless then any migration would fail
> > because there is no memory. Anyway I still do not see how using online
> > node would break anything.
> >
> Suppose we have nodes A, B,C, where C is memory less but has little
> distance to B, comparing with the one from A to B. Then if a task is
> running on A, but prefer to run on B due to memory footprint.
> task_numa_migrate() allows us to migrate the task to node C. Changing
> for_each_online_node will break this.

That would require the task to have preferred node to be C no? Or do I
missunderstand the task migration logic?
-- 
Michal Hocko
SUSE Labs
