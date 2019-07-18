Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5118B6C492
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbfGRBok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbfGRBog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA5B459465;
        Thu, 18 Jul 2019 01:44:35 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8112F19C67;
        Thu, 18 Jul 2019 01:44:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/26] drm/dp_mst: Refactor drm_dp_mst_handle_up_req()
Date:   Wed, 17 Jul 2019 21:42:34 -0400
Message-Id: <20190718014329.8107-12-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 18 Jul 2019 01:44:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a couple of changes here, so to summarize:

* Remove the big ugly mgr->up_req_recv.have_eomt conditional to save on
  indenting
* Store &mgr->up_req_recv.initial_hdr in a variable so we don't keep
  going over 80 character long lines
* De-duplicate code for calling drm_dp_send_up_ack_reply() and getting
  the MSTB via it's GUID
* Remove all of the duplicate calls to memset() and just use a goto
  instead
* Actually do line wrapping
* Remove the unnecessary if (mstb) check before calling
  drm_dp_mst_topology_put_mstb() - we are guaranteed to always have
  mstb != NULL at that point in the function

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 75 ++++++++++++++-------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0894bc237082..5dea219bf744 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3127,68 +3127,69 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_sideband_msg_req_body msg;
+	struct drm_dp_sideband_msg_hdr *hdr = &mgr->up_req_recv.initial_hdr;
 	struct drm_dp_mst_branch *mstb = NULL;
+	const u8 *guid;
 	bool seqno;
 
-	if (!drm_dp_get_one_sb_msg(mgr, true)) {
-		memset(&mgr->up_req_recv, 0,
-		       sizeof(struct drm_dp_sideband_msg_rx));
-		return 0;
-	}
+	if (!drm_dp_get_one_sb_msg(mgr, true))
+		goto out;
 
 	if (!mgr->up_req_recv.have_eomt)
 		return 0;
 
-	if (!mgr->up_req_recv.initial_hdr.broadcast) {
-		mstb = drm_dp_get_mst_branch_device(mgr,
-						    mgr->up_req_recv.initial_hdr.lct,
-						    mgr->up_req_recv.initial_hdr.rad);
+	if (!hdr->broadcast) {
+		mstb = drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
 		if (!mstb) {
-			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
-			memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-			return 0;
+			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
+				      hdr->lct);
+			goto out;
 		}
 	}
 
-	seqno = mgr->up_req_recv.initial_hdr.seqno;
+	seqno = hdr->seqno;
 	drm_dp_sideband_parse_req(&mgr->up_req_recv, &msg);
 
-	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
-		drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno, false);
+	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY)
+		guid = msg.u.conn_stat.guid;
+	else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY)
+		guid = msg.u.resource_stat.guid;
+	else
+		goto out;
 
-		if (!mstb)
-			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, msg.u.conn_stat.guid);
+	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno,
+				 false);
 
+	if (!mstb) {
+		mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
 		if (!mstb) {
-			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
-			memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-			return 0;
+			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
+				      hdr->lct);
+			goto out;
 		}
+	}
 
+	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		drm_dp_update_port(mstb, &msg.u.conn_stat);
 
-		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n", msg.u.conn_stat.port_number, msg.u.conn_stat.legacy_device_plug_status, msg.u.conn_stat.displayport_device_plug_status, msg.u.conn_stat.message_capability_status, msg.u.conn_stat.input_port, msg.u.conn_stat.peer_device_type);
-		drm_kms_helper_hotplug_event(mgr->dev);
+		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
+			      msg.u.conn_stat.port_number,
+			      msg.u.conn_stat.legacy_device_plug_status,
+			      msg.u.conn_stat.displayport_device_plug_status,
+			      msg.u.conn_stat.message_capability_status,
+			      msg.u.conn_stat.input_port,
+			      msg.u.conn_stat.peer_device_type);
 
+		drm_kms_helper_hotplug_event(mgr->dev);
 	} else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
-		drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno, false);
-		if (!mstb)
-			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, msg.u.resource_stat.guid);
-
-		if (!mstb) {
-			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
-			memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-			return 0;
-		}
-
-		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n", msg.u.resource_stat.port_number, msg.u.resource_stat.available_pbn);
+		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
+			      msg.u.resource_stat.port_number,
+			      msg.u.resource_stat.available_pbn);
 	}
 
-	if (mstb)
-		drm_dp_mst_topology_put_mstb(mstb);
-
+	drm_dp_mst_topology_put_mstb(mstb);
+out:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-
 	return 0;
 }
 
-- 
2.21.0

