Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFBE1448FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 01:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAVAgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 19:36:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:19225 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgAVAgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:36:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 16:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="250443555"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 16:36:39 -0800
Date:   Wed, 22 Jan 2020 08:36:50 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 1/8] mm/migrate.c: skip node check if done in last round
Message-ID: <20200122003650.GA11409@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-2-richardw.yang@linux.intel.com>
 <20200120093646.GL18451@dhcp22.suse.cz>
 <20200120222540.GA32314@richard>
 <20200121084205.GD29276@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121084205.GD29276@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:42:05AM +0100, Michal Hocko wrote:
>On Tue 21-01-20 06:25:40, Wei Yang wrote:
>> On Mon, Jan 20, 2020 at 10:36:46AM +0100, Michal Hocko wrote:
>> >On Sun 19-01-20 11:06:29, Wei Yang wrote:
>> >> Before move page to target node, we would check if the node id is valid.
>> >> In case we would try to move pages to the same target node, it is not
>> >> necessary to do the check each time.
>> >> 
>> >> This patch tries to skip the check if the node has been checked.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  mm/migrate.c | 19 +++++++++++--------
>> >>  1 file changed, 11 insertions(+), 8 deletions(-)
>> >> 
>> >> diff --git a/mm/migrate.c b/mm/migrate.c
>> >> index 430fdccc733e..ba7cf4fa43a0 100644
>> >> --- a/mm/migrate.c
>> >> +++ b/mm/migrate.c
>> >> @@ -1612,15 +1612,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>> >>  			goto out_flush;
>> >>  		addr = (unsigned long)untagged_addr(p);
>> >>  
>> >> -		err = -ENODEV;
>> >> -		if (node < 0 || node >= MAX_NUMNODES)
>> >> -			goto out_flush;
>> >> -		if (!node_state(node, N_MEMORY))
>> >> -			goto out_flush;
>> >> +		/* Check node if it is not checked. */
>> >> +		if (current_node == NUMA_NO_NODE || node != current_node) {
>> >> +			err = -ENODEV;
>> >> +			if (node < 0 || node >= MAX_NUMNODES)
>> >> +				goto out_flush;
>> >> +			if (!node_state(node, N_MEMORY))
>> >> +				goto out_flush;
>> >
>> >This makes the code harder to read IMHO. The original code checks the
>> >valid node first and it doesn't conflate that with the node caching
>> >logic which your change does.
>> >
>> 
>> I am sorry, would you mind showing me an example about the conflate in my
>> change? I don't get it.
>
>NUMA_NO_NODE is the iteration logic, right? It resets the batching node.
>Node check read from the userspace is an input sanitization. Do not put
>those two into the same checks. More clear now?

Yes, I see your point.

Can we think like this:

  On each iteration, we do an input sanitization?

Well, this is a trivial one. If you don't like it, I would remove this.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
