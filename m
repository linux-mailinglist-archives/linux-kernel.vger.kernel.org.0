Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2917D16D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 05:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgCHEwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 23:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgCHEwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 23:52:46 -0500
Received: from DESKTOP-GFFITBK.localdomain (220-133-90-194.HINET-IP.hinet.net [220.133.90.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34712072C;
        Sun,  8 Mar 2020 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583643166;
        bh=07rLvQ0WqPhuHx8qZF5jp9yGE4CzHoiFnGAEnIVs0gk=;
        h=From:To:Cc:Subject:Date:From;
        b=m4Zj2xDSjTGoaTSoUSQs6A03ymGE8HVvObv62K525CY3HmsFNgl4Z5A1Z3iGevjsT
         3cvQw3NuBTLUhe8anoVra/G9i1NlTCFUwY9+9+xVVh5i7vPTNKqVNP1fNodUqNOee3
         YH8pFI7s90dQVQ01uqGxnnsCIIQp1kE86Fvz59fk=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] MAINTAINERS: Update Chun-Kuang Hu's email address
Date:   Sun,  8 Mar 2020 12:52:01 +0800
Message-Id: <20200308045201.3163-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address to @kernel.org

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..dceaeebce52a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5607,7 +5607,7 @@ F:	include/uapi/drm/lima_drm.h
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR MEDIATEK
-M:	CK Hu <ck.hu@mediatek.com>
+M:	Chun-Kuang Hu <chunkuang.hu@kernel.org>
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.17.1

