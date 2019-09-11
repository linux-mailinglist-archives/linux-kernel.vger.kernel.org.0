Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAABAF700
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfIKHey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 03:34:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfIKHey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:34:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9410BAD7F;
        Wed, 11 Sep 2019 07:34:52 +0000 (UTC)
Date:   Wed, 11 Sep 2019 09:34:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190911073451.GM4023@dhcp22.suse.cz>
References: <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz>
 <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
 <20190910125339.GZ2063@dhcp22.suse.cz>
 <20190911053334.GH4023@dhcp22.suse.cz>
 <ca590101-bfc8-3934-d803-537aacb707e0@huawei.com>
 <20190911064926.GJ4023@dhcp22.suse.cz>
 <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 15:22:30, Yunsheng Lin wrote:
[...]
> It seems that there is no protection that prevent setting the node
> of device to an invalid node.
> And the kernel does have a few different check now:
> 1) some does " < 0" check;
> 2) some does "== NUMA_NO_NODE" check;
> 3) some does ">= MAX_NUMNODES" check;
> 4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.
> 
> We need to be consistent about the checking, right?

You can try and chase each of them and see what to do with them. I
suspect they are a result of random attempts to fortify the code in many
cases. Consistency is certainly good but spreading more checks all over
the place just adds more cargo cult. Each check should be reasonably
justified.

-- 
Michal Hocko
SUSE Labs
