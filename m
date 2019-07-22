Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEFF70ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfGVUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 16:34:00 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:40466 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728467AbfGVUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:34:00 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id E861070D32
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:33:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pf0RhHIBg90onpf0RhACHG; Mon, 22 Jul 2019 15:33:59 -0500
X-Authority-Reason: nr=8
Received: from cablelink149-185.telefonia.intercable.net ([201.172.149.185]:48474 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hpf0R-003M3r-00; Mon, 22 Jul 2019 15:33:59 -0500
Date:   Mon, 22 Jul 2019 15:33:58 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] video: fbdev: pvr2fb: remove unnecessary comparison of
 unsigned integer with < 0
Message-ID: <20190722203358.GA29111@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.149.185
X-Source-L: No
X-Exim-ID: 1hpf0R-003M3r-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink149-185.telefonia.intercable.net (embeddedor) [201.172.149.185]:48474
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to compare *var->xoffset* or *var->yoffset* with < 0
because such variables are of type unsigned, making it impossible to
hold a negative value.

Fix this by removing such comparisons.

Addresses-Coverity-ID: 1451964 ("Unsigned compared against 0")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/pvr2fb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 7ff4b6b84282..0a3b2b7c7891 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -458,13 +458,11 @@ static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	set_color_bitfields(var);
 
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->xoffset || var->yoffset < 0 ||
-		    var->yoffset >= var->yres_virtual) {
+		if (var->xoffset || var->yoffset >= var->yres_virtual) {
 			var->xoffset = var->yoffset = 0;
 		} else {
 			if (var->xoffset > var->xres_virtual - var->xres ||
-			    var->yoffset > var->yres_virtual - var->yres ||
-			    var->xoffset < 0 || var->yoffset < 0)
+			    var->yoffset > var->yres_virtual - var->yres)
 				var->xoffset = var->yoffset = 0;
 		}
 	} else {
-- 
2.22.0

