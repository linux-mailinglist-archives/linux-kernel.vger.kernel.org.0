Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8938713A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfGWIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 04:12:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729099AbfGWIMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7D72AD45;
        Tue, 23 Jul 2019 08:12:04 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Rossi <issor.oruam@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Fix missing inline
Date:   Tue, 23 Jul 2019 10:11:59 +0200
Message-Id: <20190723081159.22624-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I mistakenly dropped the inline while resolving the patch conflicts in
the previous fix patch.  Without inline, we get compiler warnings wrt
unused functions.

Note that Mauro's original patch contained the correct changes; it's
all my fault to submit a patch before a morning coffee.

Fixes: c8917b8ff09e ("firmware: fix build errors in paged buffer handling code")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/firmware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 842e63f19f22..7ecd590e67fe 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -141,8 +141,8 @@ int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
 int fw_map_paged_buf(struct fw_priv *fw_priv);
 #else
 static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
-static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
-static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
+static inline int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
+static inline int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
 #endif
 
 #endif /* __FIRMWARE_LOADER_H */
-- 
2.16.4

