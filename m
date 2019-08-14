Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF128E11D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 01:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfHNXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 19:11:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9915 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbfHNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:11:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5495350002>; Wed, 14 Aug 2019 16:11:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 14 Aug 2019 16:11:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 14 Aug 2019 16:11:37 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 23:11:37 +0000
Subject: Re: [PATCHv2] mm/migrate: clean up useless code in
 migrate_vma_collect_pmd()
To:     Pingfan Liu <kernelfans@gmail.com>, <linux-mm@kvack.org>
CC:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <2b208666-17b5-0f67-d425-b622c97d688d@nvidia.com>
Date:   Wed, 14 Aug 2019 16:11:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565167272-21453-1-git-send-email-kernelfans@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565824309; bh=LcX0xyfGgOmYGuz4B5wFSysH8VJd6mYYunA+2mz8sgU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PuOPsYZxCuhIerZWsb+K72kRksCiGtJ5O9QpOhbSYMQcta4yA6K5YNmt4zeugCORH
         wNWR6Fq9nU/oYgrqSfLeV6ZeN1WC0alAKtxmIz8h/yfUO+0zElW0tklqCOA7FQn8GM
         WfAACqLYC86kZe/u5Z0CT5in2Hz8WIruFeafZdtmHhIROO7VvJCezPvjqGq5s2V+n/
         KxnKUHZkNZESHRTeI0TB8rFXVrRcb5ClxwfT9HQBddKn9LAIHz9bC2tKGrcOxq8lD2
         latqICSK2HTzPoKIAnRIG/XO/62ojbQFM7Ha8wD1LA8nWAduC3/olbbFbCWtRwHWOx
         rDH6jGjTlXvSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/19 1:41 AM, Pingfan Liu wrote:
> Clean up useless 'pfn' variable.
>=20
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   mm/migrate.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8992741..d483a55 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2225,17 +2225,15 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   		pte_t pte;
>  =20
>   		pte =3D *ptep;
> -		pfn =3D pte_pfn(pte);
>  =20
>   		if (pte_none(pte)) {
>   			mpfn =3D MIGRATE_PFN_MIGRATE;
>   			migrate->cpages++;
> -			pfn =3D 0;
>   			goto next;
>   		}
>  =20
>   		if (!pte_present(pte)) {
> -			mpfn =3D pfn =3D 0;
> +			mpfn =3D 0;
>  =20
>   			/*
>   			 * Only care about unaddressable device page special
> @@ -2252,10 +2250,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   			if (is_write_device_private_entry(entry))
>   				mpfn |=3D MIGRATE_PFN_WRITE;
>   		} else {
> +			pfn =3D pte_pfn(pte);
>   			if (is_zero_pfn(pfn)) {
>   				mpfn =3D MIGRATE_PFN_MIGRATE;
>   				migrate->cpages++;
> -				pfn =3D 0;
>   				goto next;
>   			}
>   			page =3D vm_normal_page(migrate->vma, addr, pte);
> @@ -2265,10 +2263,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  =20
>   		/* FIXME support THP */
>   		if (!page || !page->mapping || PageTransCompound(page)) {
> -			mpfn =3D pfn =3D 0;
> +			mpfn =3D 0;
>   			goto next;
>   		}
> -		pfn =3D page_to_pfn(page);
>  =20
>   		/*
>   		 * By getting a reference on the page we pin it and that blocks
>=20

Thanks, I was planning to do this too.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
