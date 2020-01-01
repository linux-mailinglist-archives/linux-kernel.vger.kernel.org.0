Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221DE12DE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgAAIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 03:20:16 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56920 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgAAIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 03:20:15 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="429578757"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 09:20:08 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] video: sa1100fb: constify copied structure
Date:   Wed,  1 Jan 2020 08:43:25 +0100
Message-Id: <1577864614-5543-8-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The monspecs structure is only copied into another structure,
so make it const.

The opportunity for this change was found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/video/fbdev/sa1100fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 4680cc3efb81..c77b43dbc256 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1053,7 +1053,7 @@ static int sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
 }
 
 /* Fake monspecs to fill in fbinfo structure */
-static struct fb_monspecs monspecs = {
+static const struct fb_monspecs monspecs = {
 	.hfmin	= 30000,
 	.hfmax	= 70000,
 	.vfmin	= 50,

