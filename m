Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5944B29620
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbfEXKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 06:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390374AbfEXKmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A380308424C;
        Fri, 24 May 2019 10:42:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com [10.36.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEA875B683;
        Fri, 24 May 2019 10:42:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0FD2511AB5; Fri, 24 May 2019 12:42:51 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/qxl: drop WARN_ONCE()
Date:   Fri, 24 May 2019 12:42:50 +0200
Message-Id: <20190524104251.22761-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 24 May 2019 10:42:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason to flood the kernel log with a WARN
stacktrace just because someone tried to mmap a prime buffer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_prime.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 114653b471c6..7d3816fca5a8 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -77,6 +77,5 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
 		       struct vm_area_struct *area)
 {
-	WARN_ONCE(1, "not implemented");
 	return -ENOSYS;
 }
-- 
2.18.1

