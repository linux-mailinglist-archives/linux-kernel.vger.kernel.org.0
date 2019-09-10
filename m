Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432D0AE8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfIJLEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 07:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:51846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbfIJLEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A4B6AC10;
        Tue, 10 Sep 2019 11:04:52 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:04:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910110451.GP2063@dhcp22.suse.cz>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 18:58:05, Yunsheng Lin wrote:
> On 2019/9/10 17:31, Greg KH wrote:
> > On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
> >> On 2019/9/9 17:53, Greg KH wrote:
> >>> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
> >>>> Currently a device does not belong to any of the numa nodes
> >>>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
> >>>> specified by fw nor by virtual device layer and the device has
> >>>> no parent device.
> >>>
> >>> Is this really a problem?
> >>
> >> Not really.
> >> Someone need to guess the node id when it is not specified, right?
> > 
> > No, why?  Guessing guarantees you will get it wrong on some systems.
> > 
> > Are you seeing real problems because the id is not being set?  What
> > problem is this fixing that you can actually observe?
> 
> When passing the return value of dev_to_node() to cpumask_of_node()
> without checking the node id if the node id is not valid, there is
> global-out-of-bounds detected by KASAN as below:

OK, I seem to remember this being brought up already. And now when I
think about it, we really want to make cpumask_of_node NUMA_NO_NODE
aware. That means using the same trick the allocator does for this
special case.
-- 
Michal Hocko
SUSE Labs
