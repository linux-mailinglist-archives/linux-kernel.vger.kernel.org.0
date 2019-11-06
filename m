Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F8F1046
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 08:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfKFHbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 02:31:43 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:51108 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbfKFHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=10j9yC2LKZ4Yu8yJAT
        38Az579fi88WXpZdGmSsenJPQ=; b=UeYFaws6OMq6xy765lPDJs+n7oC6z4TtQl
        vbRk9uEz0iZ5qE5YN/NlX6LAaS6zPv86MgtPDw1tUc0aA3+UGA6XpunNBUnojJrF
        09FfMGQxsNFdoFNXRD1fYqiB3jW7aUpe7OYDqcjV3jUpHLrIU5rbsXXXcJ/Aeqzm
        R+rHk2M8c=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp4 (Coremail) with SMTP id HNxpCgCXRjG8dsJd0yl7BQ--.263S3;
        Wed, 06 Nov 2019 15:31:26 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] drm/i915/gvt: fix dropping obj reference twice
Date:   Wed,  6 Nov 2019 15:31:07 +0800
Message-Id: <1573025467-18278-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HNxpCgCXRjG8dsJd0yl7BQ--.263S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW3tr1DXFWxKrWfKw1kGrg_yoWkurbEkr
        WYqF17CrZrKFs09r1jyr9rAas2gF4UZFW8W3y7t34kA342kw1DZFZ5Zr15Zr18uF4UAFZx
        AF1xury3ZFWF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1xwIPUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQ5lclaD5JcnsgAAs7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference count of obj will be decremented twice if error occurs
in dma_buf_fd(). Additionally, attempting to read the reference count of
obj after dropping reference may lead to a use after free bug. Here, we
drop obj's reference until it is not used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 13044c027f27..4bfaefdf548d 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -498,8 +498,6 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 		goto out_free_gem;
 	}
 
-	i915_gem_object_put(obj);
-
 	ret = dma_buf_fd(dmabuf, DRM_CLOEXEC | DRM_RDWR);
 	if (ret < 0) {
 		gvt_vgpu_err("create dma-buf fd failed ret:%d\n", ret);
@@ -524,6 +522,8 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 		    file_count(dmabuf->file),
 		    kref_read(&obj->base.refcount));
 
+	i915_gem_object_put(obj);
+
 	return dmabuf_fd;
 
 out_free_dmabuf:
-- 
2.7.4

