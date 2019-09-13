Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6903B218F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfIMODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 10:03:39 -0400
Received: from foss.arm.com ([217.140.110.172]:44254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388084AbfIMODi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53F2A1000;
        Fri, 13 Sep 2019 07:03:38 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF99F3F67D;
        Fri, 13 Sep 2019 07:03:36 -0700 (PDT)
Subject: Re: [PATCH 2/8] drm/shmem: switch shmem helper to
 &drm_gem_object_funcs.mmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20190913122908.784-1-kraxel@redhat.com>
 <20190913122908.784-3-kraxel@redhat.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <197fdced-cf4a-c59a-47fd-aa5dbf8e04a2@arm.com>
Date:   Fri, 13 Sep 2019 15:03:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913122908.784-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 13:29, Gerd Hoffmann wrote:
> Switch gem shmem helper to the new mmap() workflow,
> from &gem_driver.fops.mmap to &drm_gem_object_funcs.mmap.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_shmem_helper.h      |  6 ++----
>  drivers/gpu/drm/drm_gem_shmem_helper.c  | 26 ++++++++-----------------
>  drivers/gpu/drm/panfrost/panfrost_gem.c |  2 +-
>  drivers/gpu/drm/v3d/v3d_bo.c            |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
>  5 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 01f514521687..d89f2116c8ab 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -111,7 +111,7 @@ struct drm_gem_shmem_object {
>  		.poll		= drm_poll,\
>  		.read		= drm_read,\
>  		.llseek		= noop_llseek,\
> -		.mmap		= drm_gem_shmem_mmap, \
> +		.mmap		= drm_gem_mmap, \
>  	}
>  
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
> @@ -143,9 +143,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>  int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  			      struct drm_mode_create_dumb *args);
>  
> -int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma);
> -
> -extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
> +int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  
>  void drm_gem_shmem_print_info(struct drm_printer *p, unsigned int indent,
>  			      const struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index f5918707672f..a104140154bb 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -32,7 +32,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
>  	.get_sg_table = drm_gem_shmem_get_sg_table,
>  	.vmap = drm_gem_shmem_vmap,
>  	.vunmap = drm_gem_shmem_vunmap,
> -	.vm_ops = &drm_gem_shmem_vm_ops,
> +	.mmap = drm_gem_shmem_mmap,
>  };
>  
>  /**
> @@ -505,39 +505,30 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>  	drm_gem_vm_close(vma);
>  }
>  
> -const struct vm_operations_struct drm_gem_shmem_vm_ops = {
> +static const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>  	.fault = drm_gem_shmem_fault,
>  	.open = drm_gem_shmem_vm_open,
>  	.close = drm_gem_shmem_vm_close,
>  };
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>  
>  /**
>   * drm_gem_shmem_mmap - Memory-map a shmem GEM object
> - * @filp: File object
> + * @obj: gem object
>   * @vma: VMA for the area to be mapped
>   *
>   * This function implements an augmented version of the GEM DRM file mmap
>   * operation for shmem objects. Drivers which employ the shmem helpers should
> - * use this function as their &file_operations.mmap handler in the DRM device file's
> - * file_operations structure.
> - *
> - * Instead of directly referencing this function, drivers should use the
> - * DEFINE_DRM_GEM_SHMEM_FOPS() macro.
> + * use this function as their &drm_gem_object_funcs.mmap handler.
>   *
>   * Returns:
>   * 0 on success or a negative error code on failure.
>   */
> -int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
> +int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  {
>  	struct drm_gem_shmem_object *shmem;
>  	int ret;
>  
> -	ret = drm_gem_mmap(filp, vma);
> -	if (ret)
> -		return ret;
> -
> -	shmem = to_drm_gem_shmem_obj(vma->vm_private_data);
> +	shmem = to_drm_gem_shmem_obj(obj);
>  
>  	ret = drm_gem_shmem_get_pages(shmem);
>  	if (ret) {
> @@ -545,9 +536,8 @@ int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
>  		return ret;
>  	}
>  
> -	/* VM_PFNMAP was set by drm_gem_mmap() */
> -	vma->vm_flags &= ~VM_PFNMAP;
> -	vma->vm_flags |= VM_MIXEDMAP;
> +	vma->vm_flags |= (VM_MIXEDMAP|VM_DONTEXPAND);

I'm finding this a bit hard to follow - but I think here we've lost
VM_IO and VM_DONTDUMP which used to be set by drm_gem_mmap().

Also it looks like nothing is fiddling vma->vm_page_prot anymore.

Steve

> +	vma->vm_ops = &drm_gem_shmem_vm_ops;
>  
>  	/* Remove the fake offset */
>  	vma->vm_pgoff -= drm_vma_node_start(&shmem->base.vma_node);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index acb07fe06580..deca0c30bbd4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -112,7 +112,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
>  	.get_sg_table = drm_gem_shmem_get_sg_table,
>  	.vmap = drm_gem_shmem_vmap,
>  	.vunmap = drm_gem_shmem_vunmap,
> -	.vm_ops = &drm_gem_shmem_vm_ops,
> +	.mmap = drm_gem_shmem_mmap,
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index a22b75a3a533..edd299ab53d8 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -58,7 +58,7 @@ static const struct drm_gem_object_funcs v3d_gem_funcs = {
>  	.get_sg_table = drm_gem_shmem_get_sg_table,
>  	.vmap = drm_gem_shmem_vmap,
>  	.vunmap = drm_gem_shmem_vunmap,
> -	.vm_ops = &drm_gem_shmem_vm_ops,
> +	.mmap = drm_gem_shmem_mmap,
>  };
>  
>  /* gem_create_object function for allocating a BO struct and doing
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 69a3d310ff70..017a9e0fc3bb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -86,7 +86,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
>  	.get_sg_table = drm_gem_shmem_get_sg_table,
>  	.vmap = drm_gem_shmem_vmap,
>  	.vunmap = drm_gem_shmem_vunmap,
> -	.vm_ops = &drm_gem_shmem_vm_ops,
> +	.mmap = &drm_gem_shmem_mmap,
>  };
>  
>  struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
> 

