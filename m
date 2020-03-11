Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C24181D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgCKQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:10:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:52563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgCKQKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583943030;
        bh=2rjZbi1Phw8WkletxcarQSt+EbEr8sWQgK2ggeEq6Uw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XQwRI3H1ZspffTnDslYyLKx0DXzGCRU29uYZiem2/FBjd8gdJHiPldEszqYfYE0fq
         J0vINdMk1dglGTm0JyeQlAnGmcZmHilAp4CeuunEbYnwc37i6Qx2KresERyOBuuZ2+
         NCF7l7bk+8dnW/GrUipDAiqQoAGLHuSq5UOY62Tc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.81.10.6] ([196.52.84.30]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU5R-1jq5iQ47RD-00ecZA; Wed, 11
 Mar 2020 17:10:30 +0100
Subject: Re: [PATCH] device core: fix dma_mask handling in
 platform_device_register_full
To:     Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20200311160710.376090-1-hch@lst.de>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <1183e2c5-f29d-96a1-580d-64fbc0d40f89@gmx.com>
Date:   Wed, 11 Mar 2020 16:10:28 +0000
MIME-Version: 1.0
In-Reply-To: <20200311160710.376090-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lYEPC0OG2v1QSSP1a4uTRqO0ZoBLLvNaaee7I8xFNxQPzYgtqoG
 NUz/3e/P4qeSl7HG2THkacaKTjCFeNOlK96cSgo3kAJnEUQVVZsIuVujSTJugK3b1lC09HT
 MBe2GYx7/Tu3mik62OYwBViEDjiyUhsOyM++FKURrrnvtfpc6h4tMpaWfskFIJnC7szdWGW
 SbYocwgjLzYA37KqlksiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xx/cD4mu1o=:P8JAByio6p7AZqokOyY8hK
 VS1r+MgkA2WMPwwxes3YNmiLMOaI38B0Hcbn5ECXUcQz6hpKrn9rhjKzW6dP7RP+NMTipI0F6
 Ox1JiE11pgWM+q3e9aw76P9T/p1gWEAjAAH4Ls5bEU4sM103O8Kt0Se69xYxr94emRqrWTHOI
 GnI94YjoLycQYnTDLFwThBc+jWB2kbwOtGtYWIydeBTyEIcxGhTz0L6ZOvBJ7BaLPVhtw9QEL
 Wk8s9geF0KzE3AzLTotoy8Bnha3z2zEtJmii0N+jk4Digg+RZ3v6m2gQIisS5Ikme79XcGB9d
 fyfCGnXsiUClv5QHGIZVguyhPkeJyy5puVYWtdKjgqOrBoW1nqNlrkOLZYV3nuStVbP9d3HCO
 oXvTq/HlCmrE3/Ao9+BC3X5hoLL8vjRg1fz539OYjWUmaVFSgjmTXIRjJD1TiVh02j0rkt5nw
 ZxHHVSX1knx9gz/FCuOkOWWSV1L2KPFnSWYXK1eI9yqjUOafWNxuWXduaE1ARW3CtGam3jge1
 qDngaFirpZYbRViDFf4Kq+sDP1G/KxJvwazxNr/mXz41Q2t0AqW39PAUjP37YFpLE3LfbcEmf
 E+RTZk6W1xj0OxmxExJEcba32Nm8ML0XyXeUBYxuE5ehdQafhzosRpyQApJ13GjAqw/R1QBmW
 y89CebLGMmv46k/Yt++8y0cVjO/emBBHE2m8y2mXK4v4ZX8vP4Xx+vOl42Ap4hsGhmt7oXS+z
 xGmxbga9fPcIQ889e1yLuYSwF0Z4MyM2RbREVggqTHVGIEyWM0Px+gG8fvgcOjx5tWouf5tRd
 zgiMDhJJ+N4lC1xoLKIXYQQBHZ2OQU2yYzzFcz7A2dt8A7PRaLL6FExZWvYP5eMLo1b4u6yxf
 DtXDrNSQLgdFj/KOodi7YdFx9EBKjMYdesP/axzP2+SzZQABYpub3aK/7VkOvFpb/XwLz68x+
 b2Axm+GMe1l8tZoseuxjl4/bxBJbnjJMg1I8DMd9i5lfRid0ZNhQqKP0btgs1wwKak1sKtuv8
 aoK7Dxrt33Q9a8IFI7JZ8MOkIAxxiANUugWyslfHdb4wj1mEmQWV/gqmzk+0IYJVoqMGpOlcD
 BBBcg0mbD8TMTydqlReUWchtVVPz2t9ni4fuVp/ff8Oz3i03+3m5sBHntXZKWpzvr9dA1XkFF
 xpp91sphesUDmTqtP8aSqGb3xns7erDWPTCsHakxksZUUtsp1OSIQU9KXS8rTN1JpflZo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 4:07 PM, Christoph Hellwig wrote:
> Ever since the generic platform device code started allocating DMA masks
> itself the code to allocate and leak a private DMA mask in
> platform_device_register_full has been superflous.  More so the fact tha=
t
> it unconditionally frees the DMA mask allocation in the failure path
> can lead to slab corruption if the function fails later on for a device
> where it didn't allocate the mask.  Just remove the offending code.
>
> Fixes: cdfee5623290 ("driver core: initialize a default DMA mask for pla=
tform device")
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> Tested-by: Artem S. Tashkinov <aros@gmx.com>
> ---
>   drivers/base/platform.c | 14 --------------
>   1 file changed, 14 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..47d3e6187a1c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -662,19 +662,6 @@ struct platform_device *platform_device_register_fu=
ll(
>   	pdev->dev.of_node_reused =3D pdevinfo->of_node_reused;
>
>   	if (pdevinfo->dma_mask) {
> -		/*
> -		 * This memory isn't freed when the device is put,
> -		 * I don't have a nice idea for that though.  Conceptually
> -		 * dma_mask in struct device should not be a pointer.
> -		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
> -		 */
> -		pdev->dev.dma_mask =3D
> -			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> -		if (!pdev->dev.dma_mask)
> -			goto err;
> -
> -		kmemleak_ignore(pdev->dev.dma_mask);
> -
>   		*pdev->dev.dma_mask =3D pdevinfo->dma_mask;
>   		pdev->dev.coherent_dma_mask =3D pdevinfo->dma_mask;
>   	}
> @@ -700,7 +687,6 @@ struct platform_device *platform_device_register_ful=
l(
>   	if (ret) {
>   err:
>   		ACPI_COMPANION_SET(&pdev->dev, NULL);
> -		kfree(pdev->dev.dma_mask);
>   		platform_device_put(pdev);
>   		return ERR_PTR(ret);
>   	}
>

I'd love to see this patch applied to the next round of stable kernels
(at the very least 5.5.x) ASAP because I've been stuck with kernel 5.3
on Fedora for quite some time already.

Thank you!
