Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE92069F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 01:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfGOXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 19:34:29 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11791 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfGOXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:34:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2d0d8a0000>; Mon, 15 Jul 2019 16:34:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Jul 2019 16:34:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Jul 2019 16:34:28 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Jul
 2019 23:34:22 +0000
Subject: Re: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190709223556.28908-1-rcampbell@nvidia.com>
 <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
 <05fffcad-cf5e-8f0c-f0c7-6ffbd2b10c2e@nvidia.com>
 <20190715150031.49c2846f4617f30bca5f043f@linux-foundation.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0ee5166a-26cd-a504-b9db-cffd082ecd38@nvidia.com>
Date:   Mon, 15 Jul 2019 16:34:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715150031.49c2846f4617f30bca5f043f@linux-foundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563233674; bh=h+BRneuTpawGqNjEBZFefMsMDl5kO4JZEpBOUwB1zsI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OgRxe+A50xtVuH+HsQIV6/bprmeVGbsbaB9lBSbyHuzVUuWGvBTurzo+o5F6zORfN
         N/3R1l9mp4EACbf8HPX+47skIoVrJDcI2f30c9obXLSGBxMmch4ZlQ/RkpNmGq1uHq
         yd5NXiTOUdDT50Y2cxZQItGpRtiMe4zSUBt8EpplppDt7ZNEztv0cgDHU8YSludWXJ
         3oHds8mnWZb7IDJCV7pvnbquGQcWz/xxH8GZUVa0tLGarj4n8r/vjY4EoIjCUwVDhC
         JCTAhWe1S8S9/da9QISXzHS4rr+wJFRUhZ6iuuPD/J5SFnrQxE6TWtKYYX/EaP5S4H
         ZFOYnotJa/3zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/19 3:00 PM, Andrew Morton wrote:
> On Tue, 9 Jul 2019 18:24:57 -0700 Ralph Campbell <rcampbell@nvidia.com> w=
rote:
>=20
>>
>> On 7/9/19 5:28 PM, Andrew Morton wrote:
>>> On Tue, 9 Jul 2019 15:35:56 -0700 Ralph Campbell <rcampbell@nvidia.com>=
 wrote:
>>>
>>>> When migrating a ZONE device private page from device memory to system
>>>> memory, the subpage pointer is initialized from a swap pte which compu=
tes
>>>> an invalid page pointer. A kernel panic results such as:
>>>>
>>>> BUG: unable to handle page fault for address: ffffea1fffffffc8
>>>>
>>>> Initialize subpage correctly before calling page_remove_rmap().
>>>
>>> I think this is
>>>
>>> Fixes:  a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE=
 page in migration")
>>> Cc: stable
>>>
>>> yes?
>>>
>>
>> Yes. Can you add this or should I send a v2?
>=20
> I updated the patch.  Could we please have some review input?
>=20
>=20
> From: Ralph Campbell <rcampbell@nvidia.com>
> Subject: mm/hmm: fix bad subpage pointer in try_to_unmap_one
>=20
> When migrating a ZONE device private page from device memory to system
> memory, the subpage pointer is initialized from a swap pte which computes
> an invalid page pointer. A kernel panic results such as:
>=20
> BUG: unable to handle page fault for address: ffffea1fffffffc8
>=20
> Initialize subpage correctly before calling page_remove_rmap().
>=20
> Link: http://lkml.kernel.org/r/20190709223556.28908-1-rcampbell@nvidia.co=
m
> Fixes: a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE pa=
ge in migration")
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
>  mm/rmap.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- a/mm/rmap.c~mm-hmm-fix-bad-subpage-pointer-in-try_to_unmap_one
> +++ a/mm/rmap.c
> @@ -1476,6 +1476,7 @@ static bool try_to_unmap_one(struct page
>  			 * No need to invalidate here it will synchronize on
>  			 * against the special swap migration pte.
>  			 */
> +			subpage =3D page;
>  			goto discard;
>  		}
> =20

Hi Ralph and everyone,

While the above prevents a crash, I'm concerned that it is still not
an accurate fix. This fix leads to repeatedly removing the rmap, against th=
e
same struct page, which is odd, and also doesn't directly address the
root cause, which I understand to be: this routine can't handle migrating
the zero page properly--over and back, anyway. (We should also mention more=
=20
about how this is triggered, in the commit description.)

I'll take a closer look at possible fixes (I have to step out for a bit) so=
on,=20
but any more experienced help is also appreciated here.

thanks,
--=20
John Hubbard
NVIDIA
