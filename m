Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC04E36A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503211AbfJXP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:27:51 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:60156 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503146AbfJXP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:27:51 -0400
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id HTTo2100U5USYZQ06TTodF; Thu, 24 Oct 2019 17:27:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf1g-00078G-QT; Thu, 24 Oct 2019 17:27:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf1g-0007yY-PQ; Thu, 24 Oct 2019 17:27:48 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] usb: Spelling s/disconnet/disconnect/
Date:   Thu, 24 Oct 2019 17:27:47 +0200
Message-Id: <20191024152747.30617-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "disconnect".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/chipidea/udc.c            | 2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8f18e7b6cadf4306..0b6166a64d72a762 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1612,7 +1612,7 @@ static int ci_udc_selfpowered(struct usb_gadget *_gadget, int is_on)
 }
 
 /* Change Data+ pullup status
- * this func is used by usb_gadget_connect/disconnet
+ * this func is used by usb_gadget_connect/disconnect
  */
 static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
 {
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 20141c3096f68ab4..7114a0ef4b13b4e6 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1208,7 +1208,7 @@ static int fsl_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 }
 
 /* Change Data+ pullup status
- * this func is used by usb_gadget_connect/disconnet
+ * this func is used by usb_gadget_connect/disconnect
  */
 static int fsl_pullup(struct usb_gadget *gadget, int is_on)
 {
-- 
2.17.1

