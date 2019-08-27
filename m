Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3A9EA23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfH0NxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 09:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfH0NxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F707AC45;
        Tue, 27 Aug 2019 13:53:23 +0000 (UTC)
Date:   Tue, 27 Aug 2019 15:53:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Adric Blake <promarbler14@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNINGs in set_task_reclaim_state with memory
 cgroupandfullmemory usage
Message-ID: <20190827135322.GG7538@dhcp22.suse.cz>
References: <20190824130516.2540-1-hdanton@sina.com>
 <CALOAHbAuY9BnpX6x4KSNURbzybjn5UdSNL7-1Li3R0HSQBqiGQ@mail.gmail.com>
 <20190827132931.848986B0008@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827132931.848986B0008@kanga.kvack.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 21:29:24, Hillf Danton wrote:
> 
> >> No preference seems in either way except for retaining
> >> nr_to_reclaim == SWAP_CLUSTER_MAX and target_mem_cgroup == memcg.
> >
> > Setting  target_mem_cgroup here may be a very subtle change for
> > subsequent processing.
> > Regarding retraining nr_to_reclaim == SWAP_CLUSTER_MAX, it may not
> > proper for direct reclaim, that may cause some stall if we iterate all
> > memcgs here.
> 
> Mind posting a RFC to collect thoughts?

I hope I have explained why this is not desirable
http://lkml.kernel.org/r/20190827120335.GA7538@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
