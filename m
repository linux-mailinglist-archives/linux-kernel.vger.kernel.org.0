Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78592B4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfE0MYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:24:10 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:47220 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE0MYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:24:10 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id HQQ82000B3XaVaC01QQ8ji; Mon, 27 May 2019 14:24:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEfg-0001U2-Bd; Mon, 27 May 2019 14:24:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEfg-0001YZ-A7; Mon, 27 May 2019 14:24:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] scif: Spelling s/EACCESS/EACCES/
Date:   Mon, 27 May 2019 14:24:07 +0200
Message-Id: <20190527122407.5939-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct spelling is EACCES:

include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/scif.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/scif.h b/include/linux/scif.h
index eeb250b73c4b9505..329e695b8fe5c0b2 100644
--- a/include/linux/scif.h
+++ b/include/linux/scif.h
@@ -657,7 +657,7 @@ int scif_unregister(scif_epd_t epd, off_t offset, size_t len);
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
@@ -733,7 +733,7 @@ int scif_readfrom(scif_epd_t epd, off_t loffset, size_t len, off_t
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
@@ -815,7 +815,7 @@ int scif_writeto(scif_epd_t epd, off_t loffset, size_t len, off_t
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
@@ -895,7 +895,7 @@ int scif_vreadfrom(scif_epd_t epd, void *addr, size_t len, off_t roffset,
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
-- 
2.17.1

