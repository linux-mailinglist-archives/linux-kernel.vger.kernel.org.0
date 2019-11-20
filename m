Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50AC10457F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 22:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKTVHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 16:07:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbfKTVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574284058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MFDaxa6RF7dmt3Rxp0QolGSZ/pxc+3gpIsDqUic5QU=;
        b=QhNJaMMYjTtac/j3l59FK0UsPQpwv/SDbq90GmWR1QDSmE3nFxGFgXbxovZUsyTv1HnYOu
        gYcKomcf6grG5VtxHRqVQjjsNC2U8KPw1t8mduv7JY2s7cpCJxCTuIHr+lB5aO/G0v6se9
        lkFSIqdHAjCcd+X5Dr8hG2KpFYMAnvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-584KKkRzOi6JzDXU_vgHcA-1; Wed, 20 Nov 2019 16:07:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F13DB20;
        Wed, 20 Nov 2019 21:07:32 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F035F761;
        Wed, 20 Nov 2019 21:07:29 +0000 (UTC)
Subject: Re: [PATCH v3 7/8] iommu/vt-d: Avoid sending invalid page response
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574186193-30457-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f7296c44-e816-c878-5225-d9c0c9fedfe2@redhat.com>
Date:   Wed, 20 Nov 2019 22:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 584KKkRzOi6JzDXU_vgHcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/19/19 6:56 PM, Jacob Pan wrote:
> Page responses should only be sent when last page in group (LPIG) or
> private data is present in the page request. This patch avoids sending
> invalid descriptors.
>=20
> Fixes: 5d308fc1ecf53 ("iommu/vt-d: Add 256-bit invalidation descriptor
> support")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
R-b sent on v2
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/intel-svm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 71b85b892c56..4eecc24412dc 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -686,11 +686,10 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
>  =09=09=09if (req->priv_data_present)
>  =09=09=09=09memcpy(&resp.qw2, req->priv_data,
>  =09=09=09=09       sizeof(req->priv_data));
> +=09=09=09resp.qw2 =3D 0;
> +=09=09=09resp.qw3 =3D 0;
> +=09=09=09qi_submit_sync(&resp, iommu);
>  =09=09}
> -=09=09resp.qw2 =3D 0;
> -=09=09resp.qw3 =3D 0;
> -=09=09qi_submit_sync(&resp, iommu);
> -
>  =09=09head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>  =09}
> =20
>=20

