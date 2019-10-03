Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD2C9939
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJCHv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 03:51:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37660 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJCHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:51:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id DC5D228A7E6
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     kernel@collabora.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Fix comment doc for format_modifiers
Date:   Thu,  3 Oct 2019 09:51:18 +0200
Message-Id: <20191003075118.6257-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002183011.GA29177@ravnborg.org>
References: <20191002183011.GA29177@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To human readers

"array of struct drm_format modifiers" is almost indistinguishable from
"array of struct drm_format_modifiers", especially given that
struct drm_format_modifier does exist.

And indeed the parameter passes an array of uint64_t rather than an array
of structs, but the first words of the comment suggest that it passes
an array of structs.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/gpu/drm/drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index d6ad60ab0d38..0d4f9172c0dd 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
  * @funcs: callbacks for the new plane
  * @formats: array of supported formats (DRM_FORMAT\_\*)
  * @format_count: number of elements in @formats
- * @format_modifiers: array of struct drm_format modifiers terminated by
+ * @format_modifiers: array of format modifiers terminated by
  *                    DRM_FORMAT_MOD_INVALID
  * @type: type of plane (overlay, primary, cursor)
  * @name: printf style format string for the plane name, or NULL for default name
-- 
2.17.1

