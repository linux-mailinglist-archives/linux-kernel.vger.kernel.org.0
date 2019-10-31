Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D89EB2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfJaOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34631 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727841AbfJaOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ly7khlQOPRzxwzMex/xrth00jOw8cCok4ftXBhGNR4s=;
        b=LMPP2KwilwQLHGTJgniMEpayIwEcXGyVWF6sLmsFhD0sDlv82lmjo10gMx1PEwdevwqQ9g
        1broc3hmVr82S07uVwNi6WEwuvP1OYk6SyIVjUTfTzBL+hYsjSyGvxfsdxGR/wLDGHnmyp
        M5pAFQIZP02w6Vk2YAWEKMfCt3VRx+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-sWD2HUOGPGmD_WFTWMZijA-1; Thu, 31 Oct 2019 10:35:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB2722EDC;
        Thu, 31 Oct 2019 14:35:18 +0000 (UTC)
Received: from [10.36.118.44] (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7407660876;
        Thu, 31 Oct 2019 14:35:14 +0000 (UTC)
Subject: Re: [PATCH v1 08/12] powerpc/pseries: CMM: Implement balloon
 compaction
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Arun KS <arunks@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>,
        Gao Xiang <xiang@kernel.org>,
        Greg Hackmann <ghackmann@google.com>,
        David Howells <dhowells@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
 <20191031142933.10779-9-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <be7c1424-f240-b72c-8d6d-310ebbd816e1@redhat.com>
Date:   Thu, 31 Oct 2019 15:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031142933.10779-9-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sWD2HUOGPGmD_WFTWMZijA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.19 15:29, David Hildenbrand wrote:
> We can now get rid of the cmm_lock and completely rely on the balloon
> compaction internals, which now also manage the page list and the lock.
>=20
> Inflated/"loaned" pages are now movable. Memory blocks that contain
> such apges can get offlined. Also, all such pages will be marked
> PageOffline() and can therefore be excluded in memory dumps using recent
> versions of makedumpfile.
>=20
> Don't switch to balloon_page_alloc() yet (due to the GFP_NOIO). Will
> do that separately to discuss this change in detail.
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Gao Xiang <xiang@kernel.org>
> Cc: Greg Hackmann <ghackmann@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/powerpc/platforms/pseries/Kconfig |   1 +
>   arch/powerpc/platforms/pseries/cmm.c   | 132 ++++++++++++++++++++++---
>   include/uapi/linux/magic.h             |   1 +
>   3 files changed, 120 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 9e35cddddf73..595e9f8a6539 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -108,6 +108,7 @@ config PPC_SMLPAR
>   config CMM
>   =09tristate "Collaborative memory management"
>   =09depends on PPC_SMLPAR
> +=09select MEMORY_BALLOON
>   =09default y
>   =09help
>   =09  Select this option, if you want to enable the kernel interface
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platform=
s/pseries/cmm.c
> index 3a55dd1fdd39..235fd7fe9df1 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -19,6 +19,10 @@
>   #include <linux/stringify.h>
>   #include <linux/swap.h>
>   #include <linux/device.h>
> +#include <linux/mount.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/magic.h>
> +#include <linux/balloon_compaction.h>
>   #include <asm/firmware.h>
>   #include <asm/hvcall.h>
>   #include <asm/mmu.h>
> @@ -77,13 +81,11 @@ static atomic_long_t loaned_pages;
>   static unsigned long loaned_pages_target;
>   static unsigned long oom_freed_pages;
>  =20
> -static LIST_HEAD(cmm_page_list);
> -static DEFINE_SPINLOCK(cmm_lock);
> -
>   static DEFINE_MUTEX(hotplug_mutex);
>   static int hotplug_occurred; /* protected by the hotplug mutex */
>  =20
>   static struct task_struct *cmm_thread_ptr;
> +static struct balloon_dev_info b_dev_info;
>  =20
>   static long plpar_page_set_loaned(struct page *page)
>   {
> @@ -149,19 +151,16 @@ static long cmm_alloc_pages(long nr)
>   =09=09=09=09  __GFP_NOMEMALLOC);
>   =09=09if (!page)
>   =09=09=09break;
> -=09=09spin_lock(&cmm_lock);
>   =09=09rc =3D plpar_page_set_loaned(page);
>   =09=09if (rc) {
>   =09=09=09pr_err("%s: Can not set page to loaned. rc=3D%ld\n", __func__,=
 rc);
> -=09=09=09spin_unlock(&cmm_lock);
>   =09=09=09__free_page(page);
>   =09=09=09break;
>   =09=09}
>  =20
> -=09=09list_add(&page->lru, &cmm_page_list);
> +=09=09balloon_page_enqueue(&b_dev_info, page);
>   =09=09atomic_long_inc(&loaned_pages);
>   =09=09adjust_managed_page_count(page, -1);
> -=09=09spin_unlock(&cmm_lock);
>   =09=09nr--;
>   =09}
>  =20
> @@ -178,21 +177,19 @@ static long cmm_alloc_pages(long nr)
>    **/
>   static long cmm_free_pages(long nr)
>   {
> -=09struct page *page, *tmp;
> +=09struct page *page;
>  =20
>   =09cmm_dbg("Begin free of %ld pages.\n", nr);
> -=09spin_lock(&cmm_lock);
> -=09list_for_each_entry_safe(page, tmp, &cmm_page_list, lru) {
> -=09=09if (!nr)
> +=09while (nr) {
> +=09=09page =3D balloon_page_dequeue(&b_dev_info);
> +=09=09if (!page)
>   =09=09=09break;
>   =09=09plpar_page_set_active(page);
> -=09=09list_del(&page->lru);
>   =09=09adjust_managed_page_count(page, 1);
>   =09=09__free_page(page);
>   =09=09atomic_long_dec(&loaned_pages);
>   =09=09nr--;
>   =09}
> -=09spin_unlock(&cmm_lock);
>   =09cmm_dbg("End request with %ld pages unfulfilled\n", nr);
>   =09return nr;
>   }
> @@ -484,6 +481,105 @@ static struct notifier_block cmm_mem_nb =3D {
>   =09.priority =3D CMM_MEM_HOTPLUG_PRI
>   };
>  =20
> +#ifdef CONFIG_BALLOON_COMPACTION
> +static struct vfsmount *balloon_mnt;
> +
> +static int cmm_init_fs_context(struct fs_context *fc)
> +{
> +=09return init_pseudo(fc, PPC_CMM_MAGIC) ? 0 : -ENOMEM;
> +}
> +
> +static struct file_system_type balloon_fs =3D {
> +=09.name =3D "ppc-cmm",
> +=09.init_fs_context =3D cmm_init_fs_context,
> +=09.kill_sb =3D kill_anon_super,
> +};
> +
> +static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
> +=09=09=09   struct page *newpage, struct page *page,
> +=09=09=09   enum migrate_mode mode)
> +{
> +=09unsigned long flags;
> +
> +=09/*
> +=09 * loan/"inflate" the newpage first.
> +=09 *
> +=09 * We might race against the cmm_thread who might discover after our
> +=09 * loan request that another page is to be unloaned. However, once
> +=09 * the cmm_thread runs again later, this error will automatically
> +=09 * be corrected.
> +=09 */
> +=09if (plpar_page_set_loaned(newpage)) {
> +=09=09/* Unlikely, but possible. Tell the caller not to retry now. */
> +=09=09pr_err_ratelimited("%s: Cannot set page to loaned.", __func__);
> +=09=09return -EBUSY;
> +=09}
> +
> +=09/* balloon page list reference */
> +=09get_page(newpage);
> +
> +=09spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +=09balloon_page_insert(b_dev_info, newpage);
> +=09balloon_page_delete(page);

I think I am missing a b_dev_info->isolated_pages-- here.

> +=09spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);


--=20

Thanks,

David / dhildenb

