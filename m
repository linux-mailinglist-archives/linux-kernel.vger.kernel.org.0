Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240D6B285E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 00:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404076AbfIMW1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 18:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404021AbfIMW1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BDEA79704;
        Fri, 13 Sep 2019 22:27:14 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A86A60BF1;
        Fri, 13 Sep 2019 22:27:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/encoder: Fix possible_crtcs documentation
Date:   Fri, 13 Sep 2019 18:27:02 -0400
Message-Id: <20190913222704.8241-3-lyude@redhat.com>
In-Reply-To: <20190913222704.8241-1-lyude@redhat.com>
References: <20190913222704.8241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 13 Sep 2019 22:27:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to possible_clones, we don't actually use possible_crtcs until
the driver is registered with userspace. So, fix the documentation to
indicate this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_encoder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 81273b50b3f6..d65173d413b7 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -140,7 +140,7 @@ struct drm_encoder {
 	 * @possible_crtcs: Bitmask of potential CRTC bindings, using
 	 * drm_crtc_index() as the index into the bitfield. The driver must set
 	 * the bits for all &drm_crtc objects this encoder can be connected to
-	 * before calling drm_encoder_init().
+	 * before calling drm_dev_register().
 	 *
 	 * In reality almost every driver gets this wrong.
 	 *
-- 
2.21.0

