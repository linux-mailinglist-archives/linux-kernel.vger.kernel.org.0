Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51E3596DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfF1JDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfF1JDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1638C308421A;
        Fri, 28 Jun 2019 09:03:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55AEB5C237;
        Fri, 28 Jun 2019 09:03:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6CDEC9D72; Fri, 28 Jun 2019 11:03:07 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 10/18] drm/ttm: set both resv and base.resv pointers
Date:   Fri, 28 Jun 2019 11:02:55 +0200
Message-Id: <20190628090303.29467-11-kraxel@redhat.com>
In-Reply-To: <20190628090303.29467-1-kraxel@redhat.com>
References: <20190628090303.29467-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 28 Jun 2019 09:03:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize both ttm_buffer_object->resv and ttm_buffer_object->base.resv
pointers.  This allows to move users from the former to the latter.  When
all users are moved we can drop ttm_buffer_object->resv.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 1d91da85f399..3e605b9ee2f3 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1331,9 +1331,11 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	bo->sg = sg;
 	if (resv) {
 		bo->resv = resv;
+		bo->base.resv = resv;
 		reservation_object_assert_held(bo->resv);
 	} else {
 		bo->resv = &bo->base._resv;
+		bo->base.resv = &bo->base._resv;
 	}
 	if (!ttm_bo_uses_embedded_gem_object(bo)) {
 		/*
-- 
2.18.1

