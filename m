Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B24189268
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 01:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCRAEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 20:04:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51207 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgCRAEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584489872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZGul9wAdAsYKRs6DsvL3qGxyS9Wfr9NLLvWL1Wy7L4=;
        b=WZVZn217dsYf1b12WXJRrAao6q30ALGwA4LOeQBBDuaH5asWdkgzgSrgc2LQmlyNo29u9C
        hXUNIuVc+AwO4OWb/+A7YaLE7YtrClOlY7YeqwFlnmdntkVju9FR6zXd7QSK7oLZB4ZdH7
        GGYEFKsJ5F+3GiswTGMoMo6fZXDyrro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-PKDNyvXWM0KupGYUccKZuw-1; Tue, 17 Mar 2020 20:04:28 -0400
X-MC-Unique: PKDNyvXWM0KupGYUccKZuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DA8F1137840;
        Wed, 18 Mar 2020 00:04:27 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3C3B5DA81;
        Wed, 18 Mar 2020 00:04:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau/connector: Fix DDC error when probing force-disabled connectors
Date:   Tue, 17 Mar 2020 20:04:23 -0400
Message-Id: <20200318000423.205005-2-lyude@redhat.com>
In-Reply-To: <20200318000423.205005-1-lyude@redhat.com>
References: <20200318000423.205005-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
index 0d42a7e5deff..9fb00c4b9764 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -550,6 +550,9 @@ nouveau_connector_detect(struct drm_connector *connec=
tor, bool force)
 	int ret;
 	enum drm_connector_status conn_status =3D connector_status_disconnected=
;
=20
+	if (connector->force =3D=3D DRM_FORCE_OFF)
+		return conn_status;
+
 	/* Cleanup the previous EDID block. */
 	if (nv_connector->edid) {
 		drm_connector_update_edid_property(connector, NULL);
--=20
2.24.1

