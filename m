Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62990E1892
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404689AbfJWLLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 07:11:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404635AbfJWLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:11:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so20774058wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 04:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzSjfdz533CXX+r31DyH1zv/LJLKdHTy5BRlOQmdA1w=;
        b=CsET8hcbLI3OciXqB6UqhYW9x2GYFB7JmE5P+Ooq3o8rcWqs4sM9XhVDqvjGQCjzl5
         IBVclOk7yuYq6LBKSmFVXvlGuyAcFUgCaEuxU6Xj93tUEDx56Pya9PmXn2PQoUPDGxk1
         o4n9TC9BQ4236MlB7JdzJCqKgjdA19hCUu5IFPEkscp6Z55mJBzBXYz0F5Nj4uqMaQpQ
         2u/oZPwHe5g+V1RnSgBQdWlYg4VWkIu2vQ/G5k25KJZax78O4AjmMe/E6hB7mFZgqyt4
         0qOxGSQ9NPcGVn6fPZoo0qP6qygtOLgci+4wSWXBzvzMkJ5kDKFPZg7xq2JlmADh4n4Q
         1zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzSjfdz533CXX+r31DyH1zv/LJLKdHTy5BRlOQmdA1w=;
        b=C/tMcBGqFoLumA/HT6KtFx9KK67kRZSY3QITJk+17mx/nZaxS3cypOQU/8KeJ0LyRB
         u8pb2BVgqpf5dsK1dkFxqFdybeo0qjkFn+IlZ9lQq3L8Rxg+PlvTuL7eIVh0wtdMmqEp
         hVsTXgJ//Tyv3v60BF2QHjHGdVodyb1ROGFO//fZW3QEFAl6eaYt60DxAqEcHUhfvrJi
         LMVGgETrc8x+TF4yh+JubqpU+7Kg7xS369d0E2fNFRKYliM1gGv0nFbJj1cx0NX5Vcsz
         e5wHXG/BcBomKKcZ2Kbyth2TpPx0b0DoKmQDE/DWDgjwFfqy71DJ6lfvIR1Da9ongqpp
         Jnsw==
X-Gm-Message-State: APjAAAWu/fWJuRQGC3j3wXEKUEyOAsxUZH64STr4uT/Zq61zI3sxdaUU
        Ua9DPWXL9K72Ha/U1VEVMWg=
X-Google-Smtp-Source: APXvYqzUTDjQy3LrwkwZs2bBatVab+bvLDTd9dRiBCyXxGuu6zQEGe5OeJKmIE0AkB/nB3zMglCIJQ==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr7311192wmq.137.1571829072881;
        Wed, 23 Oct 2019 04:11:12 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id 1sm3850170wrr.16.2019.10.23.04.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 04:11:12 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch
Subject: [Outreachy][PATCH] drm/mediatek: remove cast to pointers passed to kfree
Date:   Wed, 23 Oct 2019 14:11:07 +0300
Message-Id: <20191023111107.9972-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary casts to pointer types passed to kfree.
Issue detected by coccinelle:
@@
type t1;
expression *e;
@@

-kfree((t1 *)e);
+kfree(e);

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index ca672f1d140d..b04a3c2b111e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -271,7 +271,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 			       pgprot_writecombine(PAGE_KERNEL));
 
 out:
-	kfree((void *)sgt);
+	kfree(sgt);
 
 	return mtk_gem->kvaddr;
 }
@@ -285,5 +285,5 @@ void mtk_drm_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 
 	vunmap(vaddr);
 	mtk_gem->kvaddr = 0;
-	kfree((void *)mtk_gem->pages);
+	kfree(mtk_gem->pages);
 }
-- 
2.23.0

