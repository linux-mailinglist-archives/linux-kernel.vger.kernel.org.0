Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E25AAC26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391407AbfIETog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:44:36 -0400
Received: from fieldses.org ([173.255.197.46]:56692 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfIETof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AFF2C1CE6; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/9] rtl8192*: display ESSIDs using %pE
Date:   Thu,  5 Sep 2019 15:44:25 -0400
Message-Id: <1567712673-1629-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20190905193604.GC31247@fieldses.org>
References: <20190905193604.GC31247@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Everywhere else in the kernel ESSIDs are printed using %pE, and I can't
see why there should be an exception here.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2dd57e88276e..096254e422b3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2132,7 +2132,7 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
 		return escaped;
 	}
 
-	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
+	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
 	return escaped;
 }
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index d36963469015..3963a08b9eb2 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2426,7 +2426,7 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
 		return escaped;
 	}
 
-	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
+	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
 	return escaped;
 }
 
-- 
2.21.0

