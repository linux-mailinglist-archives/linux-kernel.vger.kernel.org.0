Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9A8B2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHMInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 04:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfHMInV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53120AB92;
        Tue, 13 Aug 2019 08:43:19 +0000 (UTC)
Date:   Tue, 13 Aug 2019 10:43:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
Message-ID: <20190813084317.GD17933@dhcp22.suse.cz>
References: <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
 <20190809064633.GK18351@dhcp22.suse.cz>
 <20190809151718.d285cd1f6d0f1cf02cb93dc8@linux-foundation.org>
 <20190811234614.GZ17747@sasha-vm>
 <20190812084524.GC5117@dhcp22.suse.cz>
 <39b59001-55c1-a98b-75df-3a5dcec74504@suse.cz>
 <20190812132226.GI5117@dhcp22.suse.cz>
 <20190812153326.GB17747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812153326.GB17747@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 11:33:26, Sasha Levin wrote:
[...]
> I'd be happy to run whatever validation/regression suite for mm/ you
> would suggest.

You would have to develop one first and I am afraid that won't be really
simple and useful.

> I've heard the "every patch is a snowflake" story quite a few times, and
> I understand that most mm/ patches are complex, but we agree that
> manually testing every patch isn't scalable, right? Even for patches
> that mm/ tags for stable, are they actually tested on every stable tree?
> How is it different from the "aplies-it-must-be-ok workflow"?

There is a human brain put in and process each patch to make sure that
the change makes sense and we won't break none of many workloads that
people care about. Even if you run your patch throug mm tests which is
by far the most comprehensive test suite I know of we do regress from
time to time. We simply do not have a realistic testing coverage becuase
workload differ quite a lot and they are not really trivial to isolate
to a self contained test case. A lot of functionality doesn't have a
direct interface to test for because it triggers when the system gets
into some state.

Ideal? Not at all and I am happy to hear some better ideas. Until then
we simply have to rely on gut feeling and understanding of the code
and experience from workloads we have seen in the past.
-- 
Michal Hocko
SUSE Labs
