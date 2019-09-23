Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E808BBCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 22:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502584AbfIWU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 16:26:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2785 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387796AbfIWU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:26:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d892a8f0000>; Mon, 23 Sep 2019 13:26:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2019 13:26:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 23 Sep 2019 13:26:49 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Sep
 2019 20:26:49 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Sep
 2019 20:26:48 +0000
Subject: Re: [PATCH v2 11/11] powerpc/mm/book3s64/pgtable: Uses counting
 method to skip serializing
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        "Richard Fontana" <rfontana@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Allison Randal" <allison@lohutok.net>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
 <20190920195047.7703-12-leonardo@linux.ibm.com>
 <1b39eaa7-751d-40bc-d3d7-41aaa15be42a@nvidia.com>
 <24863d8904c6e05e5dd48cab57db4274675ae654.camel@linux.ibm.com>
 <4ea26ffb-ad03-bdff-7893-95332b22a5fd@nvidia.com>
 <18c5c378db98f223a0663034baa9fd6ce42f1ec7.camel@linux.ibm.com>
 <8706a1f1-0c5e-d152-938b-f355b9a5aaa8@nvidia.com>
 <dc9fad3577551d34ead36c0f7340a573086c0cab.camel@linux.ibm.com>
 <1568b3ef-cec9-bf47-edaa-c775c2f544fb@nvidia.com>
 <c64d34118542d5c2d31b8f6b7802d2a29dac71ef.camel@linux.ibm.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b72cb1db-c341-4963-1a8b-ae71fe936458@nvidia.com>
Date:   Mon, 23 Sep 2019 13:26:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c64d34118542d5c2d31b8f6b7802d2a29dac71ef.camel@linux.ibm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569270415; bh=UcV4RD8PsGQCI3ECb3gttt6xlL6KcQV1be+lYQ3oGQI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YAC7bHogRtgPIDCGrAn3YjCzVWsG5mEgDTDxy0IU3+mLwhkIoPNwCzaPmkkGtXzRh
         weRUFOOJlmEy9Sz/dY9f8f5cKPG1i70XQiy0zvGnTY5jMbye/VHXDpEJR1T4o9OGfB
         o5WA9AES+CeS38or7OUyrSaC45pGe6tGv65N4z6JbSKira2HQY3Jd2VySTKp5W9J/A
         CALJkz1Yl/xD5KTzh+NhlrunFa876dbixft662iNenv3iHTZjqNQKPesiqAn+5QdIw
         VlJgjCTT0PkI3TlMJExnI6O/TNKmCor4h/aJX5/1Aec/7io6PzXmjPa3eI64+ugo81
         M/LHDE08SxMkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 1:23 PM, Leonardo Bras wrote:
> On Mon, 2019-09-23 at 12:58 -0700, John Hubbard wrote:
>>
>> CPU 0                            CPU 1
>> ------                         --------------
>>                                READ(pte) (re-ordered at run time)
>>                                atomic_inc(val) (no run-time memory barrier!)
>>                            
>> pmd_clear(pte)
>> if (val)
>>     run_on_all_cpus(): IPI
>>                                local_irq_disable() (also not a mem barrier)
>>
>>                                if(pte)
>>                                   walk page tables
> 
> Let me see if I can understand,
> On most patches, it would be:
> 
> CPU 0                            CPU 1
> ------				--------------
> 				ptep = __find_linux_pte  
> 				(re-ordered at run time)
> 				atomic_inc(val) 
> pmd_clear(pte)
> smp_mb()
> if (val)
>     run_on_all_cpus(): IPI
>                                local_irq_disable() 
> 
>                                if(ptep)
>                                   pte = *ptep;
> 
> Is that what you meant?
> 
> 

Yes.

thanks,
-- 
John Hubbard
NVIDIA
