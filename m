Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE3F1909
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 15:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfKFOq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 09:46:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727028AbfKFOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:46:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6Ee3Og101242
        for <linux-kernel@vger.kernel.org>; Wed, 6 Nov 2019 09:46:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w402h0kg3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:46:55 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 6 Nov 2019 14:46:53 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 14:46:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6EkogZ53936282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 14:46:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE00052052;
        Wed,  6 Nov 2019 14:46:50 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.189])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6AEA352067;
        Wed,  6 Nov 2019 14:46:50 +0000 (GMT)
Date:   Wed, 6 Nov 2019 16:46:48 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Cao jin <caoj.fnst@cn.fujitsu.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: cleanup doc
References: <20190912123127.8694-1-caoj.fnst@cn.fujitsu.com>
 <20190915051640.GA11429@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915051640.GA11429@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19110614-0020-0000-0000-000003831BA9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110614-0021-0000-0000-000021D94B50
Message-Id: <20191106144648.GC10737@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Sep 15, 2019 at 08:16:40AM +0300, Mike Rapoport wrote:
> On Thu, Sep 12, 2019 at 08:31:27PM +0800, Cao jin wrote:
> > fix typos for:
> >     elaboarte -> elaborate
> >     architecure -> architecture
> >     compltes -> completes
> > 
> > And, convert the markup :c:func:`foo` to foo() as kernel documentation
> > toolchain can recognize foo() as a function.
> > 
> > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Can you please pick this to the -mm tree?
 
> > ---
> >  mm/memblock.c | 44 ++++++++++++++++++++------------------------
> >  1 file changed, 20 insertions(+), 24 deletions(-)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 7d4f61ae666a..c23b370cc49e 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -57,42 +57,38 @@
> >   * at build time. The region arrays for the "memory" and "reserved"
> >   * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
> >   * "physmap" type to %INIT_PHYSMEM_REGIONS.
> > - * The :c:func:`memblock_allow_resize` enables automatic resizing of
> > - * the region arrays during addition of new regions. This feature
> > - * should be used with care so that memory allocated for the region
> > - * array will not overlap with areas that should be reserved, for
> > - * example initrd.
> > + * The memblock_allow_resize() enables automatic resizing of the region
> > + * arrays during addition of new regions. This feature should be used
> > + * with care so that memory allocated for the region array will not
> > + * overlap with areas that should be reserved, for example initrd.
> >   *
> >   * The early architecture setup should tell memblock what the physical
> > - * memory layout is by using :c:func:`memblock_add` or
> > - * :c:func:`memblock_add_node` functions. The first function does not
> > - * assign the region to a NUMA node and it is appropriate for UMA
> > - * systems. Yet, it is possible to use it on NUMA systems as well and
> > - * assign the region to a NUMA node later in the setup process using
> > - * :c:func:`memblock_set_node`. The :c:func:`memblock_add_node`
> > - * performs such an assignment directly.
> > + * memory layout is by using memblock_add() or memblock_add_node()
> > + * functions. The first function does not assign the region to a NUMA
> > + * node and it is appropriate for UMA systems. Yet, it is possible to
> > + * use it on NUMA systems as well and assign the region to a NUMA node
> > + * later in the setup process using memblock_set_node(). The
> > + * memblock_add_node() performs such an assignment directly.
> >   *
> >   * Once memblock is setup the memory can be allocated using one of the
> >   * API variants:
> >   *
> > - * * :c:func:`memblock_phys_alloc*` - these functions return the
> > - *   **physical** address of the allocated memory
> > - * * :c:func:`memblock_alloc*` - these functions return the **virtual**
> > - *   address of the allocated memory.
> > + * * memblock_phys_alloc*() - these functions return the **physical**
> > + *   address of the allocated memory
> > + * * memblock_alloc*() - these functions return the **virtual** address
> > + *   of the allocated memory.
> >   *
> >   * Note, that both API variants use implict assumptions about allowed
> >   * memory ranges and the fallback methods. Consult the documentation
> > - * of :c:func:`memblock_alloc_internal` and
> > - * :c:func:`memblock_alloc_range_nid` functions for more elaboarte
> > - * description.
> > + * of memblock_alloc_internal() and memblock_alloc_range_nid()
> > + * functions for more elaborate description.
> >   *
> > - * As the system boot progresses, the architecture specific
> > - * :c:func:`mem_init` function frees all the memory to the buddy page
> > - * allocator.
> > + * As the system boot progresses, the architecture specific mem_init()
> > + * function frees all the memory to the buddy page allocator.
> >   *
> > - * Unless an architecure enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
> > + * Unless an architecture enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
> >   * memblock data structures will be discarded after the system
> > - * initialization compltes.
> > + * initialization completes.
> >   */
> >  
> >  #ifndef CONFIG_NEED_MULTIPLE_NODES
> > -- 
> > 2.21.0
> > 
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
> 

-- 
Sincerely yours,
Mike.

