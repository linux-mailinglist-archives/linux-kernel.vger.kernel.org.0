Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF482357
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfHERBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 13:01:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51474 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfHERBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:01:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75Gj6IA113561;
        Mon, 5 Aug 2019 17:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9pUfgziCq7pxPpZPM6g5Do4JMKoJYIw8oH79TZUxwXY=;
 b=PkQPMljfOmAIQpx501wtF+rIjs+mcgDoiMpircWo7jHH88A2tIpl4nnV8azMM1Dd66PX
 jqn9tc+tvmCDyOcUWjv9nI5xdOc9NBYzIuJHEzPiTNA0N6uZ9ETtevbC9N8RBHViNpaa
 YuFbP1C5k2riXhF6eKTP+ELkI8d/H5rWJC/7fm7nRcIeobm3rkyZRREKfYApppimsSbc
 3V4IvMw1i4FN8ZGz7rL5+kWYXrh9ex+JjsitLy7mh8fpEvJprSC+7AOLDU5PyQRb3aEi
 4Ix1s1in1si6pvznojlvamRz0YkPdffwvMSQJVI31ZumJNx9LbpgZvNQK9wwvD0drxSK Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u527pgf0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 17:00:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75GlBa3160930;
        Mon, 5 Aug 2019 16:58:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u4ycu5ure-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 16:58:40 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x75Gwb6J022007;
        Mon, 5 Aug 2019 16:58:38 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 09:58:37 -0700
Subject: Re: [PATCH 1/3] mm, reclaim: make should_continue_reclaim perform
 dryrun detection
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190802223930.30971-1-mike.kravetz@oracle.com>
 <20190802223930.30971-2-mike.kravetz@oracle.com>
 <bb16d3f0-0984-be32-4346-358abad92c4c@suse.cz>
 <0d31cc14-13cd-13e0-cf2d-dd8a8d3049ff@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b4dbe25f-4499-af28-94bb-d12147505326@oracle.com>
Date:   Mon, 5 Aug 2019 09:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0d31cc14-13cd-13e0-cf2d-dd8a8d3049ff@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050184
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=965 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 3:57 AM, Vlastimil Babka wrote:
> On 8/5/19 10:42 AM, Vlastimil Babka wrote:
>> On 8/3/19 12:39 AM, Mike Kravetz wrote:
>>> From: Hillf Danton <hdanton@sina.com>
>>>
>>> Address the issue of should_continue_reclaim continuing true too often
>>> for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
>>> This could happen during hugetlb page allocation causing stalls for
>>> minutes or hours.
>>>
>>> We can stop reclaiming pages if compaction reports it can make a progress.
>>> A code reshuffle is needed to do that.
>>
>>> And it has side-effects, however,
>>> with allocation latencies in other cases but that would come at the cost
>>> of potential premature reclaim which has consequences of itself.
>>
>> Based on Mel's longer explanation, can we clarify the wording here? e.g.:
>>
>> There might be side-effect for other high-order allocations that would
>> potentially benefit from more reclaim before compaction for them to be
>> faster and less likely to stall, but the consequences of
>> premature/over-reclaim are considered worse.
>>
>>> We can also bail out of reclaiming pages if we know that there are not
>>> enough inactive lru pages left to satisfy the costly allocation.
>>>
>>> We can give up reclaiming pages too if we see dryrun occur, with the
>>> certainty of plenty of inactive pages. IOW with dryrun detected, we are
>>> sure we have reclaimed as many pages as we could.
>>>
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Signed-off-by: Hillf Danton <hdanton@sina.com>
>>> Tested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Acked-by: Mel Gorman <mgorman@suse.de>
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> I will send some followup cleanup.
> 
> How about this?
> ----8<----
> From 0040b32462587171ad22395a56699cc036ad483f Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 5 Aug 2019 12:49:40 +0200
> Subject: [PATCH] mm, reclaim: cleanup should_continue_reclaim()
> 
> After commit "mm, reclaim: make should_continue_reclaim perform dryrun
> detection", closer look at the function shows, that nr_reclaimed == 0 means
> the function will always return false. And since non-zero nr_reclaimed implies
> non_zero nr_scanned, testing nr_scanned serves no purpose, and so does the
> testing for __GFP_RETRY_MAYFAIL.
> 
> This patch thus cleans up the function to test only !nr_reclaimed upfront, and
> remove the __GFP_RETRY_MAYFAIL test and nr_scanned parameter completely.
> Comment is also updated, explaining that approximating "full LRU list has been
> scanned" with nr_scanned == 0 didn't really work.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Would you like me to add this to the series, or do you want to send later?
-- 
Mike Kravetz
