Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602B8180890
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCJTvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:51:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55284 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgCJTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583869897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3PhESK6uLexgJItbHee1HRK9XWHVAGUlhz9Vq1Mc4E=;
        b=aTt4VyNIaQhde14wlKLhuW+EykooJDZ//QAZvR8aUXRbeUSpYqquXLDpaz75VOV0E7cDDh
        YLSEXmPH+oAzazSlGquz6BmzvlwX+GcG0Z+EhWFUc5cfFKdNo/lKMFdDfKXVjHsEyP0NBl
        IU1RVK+bSWeKETMqZi96LMDO8F7Ofag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-vir2D4viMvG5hbmtrcKL2Q-1; Tue, 10 Mar 2020 15:51:34 -0400
X-MC-Unique: vir2D4viMvG5hbmtrcKL2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901FE8017CC;
        Tue, 10 Mar 2020 19:51:31 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870E88F366;
        Tue, 10 Mar 2020 19:51:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Cc:     Manasi Navare <manasi.d.navare@intel.com>,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/i915/mst: Hookup DRM DP MST late_register/early_unregister callbacks
Date:   Tue, 10 Mar 2020 15:51:21 -0400
Message-Id: <20200310195122.1590925-1-lyude@redhat.com>
In-Reply-To: <20200310185417.1588984-1-lyude@redhat.com>
References: <20200310185417.1588984-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915 can enable aux device nodes for DP MST by calling
drm_dp_mst_connector_late_register()/drm_dp_mst_connector_early_unregiste=
r(),
so let's hook that up.

Changes since v1:
* Call intel_connector_register/unregister() from
  intel_dp_mst_connector_late_register/unregister() so we don't lose
  error injection - Ville Syrj=C3=A4l=C3=A4
Changes since v2:
* Don't forget to clean up if intel_connector_register() fails - Ville

Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 33 +++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
index d53978ed3c12..e08caca658c6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -548,12 +548,41 @@ static int intel_dp_mst_get_ddc_modes(struct drm_co=
nnector *connector)
 	return ret;
 }
=20
+static int
+intel_dp_mst_connector_late_register(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+	int ret;
+
+	ret =3D drm_dp_mst_connector_late_register(connector,
+						 intel_connector->port);
+	if (ret < 0)
+		return ret;
+
+	ret =3D intel_connector_register(connector);
+	if (ret < 0)
+		drm_dp_mst_connector_early_unregister(connector,
+						      intel_connector->port);
+
+	return ret;
+}
+
+static void
+intel_dp_mst_connector_early_unregister(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+
+	intel_connector_unregister(connector);
+	drm_dp_mst_connector_early_unregister(connector,
+					      intel_connector->port);
+}
+
 static const struct drm_connector_funcs intel_dp_mst_connector_funcs =3D=
 {
 	.fill_modes =3D drm_helper_probe_single_connector_modes,
 	.atomic_get_property =3D intel_digital_connector_atomic_get_property,
 	.atomic_set_property =3D intel_digital_connector_atomic_set_property,
-	.late_register =3D intel_connector_register,
-	.early_unregister =3D intel_connector_unregister,
+	.late_register =3D intel_dp_mst_connector_late_register,
+	.early_unregister =3D intel_dp_mst_connector_early_unregister,
 	.destroy =3D intel_connector_destroy,
 	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state =3D intel_digital_connector_duplicate_state,
--=20
2.24.1

