Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC356E77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFZQOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 12:14:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgArw+nVtTXG7oezfdfD4Z1XiVxNfU8kA8v4SVH+Er8=; b=H8pU6ksMjxPS9r4Rpfv5NA8Hz
        +YS3Oa+ujur3g18XgsDxJQe7f0Mom3EwR5DPIW1GpwAsW1jzd2koULTevDvSOhS7aq+XgZ8HxwiEd
        TBJx1lvgP3P1uks1zEwTL8j7Hk4nAcViKpVzEblKnZXK/C+HKQtdfxbKWHZsRXvpw3hQ3QguTYSzj
        JBRdRCxyzdLJaecnl2YkSxGuJsNkXk4L6tW9lObvi87S5GEGoXU+4/ezOe6GXvTzXJGIAHftGd4GY
        TIQerjgzoce7Z+9ZJOXftSSONKMRf1AWdCShlccCI1jecYU5SL21L+gMj2G/RJa69lKnhkG2NiOtd
        dd95/mUQg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgAYq-0004wb-Ov; Wed, 26 Jun 2019 16:14:16 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgAYo-0008AF-RE; Wed, 26 Jun 2019 13:14:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: fix a reference for a renamed file: fb/modedb.rst
Date:   Wed, 26 Jun 2019 13:14:13 -0300
Message-Id: <699d7618720e2808f9aa094a13ab2f3545c3c25c.1561565652.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to two patches being applied about the same time, the
reference for modedb.rst file got wrong:

	Documentation/fb/modedb.txt is now Documentation/fb/modedb.rst.

Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
Fixes: ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/gpu/drm/drm_modes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 57e6408288c8..4645af681ef8 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1680,7 +1680,7 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
  *
  * Additionals options can be provided following the mode, using a comma to
  * separate each option. Valid options can be found in
- * Documentation/fb/modedb.txt.
+ * Documentation/fb/modedb.rst.
  *
  * The intermediate drm_cmdline_mode structure is required to store additional
  * options from the command line modline like the force-enable/disable flag.
-- 
2.21.0

