Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4568DDC7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410361AbfJROsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 10:48:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40059 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729257AbfJROsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571410090;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xUWPDHliBoxc0ihU+NKk1qsJN/0TLVezwKKP1i/PSI=;
        b=XwpQPnbEtf3ilv0j2DNlwQK8EFvVQtAmfdUbFyWITxKJzAlt6WDJJ5DK3Mh+GJhHnqeNl8
        ctHBNLbTlue3YmQsVkCbjKJoxejEipUHQgvdqmnDn+ehNYEsVjIVmkESoyzf9B/tPvP8Zo
        pJlY5gNZJEZSOKrieCBg6IYfjUOWKTs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-pZzxmlt4NnSyyMPj27bJ8Q-1; Fri, 18 Oct 2019 10:48:08 -0400
Received: by mail-il1-f198.google.com with SMTP id o12so1952643ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0SSL2373lC6DgsMmmsDZmA6zvnlA8UickiHBAjdntOQ=;
        b=ey3eyzN49kIlI7JR7WANDY++5cjnuTPx9baaz1wpUMoJD4nYoL+eXBnooM6XA+m08I
         Fha2tTmUGBj07GSYGxMRi6xUWRAXm9CLq5+Bc418bAU1dq8/ysRJBgkc3c7t+57GSxu+
         RHtvtLkAXQg88SfP2sVN2cCPGMjFI8TZw4llxCZs48wTqMfvWUlfVrN4hgtqjkizrW66
         +6xNv1P/W7b4FmnwtyiQbQOVRluxuoAp881vjS1hXtN7PjFOscdRmQgcoFj6ZBTYYtoI
         iwX59yW3wyVMUtADUKNx3CDJYuDTnJyVaD9eq0aZt6hYaZe+0FTb2JpD+ZRpihJeRmiu
         bwiA==
X-Gm-Message-State: APjAAAU8Lpwd4vbsawhagK09j4WOsJgX5MEdolhpBp9uof+JK2y44Zmd
        1UU7izBE7gMi8WNkgp+7UMAhcphTNBeXwyIqzUn8OJJXh5VooTf4fQTI10gwFY7QtfqKGVITx3A
        DqVVr3V6A+Sg7T+NhNeKOMsbv
X-Received: by 2002:a92:c2:: with SMTP id 185mr10527385ila.92.1571410088307;
        Fri, 18 Oct 2019 07:48:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWbRwj/fjTBeTuKTGQTT7Fu5ra8qoDURv6eP3usXETnKzvD8vxqCt0UkKoNoyNlAsUsHb8gQ==
X-Received: by 2002:a92:c2:: with SMTP id 185mr10527353ila.92.1571410088007;
        Fri, 18 Oct 2019 07:48:08 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l3sm1778016ioj.7.2019.10.18.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:48:07 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:48:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Qian Cai <cai@lca.pw>, don.brace@microsemi.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, esc.storagedev@microsemi.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Check PM_LEVEL_SIZE() condition in locked
 section
Message-ID: <20191018144805.ici3ewsvonlgketl@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        don.brace@microsemi.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <20191016225859.j3jq6pt73mn56chn@cantor>
 <577A2A6B-3012-4CDE-BE57-3E0D628572CB@lca.pw>
 <20191018093830.GA26328@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191018093830.GA26328@suse.de>
User-Agent: NeoMutt/20180716
X-MC-Unique: pZzxmlt4NnSyyMPj27bJ8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 18 19, Joerg Roedel wrote:
>On Thu, Oct 17, 2019 at 07:36:51AM -0400, Qian Cai wrote:
>>
>>
>> > On Oct 16, 2019, at 6:59 PM, Jerry Snitselaar <jsnitsel@redhat.com> wr=
ote:
>> >
>> > I guess the mode level 6 check is really for other potential callers
>> > increase_address_space, none exist at the moment, and the condition
>> > of the while loop in alloc_pte should fail if the mode level is 6.
>>
>> Because there is no locking around iommu_map_page(), if there are
>> several concurrent callers of it for the same domain, could it be that
>> it silently corrupt data due to invalid access?
>
>No, that can't happen because increase_address_space locks the domain
>before actually doing anything. So the address space can't grow above
>domain->mode =3D=3D 6. But what can happen is that the WARN_ON_ONCE trigge=
rs
>in there and that the address space is increased multiple times when
>only one increase would be sufficient.
>
>To fix this we just need to check the PM_LEVEL_SIZE() condition again
>when we hold the lock:
>
>From e930e792a998e89dfd4feef15fbbf289c45124dc Mon Sep 17 00:00:00 2001
>From: Joerg Roedel <jroedel@suse.de>
>Date: Fri, 18 Oct 2019 11:34:22 +0200
>Subject: [PATCH] iommu/amd: Check PM_LEVEL_SIZE() condition in locked sect=
ion
>
>The increase_address_space() function has to check the PM_LEVEL_SIZE()
>condition again under the domain->lock to avoid a false trigger of the
>WARN_ON_ONCE() and to avoid that the address space is increase more
>often than necessary.
>
>Reported-by: Qian Cai <cai@lca.pw>
>Fixes: 754265bcab78 ("iommu/amd: Fix race in increase_address_space()")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..a0639e511ffe 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -1463,6 +1463,7 @@ static void free_pagetable(struct protection_domain =
*domain)
>  * to 64 bits.
>  */
> static bool increase_address_space(struct protection_domain *domain,
>+=09=09=09=09   unsigned long address,
> =09=09=09=09   gfp_t gfp)
> {
> =09unsigned long flags;
>@@ -1471,8 +1472,8 @@ static bool increase_address_space(struct protection=
_domain *domain,
>
> =09spin_lock_irqsave(&domain->lock, flags);
>
>-=09if (WARN_ON_ONCE(domain->mode =3D=3D PAGE_MODE_6_LEVEL))
>-=09=09/* address space already 64 bit large */
>+=09if (address <=3D PM_LEVEL_SIZE(domain->mode) ||
>+=09    WARN_ON_ONCE(domain->mode =3D=3D PAGE_MODE_6_LEVEL))
> =09=09goto out;
>
> =09pte =3D (void *)get_zeroed_page(gfp);
>@@ -1505,7 +1506,7 @@ static u64 *alloc_pte(struct protection_domain *doma=
in,
> =09BUG_ON(!is_power_of_2(page_size));
>
> =09while (address > PM_LEVEL_SIZE(domain->mode))
>-=09=09*updated =3D increase_address_space(domain, gfp) || *updated;
>+=09=09*updated =3D increase_address_space(domain, address, gfp) || *updat=
ed;
>
> =09level   =3D domain->mode - 1;
> =09pte     =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
>--=20
>2.16.4
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

