Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C578F470
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfHOTXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 15:23:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8753 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfHOTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:23:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d55b1430000>; Thu, 15 Aug 2019 12:23:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 15 Aug 2019 12:23:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 15 Aug 2019 12:23:45 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Aug
 2019 19:23:44 +0000
Subject: Re: [PATCHv2] mm/migrate: clean up useless code in
 migrate_vma_collect_pmd()
To:     Jerome Glisse <jglisse@redhat.com>,
        Pingfan Liu <kernelfans@gmail.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190807052858.GA9749@mypc>
 <1565167272-21453-1-git-send-email-kernelfans@gmail.com>
 <20190815171918.GC30916@redhat.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <d0a8ab6e-1122-a101-6139-9d7dadb9e999@nvidia.com>
Date:   Thu, 15 Aug 2019 12:23:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815171918.GC30916@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565897027; bh=vkjRswpUjtZfCjVU2R9I+hlvzvOMVMgQk4AI8p27uwY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=P+RSFj2MK6qwETLKT3U+Kgh8Zs/QjjEaL0NaxpNb2FGAew8lBC7SrZjoYTNsxIUBC
         sRqNyCTBmnUsDzC54aJbweOncfryqggz82LyC5JFGjngwplsubbikkOzZ6adhvbyfm
         NTC5la+MqrS4VXQRgugtcuB7+IFTLxd5VIbuak6jhvOI9uPTRM+jRB7FepjPo2S25t
         gfWzV2WehEd1RnVieZvPRERjdwuq1jhfHZ8cJftn4CDkCLF8s+Lp8Q7f+n4shOekD/
         3AnIjoPlvxEWtSGAzchogN8DcBDpOrFqqJHROWMLYQQ3oW3aoKWxRyCq9hqP+rhLpm
         s/RnpwxqsXG6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/19 10:19 AM, Jerome Glisse wrote:
> On Wed, Aug 07, 2019 at 04:41:12PM +0800, Pingfan Liu wrote:
>> Clean up useless 'pfn' variable.
>=20
> NAK there is a bug see below:
>=20
>>
>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> To: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   mm/migrate.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 8992741..d483a55 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2225,17 +2225,15 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>   		pte_t pte;
>>  =20
>>   		pte =3D *ptep;
>> -		pfn =3D pte_pfn(pte);
>>  =20
>>   		if (pte_none(pte)) {
>>   			mpfn =3D MIGRATE_PFN_MIGRATE;
>>   			migrate->cpages++;
>> -			pfn =3D 0;
>>   			goto next;
>>   		}
>>  =20
>>   		if (!pte_present(pte)) {
>> -			mpfn =3D pfn =3D 0;
>> +			mpfn =3D 0;
>>  =20
>>   			/*
>>   			 * Only care about unaddressable device page special
>> @@ -2252,10 +2250,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>   			if (is_write_device_private_entry(entry))
>>   				mpfn |=3D MIGRATE_PFN_WRITE;
>>   		} else {
>> +			pfn =3D pte_pfn(pte);
>>   			if (is_zero_pfn(pfn)) {
>>   				mpfn =3D MIGRATE_PFN_MIGRATE;
>>   				migrate->cpages++;
>> -				pfn =3D 0;
>>   				goto next;
>>   			}
>>   			page =3D vm_normal_page(migrate->vma, addr, pte);
>> @@ -2265,10 +2263,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>  =20
>>   		/* FIXME support THP */
>>   		if (!page || !page->mapping || PageTransCompound(page)) {
>> -			mpfn =3D pfn =3D 0;
>> +			mpfn =3D 0;
>>   			goto next;
>>   		}
>> -		pfn =3D page_to_pfn(page);
>=20
> You can not remove that one ! Otherwise it will break the device
> private case.
>=20

I don't understand. The only use of "pfn" I see is in the "else"
clause above where it is set just before using it.
