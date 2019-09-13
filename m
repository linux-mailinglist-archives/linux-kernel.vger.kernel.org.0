Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5BB285D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404088AbfIMW1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 18:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404072AbfIMW1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16B00308402D;
        Fri, 13 Sep 2019 22:27:15 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C40460BF1;
        Fri, 13 Sep 2019 22:27:14 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/encoder: Don't raise voice in drm_encoder_mask() documentation
Date:   Fri, 13 Sep 2019 18:27:03 -0400
Message-Id: <20190913222704.8241-4-lyude@redhat.com>
In-Reply-To: <20190913222704.8241-1-lyude@redhat.com>
References: <20190913222704.8241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 13 Sep 2019 22:27:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to raise our voice when saying encoder, we're all
civilized adults here!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_encoder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index d65173d413b7..f06164f44efe 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -198,7 +198,7 @@ static inline unsigned int drm_encoder_index(const struct drm_encoder *encoder)
 }
 
 /**
- * drm_encoder_mask - find the mask of a registered ENCODER
+ * drm_encoder_mask - find the mask of a registered encoder
  * @encoder: encoder to find mask for
  *
  * Given a registered encoder, return the mask bit of that encoder for an
-- 
2.21.0

