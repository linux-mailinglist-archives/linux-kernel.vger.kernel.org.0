Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D956DAE8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfIJLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 07:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfIJLMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:12:55 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74CA1207FC;
        Tue, 10 Sep 2019 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568113975;
        bh=PD9H6wLyS/xRG838kVHNjqCpnvHomor6bbn+BhwaSnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oz3PQejY4fHlFE7NNmUuqi02wtM30x68VrstR+jB50Y6No3lozKwy9x2b6C7iQQ1P
         7MyfGeVyn1I5qyr6PEz1BAg0fsFy55sBQiKNz14d+DVXIkVSNakpNUkUtBJtJVV9hQ
         KD+acilLF9FKFjD+T4qVlZX1gXjnxqAiIOjwnPN0=
Date:   Tue, 10 Sep 2019 12:12:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910111252.GA8970@kroah.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910110451.GP2063@dhcp22.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 01:04:51PM +0200, Michal Hocko wrote:
> On Tue 10-09-19 18:58:05, Yunsheng Lin wrote:
> > On 2019/9/10 17:31, Greg KH wrote:
> > > On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
> > >> On 2019/9/9 17:53, Greg KH wrote:
> > >>> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
> > >>>> Currently a device does not belong to any of the numa nodes
> > >>>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
> > >>>> specified by fw nor by virtual device layer and the device has
> > >>>> no parent device.
> > >>>
> > >>> Is this really a problem?
> > >>
> > >> Not really.
> > >> Someone need to guess the node id when it is not specified, right?
> > > 
> > > No, why?  Guessing guarantees you will get it wrong on some systems.
> > > 
> > > Are you seeing real problems because the id is not being set?  What
> > > problem is this fixing that you can actually observe?
> > 
> > When passing the return value of dev_to_node() to cpumask_of_node()
> > without checking the node id if the node id is not valid, there is
> > global-out-of-bounds detected by KASAN as below:
> 
> OK, I seem to remember this being brought up already. And now when I
> think about it, we really want to make cpumask_of_node NUMA_NO_NODE
> aware. That means using the same trick the allocator does for this
> special case.

That seems reasonable to me, and much more "obvious" as to what is going
on.

thanks,

greg k-h
