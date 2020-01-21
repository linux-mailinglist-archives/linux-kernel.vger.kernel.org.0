Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4DFD14351D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 02:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAUBVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 20:21:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:62102 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgAUBVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:21:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 17:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="277391772"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2020 17:21:49 -0800
Date:   Tue, 21 Jan 2020 09:22:00 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 7/8] mm/migrate.c: move page on next iteration
Message-ID: <20200121012200.GA1567@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-8-richardw.yang@linux.intel.com>
 <20200120100203.GR18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120100203.GR18451@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:02:03AM +0100, Michal Hocko wrote:
>On Sun 19-01-20 11:06:35, Wei Yang wrote:
>> When page is not successfully queued for migration, we would move pages
>> on pagelist immediately. Actually, this could be done in the next
>> iteration by telling it we need some help.
>> 
>> This patch adds a new variable need_move to be an indication. After
>> this, we only need to call move_pages_and_store_status() twice.
>
>No! Not another iterator. There are two and this makes the function
>quite hard to follow already. We do not want to add a third one.
>

Two iterators here are? I don't get your point.

>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/migrate.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index aee5aeb082c4..2a857fec65b6 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1610,6 +1610,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  	LIST_HEAD(pagelist);
>>  	int start, i;
>>  	int err = 0, err1;
>> +	int need_move = 0;
>>  
>>  	migrate_prep();
>>  
>> @@ -1641,13 +1642,15 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  		if (current_node == NUMA_NO_NODE) {
>>  			current_node = node;
>>  			start = i;
>> -		} else if (node != current_node) {
>> +		} else if (node != current_node || need_move) {
>>  			err = move_pages_and_store_status(mm, current_node,
>> -					&pagelist, status, start, i - start);
>> +					&pagelist, status, start,
>> +					i - start - need_move);
>>  			if (err)
>>  				goto out;
>>  			start = i;
>>  			current_node = node;
>> +			need_move = 0;
>>  		}
>>  
>>  		/*
>> @@ -1662,6 +1665,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  			continue;
>>  		}
>>  
>> +		/* Ask next iteration to move us */
>> +		need_move = 1;
>> +
>>  		/*
>>  		 * Two possible cases for err here:
>>  		 * == 0: page is already on the target node, then store
>> @@ -1671,17 +1677,11 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>>  		err = store_status(status, i, err ? : current_node, 1);
>>  		if (err)
>>  			goto out_flush;
>> -
>> -		err = move_pages_and_store_status(mm, current_node, &pagelist,
>> -				status, start, i - start);
>> -		if (err)
>> -			goto out;
>> -		current_node = NUMA_NO_NODE;
>>  	}
>>  out_flush:
>>  	/* Make sure we do not overwrite the existing error */
>>  	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
>> -				status, start, i - start);
>> +				status, start, i - start - need_move);
>>  	if (err >= 0)
>>  		err = err1;
>>  out:
>> -- 
>> 2.17.1
>> 
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
