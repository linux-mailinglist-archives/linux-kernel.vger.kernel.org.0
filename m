Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA808129338
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 09:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfLWInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 03:43:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56499 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbfLWInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577090630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9Vt9aITJ0g63smVGvQqe7KZcDWn2ziP1vtUVkzcCrA=;
        b=XhrQRtJeG712jz+cT/u9fcJZIAu6yFbQiVU9HWhG+q1aY7ZIpfzcBfcyK6SsGiHPs23ZpR
        iqFp5UujmVKp0XguEK7i8jMOqqHbgVMelS188xc9kEbknHICMEiQKdrUmWvQp9sUmtFZ1s
        DzE7YpAwczMRYVeE3kFdVfS1i+/hn/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-9fNGjymUPNqPkYBGt7BNAA-1; Mon, 23 Dec 2019 03:43:48 -0500
X-MC-Unique: 9fNGjymUPNqPkYBGt7BNAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF614800D41;
        Mon, 23 Dec 2019 08:43:46 +0000 (UTC)
Received: from [10.72.12.41] (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 301065D9D6;
        Mon, 23 Dec 2019 08:43:42 +0000 (UTC)
Subject: Re: [PATCH] virtio-mmio: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20191222190839.4863-1-tiny.windzz@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <209a1d81-00f7-ab22-ccca-36c1a014b345@redhat.com>
Date:   Mon, 23 Dec 2019 16:43:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191222190839.4863-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/23 =E4=B8=8A=E5=8D=883:08, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code, which
> contains platform_get_resource, devm_request_mem_region and
> devm_ioremap.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/virtio/virtio_mmio.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> index e09edb5c5e06..97d5725fd9a2 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -531,18 +531,9 @@ static void virtio_mmio_release_dev(struct device =
*_d)
>   static int virtio_mmio_probe(struct platform_device *pdev)
>   {
>   	struct virtio_mmio_device *vm_dev;
> -	struct resource *mem;
>   	unsigned long magic;
>   	int rc;
>  =20
> -	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem)
> -		return -EINVAL;
> -
> -	if (!devm_request_mem_region(&pdev->dev, mem->start,
> -			resource_size(mem), pdev->name))
> -		return -EBUSY;
> -
>   	vm_dev =3D devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
>   	if (!vm_dev)
>   		return -ENOMEM;
> @@ -554,9 +545,9 @@ static int virtio_mmio_probe(struct platform_device=
 *pdev)
>   	INIT_LIST_HEAD(&vm_dev->virtqueues);
>   	spin_lock_init(&vm_dev->lock);
>  =20
> -	vm_dev->base =3D devm_ioremap(&pdev->dev, mem->start, resource_size(m=
em));
> -	if (vm_dev->base =3D=3D NULL)
> -		return -EFAULT;
> +	vm_dev->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(vm_dev->base))
> +		return PTR_ERR(vm_dev->base);
>  =20
>   	/* Check magic value */
>   	magic =3D readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);


Acked-by: Jason Wang <jasowang@redhat.com>


