Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437E96C498
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389291AbfGRBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389026AbfGRBow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46620335C9;
        Thu, 18 Jul 2019 01:44:52 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C51B19C67;
        Thu, 18 Jul 2019 01:44:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/26] drm/dp_mst: Protect drm_dp_mst_port members with connection_mutex
Date:   Wed, 17 Jul 2019 21:42:42 -0400
Message-Id: <20190718014329.8107-20-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 18 Jul 2019 01:44:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes-you read that right. Currently there is literally no locking in
place for any of the drm_dp_mst_port struct members that can be modified
in response to a link address response, or a connection status response.
Which literally means if we're unlucky enough to have any sort of
hotplugging event happen before we're finished with reprobing link
addresses, we'll race and the contents of said struct members becomes
undefined. Fun!

So, finally add some simple locking protections to our MST helpers by
protecting any drm_dp_mst_port members which can be changed by link
address responses or connection status notifications under
drm_device->mode_config.connection_mutex.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 144 +++++++++++++++++++-------
 include/drm/drm_dp_mst_helper.h       |  39 +++++--
 2 files changed, 133 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index ee28b372afa4..dffd80f31537 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1352,6 +1352,7 @@ static void drm_dp_free_mst_port(struct kref *kref)
 		container_of(kref, struct drm_dp_mst_port, malloc_kref);
 
 	drm_dp_mst_put_mstb_malloc(port->parent);
+	mutex_destroy(&port->lock);
 	kfree(port);
 }
 
@@ -1818,6 +1819,36 @@ static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
 	strlcat(proppath, temp, proppath_size);
 }
 
+static void
+drm_dp_mst_port_add_connector(struct drm_dp_mst_branch *mstb,
+			      struct drm_dp_mst_port *port)
+{
+	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
+	char proppath[255];
+	int ret;
+
+	build_mst_prop_path(mstb, port->port_num, proppath, sizeof(proppath));
+	port->connector = mgr->cbs->add_connector(mgr, port, proppath);
+	if (!port->connector) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	if ((port->pdt == DP_PEER_DEVICE_DP_LEGACY_CONV ||
+	     port->pdt == DP_PEER_DEVICE_SST_SINK) &&
+	    port->port_num >= DP_MST_LOGICAL_PORT_0) {
+		port->cached_edid = drm_get_edid(port->connector,
+						 &port->aux.ddc);
+		drm_connector_set_tile_property(port->connector);
+	}
+
+	mgr->cbs->register_connector(port->connector);
+	return;
+
+error:
+	DRM_ERROR("Failed to create connector for port %p: %d\n", port, ret);
+}
+
 static void
 drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 				    struct drm_device *dev,
@@ -1825,8 +1856,12 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 {
 	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
 	struct drm_dp_mst_port *port;
-	bool created = false;
-	int old_ddps = 0;
+	struct drm_dp_mst_branch *child_mstb = NULL;
+	struct drm_connector *connector_to_destroy = NULL;
+	int old_ddps = 0, ret;
+	u8 new_pdt = DP_PEER_DEVICE_NONE;
+	bool created = false, send_link_addr = false,
+	     create_connector = false;
 
 	port = drm_dp_get_port(mstb, port_msg->port_number);
 	if (!port) {
@@ -1835,6 +1870,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 			return;
 		kref_init(&port->topology_kref);
 		kref_init(&port->malloc_kref);
+		mutex_init(&port->lock);
 		port->parent = mstb;
 		port->port_num = port_msg->port_number;
 		port->mgr = mgr;
@@ -1848,11 +1884,17 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 		drm_dp_mst_get_mstb_malloc(mstb);
 
 		created = true;
-	} else {
-		old_ddps = port->ddps;
 	}
 
+	mutex_lock(&port->lock);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (!created)
+		old_ddps = port->ddps;
+
 	port->input = port_msg->input_port;
+	if (!port->input)
+		new_pdt = port_msg->peer_device_type;
 	port->mcs = port_msg->mcs;
 	port->ddps = port_msg->ddps;
 	port->ldps = port_msg->legacy_device_plug_status;
@@ -1880,44 +1922,58 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 		}
 	}
 
-	if (!port->input) {
-		int ret = drm_dp_port_set_pdt(port,
-					      port_msg->peer_device_type);
-		if (ret == 1) {
-			drm_dp_send_link_address(mgr, port->mstb);
-		} else if (ret < 0) {
-			DRM_ERROR("Failed to change PDT on port %p: %d\n",
-				  port, ret);
-			goto fail;
+	ret = drm_dp_port_set_pdt(port, new_pdt);
+	if (ret == 1) {
+		send_link_addr = true;
+	} else if (ret < 0) {
+		DRM_ERROR("Failed to change PDT on port %p: %d\n",
+			  port, ret);
+		goto fail_unlock;
+	}
+
+	if (send_link_addr) {
+		mutex_lock(&mgr->lock);
+		if (port->mstb) {
+			child_mstb = port->mstb;
+			drm_dp_mst_get_mstb_malloc(child_mstb);
 		}
+		mutex_unlock(&mgr->lock);
 	}
 
-	if (created && !port->input) {
-		char proppath[255];
+	/*
+	 * We unset port->connector before dropping connection_mutex so that
+	 * there's no chance any of the atomic MST helpers can accidentally
+	 * associate a to-be-destroyed connector with a port.
+	 */
+	if (port->connector && port->input) {
+		connector_to_destroy = port->connector;
+		port->connector = NULL;
+	} else if (!port->connector && !port->input) {
+		create_connector = true;
+	}
 
-		build_mst_prop_path(mstb, port->port_num, proppath,
-				    sizeof(proppath));
-		port->connector = (*mgr->cbs->add_connector)(mgr, port,
-							     proppath);
-		if (!port->connector)
-			goto fail;
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 
-		if ((port->pdt == DP_PEER_DEVICE_DP_LEGACY_CONV ||
-		     port->pdt == DP_PEER_DEVICE_SST_SINK) &&
-		    port->port_num >= DP_MST_LOGICAL_PORT_0) {
-			port->cached_edid = drm_get_edid(port->connector,
-							 &port->aux.ddc);
-			drm_connector_set_tile_property(port->connector);
-		}
+	if (connector_to_destroy)
+		mgr->cbs->destroy_connector(mgr, connector_to_destroy);
+	else if (create_connector)
+		drm_dp_mst_port_add_connector(mstb, port);
+
+	mutex_unlock(&port->lock);
 
-		(*mgr->cbs->register_connector)(port->connector);
+	if (send_link_addr && child_mstb) {
+		drm_dp_send_link_address(mgr, child_mstb);
+		drm_dp_mst_put_mstb_malloc(child_mstb);
 	}
 
 	/* put reference to this port */
 	drm_dp_mst_topology_put_port(port);
 	return;
 
-fail:
+fail_unlock:
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&port->lock);
+
 	/* Remove it from the port list */
 	mutex_lock(&mgr->lock);
 	list_del(&port->next);
@@ -1933,6 +1989,7 @@ static void
 drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 			    struct drm_dp_connection_status_notify *conn_stat)
 {
+	struct drm_device *dev = mstb->mgr->dev;
 	struct drm_dp_mst_port *port;
 	int old_ddps;
 	bool dowork = false;
@@ -1941,6 +1998,8 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 	if (!port)
 		return;
 
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
 	old_ddps = port->ddps;
 	port->mcs = conn_stat->message_capability_status;
 	port->ldps = conn_stat->legacy_device_plug_status;
@@ -1966,6 +2025,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 		}
 	}
 
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	drm_dp_mst_topology_put_port(port);
 	if (dowork)
 		queue_work(system_long_wq, &mstb->mgr->work);
@@ -2058,28 +2118,34 @@ drm_dp_get_mst_branch_device_by_guid(struct drm_dp_mst_topology_mgr *mgr,
 static void drm_dp_check_and_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 					       struct drm_dp_mst_branch *mstb)
 {
+	struct drm_device *dev = mgr->dev;
 	struct drm_dp_mst_port *port;
-	struct drm_dp_mst_branch *mstb_child;
+
 	if (!mstb->link_address_sent)
 		drm_dp_send_link_address(mgr, mstb);
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		if (port->input)
-			continue;
+		struct drm_dp_mst_branch *mstb_child = NULL;
+
+		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 
-		if (!port->ddps)
+		if (port->input || !port->ddps) {
+			drm_modeset_unlock(&dev->mode_config.connection_mutex);
 			continue;
+		}
 
 		if (!port->available_pbn)
 			drm_dp_send_enum_path_resources(mgr, mstb, port);
 
-		if (port->mstb) {
+		if (port->mstb)
 			mstb_child = drm_dp_mst_topology_get_mstb_validated(
 			    mgr, port->mstb);
-			if (mstb_child) {
-				drm_dp_check_and_send_link_address(mgr, mstb_child);
-				drm_dp_mst_topology_put_mstb(mstb_child);
-			}
+
+		drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+		if (mstb_child) {
+			drm_dp_check_and_send_link_address(mgr, mstb_child);
+			drm_dp_mst_topology_put_mstb(mstb_child);
 		}
 	}
 }
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index ac1a68574a1a..aed68d7e6492 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -45,23 +45,34 @@ struct drm_dp_vcpi {
 /**
  * struct drm_dp_mst_port - MST port
  * @port_num: port number
- * @input: if this port is an input port.
- * @mcs: message capability status - DP 1.2 spec.
- * @ddps: DisplayPort Device Plug Status - DP 1.2
- * @pdt: Peer Device Type
- * @ldps: Legacy Device Plug Status
- * @dpcd_rev: DPCD revision of device on this port
- * @num_sdp_streams: Number of simultaneous streams
- * @num_sdp_stream_sinks: Number of stream sinks
- * @available_pbn: Available bandwidth for this port.
+ * @input: if this port is an input port. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @mcs: message capability status - DP 1.2 spec. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @ddps: DisplayPort Device Plug Status - DP 1.2. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @pdt: Peer Device Type. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @ldps: Legacy Device Plug Status. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @dpcd_rev: DPCD revision of device on this port. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @num_sdp_streams: Number of simultaneous streams. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @num_sdp_stream_sinks: Number of stream sinks. Protected by
+ * &drm_device.mode_config.connection_mutex.
+ * @available_pbn: Available bandwidth for this port. Protected by
+ * &drm_device.mode_config.connection_mutex.
  * @next: link to next port on this branch device
  * @mstb: branch device on this port, protected by
  * &drm_dp_mst_topology_mgr.lock
  * @aux: i2c aux transport to talk to device connected to this port, protected
- * by &drm_dp_mst_topology_mgr.lock
+ * by &drm_device.mode_config.connection_mutex.
  * @parent: branch device parent of this port
  * @vcpi: Virtual Channel Payload info for this port.
- * @connector: DRM connector this port is connected to.
+ * @connector: DRM connector this port is connected to. Protected by @lock.
+ * When there is already a connector registered for this port, this is also
+ * protected by &drm_device.mode_config.connection_mutex.
  * @mgr: topology manager this port lives under.
  *
  * This structure represents an MST port endpoint on a device somewhere
@@ -100,6 +111,12 @@ struct drm_dp_mst_port {
 	struct drm_connector *connector;
 	struct drm_dp_mst_topology_mgr *mgr;
 
+	/**
+	 * @lock: Protects @connector. If needed, this lock should be grabbed
+	 * before &drm_device.mode_config.connection_mutex.
+	 */
+	struct mutex lock;
+
 	/**
 	 * @cached_edid: for DP logical ports - make tiling work by ensuring
 	 * that the EDID for all connectors is read immediately.
-- 
2.21.0

