Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529C2157EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 16:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgBJPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 10:36:00 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:46064 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJPf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:35:59 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id AF39379FFC;
        Mon, 10 Feb 2020 15:35:58 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 48GVNt3Wgvz4c85;
        Mon, 10 Feb 2020 15:35:58 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from skull.home.blih.net (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 58EF722AF;
        Mon, 10 Feb 2020 15:35:57 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
From:   Emmanuel Vadot <manu@FreeBSD.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@FreeBSD.Org>,
        Emmanuel Vadot <manu@FreeBSD.org>
Subject: [PATCH 1/2] drm/client: Dual licence the file in GPL-2 and MIT
Date:   Mon, 10 Feb 2020 16:35:43 +0100
Message-Id: <20200210153544.24750-2-manu@FreeBSD.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210153544.24750-1-manu@FreeBSD.org>
References: <20200210153544.24750-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Vadot <manu@FreeBSD.Org>

Change the licence to a dual one with MIT so BSDs could use this file.

Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
---
 drivers/gpu/drm/drm_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index b031b45aa8ef..6b0c6ef8b9b3 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 or MIT
 /*
  * Copyright 2018 Noralf Trønnes
  */
-- 
2.25.0

