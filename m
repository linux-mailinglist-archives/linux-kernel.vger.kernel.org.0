Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22312F45B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfKHLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:30:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727591AbfKHLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573212644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TXAidM7cQyun2sKAe+IfCYkeyFZgA7wy+fzvFWONM4=;
        b=XFwvW3vOCIfA6ryoWSX7WpD7PFaGz/6NYkGNQe00VtS5eoil4EBGQJwmcnVFcFfth9HYdB
        vksLsYfcxeXiNr6qB22soey1kiZvYPkFhb8XJ6aIroLlRuYcfxGZxoUf34cYonagqNA3pl
        ZuaRWYFsZNLyhkVGG1yJ4RuSBRc8CV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-KuEhJzJtM1q8l2yDl9Laiw-1; Fri, 08 Nov 2019 06:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 486DD477;
        Fri,  8 Nov 2019 11:30:39 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7314608B3;
        Fri,  8 Nov 2019 11:30:32 +0000 (UTC)
Subject: Re: [PATCH v7 04/11] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <b69e22f9-a0cf-51e2-6840-44ac523e9e28@redhat.com>
Date:   Fri, 8 Nov 2019 12:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KuEhJzJtM1q8l2yDl9Laiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:54 PM, Jacob Pan wrote:
> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 12 ++++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 39 +++++++++++++++++++++++----------------
>  3 files changed, 29 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ced1d89ef977..2ea09b988a23 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5311,7 +5311,7 @@ static void auxiliary_unlink_device(struct dmar_dom=
ain *domain,
>  =09domain->auxd_refcnt--;
> =20
>  =09if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -=09=09intel_pasid_free_id(domain->default_pasid);
> +=09=09ioasid_free(domain->default_pasid);
>  }
> =20
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5329,10 +5329,10 @@ static int aux_domain_add_dev(struct dmar_domain =
*domain,
>  =09if (domain->default_pasid <=3D 0) {
>  =09=09int pasid;
> =20
> -=09=09pasid =3D intel_pasid_alloc_id(domain, PASID_MIN,
> -=09=09=09=09=09     pci_max_pasids(to_pci_dev(dev)),
> -=09=09=09=09=09     GFP_KERNEL);
> -=09=09if (pasid <=3D 0) {
> +=09=09/* No private data needed for the default pasid */
> +=09=09pasid =3D ioasid_alloc(NULL, PASID_MIN, pci_max_pasids(to_pci_dev(=
dev)) - 1,
> +=09=09=09=09NULL);
> +=09=09if (pasid =3D=3D INVALID_IOASID) {
>  =09=09=09pr_err("Can't allocate default pasid\n");
>  =09=09=09return -ENODEV;
>  =09=09}
> @@ -5368,7 +5368,7 @@ static int aux_domain_add_dev(struct dmar_domain *d=
omain,
>  =09spin_unlock(&iommu->lock);
>  =09spin_unlock_irqrestore(&device_domain_lock, flags);
>  =09if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -=09=09intel_pasid_free_id(domain->default_pasid);
> +=09=09ioasid_free(domain->default_pasid);
> =20
>  =09return ret;
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index d81e857d2b25..e79d680fe300 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -26,42 +26,6 @@
>   */
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id =3D PASID_MAX;
> -static DEFINE_IDR(pasid_idr);
> -
> -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> -{
> -=09int ret, min, max;
> -
> -=09min =3D max_t(int, start, PASID_MIN);
> -=09max =3D min_t(int, end, intel_pasid_max_id);
> -
> -=09WARN_ON(in_interrupt());
> -=09idr_preload(gfp);
> -=09spin_lock(&pasid_lock);
> -=09ret =3D idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> -=09spin_unlock(&pasid_lock);
> -=09idr_preload_end();
> -
> -=09return ret;
> -}
> -
> -void intel_pasid_free_id(int pasid)
> -{
> -=09spin_lock(&pasid_lock);
> -=09idr_remove(&pasid_idr, pasid);
> -=09spin_unlock(&pasid_lock);
> -}
> -
> -void *intel_pasid_lookup_id(int pasid)
> -{
> -=09void *p;
> -
> -=09spin_lock(&pasid_lock);
> -=09p =3D idr_find(&pasid_idr, pasid);
> -=09spin_unlock(&pasid_lock);
> -
> -=09return p;
> -}
> =20
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
>  {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 9b159132405d..a9a7f85a09bc 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -17,6 +17,7 @@
>  #include <linux/dmar.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm_types.h>
> +#include <linux/ioasid.h>
>  #include <asm/page.h>
> =20
>  #include "intel-pasid.h"
> @@ -318,16 +319,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasi=
d, int flags, struct svm_dev_
>  =09=09if (pasid_max > intel_pasid_max_id)
>  =09=09=09pasid_max =3D intel_pasid_max_id;
> =20
> -=09=09/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
> -=09=09ret =3D intel_pasid_alloc_id(svm,
> -=09=09=09=09=09   !!cap_caching_mode(iommu->cap),
> -=09=09=09=09=09   pasid_max - 1, GFP_KERNEL);
> -=09=09if (ret < 0) {
> +=09=09/* Do not use PASID 0, reserved for RID to PASID */
> +=09=09svm->pasid =3D ioasid_alloc(NULL, PASID_MIN,
> +=09=09=09=09=09pasid_max - 1, svm);
pasid_max -1 is inclusive. whereas max param in intel_pasid_alloc_id()
is exclusive right? If you fixed an issue, you can mention it in the
commit message.
> +=09=09if (svm->pasid =3D=3D INVALID_IOASID) {
>  =09=09=09kfree(svm);>  =09=09=09kfree(sdev);
> +=09=09=09ret =3D ENOSPC;
-ENOSPC.
Nit: in 2/11 vcmd_alloc_pasid returned -ENOMEM
>  =09=09=09goto out;
>  =09=09}
> -=09=09svm->pasid =3D ret;
>  =09=09svm->notifier.ops =3D &intel_mmuops;
>  =09=09svm->mm =3D mm;
>  =09=09svm->flags =3D flags;
> @@ -337,7 +337,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid,=
 int flags, struct svm_dev_
>  =09=09if (mm) {
>  =09=09=09ret =3D mmu_notifier_register(&svm->notifier, mm);
>  =09=09=09if (ret) {
> -=09=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09=09ioasid_free(svm->pasid);
>  =09=09=09=09kfree(svm);
>  =09=09=09=09kfree(sdev);
>  =09=09=09=09goto out;
> @@ -353,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid,=
 int flags, struct svm_dev_
>  =09=09if (ret) {
>  =09=09=09if (mm)
>  =09=09=09=09mmu_notifier_unregister(&svm->notifier, mm);
> -=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09ioasid_free(svm->pasid);
>  =09=09=09kfree(svm);
>  =09=09=09kfree(sdev);
>  =09=09=09goto out;
> @@ -401,7 +401,12 @@ int intel_svm_unbind_mm(struct device *dev, int pasi=
d)
>  =09if (!iommu)
>  =09=09goto out;
> =20
> -=09svm =3D intel_pasid_lookup_id(pasid);
> +=09svm =3D ioasid_find(NULL, pasid, NULL);
> +=09if (IS_ERR(svm)) {
> +=09=09ret =3D PTR_ERR(svm);
> +=09=09goto out;
> +=09}
> +
>  =09if (!svm)
>  =09=09goto out;
> =20
> @@ -423,7 +428,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid=
)
>  =09=09=09=09kfree_rcu(sdev, rcu);
> =20
>  =09=09=09=09if (list_empty(&svm->devs)) {
> -=09=09=09=09=09intel_pasid_free_id(svm->pasid);
> +=09=09=09=09=09/* Clear private data so that free pass check */> +=09=09=
=09=09=09ioasid_set_data(svm->pasid, NULL);
I don't get the above comment. Why is it needed?
> +=09=09=09=09=09ioasid_free(svm->pasid);
>  =09=09=09=09=09if (svm->mm)
>  =09=09=09=09=09=09mmu_notifier_unregister(&svm->notifier, svm->mm);
> =20
> @@ -458,10 +465,11 @@ int intel_svm_is_pasid_valid(struct device *dev, in=
t pasid)
>  =09if (!iommu)
>  =09=09goto out;
> =20
> -=09svm =3D intel_pasid_lookup_id(pasid);
> -=09if (!svm)
> +=09svm =3D ioasid_find(NULL, pasid, NULL);
> +=09if (IS_ERR(svm)) {
> +=09=09ret =3D PTR_ERR(svm);
>  =09=09goto out;
> -
> +=09}
>  =09/* init_mm is used in this case */
>  =09if (!svm->mm)
>  =09=09ret =3D 1;
> @@ -568,13 +576,12 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
> =20
>  =09=09if (!svm || svm->pasid !=3D req->pasid) {
>  =09=09=09rcu_read_lock();
> -=09=09=09svm =3D intel_pasid_lookup_id(req->pasid);
> +=09=09=09svm =3D ioasid_find(NULL, req->pasid, NULL);
>  =09=09=09/* It *can't* go away, because the driver is not permitted
>  =09=09=09 * to unbind the mm while any page faults are outstanding.
>  =09=09=09 * So we only need RCU to protect the internal idr code. */
>  =09=09=09rcu_read_unlock();
> -
> -=09=09=09if (!svm) {
> +=09=09=09if (IS_ERR(svm) || !svm) {
>  =09=09=09=09pr_err("%s: Page request for invalid PASID %d: %08llx %08llx=
\n",
>  =09=09=09=09       iommu->name, req->pasid, ((unsigned long long *)req)[=
0],
>  =09=09=09=09       ((unsigned long long *)req)[1]);
>=20
Thanks

Eric

