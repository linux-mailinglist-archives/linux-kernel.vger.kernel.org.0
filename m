Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09FF5F70C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfGDLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 07:09:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfGDLJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:09:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B698AEAF;
        Thu,  4 Jul 2019 11:09:04 +0000 (UTC)
Date:   Thu, 4 Jul 2019 13:09:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [Question] Should direct reclaim time be bounded?
Message-ID: <20190704110903.GE5620@dhcp22.suse.cz>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
 <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
 <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
 <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
 <20190701085920.GB2812@suse.de>
 <80036eed-993d-1d24-7ab6-e495f01b1caa@oracle.com>
 <20190703094325.GB2737@techsingularity.net>
 <571d5557-2153-59ea-334b-8636cc1a49c9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571d5557-2153-59ea-334b-8636cc1a49c9@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-07-19 16:54:35, Mike Kravetz wrote:
> On 7/3/19 2:43 AM, Mel Gorman wrote:
> > Indeed. I'm getting knocked offline shortly so I didn't give this the
> > time it deserves but it appears that part of this problem is
> > hugetlb-specific when one node is full and can enter into this continual
> > loop due to __GFP_RETRY_MAYFAIL requiring both nr_reclaimed and
> > nr_scanned to be zero.
> 
> Yes, I am not aware of any other large order allocations consistently made
> with __GFP_RETRY_MAYFAIL.  But, I did not look too closely.  Michal believes
> that hugetlb pages allocations should use __GFP_RETRY_MAYFAIL.

Yes. The argument is that this is controlable by an admin and failures
should be prevented as much as possible. I didn't get to understand
should_continue_reclaim part of the problem but I have a strong feeling
that __GFP_RETRY_MAYFAIL handling at that layer is not correct. What
happens if it is simply removed and we rely only on the retry mechanism
from the page allocator instead? Does the success rate is reduced
considerably?
-- 
Michal Hocko
SUSE Labs
