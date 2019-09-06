Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E4AC28D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405044AbfIFWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 18:31:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10247 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfIFWbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:31:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d72de540000>; Fri, 06 Sep 2019 15:31:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Sep 2019 15:31:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Sep 2019 15:31:45 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Sep
 2019 22:31:44 +0000
Subject: Re: [PATCH] mm, notifier: Fix early return case for new lockdep
 annotations
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
CC:     DRI Development <dri-devel@lists.freedesktop.org>,
        <syzbot+aaedc50d99a03250fe1f@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <linux-mm@kvack.org>
References: <20190906174730.22462-1-daniel.vetter@ffwll.ch>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e076dad4-a5f0-d9cc-7611-4892985f95f2@nvidia.com>
Date:   Fri, 6 Sep 2019 15:31:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906174730.22462-1-daniel.vetter@ffwll.ch>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567809108; bh=HMZ0qlWEBQ226w28k44JWwaPPo4f1iFeti/9oDWU1G0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cKiY0E1yN7X0N9uQOvluxNcsXjklOOdWSsKNEQJzFwvVuOhhwiSp2iMiyAEyIJOmD
         BbNOqTrKkB+K/AMpJHdkNp6An2OKlfdVg57QX431Su/mfYlRFTMKGe34TSl+VLUxLf
         kXrpfkAZYbhFfBQpBAzM2YwRvhLxtIciId7pvonZQD1rEbZ4MgX8f0mE3iE8er4MTx
         NgCtHIENpw+87hfnh6ykdRYIc2YLZ5sohIGN5OK4F3vZmkem5XZ0hsqqs3PBY5bSKJ
         GYgctkGF6W3oKq4urLWEVnKHa3sBLQElqnm9gZ2ZM4T5SiA4M9xvEpPNeqG/LdlSi6
         Pf19VtL3+4R7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 10:47 AM, Daniel Vetter wrote:
> I missed that when extending the lockdep annotations to the
> nonblocking case.
>=20
> I missed this while testing since in the i915 mmu notifiers is hitting
> a nice lockdep splat already before the point of going into oom killer
> mode :-/
>=20
> Reported-by: syzbot+aaedc50d99a03250fe1f@syzkaller.appspotmail.com
> Fixes: d2b219ed03d4 ("mm/mmu_notifiers: add a lockdep map for invalidate_=
range_start/end")
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  include/linux/mmu_notifier.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 5a03417e5bf7..4edd98b06834 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -356,13 +356,14 @@ mmu_notifier_invalidate_range_start(struct mmu_noti=
fier_range *range)
>  static inline int
>  mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *=
range)
>  {
> +	int ret =3D 0;
>  	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>  	if (mm_has_notifiers(range->mm)) {
>  		range->flags &=3D ~MMU_NOTIFIER_RANGE_BLOCKABLE;
> -		return __mmu_notifier_invalidate_range_start(range);
> +		ret =3D __mmu_notifier_invalidate_range_start(range);
>  	}
>  	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> -	return 0;
> +	return ret;
>  }
> =20
>  static inline void
>=20

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
--=20
John Hubbard
NVIDIA
