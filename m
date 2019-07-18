Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9346C479
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 03:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfGRBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 21:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388629AbfGRBoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F085C057E29;
        Thu, 18 Jul 2019 01:44:34 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFE5E19C67;
        Thu, 18 Jul 2019 01:44:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/26] drm/dp_mst: Constify guid in drm_dp_get_mst_branch_by_guid()
Date:   Wed, 17 Jul 2019 21:42:33 -0400
Message-Id: <20190718014329.8107-11-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 18 Jul 2019 01:44:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And it's helper, we'll be using this in just a moment.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index b867a2e8f779..0894bc237082 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1971,7 +1971,7 @@ static struct drm_dp_mst_branch *drm_dp_get_mst_branch_device(struct drm_dp_mst_
 
 static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 	struct drm_dp_mst_branch *mstb,
-	uint8_t *guid)
+	const uint8_t *guid)
 {
 	struct drm_dp_mst_branch *found_mstb;
 	struct drm_dp_mst_port *port;
@@ -1995,7 +1995,7 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 
 static struct drm_dp_mst_branch *
 drm_dp_get_mst_branch_device_by_guid(struct drm_dp_mst_topology_mgr *mgr,
-				     uint8_t *guid)
+				     const uint8_t *guid)
 {
 	struct drm_dp_mst_branch *mstb;
 	int ret;
-- 
2.21.0

