Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98F4B5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfFSJ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 05:57:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46726 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFSJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:57:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so26282357edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYUOBbihdDezrYIpc84bsimr033/fNxizTudReyy9GE=;
        b=VooeCWO1OpfkqLQECa5vkxYQhv9QcgV0EEz4MtAZie/DQpFAzkLReYAKFordnWIKq2
         76y1DCcwaJOZMGb2KIbmbHVmjn2ZeqGGDGzFy8n7iIGwgAGZD/4OQpNyHxlqk/saUlUA
         Iu0+x1IlzIm74/Ap43c90NeDs0k6H3Sgq2zwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OYUOBbihdDezrYIpc84bsimr033/fNxizTudReyy9GE=;
        b=ejp/l7VaZo81t2Vt2/LXD/P/8Os+TJIEYxorhyHRR/fm2AZPJPoTItFwn2xcwloHMk
         BZA7up/5ygUcUvi+zh580AuFN32rz5uAIbgoFt5LGSXjTr3NBRguAAtp0Y0flsy0jR75
         76eeaXH8G4Xtfbq0+zRK0GZb5kJyMzddnfaJDDbajbul822vy1f3JzdBFXIGQmYH15Hy
         W7ZFkXm//z1AtLSZ2u+3uBLpwgTTNsPEISMtXkpmDCW2+l6MSTOoDY/IwhjFjsY16gd+
         jf2dGAUvveqJcb40PCf2xJlfmfr2r7AaSgxRIZkVlE8GFXgVcG4nEqhDYBnZdbL8WFsw
         bzNg==
X-Gm-Message-State: APjAAAXr6AozNrX1mVpmtfRfLC+rhwWlUgioPJapLh5o+074FdzbF7vX
        NuvHC+gvfmONvzqEtqukAvQu1Ld1dXo=
X-Google-Smtp-Source: APXvYqxmuZBxDErDZLmU5QeCx1tL6e44prW1irGwG0kDOxQYTRxd1JoAqkmtlD6HogrJKkLq+7r1aQ==
X-Received: by 2002:a50:b7e2:: with SMTP id i31mr83477702ede.229.1560938232780;
        Wed, 19 Jun 2019 02:57:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e26sm3180489eje.29.2019.06.19.02.57.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 02:57:12 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:57:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/12] drm/virtio: remove ttm calls from in
 virtio_gpu_object_{reserve,unreserve}
Message-ID: <20190619095708.GL12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-8-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:04:15AM +0200, Gerd Hoffmann wrote:
> Call reservation_object_* directly instead
> of using ttm_bo_{reserve,unreserve}.
> 
> v3: check for EINTR too.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 06cc0e961df6..77ac69a8e6cc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -402,9 +402,9 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>  	int r;
>  
> -	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> +	r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
>  	if (unlikely(r != 0)) {
> -		if (r != -ERESTARTSYS) {
> +		if (r != -ERESTARTSYS && r != -EINTR) {

You only need to check for EINTR I think. ttm_bo_reserv does the EINVAL ->
ERESTARTSYS remapping.
-Daniel

>  			struct virtio_gpu_device *qdev =
>  				bo->gem_base.dev->dev_private;
>  			dev_err(qdev->dev, "%p reserve failed\n", bo);
> @@ -416,7 +416,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  
>  static inline void virtio_gpu_object_unreserve(struct virtio_gpu_object *bo)
>  {
> -	ttm_bo_unreserve(&bo->tbo);
> +	reservation_object_unlock(bo->gem_base.resv);
>  }
>  
>  /* virgl debufs */
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
