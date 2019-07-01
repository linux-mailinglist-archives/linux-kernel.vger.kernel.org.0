Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176B236D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFFHlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 03:41:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFHlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:41:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73A11C04FFF1;
        Thu,  6 Jun 2019 07:41:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-131.ams2.redhat.com [10.36.117.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 233192E040;
        Thu,  6 Jun 2019 07:41:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 637F511AAF; Thu,  6 Jun 2019 09:41:22 +0200 (CEST)
Date:   Thu, 6 Jun 2019 09:41:22 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     davidriley@chromium.org
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/virtio: Add memory barriers for capset cache.
Message-ID: <20190606074122.csocqu6g3in7dgbj@sirius.home.kraxel.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
 <20190605234423.11348-4-davidriley@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605234423.11348-4-davidriley@chromium.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 06 Jun 2019 07:41:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 04:44:23PM -0700, davidriley@chromium.org wrote:
> From: David Riley <davidriley@chromium.org>
> 
> After data is copied to the cache entry, atomic_set is used indicate
> that the data is the entry is valid without appropriate memory barriers.
> Similarly the read side was missing the same memory barries.
> 
> Signed-off-by: David Riley <davidriley@chromium.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 88c1ed57a3c5..502f5f7c2298 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -542,6 +542,9 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>  	if (!ret)
>  		return -EBUSY;
>  
> +	/* is_valid check must proceed before copy of the cache entry. */
> +	virt_rmb();

I don't think you need virt_rmb() here.  This isn't guest <=> host
communication, so a normal barrier should do.

The other three fixes are queued up for drm-misc-next.

cheers,
  Gerd

