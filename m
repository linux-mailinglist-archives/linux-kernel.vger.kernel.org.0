Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3977EE3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbfHBICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfHBICu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:02:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEE058535D;
        Fri,  2 Aug 2019 08:02:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4FF19C68;
        Fri,  2 Aug 2019 08:02:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B04BF16E05; Fri,  2 Aug 2019 10:02:45 +0200 (CEST)
Date:   Fri, 2 Aug 2019 10:02:45 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: kick vq outside of the vq lock
Message-ID: <20190802080245.za2n5rgx763xvhpd@sirius.home.kraxel.org>
References: <20190711022937.166015-1-olvaffe@gmail.com>
 <20190711023959.170158-1-olvaffe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711023959.170158-1-olvaffe@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 02 Aug 2019 08:02:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -291,11 +291,9 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>  		trace_virtio_gpu_cmd_queue(vq,
>  			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
>  
> -		virtqueue_kick(vq);
> +		ret = virtqueue_kick_prepare(vq);
>  	}
>  
> -	if (!ret)
> -		ret = vq->num_free;

Hmm.  Change looks unrelated.

On a closer look it seems this is basically dead code.
virtio_gpu_queue_ctrl_buffer_locked is called by
virtio_gpu_queue_ctrl_buffer and virtio_gpu_queue_fenced_ctrl_buffer.
The call sites for these two functions all ignore the return value.

So it is a valid change, but it should go to a separate patch.  And
while being at it virtio_gpu_queue_ctrl_buffer and
virtio_gpu_queue_fenced_ctrl_buffer can be changed to return void.

Otherwise the patch looks fine.  Nice analysis btw.

cheers,
  Gerd

