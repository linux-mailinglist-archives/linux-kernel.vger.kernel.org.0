Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8AA7626
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfICV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 17:27:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfICV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:27:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83LOAgJ108721;
        Tue, 3 Sep 2019 21:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ZUSxy8swbo3YjFG5hrbyxkGQ0Fy8sGlGHn7XZkge1C8=;
 b=IRDB3EtHGCia/DW9zISe2m6ai47HEU5dvpdOBkPBTjSbtL+52mlwbDOBZPT/cQqyECRa
 W5I1tHvm9IAiWp107YTWJ8HcM+VHnr7MhqKnNWyq0dOMsqVl33+sfOHAVAuNqRsz/T3N
 yRi/p0umoPg77lYomERQgsJ7wZLSDqCLpr6/2XAyHZKY+yQF+SaPnXsyr6i0Uk/kKSsZ
 iIygeB+yPtDmG7S6D/yBh713e+rdOMKy8n6SJ0DkpmW+/V6Ud6DZnYDJeKXfcKaaIMMT
 2ea8uEIB4u7qZOTcEKojXu/vERg6+Rhjmpez0xza4V+0fA8Sh1lDRYXd68r0pQH5VKKd Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2usyy9r114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 21:26:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83LNoLh142829;
        Tue, 3 Sep 2019 21:26:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2us5phbbrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 21:26:11 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83LQ9PT028518;
        Tue, 3 Sep 2019 21:26:09 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 14:26:09 -0700
Subject: Re: [PATCH v2] mm/hugetlb: avoid looping to the same hugepage if
 !pages and !vmas
To:     Zhigang Lu <totty.lu@gmail.com>, luzhigang001@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zhigang Lu <tonnylu@tencent.com>
References: <1567086657-22528-1-git-send-email-totty.lu@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1f0e6e1a-c947-f389-801e-b1d748cb5bce@oracle.com>
Date:   Tue, 3 Sep 2019 14:26:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1567086657-22528-1-git-send-email-totty.lu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030214
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 6:50 AM, Zhigang Lu wrote:
> From: Zhigang Lu <tonnylu@tencent.com>
> 
> When mmapping an existing hugetlbfs file with MAP_POPULATE, we find
> it is very time consuming. For example, mmapping a 128GB file takes
> about 50 milliseconds. Sampling with perfevent shows it spends 99%
> time in the same_page loop in follow_hugetlb_page().
> 
> samples: 205  of event 'cycles', Event count (approx.): 136686374
> -  99.04%  test_mmap_huget  [kernel.kallsyms]  [k] follow_hugetlb_page
>         follow_hugetlb_page
>         __get_user_pages
>         __mlock_vma_pages_range
>         __mm_populate
>         vm_mmap_pgoff
>         sys_mmap_pgoff
>         sys_mmap
>         system_call_fastpath
>         __mmap64
> 
> follow_hugetlb_page() is called with pages=NULL and vmas=NULL, so for
> each hugepage, we run into the same_page loop for pages_per_huge_page()
> times, but doing nothing. With this change, it takes less then 1
> millisecond to mmap a 128GB file in hugetlbfs.

Thanks for the analysis!

Just curious, do you have an application that does this (mmap(MAP_POPULATE)
for an existing hugetlbfs file), or was this part of some test suite or
debug code?

> Signed-off-by: Zhigang Lu <tonnylu@tencent.com>
> Reviewed-by: Haozhong Zhang <hzhongzhang@tencent.com>
> Reviewed-by: Zongming Zhang <knightzhang@tencent.com>
> Acked-by: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/hugetlb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6d7296d..2df941a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4391,6 +4391,17 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  				break;
>  			}
>  		}

It might be helpful to add a comment here to help readers of the code.
Something like:

		/*
		 * If subpage information not requested, update counters
		 * and skip the same_page loop below.
		 */
> +
> +		if (!pages && !vmas && !pfn_offset &&
> +		    (vaddr + huge_page_size(h) < vma->vm_end) &&
> +		    (remainder >= pages_per_huge_page(h))) {
> +			vaddr += huge_page_size(h);
> +			remainder -= pages_per_huge_page(h);
> +			i += pages_per_huge_page(h);
> +			spin_unlock(ptl);
> +			continue;
> +		}
> +
>  same_page:
>  		if (pages) {
>  			pages[i] = mem_map_offset(page, pfn_offset);
> 

With a comment added to the code,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
