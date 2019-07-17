Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCE6B709
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfGQG6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 02:58:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfGQG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:58:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 878B3B2BD220132AE72E;
        Wed, 17 Jul 2019 14:57:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 14:57:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dri-devel@lists.freedesktop.org>, <bskeggs@redhat.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/nouveau/secboot: Make acr_r352_ls_gpccs_func static
Date:   Wed, 17 Jul 2019 14:56:26 +0800
Message-ID: <20190717065626.42016-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c:1092:1:
 warning: symbol 'acr_r352_ls_gpccs_func' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
index 4fd4cfe..7af971d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
@@ -1088,7 +1088,7 @@ acr_r352_ls_gpccs_func_0 = {
 	.lhdr_flags = LSF_FLAG_FORCE_PRIV_LOAD,
 };
 
-const struct acr_r352_ls_func
+static const struct acr_r352_ls_func
 acr_r352_ls_gpccs_func = {
 	.load = acr_ls_ucode_load_gpccs,
 	.version_max = 0,
-- 
2.7.4


