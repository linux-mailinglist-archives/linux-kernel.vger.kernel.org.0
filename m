Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089BB100260
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKRK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 05:29:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:38984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfKRK3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:29:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56444AE89;
        Mon, 18 Nov 2019 10:29:51 +0000 (UTC)
Date:   Mon, 18 Nov 2019 11:29:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>, Rong Chen <rong.a.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3] memcg: add memcg lru
Message-ID: <20191118102950.GB14255@dhcp22.suse.cz>
References: <20191117113526.5640-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117113526.5640-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 17-11-19 19:35:26, Hillf Danton wrote:
> 
> Currently soft limit reclaim (slr) is frozen, see
> Documentation/admin-guide/cgroup-v2.rst for reasons.
> 
> This work adds memcg hook into kswapd's logic to bypass slr, paving
> a brick for its cleanup later.
> 
> After b23afb93d317 ("memcg: punt high overage reclaim to
> return-to-userland path"), high limit breachers (hlb) are reclaimed
> one after another spiraling up through the memcg hierarchy before
> returning to userspace.
> 
> The current memcg high work helps to add the lru because we get to
> collect hlb at zero price and in particular without adding changes
> to the high work's behavior.
> 
> Then a fifo list, which is essencially a simple copy of the page lru,
> is needed to facilitate queuing up hlb and ripping pages off them in
> round robin once kswapd starts doing its job.
> 
> Finally new hook is added with slr's two problems addressed i.e.
> hierarchy-unaware reclaim and overreclaim.
> 
> Thanks to Rong Chen for testing.

You have ignored the previous review feedback again [1]. I have nacked
the patch on grounds that it is completely missing any real use case
scenario or any numbers suggesting there is an actual improvement.

Please do not post new versions until you make those things clear.

[1] http://lkml.kernel.org/r/20191029083730.GC31513@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
