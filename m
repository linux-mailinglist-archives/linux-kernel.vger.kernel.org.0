Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0B127610
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:02:09 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59360 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLTHCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:02:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2B0A1DFCA6;
        Fri, 20 Dec 2019 07:02:11 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id suoZH-FJMzFf; Fri, 20 Dec 2019 07:02:10 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A30F8DFCA8;
        Fri, 20 Dec 2019 07:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2GlQI33HSVV8; Fri, 20 Dec 2019 07:02:10 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4F4B3DFCA6;
        Fri, 20 Dec 2019 07:02:10 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] USB: EHCI: ehci-mv: drop pxa_ehci_type and unused device IDs
Date:   Fri, 20 Dec 2019 08:02:02 +0100
Message-Id: <20191220070202.239870-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial cleanup.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c           | 6 ++----
 include/linux/platform_data/mv_usb.h | 8 --------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index c8717f06cd8cb..91602e3492084 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -257,10 +257,8 @@ static int mv_ehci_remove(struct platform_device *pd=
ev)
 MODULE_ALIAS("mv-ehci");
=20
 static const struct platform_device_id ehci_id_table[] =3D {
-	{"pxa-u2oehci", PXA_U2OEHCI},
-	{"pxa-sph", PXA_SPH},
-	{"mmp3-hsic", MMP3_HSIC},
-	{"mmp3-fsic", MMP3_FSIC},
+	{"pxa-u2oehci", 0},
+	{"pxa-sph", 0},
 	{},
 };
=20
diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platfor=
m_data/mv_usb.h
index 5376b6d799d5d..20d239c02bf3a 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -6,14 +6,6 @@
 #ifndef __MV_PLATFORM_USB_H
 #define __MV_PLATFORM_USB_H
=20
-enum pxa_ehci_type {
-	EHCI_UNDEFINED =3D 0,
-	PXA_U2OEHCI,	/* pxa 168, 9xx */
-	PXA_SPH,	/* pxa 168, 9xx SPH */
-	MMP3_HSIC,	/* mmp3 hsic */
-	MMP3_FSIC,	/* mmp3 fsic */
-};
-
 enum {
 	MV_USB_MODE_OTG,
 	MV_USB_MODE_HOST,
--=20
2.24.1

