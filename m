Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385A16F3C0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGUOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 10:49:34 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:46833 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGUOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:49:34 -0400
X-Greylist: delayed 25934 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jul 2019 10:49:33 EDT
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6LEnDGu018230;
        Sun, 21 Jul 2019 23:49:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6LEnDGu018230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563720553;
        bh=ZvBmqSLOzfHz/hzO4+w3rXciLrI8mgXK07czQ76JAGk=;
        h=From:To:Cc:Subject:Date:From;
        b=ahjxzbJhU1v9pWW0Ea6BPbxGhDopYgTjQkgf0PNgBvdUTpnRZFlEImnmfz2yB7e+D
         1VelLDCfe33uBdpRFB3c+oh0IUmQRWzbTV7Slo16YeNATLZnBx73vS9cm+XfO2/XO4
         dw7hkD2cqMWWOq+0h7zrZeC3j506qBvd/Da956PuT5WRYLnOKYqqYjBIiSIaWFLgdu
         lD3nOGToFrySjDHG32u2mriokdJ1Lqn7VG09JweVzkIAE3bS74AiNPJE3Lh5kKx2JI
         OZBGU7Xme/QsksCTRx1gbMYlLqRSDs6QWv78RkuZoIa6Vf4iDE+aNj45dpqGkeEkb1
         JuIYmU+3lxgvQ==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: host: oxu210hp-hcd: remove include/linux/oxu210hp.h
Date:   Sun, 21 Jul 2019 23:49:08 +0900
Message-Id: <20190721144909.5295-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct oxu210hp_platform_data is defined, but not used at all.

$ git grep oxu210hp_platform_data
include/linux/oxu210hp.h:struct oxu210hp_platform_data {

include/linux/oxu210hp.h exists just for defining an unused structure,
so it can go away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/usb/host/oxu210hp.h | 2 --
 include/linux/oxu210hp.h    | 8 --------
 2 files changed, 10 deletions(-)
 delete mode 100644 include/linux/oxu210hp.h

diff --git a/drivers/usb/host/oxu210hp.h b/drivers/usb/host/oxu210hp.h
index 437044147862..67ebea4993b6 100644
--- a/drivers/usb/host/oxu210hp.h
+++ b/drivers/usb/host/oxu210hp.h
@@ -444,5 +444,3 @@ enum ehci_timer_action {
 	TIMER_ASYNC_SHRINK,
 	TIMER_ASYNC_OFF,
 };
-
-#include <linux/oxu210hp.h>
diff --git a/include/linux/oxu210hp.h b/include/linux/oxu210hp.h
deleted file mode 100644
index 94cd25165c08..000000000000
--- a/include/linux/oxu210hp.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* platform data for the OXU210HP HCD */
-
-struct oxu210hp_platform_data {
-	unsigned int bus16:1;
-	unsigned int use_hcd_otg:1;
-	unsigned int use_hcd_sph:1;
-};
-- 
2.17.1

