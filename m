Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF0AE498
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfIJHY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 03:24:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIJHY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:24:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23AFAAF6B;
        Tue, 10 Sep 2019 07:24:26 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:24:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910072425.GI2063@dhcp22.suse.cz>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909185035.GC2063@dhcp22.suse.cz>
 <07576292-e129-5949-6a2e-45fff067ca5a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07576292-e129-5949-6a2e-45fff067ca5a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our emails crossed, sorry about that.

On Tue 10-09-19 15:08:20, Yunsheng Lin wrote:
> On 2019/9/10 2:50, Michal Hocko wrote:
> > On Mon 09-09-19 14:04:23, Yunsheng Lin wrote:
[...]
> >> Even if a device's numa node is not specified, the device really
> >> does belong to a node.
> > 
> > What does this mean?
> 
> It means some one need to guess the node id if the node is not
> specified.

I have asked about this in other email so let's not cross the
communication even more.
 
> >> This patch sets the device node to node 0 in device_add() if the
> >> device's node id is not specified and it either has no parent
> >> device, or the parent device also does not have a valid node id.
> > 
> > Why is node 0 special? I have seen platforms with node 0 missing or
> > being memory less. The changelog also lacks an actual problem
> 
> by node 0 missing, how do we know if node 0 is missing?
> by node_online(0)?

No, this is a dynamic situation. Node might get offline via hotremove.
In most cases it wouldn't because there will likely be some kernel
memory on node0 but you cannot really make any assumptions here. Besides
that nothing should really care.

> > descripton. Why do we even care about NUMA_NO_NODE? E.g. the page
> > allocator interprets NUMA_NO_NODE as the closest node with a memory.
> > And by closest it really means to the CPU which is performing the
> > allocation.
> 
> Yes, I should have mentioned that in the commit log.
> 
> I mentioned the below in the RFC, but somehow deleted when sending
> V1:
> "There may be explicit handling out there relying on NUMA_NO_NODE,
> like in nvme_probe()."

This code, and other doing similar things, is very likely bogus. Just
look at what the code does. It takes the node affinity from the dev and
uses it for an allocation. So far so good. But it tries to be clever
and special cases NUMA_NO_NODE to be first_node. So now the allocator
has used a proper fallback to the nearest node with memory for the
current CPU that is executing the code while dev will point to a
first_node which might be a completely different one. See the
discrepancy?
-- 
Michal Hocko
SUSE Labs
