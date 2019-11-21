Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340171050B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUKiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 05:38:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574332697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhfsdgfnBGFdqQ+uLrLd0ryQWfyJPaQk6Np/gMUhFtg=;
        b=AlMs0mLPG3tgVK6amhXEELwBkEVJRzamQFS8kAiR9RdmD4oE9UkfgOyTq4zInCe0yOz31d
        cUy92csFt9/iN0NE4u16VUMqetwzMey/mzFzVmn4jLg3wHddBLNj/Lv8p/mhEdvguuMjmn
        X5KOZSt0TpBHjFPysqyl+guuNdoCGSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-PqYQGKb9MKe9HMCdYqCfBA-1; Thu, 21 Nov 2019 05:38:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BE1107BA9E;
        Thu, 21 Nov 2019 10:38:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79FD1106F972;
        Thu, 21 Nov 2019 10:38:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C868DA1E0; Thu, 21 Nov 2019 11:38:07 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm: share address space for dma bufs
Date:   Thu, 21 Nov 2019 11:38:07 +0100
Message-Id: <20191121103807.18424-3-kraxel@redhat.com>
In-Reply-To: <20191121103807.18424-1-kraxel@redhat.com>
References: <20191121103807.18424-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PqYQGKb9MKe9HMCdYqCfBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the shared address space of the drm device (see drm_open() in
drm_file.c) for dma-bufs too.  That removes a difference betweem drm
device mmap vmas and dma-buf mmap vmas and fixes corner cases like
unmaps not working properly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_prime.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index a9633bd241bb..c3fc341453c0 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_fi=
le_private *prime_fpriv)
 struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
 =09=09=09=09      struct dma_buf_export_info *exp_info)
 {
+=09struct drm_gem_object *obj =3D exp_info->priv;
 =09struct dma_buf *dma_buf;
=20
 =09dma_buf =3D dma_buf_export(exp_info);
@@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device=
 *dev,
 =09=09return dma_buf;
=20
 =09drm_dev_get(dev);
-=09drm_gem_object_get(exp_info->priv);
+=09drm_gem_object_get(obj);
+=09dma_buf->file->f_mapping =3D obj->dev->anon_inode->i_mapping;
=20
 =09return dma_buf;
 }
--=20
2.18.1

