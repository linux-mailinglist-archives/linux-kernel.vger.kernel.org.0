Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E086F720
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 04:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfGVCZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 22:25:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10336 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfGVCZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:25:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d351e9a0000>; Sun, 21 Jul 2019 19:25:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jul 2019 19:25:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jul 2019 19:25:32 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jul
 2019 02:25:32 +0000
Subject: Re: [PATCH 1/3] sgi-gru: Convert put_page() to get_user_page*()
To:     Bharath Vedartham <linux.bhar@gmail.com>, <arnd@arndb.de>,
        <sivanich@sgi.com>, <gregkh@linuxfoundation.org>
CC:     <ira.weiny@intel.com>, <jglisse@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-2-git-send-email-linux.bhar@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <dae42533-7e71-0e41-54a2-58c459761b3e@nvidia.com>
Date:   Sun, 21 Jul 2019 19:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563724685-6540-2-git-send-email-linux.bhar@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563762330; bh=R+oEYBF12a6qSQ/9qA6zFvvWBnLycevyTeAHjJjA370=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JHghyeeNy7gglOmX4/lc88T4YXMiAPg22iQHB0njPY7a7oWFps2m5biGSz5kP6cCF
         Ufqr2MonNAXr6SGE028w8ITLYllg7Er5pY+TgaxitwJPzOgyqrKAbLZXBImYS2wvpc
         3ZyZNjzU2/Io9qo1MXpKAwJQ6f5dDhmGnATrMrtWcItBZZcr549FB3juPENbqzw6YR
         dz/gpLTZyf+Uq8QsyKJ4TOxWf8Tp/l8PoBuzAG6T8ABkteNXIawlPDjANTjYqvPpOG
         +W/U33sGNuNk6F05nmXlv8k6Iwm1GeTEuI+xy3J2DhU+jckRN/Cn5VKbH9PALK8RbH
         qdFlvyFC1E35A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/19 8:58 AM, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page().
>=20
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
>=20
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA

> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufa=
ult.c
> index 4b713a8..61b3447 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struc=
t *vma,
>  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <=3D =
0)
>  		return -EFAULT;
>  	*paddr =3D page_to_phys(page);
> -	put_page(page);
> +	put_user_page(page);
>  	return 0;
>  }
> =20
>=20
