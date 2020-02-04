Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0828B15210B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 20:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBDT2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 14:28:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbgBDT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD4sh7+q1QcXfGlCHQJDWJrnzcBICIJB57lOc03qehU=;
        b=RwEj7LpF41jPma743xZK2iNgRjVqTbiRrJqMOhevbzlUup4DtAJWO7JHdA34avP+qyMNBD
        Yd09GwoH8yM/nrOyv5ON4emqWXxUvsTd7l2zzgMap6f8TTp01RNARXfEo2yy6a8976XmjH
        KTDlaSf1+bE+mrx1U/wNtlm053zlyl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-tk8T_SkEO-yxls4-uZb5UA-1; Tue, 04 Feb 2020 14:28:49 -0500
X-MC-Unique: tk8T_SkEO-yxls4-uZb5UA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8841005F6E;
        Tue,  4 Feb 2020 19:28:46 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E27B185750;
        Tue,  4 Feb 2020 19:28:44 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/dp: Introduce EDID-based quirks
Date:   Tue,  4 Feb 2020 14:28:10 -0500
Message-Id: <20200204192823.111404-3-lyude@redhat.com>
In-Reply-To: <20200204192823.111404-1-lyude@redhat.com>
References: <20200204192823.111404-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole point of using OUIs is so that we can recognize certain
devices and potentially apply quirks for them. Normally this should work
quite well, but there appears to be quite a number of laptop panels out
there that will fill the OUI but not the device ID. As such, for devices
like this I can't imagine it's a very good idea to try relying on OUIs
for applying quirks. As well, some laptop vendors have confirmed to us
that their panels have this exact issue.

So, let's introduce the ability to apply DP quirks based on EDID
identification. We reuse the same quirk bits for OUI-based quirks, so
that callers can simply check all possible quirks using
drm_dp_has_quirk().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c               | 61 +++++++++++++++++++
 drivers/gpu/drm/drm_dp_mst_topology.c         |  3 +-
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 11 ++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  2 +-
 include/drm/drm_dp_helper.h                   | 11 +++-
 7 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_hel=
per.c
index 5a103e9b3c86..db23308f4d8b 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1221,6 +1221,67 @@ drm_dp_get_quirks(const struct drm_dp_dpcd_ident *=
ident, bool is_branch)
 #undef DEVICE_ID_ANY
 #undef DEVICE_ID
=20
+struct edid_quirk {
+	u8 mfg_id[2];
+	u8 prod_id[2];
+	u32 quirks;
+};
+
+#define MFG(first, second) { (first), (second) }
+#define PROD_ID(first, second) { (first), (second) }
+
+/*
+ * Some devices have unreliable OUIDs where they don't set the device ID
+ * correctly, and as a result we need to use the EDID for finding additi=
onal
+ * DP quirks in such cases.
+ */
+static const struct edid_quirk edid_quirk_list[] =3D {
+};
+
+#undef MFG
+#undef PROD_ID
+
+/**
+ * drm_dp_get_edid_quirks() - Check the EDID of a DP device to find addi=
tional
+ * DP-specific quirks
+ * @edid: The EDID to check
+ *
+ * While OUIDs are meant to be used to recognize a DisplayPort device, a=
 lot
+ * of manufacturers don't seem to like following standards and neglect t=
o fill
+ * the dev-ID in, making it impossible to only use OUIDs for determining
+ * quirks in some cases. This function can be used to check the EDID and=
 look
+ * up any additional DP quirks. The bits returned by this function corre=
spond
+ * to the quirk bits in &drm_dp_quirk.
+ *
+ * Returns: a bitmask of quirks, if any. The driver can check this using
+ * drm_dp_has_quirk().
+ */
+u32 drm_dp_get_edid_quirks(const struct edid *edid)
+{
+	const struct edid_quirk *quirk;
+	u32 quirks =3D 0;
+	int i;
+
+	if (!edid)
+		return 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(edid_quirk_list); i++) {
+		quirk =3D &edid_quirk_list[i];
+		if (memcmp(quirk->mfg_id, edid->mfg_id,
+			   sizeof(edid->mfg_id)) =3D=3D 0 &&
+		    memcmp(quirk->prod_id, edid->prod_code,
+			   sizeof(edid->prod_code)) =3D=3D 0)
+			quirks |=3D quirk->quirks;
+	}
+
+	DRM_DEBUG_KMS("DP sink: EDID mfg %*phD prod-ID %*phD quirks: 0x%04x\n",
+		      (int)sizeof(edid->mfg_id), edid->mfg_id,
+		      (int)sizeof(edid->prod_code), edid->prod_code, quirks);
+
+	return quirks;
+}
+EXPORT_SYMBOL(drm_dp_get_edid_quirks);
+
 /**
  * drm_dp_read_desc - read sink/branch descriptor from DPCD
  * @aux: DisplayPort AUX channel
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index a811247cecfe..68247670427a 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -5452,7 +5452,8 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(stru=
ct drm_dp_mst_port *port)
 	if (drm_dp_read_desc(port->mgr->aux, &desc, true))
 		return NULL;
=20
-	if (drm_dp_has_quirk(&desc, DP_DPCD_QUIRK_DSC_WITHOUT_VIRTUAL_DPCD) &&
+	if (drm_dp_has_quirk(&desc, 0,
+			     DP_DPCD_QUIRK_DSC_WITHOUT_VIRTUAL_DPCD) &&
 	    port->mgr->dpcd[DP_DPCD_REV] >=3D DP_DPCD_REV_14 &&
 	    port->parent =3D=3D port->mgr->mst_primary) {
 		u8 downstreamport;
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers=
/gpu/drm/i915/display/intel_display_types.h
index 7c6133a9c51b..eebf02ff4ed2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1231,6 +1231,7 @@ struct intel_dp {
 	int max_link_rate;
 	/* sink or branch descriptor */
 	struct drm_dp_desc desc;
+	u32 edid_quirks;
 	struct drm_dp_aux aux;
 	u32 aux_busy_last_status;
 	u8 train_set[4];
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
index f4dede6253f8..245e21d1cadd 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2386,7 +2386,7 @@ intel_dp_compute_config(struct intel_encoder *encod=
er,
 	struct intel_connector *intel_connector =3D intel_dp->attached_connecto=
r;
 	struct intel_digital_connector_state *intel_conn_state =3D
 		to_intel_digital_connector_state(conn_state);
-	bool constant_n =3D drm_dp_has_quirk(&intel_dp->desc,
+	bool constant_n =3D drm_dp_has_quirk(&intel_dp->desc, 0,
 					   DP_DPCD_QUIRK_CONSTANT_N);
 	int ret =3D 0, output_bpp;
=20
@@ -4499,7 +4499,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 	 * it don't care about read it here and in intel_edp_init_dpcd().
 	 */
 	if (!intel_dp_is_edp(intel_dp) &&
-	    !drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_NO_SINK_COUNT)) {
+	    !drm_dp_has_quirk(&intel_dp->desc, 0,
+			      DP_DPCD_QUIRK_NO_SINK_COUNT)) {
 		u8 count;
 		ssize_t r;
=20
@@ -5666,6 +5667,7 @@ intel_dp_set_edid(struct intel_dp *intel_dp)
=20
 	intel_dp->has_audio =3D drm_detect_monitor_audio(edid);
 	drm_dp_cec_set_edid(&intel_dp->aux, edid);
+	intel_dp->edid_quirks =3D drm_dp_get_edid_quirks(edid);
 }
=20
 static void
@@ -5678,6 +5680,7 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
 	intel_connector->detect_edid =3D NULL;
=20
 	intel_dp->has_audio =3D false;
+	intel_dp->edid_quirks =3D 0;
 }
=20
 static int
@@ -7409,8 +7412,8 @@ static bool intel_edp_init_connector(struct intel_d=
p *intel_dp,
 	edid =3D drm_get_edid(connector, &intel_dp->aux.ddc);
 	if (edid) {
 		if (drm_add_edid_modes(connector, edid)) {
-			drm_connector_update_edid_property(connector,
-								edid);
+			drm_connector_update_edid_property(connector, edid);
+			intel_dp->edid_quirks =3D drm_dp_get_edid_quirks(edid);
 		} else {
 			kfree(edid);
 			edid =3D ERR_PTR(-EINVAL);
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
index b8aee506d595..82843272a873 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -50,7 +50,7 @@ static int intel_dp_mst_compute_link_config(struct inte=
l_encoder *encoder,
 	const struct drm_display_mode *adjusted_mode =3D
 		&crtc_state->hw.adjusted_mode;
 	void *port =3D connector->port;
-	bool constant_n =3D drm_dp_has_quirk(&intel_dp->desc,
+	bool constant_n =3D drm_dp_has_quirk(&intel_dp->desc, 0,
 					   DP_DPCD_QUIRK_CONSTANT_N);
 	int bpp, slots =3D -EINVAL;
=20
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
index db3d1561e9bf..377828dd2884 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -287,7 +287,7 @@ void intel_psr_init_dpcd(struct intel_dp *intel_dp)
 	drm_dbg_kms(&dev_priv->drm, "eDP panel supports PSR version %x\n",
 		    intel_dp->psr_dpcd[0]);
=20
-	if (drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_NO_PSR)) {
+	if (drm_dp_has_quirk(&intel_dp->desc, 0, DP_DPCD_QUIRK_NO_PSR)) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "PSR support not currently available for this panel\n");
 		return;
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 262faf9e5e94..7f5dd2ee4a94 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1495,13 +1495,16 @@ struct drm_dp_desc {
=20
 int drm_dp_read_desc(struct drm_dp_aux *aux, struct drm_dp_desc *desc,
 		     bool is_branch);
+u32 drm_dp_get_edid_quirks(const struct edid *edid);
=20
 /**
  * enum drm_dp_quirk - Display Port sink/branch device specific quirks
  *
  * Display Port sink and branch devices in the wild have a variety of bu=
gs, try
  * to collect them here. The quirks are shared, but it's up to the drive=
rs to
- * implement workarounds for them.
+ * implement workarounds for them. Note that because some devices have
+ * unreliable OUIDs, the EDID of sinks should also be checked for quirks=
 using
+ * drm_dp_get_edid_quirks().
  */
 enum drm_dp_quirk {
 	/**
@@ -1537,14 +1540,16 @@ enum drm_dp_quirk {
 /**
  * drm_dp_has_quirk() - does the DP device have a specific quirk
  * @desc: Device decriptor filled by drm_dp_read_desc()
+ * @edid_quirks: Optional quirk bitmask filled by drm_dp_get_edid_quirks=
()
  * @quirk: Quirk to query for
  *
  * Return true if DP device identified by @desc has @quirk.
  */
 static inline bool
-drm_dp_has_quirk(const struct drm_dp_desc *desc, enum drm_dp_quirk quirk=
)
+drm_dp_has_quirk(const struct drm_dp_desc *desc, u32 edid_quirks,
+		 enum drm_dp_quirk quirk)
 {
-	return desc->quirks & BIT(quirk);
+	return (desc->quirks | edid_quirks) & BIT(quirk);
 }
=20
 #ifdef CONFIG_DRM_DP_CEC
--=20
2.24.1

