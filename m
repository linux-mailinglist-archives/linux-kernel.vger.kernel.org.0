Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3100B6777D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfGMBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 21:11:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfGMBLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 21:11:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6D0sfpc178083;
        Sat, 13 Jul 2019 01:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jUTho8nKW5hjHRWxClJOHdo4lCalGSvqrppSqDi2e5U=;
 b=PLGES2Ytpe4W9BYJworC8/e6RLJhW9Y5+9Q84yHoqn10S/+dE9MrFf0Ozd+EI0g+qgwC
 qno4eLFWqNf3h4lT23a3YFdmNObgU5rz/Cn2p1mTgGDJyoOTs2iQT9PUXmFmXk+HcfAK
 V2LKG297dptF4PzytZdGwItMYsqyDThxvhmEkgYEH2nPittyADiKNtYTjYRK1etvtE3O
 V9nM+tkWyHJW47ZzqMPJuIpdIppSFOjNl8eRooKwaDVLkCsMvyEzH86JYvKGGc4mJGNI
 FwAc2H9Y5DfDJKv75flo7uBhHMn9s3sl3Dv7PaajqZbkD2FafIBDsnG/pv4JO9p/jDa5 OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tjk2u855c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 01:11:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6D16BUx181034;
        Sat, 13 Jul 2019 01:11:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tq5bb01pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 01:11:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6D1BVaG001148;
        Sat, 13 Jul 2019 01:11:32 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 18:11:31 -0700
Subject: Re: [Question] Should direct reclaim time be bounded?
To:     Hillf Danton <hdanton@sina.com>, Mel Gorman <mgorman@suse.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20190712054732.7264-1-hdanton@sina.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c39e7cb3-204c-c4e3-fb43-7a37d91c0ccb@oracle.com>
Date:   Fri, 12 Jul 2019 18:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712054732.7264-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9316 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907130007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9316 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907130007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/19 10:47 PM, Hillf Danton wrote:
> 
> On Thu, 11 Jul 2019 02:42:56 +0800 Mike Kravetz wrote:
>>
>> It is quite easy to hit the condition where:
>> nr_reclaimed == 0  && nr_scanned == 0 is true, but we skip the previous test
>>
> Then skipping check of __GFP_RETRY_MAYFAIL makes no sense in your case.
> It is restored in respin below.
> 
>> and the compaction check:
>> sc->nr_reclaimed < pages_for_compaction &&
>> 	inactive_lru_pages > pages_for_compaction
>> is true, so we return true before the below check of costly_fg_reclaim
>>
> This check is placed after COMPACT_SUCCESS; the latter is used to
> replace sc->nr_reclaimed < pages_for_compaction.
> 
> And dryrun detection is added based on the result of last round of
> shrinking of inactive pages, particularly when their number is large
> enough.
> 

Thanks Hillf.

This change does appear to eliminate the issue with stalls by
should_continue_reclaim returning true too often.  I need to think
some more about exactly what is impacted with the change.

With this change, the problem moves to compaction with should_compact_retry
returning true too often.  It is the same behavior seem when I simply removed
the __GFP_RETRY_MAYFAIL special casing in should_continue_reclaim.

At Mel's suggestion I removed the compaction_zonelist_suitable() call
from should_compact_retry.  This eliminated the compaction stalls.  Thanks
Mel.

With both changes, stalls appear to be eliminated.  This is promising.
I'll try to refine these approaches and continue testing.
-- 
Mike Kravetz

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2571,18 +2571,6 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>  			return false;
>  	}
> 
> -	/*
> -	 * If we have not reclaimed enough pages for compaction and the
> -	 * inactive lists are large enough, continue reclaiming
> -	 */
> -	pages_for_compaction = compact_gap(sc->order);
> -	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -	if (get_nr_swap_pages() > 0)
> -		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
> -	if (sc->nr_reclaimed < pages_for_compaction &&
> -			inactive_lru_pages > pages_for_compaction)
> -		return true;
> -
>  	/* If compaction would go ahead or the allocation would succeed, stop */
>  	for (z = 0; z <= sc->reclaim_idx; z++) {
>  		struct zone *zone = &pgdat->node_zones[z];
> @@ -2598,7 +2586,21 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>  			;
>  		}
>  	}
> -	return true;
> +
> +	/*
> +	 * If we have not reclaimed enough pages for compaction and the
> +	 * inactive lists are large enough, continue reclaiming
> +	 */
> +	pages_for_compaction = compact_gap(sc->order);
> +	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> +	if (get_nr_swap_pages() > 0)
> +		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
> +
> +	return inactive_lru_pages > pages_for_compaction &&
> +		/*
> +		 * avoid dryrun with plenty of inactive pages
> +		 */
> +		nr_scanned && nr_reclaimed;
>  }
> 
>  static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
> --
> 
