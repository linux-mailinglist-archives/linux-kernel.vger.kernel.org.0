Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7382D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfHFIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 04:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:46184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728975AbfHFIDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C56BAF5D;
        Tue,  6 Aug 2019 08:03:43 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] hugetlbfs: don't retry when pool page allocations
 start to fail
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190806014744.15446-1-mike.kravetz@oracle.com>
 <20190806014744.15446-5-mike.kravetz@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c13c0c78-55d1-b2e2-c24b-897ce2469410@suse.cz>
Date:   Tue, 6 Aug 2019 10:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806014744.15446-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 3:47 AM, Mike Kravetz wrote:
> When allocating hugetlbfs pool pages via /proc/sys/vm/nr_hugepages,
> the pages will be interleaved between all nodes of the system.  If
> nodes are not equal, it is quite possible for one node to fill up
> before the others.  When this happens, the code still attempts to
> allocate pages from the full node.  This results in calls to direct
> reclaim and compaction which slow things down considerably.
> 
> When allocating pool pages, note the state of the previous allocation
> for each node.  If previous allocation failed, do not use the
> aggressive retry algorithm on successive attempts.  The allocation
> will still succeed if there is memory available, but it will not try
> as hard to free up memory.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
