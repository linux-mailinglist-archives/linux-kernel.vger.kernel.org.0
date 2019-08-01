Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548937E036
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfHAQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:32:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730790AbfHAQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:32:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F04C7AFF3;
        Thu,  1 Aug 2019 16:32:15 +0000 (UTC)
Date:   Thu, 1 Aug 2019 18:32:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Hadrava <had@kam.mff.cuni.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wizards@kam.mff.cuni.cz, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [BUG]: mm/vmscan.c: shrink_slab does not work correctly with
 memcg disabled via commandline
Message-ID: <20190801163213.GO11627@dhcp22.suse.cz>
References: <20190801134250.scbfnjewahbt5zui@kam.mff.cuni.cz>
 <20190801140610.GM11627@dhcp22.suse.cz>
 <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 17:54:34, Jan Hadrava wrote:
> On Thu, Aug 01, 2019 at 04:06:10PM +0200, Michal Hocko wrote:
> > On Thu 01-08-19 15:42:50, Jan Hadrava wrote:
> > > There seems to be a bug in mm/vmscan.c shrink_slab function when kernel is
> > > compilled with CONFIG_MEMCG=y and it is then disabled at boot with commandline
> > > parameter cgroup_disable=memory. SLABs are then not getting shrinked if the
> > > system memory is consumed by userspace.
> > 
> > This looks similar to http://lkml.kernel.org/r/1563385526-20805-1-git-send-email-yang.shi@linux.alibaba.com
> > although the culprit commit has been identified to be different. Could
> > you try it out please? Maybe we need more fixes.
> 
> Yes, it is same.

I am happy to hear that!

> So my report is duplicate and I'm just bad in searching the
> archives, sorry.

No worries. Your bug report was really good with great level of details.
I wish all the bug reports were done so thoroughly.
 
> Just to be sure, i run my tests and patch proposed in the original thread
> solves my issue in all four affected stable releases:

Cc Andrew. I assume we can assume your Tested-by tag?

Thanks a lot!
-- 
Michal Hocko
SUSE Labs
