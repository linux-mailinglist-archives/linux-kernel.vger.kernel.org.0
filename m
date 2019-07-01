Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5F38922
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfFGLgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 07:36:03 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:54918 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFGLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:36:02 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id Mnc02000C3XaVaC01nc0EL; Fri, 07 Jun 2019 13:36:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZDA8-0004Fz-5g; Fri, 07 Jun 2019 13:36:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZDA8-0003wW-3R; Fri, 07 Jun 2019 13:36:00 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mm/balloon_compaction: Grammar s/the its/its/
Date:   Fri,  7 Jun 2019 13:35:59 +0200
Message-Id: <20190607113559.15115-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/balloon_compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index ba739b76e6c52e55..17ac81d8d26bcb50 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
 /*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
- *			  the its address to allow the driver release the page.
+ *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device decriptor where we will grab a page from.
  *
  * Driver must call it to properly de-allocate a previous enlisted balloon page
-- 
2.17.1

