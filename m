Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EFFAAC27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbfIEToh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:44:37 -0400
Received: from fieldses.org ([173.255.197.46]:56702 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfIETof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C193A201B; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/9] staging: wlan-ng: use "%*pE" for serial number
Date:   Thu,  5 Sep 2019 15:44:27 -0400
Message-Id: <1567712673-1629-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Almost every user of "%*pE" in the kernel uses just bare "%*pE".  This
is the only user of "%pEhp".  I can't see why it's needed.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 drivers/staging/wlan-ng/prism2sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index fb5441399131..8f25496188aa 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -846,7 +846,7 @@ static int prism2sta_getcardinfo(struct wlandevice *wlandev)
 	result = hfa384x_drvr_getconfig(hw, HFA384x_RID_NICSERIALNUMBER,
 					snum, HFA384x_RID_NICSERIALNUMBER_LEN);
 	if (!result) {
-		netdev_info(wlandev->netdev, "Prism2 card SN: %*pEhp\n",
+		netdev_info(wlandev->netdev, "Prism2 card SN: %*pE\n",
 			    HFA384x_RID_NICSERIALNUMBER_LEN, snum);
 	} else {
 		netdev_err(wlandev->netdev, "Failed to retrieve Prism2 Card SN\n");
-- 
2.21.0

