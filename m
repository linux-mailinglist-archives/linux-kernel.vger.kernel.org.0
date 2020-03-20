Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9018C539
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 03:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCTCV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 22:21:28 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:19801 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgCTCV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:21:27 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id E726A7F650;
        Fri, 20 Mar 2020 02:21:26 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 48k6w61JWRz45gV;
        Fri, 20 Mar 2020 02:21:26 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from tails.my.domain (om126255013092.24.openmobile.ne.jp [126.255.13.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 547E71DCC4;
        Fri, 20 Mar 2020 02:21:23 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
From:   Emmanuel Vadot <manu@FreeBSD.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, noralf@tronnes.org, kraxel@redhat.com,
        tglx@linutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@FreeBSD.org>
Subject: [PATCH 1/2] drm/client: Dual licence the header in GPL-2 and MIT
Date:   Fri, 20 Mar 2020 03:21:13 +0100
Message-Id: <20200320022114.2234-1-manu@FreeBSD.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source file was dual licenced but the header was omitted, fix that.
Contributors for this file are:
Daniel Vetter <daniel.vetter@ffwll.ch>
Matt Roper <matthew.d.roper@intel.com>
Maxime Ripard <mripard@kernel.org>
Noralf Trønnes <noralf@tronnes.org>
Thomas Zimmermann <tzimmermann@suse.de>

Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
---
 include/drm/drm_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 3ed5dee899fd..94c9c72c206d 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
 
 #ifndef _DRM_CLIENT_H_
 #define _DRM_CLIENT_H_
-- 
2.25.1

