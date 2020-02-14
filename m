Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8539415D42B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 09:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgBNI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 03:57:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47780 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgBNI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581670654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcSjZSHLEnp5ZLdnGZuQU+ROR/fBtg18iFgXLEAHrB0=;
        b=S3Vy5MyLMpcoRBYPIcRQTS2wVpe9yGzKF0UcecjrETBsOwmFghHfF3feW7VfC/BPPiMQ3y
        dnD5KWXXCtnwhpAAfVMeLwlb5d2Hl1C/Ov1L0Zm2KDa6trf/92ftSX276EUJUZsVwK/ino
        Opgwu8wFPFL9BzEaC9GXQqjJCPl79tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-o3cQdsa8OY63VP8hprtgPg-1; Fri, 14 Feb 2020 03:57:31 -0500
X-MC-Unique: o3cQdsa8OY63VP8hprtgPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8561801E67;
        Fri, 14 Feb 2020 08:57:29 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DD215DA88;
        Fri, 14 Feb 2020 08:57:25 +0000 (UTC)
Date:   Fri, 14 Feb 2020 09:57:23 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, olvaffe@gmail.com,
        smitterl@redhat.com, gurchetansingh@chromium.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] drm/virtio: fix error check
Message-ID: <20200214095723.0c489524.cohuck@redhat.com>
In-Reply-To: <20200214080100.1273-1-kraxel@redhat.com>
References: <20200214080100.1273-1-kraxel@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 09:01:00 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The >= compare op must happen in cpu byte order, doing it in
> little endian fails on big endian machines like s390.
> 
> Reported-by: Sebastian Mitterle <smitterl@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index cfe9c54f87a3..67caecde623e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -222,7 +222,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>  		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
>  
>  		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
> -			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
> +			if (le32_to_cpu(resp->type) >= VIRTIO_GPU_RESP_ERR_UNSPEC) {
>  				struct virtio_gpu_ctrl_hdr *cmd;
>  				cmd = virtio_gpu_vbuf_ctrl_hdr(entry);
>  				DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Endianness continues to be fun.

