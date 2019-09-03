Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDDA7592
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 22:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfICUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 16:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbfICUsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:48:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3D5DC057F88;
        Tue,  3 Sep 2019 20:48:41 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C84B51001B02;
        Tue,  3 Sep 2019 20:48:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/27] drm/nouveau: Don't grab runtime PM refs for HPD IRQs
Date:   Tue,  3 Sep 2019 16:46:00 -0400
Message-Id: <20190903204645.25487-23-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 20:48:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for suspend/resume reprobing to work, we need to be able to
perform sideband communications during suspend/resume, along with
runtime PM suspend/resume. In order to do so, we also need to make sure
that nouveau doesn't bother grabbing a runtime PM reference to do so,
since otherwise we'll start deadlocking runtime PM again.

Note that we weren't able to do this before, because of the DP MST
helpers processing UP requests from topologies in the same context as
drm_dp_mst_hpd_irq() which would have caused us to open ourselves up to
receiving hotplug events and deadlocking with runtime suspend/resume.
Now that those requests are handled asynchronously, this change should
be completely safe.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 33 +++++++++++----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 56871d34e3fb..f276918d3f3b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1131,6 +1131,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 	const char *name = connector->name;
 	struct nouveau_encoder *nv_encoder;
 	int ret;
+	bool plugged = (rep->mask != NVIF_NOTIFY_CONN_V0_UNPLUG);
+
+	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
+		NV_DEBUG(drm, "service %s\n", name);
+		drm_dp_cec_irq(&nv_connector->aux);
+		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
+			nv50_mstm_service(nv_encoder->dp.mstm);
+
+		return NVIF_NOTIFY_KEEP;
+	}
 
 	ret = pm_runtime_get(drm->dev->dev);
 	if (ret == 0) {
@@ -1151,25 +1161,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 		return NVIF_NOTIFY_DROP;
 	}
 
-	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
-		NV_DEBUG(drm, "service %s\n", name);
-		drm_dp_cec_irq(&nv_connector->aux);
-		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
-			nv50_mstm_service(nv_encoder->dp.mstm);
-	} else {
-		bool plugged = (rep->mask != NVIF_NOTIFY_CONN_V0_UNPLUG);
-
+	if (!plugged)
+		drm_dp_cec_unset_edid(&nv_connector->aux);
+	NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
+	if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP))) {
 		if (!plugged)
-			drm_dp_cec_unset_edid(&nv_connector->aux);
-		NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
-		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP))) {
-			if (!plugged)
-				nv50_mstm_remove(nv_encoder->dp.mstm);
-		}
-
-		drm_helper_hpd_irq_event(connector->dev);
+			nv50_mstm_remove(nv_encoder->dp.mstm);
 	}
 
+	drm_helper_hpd_irq_event(connector->dev);
+
 	pm_runtime_mark_last_busy(drm->dev->dev);
 	pm_runtime_put_autosuspend(drm->dev->dev);
 	return NVIF_NOTIFY_KEEP;
-- 
2.21.0

