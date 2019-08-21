Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1C97F99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfHUQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:02:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbfHUQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:02:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LFvdZr144337
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:02:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh87njr3b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:02:10 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 21 Aug 2019 17:02:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 17:02:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LG22In48693276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 16:02:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ABF0AE053;
        Wed, 21 Aug 2019 16:02:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C708AE04D;
        Wed, 21 Aug 2019 16:02:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Aug 2019 16:02:01 +0000 (GMT)
Date:   Wed, 21 Aug 2019 19:01:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: consolidate pgtable_cache_init() and pgd_cache_init()
References: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
 <20190821154942.js4u466rolnekwmq@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821154942.js4u466rolnekwmq@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082116-0016-0000-0000-000002A129E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082116-0017-0000-0000-000033015F04
Message-Id: <20190821160159.GG26713@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:49:42PM +0100, Will Deacon wrote:
> On Wed, Aug 21, 2019 at 06:06:58PM +0300, Mike Rapoport wrote:
> > Both pgtable_cache_init() and pgd_cache_init() are used to initialize kmem
> > cache for page table allocations on several architectures that do not use
> > PAGE_SIZE tables for one or more levels of the page table hierarchy.
> > 
> > Most architectures do not implement these functions and use __week default
> > NOP implementation of pgd_cache_init(). Since there is no such default for
> > pgtable_cache_init(), its empty stub is duplicated among most
> > architectures.
> > 
> > Rename the definitions of pgd_cache_init() to pgtable_cache_init() and drop
> > empty stubs of pgtable_cache_init().
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> 
> [...]
> 
> > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> > index 7548f9c..4a64089 100644
> > --- a/arch/arm64/mm/pgd.c
> > +++ b/arch/arm64/mm/pgd.c
> > @@ -35,7 +35,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> >  		kmem_cache_free(pgd_cache, pgd);
> >  }
> >  
> > -void __init pgd_cache_init(void)
> > +void __init pgtable_cache_init(void)
> >  {
> >  	if (PGD_SIZE == PAGE_SIZE)
> >  		return;
> 
> [...]
> 
> > diff --git a/init/main.c b/init/main.c
> > index b90cb5f..2fa8038 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -507,7 +507,7 @@ void __init __weak mem_encrypt_init(void) { }
> >  
> >  void __init __weak poking_init(void) { }
> >  
> > -void __init __weak pgd_cache_init(void) { }
> > +void __init __weak pgtable_cache_init(void) { }
> >  
> >  bool initcall_debug;
> >  core_param(initcall_debug, initcall_debug, bool, 0644);
> > @@ -565,7 +565,6 @@ static void __init mm_init(void)
> >  	init_espfix_bsp();
> >  	/* Should be run after espfix64 is set up. */
> >  	pti_init();
> > -	pgd_cache_init();
> >  }
> 
> AFAICT, this change means we now initialise our pgd cache before
> debug_objects_mem_init() has run.

Right.

> Is that going to cause fireworks with CONFIG_DEBUG_OBJECTS when we later
> free a pgd?

We don't allocate a pgd at that time, we only create the kmem cache for the
future allocations. And that cache is never destroyed anyway.

> Will

-- 
Sincerely yours,
Mike.

