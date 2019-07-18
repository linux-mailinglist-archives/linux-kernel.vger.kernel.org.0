Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50386C49D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfGRBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:45:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389139AbfGRBoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9233030832C5;
        Thu, 18 Jul 2019 01:44:43 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6148919C67;
        Thu, 18 Jul 2019 01:44:42 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/26] drm/dp_mst: Refactor pdt setup/teardown, add more locking
Date:   Wed, 17 Jul 2019 21:42:38 -0400
Message-Id: <20190718014329.8107-16-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Jul 2019 01:44:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to be implementing suspend/resume reprobing very soon,
we need to make sure we are extra careful to ensure that our locking
actually protects the topology state where we expect it to. Turns out
this isn't the case with drm_dp_port_setup_pdt() and
drm_dp_port_teardown_pdt(), both of which change port->mstb without
grabbing &mgr->lock.

Additionally, since most callers of these functions are just using it to
teardown the port's previous PDT and setup a new one we can simplify
things a bit and combine drm_dp_port_setup_pdt() and
drm_dp_port_teardown_pdt() into a single function:
drm_dp_port_set_pdt(). This function also handles actually ensuring that
we grab the correct locks when we need to modify port->mstb.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 181 +++++++++++++++-----------
 include/drm/drm_dp_mst_helper.h       |   6 +-
 2 files changed, 110 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 13adfb77bf00..68fda2131feb 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1485,24 +1485,6 @@ drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
 	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
 }
 
-static void drm_dp_port_teardown_pdt(struct drm_dp_mst_port *port, int old_pdt)
-{
-	struct drm_dp_mst_branch *mstb;
-
-	switch (old_pdt) {
-	case DP_PEER_DEVICE_DP_LEGACY_CONV:
-	case DP_PEER_DEVICE_SST_SINK:
-		/* remove i2c over sideband */
-		drm_dp_mst_unregister_i2c_bus(&port->aux);
-		break;
-	case DP_PEER_DEVICE_MST_BRANCHING:
-		mstb = port->mstb;
-		port->mstb = NULL;
-		drm_dp_mst_topology_put_mstb(mstb);
-		break;
-	}
-}
-
 static void drm_dp_destroy_port(struct kref *kref)
 {
 	struct drm_dp_mst_port *port =
@@ -1712,38 +1694,79 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_port *port,
 	return parent_lct + 1;
 }
 
-/*
- * return sends link address for new mstb
- */
-static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
+static int drm_dp_port_set_pdt(struct drm_dp_mst_port *port, u8 new_pdt)
 {
-	int ret;
-	u8 rad[6], lct;
-	bool send_link = false;
+	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
+	struct drm_dp_mst_branch *mstb;
+	u8 rad[8], lct;
+	int ret = 0;
+
+	if (port->pdt == new_pdt)
+		return 0;
+
+	/* Teardown the old pdt, if there is one */
+	switch (port->pdt) {
+	case DP_PEER_DEVICE_DP_LEGACY_CONV:
+	case DP_PEER_DEVICE_SST_SINK:
+		/*
+		 * If the new PDT would also have an i2c bus, don't bother
+		 * with reregistering it
+		 */
+		if (new_pdt == DP_PEER_DEVICE_DP_LEGACY_CONV ||
+		    new_pdt == DP_PEER_DEVICE_SST_SINK) {
+			port->pdt = new_pdt;
+			return 0;
+		}
+
+		/* remove i2c over sideband */
+		drm_dp_mst_unregister_i2c_bus(&port->aux);
+		break;
+	case DP_PEER_DEVICE_MST_BRANCHING:
+		mutex_lock(&mgr->lock);
+		drm_dp_mst_topology_put_mstb(port->mstb);
+		port->mstb = NULL;
+		mutex_unlock(&mgr->lock);
+		break;
+	}
+
+	port->pdt = new_pdt;
 	switch (port->pdt) {
 	case DP_PEER_DEVICE_DP_LEGACY_CONV:
 	case DP_PEER_DEVICE_SST_SINK:
 		/* add i2c over sideband */
 		ret = drm_dp_mst_register_i2c_bus(&port->aux);
 		break;
+
 	case DP_PEER_DEVICE_MST_BRANCHING:
 		lct = drm_dp_calculate_rad(port, rad);
+		mstb = drm_dp_add_mst_branch_device(lct, rad);
+		if (!mstb) {
+			ret = -ENOMEM;
+			DRM_ERROR("Failed to create MSTB for port %p", port);
+			goto out;
+		}
 
-		port->mstb = drm_dp_add_mst_branch_device(lct, rad);
-		if (port->mstb) {
-			port->mstb->mgr = port->mgr;
-			port->mstb->port_parent = port;
-			/*
-			 * Make sure this port's memory allocation stays
-			 * around until its child MSTB releases it
-			 */
-			drm_dp_mst_get_port_malloc(port);
+		mutex_lock(&mgr->lock);
+		port->mstb = mstb;
+		mstb->mgr = port->mgr;
+		mstb->port_parent = port;
 
-			send_link = true;
-		}
+		/*
+		 * Make sure this port's memory allocation stays
+		 * around until its child MSTB releases it
+		 */
+		drm_dp_mst_get_port_malloc(port);
+		mutex_unlock(&mgr->lock);
+
+		/* And make sure we send a link address for this */
+		ret = 1;
 		break;
 	}
-	return send_link;
+
+out:
+	if (ret < 0)
+		port->pdt = DP_PEER_DEVICE_NONE;
+	return ret;
 }
 
 static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *guid)
@@ -1793,10 +1816,9 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 			    struct drm_device *dev,
 			    struct drm_dp_link_addr_reply_port *port_msg)
 {
+	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
 	struct drm_dp_mst_port *port;
-	bool ret;
 	bool created = false;
-	int old_pdt = 0;
 	int old_ddps = 0;
 
 	port = drm_dp_get_port(mstb, port_msg->port_number);
@@ -1808,7 +1830,7 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 		kref_init(&port->malloc_kref);
 		port->parent = mstb;
 		port->port_num = port_msg->port_number;
-		port->mgr = mstb->mgr;
+		port->mgr = mgr;
 		port->aux.name = "DPMST";
 		port->aux.dev = dev->dev;
 
@@ -1820,11 +1842,9 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 
 		created = true;
 	} else {
-		old_pdt = port->pdt;
 		old_ddps = port->ddps;
 	}
 
-	port->pdt = port_msg->peer_device_type;
 	port->input = port_msg->input_port;
 	port->mcs = port_msg->mcs;
 	port->ddps = port_msg->ddps;
@@ -1836,29 +1856,33 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 	/* manage mstb port lists with mgr lock - take a reference
 	   for this list */
 	if (created) {
-		mutex_lock(&mstb->mgr->lock);
+		mutex_lock(&mgr->lock);
 		drm_dp_mst_topology_get_port(port);
 		list_add(&port->next, &mstb->ports);
-		mutex_unlock(&mstb->mgr->lock);
+		mutex_unlock(&mgr->lock);
 	}
 
 	if (old_ddps != port->ddps) {
 		if (port->ddps) {
 			if (!port->input) {
-				drm_dp_send_enum_path_resources(mstb->mgr,
-								mstb, port);
+				drm_dp_send_enum_path_resources(mgr, mstb,
+								port);
 			}
 		} else {
 			port->available_pbn = 0;
 		}
 	}
 
-	if (old_pdt != port->pdt && !port->input) {
-		drm_dp_port_teardown_pdt(port, old_pdt);
-
-		ret = drm_dp_port_setup_pdt(port);
-		if (ret == true)
-			drm_dp_send_link_address(mstb->mgr, port->mstb);
+	if (!port->input) {
+		int ret = drm_dp_port_set_pdt(port,
+					      port_msg->peer_device_type);
+		if (ret == 1) {
+			drm_dp_send_link_address(mgr, port->mstb);
+		} else if (ret < 0) {
+			DRM_ERROR("Failed to change PDT on port %p: %d\n",
+				  port, ret);
+			goto fail;
+		}
 	}
 
 	if (created && !port->input) {
@@ -1866,18 +1890,11 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 
 		build_mst_prop_path(mstb, port->port_num, proppath,
 				    sizeof(proppath));
-		port->connector = (*mstb->mgr->cbs->add_connector)(mstb->mgr,
-								   port,
-								   proppath);
-		if (!port->connector) {
-			/* remove it from the port list */
-			mutex_lock(&mstb->mgr->lock);
-			list_del(&port->next);
-			mutex_unlock(&mstb->mgr->lock);
-			/* drop port list reference */
-			drm_dp_mst_topology_put_port(port);
-			goto out;
-		}
+		port->connector = (*mgr->cbs->add_connector)(mgr, port,
+							     proppath);
+		if (!port->connector)
+			goto fail;
+
 		if ((port->pdt == DP_PEER_DEVICE_DP_LEGACY_CONV ||
 		     port->pdt == DP_PEER_DEVICE_SST_SINK) &&
 		    port->port_num >= DP_MST_LOGICAL_PORT_0) {
@@ -1885,28 +1902,38 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 							 &port->aux.ddc);
 			drm_connector_set_tile_property(port->connector);
 		}
-		(*mstb->mgr->cbs->register_connector)(port->connector);
+
+		(*mgr->cbs->register_connector)(port->connector);
 	}
 
-out:
 	/* put reference to this port */
 	drm_dp_mst_topology_put_port(port);
+	return;
+
+fail:
+	/* Remove it from the port list */
+	mutex_lock(&mgr->lock);
+	list_del(&port->next);
+	mutex_unlock(&mgr->lock);
+
+	/* Drop the port list reference */
+	drm_dp_mst_topology_put_port(port);
+	/* And now drop our reference */
+	drm_dp_mst_topology_put_port(port);
 }
 
 static void drm_dp_update_port(struct drm_dp_mst_branch *mstb,
 			       struct drm_dp_connection_status_notify *conn_stat)
 {
 	struct drm_dp_mst_port *port;
-	int old_pdt;
 	int old_ddps;
 	bool dowork = false;
+
 	port = drm_dp_get_port(mstb, conn_stat->port_number);
 	if (!port)
 		return;
 
 	old_ddps = port->ddps;
-	old_pdt = port->pdt;
-	port->pdt = conn_stat->peer_device_type;
 	port->mcs = conn_stat->message_capability_status;
 	port->ldps = conn_stat->legacy_device_plug_status;
 	port->ddps = conn_stat->displayport_device_plug_status;
@@ -1918,11 +1945,17 @@ static void drm_dp_update_port(struct drm_dp_mst_branch *mstb,
 			port->available_pbn = 0;
 		}
 	}
-	if (old_pdt != port->pdt && !port->input) {
-		drm_dp_port_teardown_pdt(port, old_pdt);
 
-		if (drm_dp_port_setup_pdt(port))
+	if (!port->input) {
+		int ret = drm_dp_port_set_pdt(port,
+					      conn_stat->peer_device_type);
+		if (ret == 1) {
 			dowork = true;
+		} else if (ret < 0) {
+			DRM_ERROR("Failed to change PDT for port %p: %d\n",
+				  port, ret);
+			dowork = false;
+		}
 	}
 
 	drm_dp_mst_topology_put_port(port);
@@ -3884,9 +3917,7 @@ drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)
 	if (port->connector)
 		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
 
-	drm_dp_port_teardown_pdt(port, port->pdt);
-	port->pdt = DP_PEER_DEVICE_NONE;
-
+	drm_dp_port_set_pdt(port, DP_PEER_DEVICE_NONE);
 	drm_dp_mst_put_port_malloc(port);
 }
 
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 4c8d177e83e5..f704d217c9e0 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -55,8 +55,10 @@ struct drm_dp_vcpi {
  * @num_sdp_stream_sinks: Number of stream sinks
  * @available_pbn: Available bandwidth for this port.
  * @next: link to next port on this branch device
- * @mstb: branch device attach below this port
- * @aux: i2c aux transport to talk to device connected to this port.
+ * @mstb: branch device on this port, protected by
+ * &drm_dp_mst_topology_mgr.lock
+ * @aux: i2c aux transport to talk to device connected to this port, protected
+ * by &drm_dp_mst_topology_mgr.lock
  * @parent: branch device parent of this port
  * @vcpi: Virtual Channel Payload info for this port.
  * @connector: DRM connector this port is connected to.
-- 
2.21.0

