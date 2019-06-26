Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE03563B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfFZHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZHv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:51:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 985483087BA9;
        Wed, 26 Jun 2019 07:51:58 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296F660C6E;
        Wed, 26 Jun 2019 07:51:48 +0000 (UTC)
Date:   Wed, 26 Jun 2019 09:51:46 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, jcmvbkbc@gmail.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] drm/virtio: move drm_connector_update_edid_property()
 call
Message-ID: <20190626095146.2731a2dc.cohuck@redhat.com>
In-Reply-To: <20190405044602.2334-1-kraxel@redhat.com>
References: <20190405044602.2334-1-kraxel@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Jun 2019 07:51:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Apr 2019 06:46:02 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> drm_connector_update_edid_property can sleep, we must not
> call it while holding a spinlock.  Move the callsize.

s/callsize/callsite/

> 
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index e62fe24b1a2e..5bb0f0a084e9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -619,11 +619,11 @@ static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
>  	output = vgdev->outputs + scanout;
>  
>  	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
> +	drm_connector_update_edid_property(&output->conn, new_edid);
>  
>  	spin_lock(&vgdev->display_info_lock);
>  	old_edid = output->edid;
>  	output->edid = new_edid;
> -	drm_connector_update_edid_property(&output->conn, output->edid);
>  	spin_unlock(&vgdev->display_info_lock);
>  
>  	kfree(old_edid);

This gets rid of the sleeping while atomic traces I've been seeing with
an s390x guest (both virtio-gpu-pci and virtio-gpu-ccw).

Tested-by: Cornelia Huck <cohuck@redhat.com>

I have also looked at the code a bit, but don't feel confident enough
to give an R-b.

Acked-by: Cornelia Huck <cohuck@redhat.com>
