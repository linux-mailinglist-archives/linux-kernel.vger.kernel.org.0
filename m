Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1AB1DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfIMM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 08:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbfIMM3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DED2811DE;
        Fri, 13 Sep 2019 12:29:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8E585C22F;
        Fri, 13 Sep 2019 12:29:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB7D19D75; Fri, 13 Sep 2019 14:29:08 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] drm: add mmap() to drm_gem_object_funcs
Date:   Fri, 13 Sep 2019 14:29:01 +0200
Message-Id: <20190913122908.784-2-kraxel@redhat.com>
In-Reply-To: <20190913122908.784-1-kraxel@redhat.com>
References: <20190913122908.784-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 13 Sep 2019 12:29:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_object_funcs->vm_ops alone can't handle everything which needs
to be done for mmap(), tweaking vm_flags for example.  So add a new
mmap() callback to drm_gem_object_funcs where this code can go to.

Note that the vm_ops field is not used in case the mmap callback is
presnt, it is expected that the callback sets vma->vm_ops instead.

drm_gem_mmap_obj() will use the new callback for object specific mmap
setup.  With this in place the need for driver-speific fops->mmap
callbacks goes away, drm_gem_mmap can be hooked instead.

drm_gem_prime_mmap() will use the new callback too to just mmap gem
objects directly instead of jumping though loops to make
drm_gem_object_lookup() and fops->mmap work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem.h       | 14 ++++++++++++++
 drivers/gpu/drm/drm_gem.c   | 27 ++++++++++++++++++---------
 drivers/gpu/drm/drm_prime.c |  9 +++++++++
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 6aaba14f5972..e71f75a2ab57 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -150,6 +150,20 @@ struct drm_gem_object_funcs {
 	 */
 	void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
 
+	/**
+	 * @mmap:
+	 *
+	 * Handle mmap() of the gem object, setup vma accordingly.
+	 *
+	 * This callback is optional.
+	 *
+	 * The callback is used by by both drm_gem_mmap_obj() and
+	 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
+	 * used, the @mmap callback must set vma->vm_ops instead.
+	 *
+	 */
+	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
+
 	/**
 	 * @vm_ops:
 	 *
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6854f5867d51..56f42e0f2584 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1099,22 +1099,31 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 		     struct vm_area_struct *vma)
 {
 	struct drm_device *dev = obj->dev;
+	int ret;
 
 	/* Check for valid size. */
 	if (obj_size < vma->vm_end - vma->vm_start)
 		return -EINVAL;
 
-	if (obj->funcs && obj->funcs->vm_ops)
-		vma->vm_ops = obj->funcs->vm_ops;
-	else if (dev->driver->gem_vm_ops)
-		vma->vm_ops = dev->driver->gem_vm_ops;
-	else
-		return -EINVAL;
+	if (obj->funcs && obj->funcs->mmap) {
+		ret = obj->funcs->mmap(obj, vma);
+		if (ret)
+			return ret;
+		WARN_ON(!(vma->vm_flags & VM_DONTEXPAND));
+	} else {
+		if (obj->funcs && obj->funcs->vm_ops)
+			vma->vm_ops = obj->funcs->vm_ops;
+		else if (dev->driver->gem_vm_ops)
+			vma->vm_ops = dev->driver->gem_vm_ops;
+		else
+			return -EINVAL;
+
+		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
+		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+	}
 
-	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_private_data = obj;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
-	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* Take a ref for this mapping of the object, so that the fault
 	 * handler can dereference the mmap offset's pointer to the object.
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 0a2316e0e812..0814211b0f3f 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -713,6 +713,15 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	struct file *fil;
 	int ret;
 
+	if (obj->funcs && obj->funcs->mmap) {
+		ret = obj->funcs->mmap(obj, vma);
+		if (ret)
+			return ret;
+		vma->vm_private_data = obj;
+		drm_gem_object_get(obj);
+		return 0;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	fil = kzalloc(sizeof(*fil), GFP_KERNEL);
 	if (!priv || !fil) {
-- 
2.18.1

