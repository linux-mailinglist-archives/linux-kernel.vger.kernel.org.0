Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A51180502
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCJRim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:38:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgCJRil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:38:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AHcUHc004995;
        Tue, 10 Mar 2020 17:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6688J8/XvMu+Cd7PgFZ1QhobnZSBKPscm/zSDiaClt4=;
 b=txPsdgRP14V3v38TYuUzx1z1OvOl89lA3JI6K5VDVo4gxx/XBz0GQVhtUmlxnoqL5ALI
 LQ/m3iHSV4HTLWWSngH606QLUnsBP1objAYqlTOB5T+rKgYxI7XMZZpQKHUp2g3iRDVa
 HdPiL+peeBxRmP3joGflp0N4liNaxdUcg4Al/o8aht1fB2u5LeVHutrofRdRVIRAiqpe
 5P8CtphrrfXwn1yFLXQeXRNPLgCxPdbeylUVL9Ab4IhySnQYonsXTmETozr+OMmn6ExY
 GL/ZPfZa67YMAEFFb9DGauddwIUKvhqlzWF2+9NojXyF1Yj27hF/8j+G6MIBOTwuo0bJ Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ym31uf2mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 17:38:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AHYG5t112155;
        Tue, 10 Mar 2020 17:38:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yp8psry8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 17:38:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AHcQAS030678;
        Tue, 10 Mar 2020 17:38:26 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 10:38:26 -0700
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310084544.GY8447@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ce96c9e9-1082-df68-010e-b759d2ede69a@oracle.com>
Date:   Tue, 10 Mar 2020 10:38:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310084544.GY8447@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 1:45 AM, Michal Hocko wrote:
> On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
<snip>
>> +early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
>> +
>> +void __init hugetlb_cma_reserve(void)
>> +{
>> +	unsigned long totalpages = 0;
>> +	unsigned long start_pfn, end_pfn;
>> +	phys_addr_t size;
>> +	int nid, i, res;
>> +
>> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
>> +		return;
>> +
>> +	if (hugetlb_cma_percent) {
>> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
>> +				       NULL)
>> +			totalpages += end_pfn - start_pfn;
>> +
>> +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
>> +			10000UL;
>> +	} else {
>> +		size = hugetlb_cma_size;
>> +	}
>> +
>> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
>> +		size / nr_online_nodes);
>> +
>> +	size /= nr_online_nodes;
>> +
>> +	for_each_node_state(nid, N_ONLINE) {
>> +		unsigned long min_pfn = 0, max_pfn = 0;
>> +
>> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>> +			if (!min_pfn)
>> +				min_pfn = start_pfn;
>> +			max_pfn = end_pfn;
>> +		}
> 
> Do you want to compare the range to the size? But besides that, I
> believe this really needs to be much more careful. I believe you do not
> want to eat a considerable part of the kernel memory because the
> resulting configuration will really struggle (yeah all the low mem/high
> mem problems all over again).

Will it struggle any worse than if the we allocated the same amount of memory
for gigantic pages as is done today?  Of course, sys admins may think reserving
memory for CMA is better than pre-allocating and end up reserving a greater
amount.

-- 
Mike Kravetz
