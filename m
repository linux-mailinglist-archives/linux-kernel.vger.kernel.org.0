Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D363B7258
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 06:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfISEsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 00:48:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbfISEsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 00:48:07 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8J4kj4j131734
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:48:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3vdf1fdh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:48:05 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 19 Sep 2019 05:48:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 05:47:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8J4lvRa38600716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 04:47:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4DCFA4053;
        Thu, 19 Sep 2019 04:47:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DDE6A404D;
        Thu, 19 Sep 2019 04:47:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.7])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Sep 2019 04:47:56 +0000 (GMT)
Date:   Thu, 19 Sep 2019 07:47:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.co,
        dan.j.williams@intel.com, david@redhat.com,
        richardw.yang@linux.intel.com, cai@lca.pw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
References: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19091904-4275-0000-0000-000003685A1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091904-4276-0000-0000-0000387AC4AE
Message-Id: <20190919044753.GA20548@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 18, 2019 at 12:22:29PM +0800, Yunfeng Ye wrote:
> Currently, when memblock_find_in_range_node() fail on the exact node, it
> will use %NUMA_NO_NODE to find memblock from other nodes. At present,
> the work is good, but when the large memory is insufficient and the
> small memory is enough, we want to allocate the small memory of this
> node first, and do not need to allocate large memory from other nodes.
> 
> In sparse_buffer_init(), it will prepare large chunks of memory for page
> structure. The page management structure requires a lot of memory, but
> if the node does not have enough memory, it can be converted to a small
> memory allocation without having to allocate it from other nodes.
> 
> Add %MEMBLOCK_ALLOC_EXACT_NODE flag for this situation. Normally, the
> behavior is the same with %MEMBLOCK_ALLOC_ACCESSIBLE, only that it will
> not allocate from other nodes when a single node fails to allocate.
> 
> If large contiguous block memory allocated fail in sparse_buffer_init(),
> it will allocates small block memmory section by section later.

Did you see the sparse_buffer_init() actually falling back to allocate from a
different node? If a node does not have enough memory to hold it's own
memory map, filling only it with parts of the memory map will not make such
node usable.
 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  include/linux/memblock.h | 1 +
>  mm/memblock.c            | 3 ++-
>  mm/sparse.c              | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f491690..9a81d9c 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -339,6 +339,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
>  #define MEMBLOCK_ALLOC_KASAN		1
> +#define MEMBLOCK_ALLOC_EXACT_NODE	2
> 
>  /* We are using top down, so it is safe to use 0 here */
>  #define MEMBLOCK_LOW_LIMIT 0
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7d4f61a..dbd52c3c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -277,6 +277,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> 
>  	/* pump up @end */
>  	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
> +	    end == MEMBLOCK_ALLOC_EXACT_NODE ||
>  	    end == MEMBLOCK_ALLOC_KASAN)
>  		end = memblock.current_limit;
> 
> @@ -1365,7 +1366,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  	if (found && !memblock_reserve(found, size))
>  		goto done;
> 
> -	if (nid != NUMA_NO_NODE) {
> +	if (end != MEMBLOCK_ALLOC_EXACT_NODE && nid != NUMA_NO_NODE) {
>  		found = memblock_find_in_range_node(size, align, start,
>  						    end, NUMA_NO_NODE,
>  						    flags);
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d..828db46 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -477,7 +477,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>  	sparsemap_buf =
>  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>  						addr,
> -						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +						MEMBLOCK_ALLOC_EXACT_NODE, nid);
>  	sparsemap_buf_end = sparsemap_buf + size;
>  }
> 
> -- 
> 2.7.4.huawei.3
> 
> 

-- 
Sincerely yours,
Mike.

