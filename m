Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE35B133D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfILRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 13:08:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18786 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbfILRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:08:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7a7b940001>; Thu, 12 Sep 2019 10:08:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Sep 2019 10:08:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Sep 2019 10:08:31 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Sep
 2019 17:08:31 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Sep
 2019 17:08:29 +0000
Subject: Re: [PATCH 2/4] mm/hmm: allow snapshot of the special zero page
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
 <20190911222829.28874-3-rcampbell@nvidia.com> <20190912082648.GB14368@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6b124c6d-0fac-2a34-0542-7516de939b9e@nvidia.com>
Date:   Thu, 12 Sep 2019 10:08:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912082648.GB14368@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568308116; bh=+GKH1AipM7oG/s2bgF7S7KajVnJGTKEgPflQKyI5DSM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NCPYwAbJfj+jlzLC4k7UA+8/QOE9h0v6qDvzE/V1RnbUxex1B9SEAY36Efl5u+3ZO
         zvZ51eidxCdXZ8HFCWMCw5hGNa/lMPoiNFy6j4+wo/LscvqWd28kSyWnS9/xCu5bu/
         jF21AcFwtWR6yW5/o4oHKOVT9hVbzCALReGwp4U0JeF9BnD5rGRF+bURQvnTnBf//7
         lCdky8a8sTXbWPLyS5Wjzz1rNTZXp6xGu/k+nvAHrd2GO1cvnh91cCbK3/0ajr8c/A
         tjaFNJZ2graB7u7BnkySgeqpV77zRY2GPSHJkizUsXRqwsDz5aOvedaOvDPbx2Grvp
         +ZGSkOgtPseUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/19 1:26 AM, Christoph Hellwig wrote:
> On Wed, Sep 11, 2019 at 03:28:27PM -0700, Ralph Campbell wrote:
>> Allow hmm_range_fault() to return success (0) when the CPU pagetable
>> entry points to the special shared zero page.
>> The caller can then handle the zero page by possibly clearing device
>> private memory instead of DMAing a zero page.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> ---
>>   mm/hmm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 06041d4399ff..7217912bef13 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -532,7 +532,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>>   			return -EBUSY;
>>   	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte=
)) {
>>   		*pfn =3D range->values[HMM_PFN_SPECIAL];
>> -		return -EFAULT;
>> +		return is_zero_pfn(pte_pfn(pte)) ? 0 : -EFAULT;
>=20
> Any chance to just use a normal if here:
>=20
> 		if (!is_zero_pfn(pte_pfn(pte)))
> 			return -EFAULT;
> 		return 0;
>=20

Sure, no problem.
