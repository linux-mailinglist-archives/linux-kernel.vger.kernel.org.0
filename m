Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEBD0FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJINPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 09:15:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57348 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfJINPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:15:33 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIBoN-0006s3-B8; Wed, 09 Oct 2019 14:15:27 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIBoM-00019G-PA; Wed, 09 Oct 2019 14:15:26 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/falcon: make unexported objects static
Date:   Wed,  9 Oct 2019 14:15:25 +0100
Message-Id: <20191009131525.4352-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the msgqueue_0148cdec_acr_func and msgqueue_0148cdec_func
static to avoid the following sparse warnings:

drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c:230:1: warning: symbol 'msgqueue_0148cdec_acr_func' was not declared. Should it be static?
drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c:241:1: warning: symbol 'msgqueue_0148cdec_func' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c b/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c
index 9424803b9ef4..dfc0d50f080b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue_0148cdec.c
@@ -226,7 +226,7 @@ acr_boot_falcon(struct nvkm_msgqueue *priv, enum nvkm_secboot_falcon falcon)
 	return 0;
 }
 
-const struct nvkm_msgqueue_acr_func
+static const struct nvkm_msgqueue_acr_func
 msgqueue_0148cdec_acr_func = {
 	.boot_falcon = acr_boot_falcon,
 };
@@ -237,7 +237,7 @@ msgqueue_0148cdec_dtor(struct nvkm_msgqueue *queue)
 	kfree(msgqueue_0148cdec(queue));
 }
 
-const struct nvkm_msgqueue_func
+static const struct nvkm_msgqueue_func
 msgqueue_0148cdec_func = {
 	.init_func = &msgqueue_0148cdec_init_func,
 	.acr_func = &msgqueue_0148cdec_acr_func,
-- 
2.23.0

