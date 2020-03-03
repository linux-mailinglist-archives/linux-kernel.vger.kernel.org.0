Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD217850E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 22:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgCCVrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 16:47:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43963 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:47:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id j5so4620304otn.10;
        Tue, 03 Mar 2020 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kzS7sppGtoeQZStlmLGTvgFs7IdS5XigTWRah7nTvXo=;
        b=NhF5+mnsG1Ih/AIs16uFf3EZ1vDLZH2/LM4uFBE5p0HBDSAhMksi1AlZMsTdpW9MCb
         FbsM7a1tmWyul9BrfgNnI1WcRQ+dm/XoDE+inLceEecql/2m8WK38PQf2lIIVhrvI0Ty
         ifpmwEgagy4UrImGjkc42E2U9lxSaC6mirsrzYWWvCv4L26vtiY4M/5DFO3DVdYRxfZw
         MxOatoVNLEBCjzqiMXJhkc1D7/YsfMOO6TKaReb5/4OOYgPT4PNkkajZWBcd+ZAoY9RA
         M3QLgzKaxQDMnubjyQzR5/WBVMapohx/KQgu6TyQj9BTYfs7AXaVj9jMmOkGFozdmGfH
         pFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kzS7sppGtoeQZStlmLGTvgFs7IdS5XigTWRah7nTvXo=;
        b=e7b4HonVYLQioFBAmzf9W93KnPbCSZHSQe+Lz0wAuQh/zuHiPBFaNeyWm+P2GrKoOT
         bU7995xUKwvDsx6WqGJZLupJphcI9ORxi4vW7DgIkqq42C/uX8dCL7kXHgbgpfOZQSFv
         DmeeTNHqf8+k8w7GgoHP3Rqhln6A7CstnJcxxfI1yPfFfNxTaD3CSD19yXSbZ6SPwo9D
         g2J2vNaD8Dlqb9XRq7s8MBRchL5a091BTD50Tc/X1+Yc4nlUfbB/CN+7Qjcg6eQuG+Ns
         kFJ+U0XNiHOYhaFzzJNqTlQdFVMbko/BLyE9Z7GUb1VT5Vm6xevL3D+IJD3tEOpJQDxz
         RW0g==
X-Gm-Message-State: ANhLgQ1jhZBT2SfCVxGVlwVf9hPj3Pw8Fz69byw6IlmLs2VUNxFYKRZK
        iqRg61BxlKQ/L6WTu4uR3VkpMh1Nj2csTo2vbUtKuYVH2Tw=
X-Google-Smtp-Source: ADFU+vuDjdyRB3ehuG18m1u1HXkDauvyAATDfc8Cq4w7yAjGn9kV3muaZEkknO/VzqE6ZzRHvu5tlen8TgfRi1imdXw=
X-Received: by 2002:a05:6830:104d:: with SMTP id b13mr4526678otp.42.1583272053229;
 Tue, 03 Mar 2020 13:47:33 -0800 (PST)
MIME-Version: 1.0
From:   Tony Fischetti <tony.fischetti@gmail.com>
Date:   Tue, 3 Mar 2020 16:47:22 -0500
Message-ID: <CAOMV6SWp3UgY+4AThCLeYmAk2gmh5m0UhG7+=ujPvKFsUdjU-A@mail.gmail.com>
Subject: Trouble adding QUIRK_ALWAYS_POLL to quirky USB mouse
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a lenovo pixart mouse (vendorId: 0x17ef, productId: 0x608d)
that's afflicted with the apparently common problem of disconnecting
and re-connecting every minute, each time incrementing the device
number

I tried to apply a patch very much like the one in this commit with
the identical problem: dcf768b0ac868630e7bdb6f2f1c9fe72788012fa
The particular patch I applied appears at the end of this email (not
meant to be submitted/applied, just as a reference)

The problem is that when I apply the patch and boot the new kernel,
the quirk appears not to have been registered (it doesn't appear in
/sys/module/usbhid/parameters/quirks)
It is only when I add the kernel boot parameter
usbhid.quirks=0x17ef:0x608d:0x00000400 that it appears to be working

Anyone have any ideas on how to fix this? I'd like to submit a patch
fixing this issue once I get it sorted out

Thank you for your time.

---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3a400ce603c4..9e1dfc714ea8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -726,6 +726,7 @@
 #define USB_DEVICE_ID_LENOVO_X1_COVER    0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB    0x60a3
 #define USB_DEVICE_ID_LENOVO_X1_TAB3    0x60b5
+#define USB_DEVICE_ID_LENOVO_PIXART_USB_OPTICAL_MOUSE    0x608d

 #define USB_VENDOR_ID_LG        0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH    0x0064
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0e7b2d998395..247747d6d8cf 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -103,6 +103,7 @@ static const struct hid_device_id hid_quirks[] = {
     { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_KYE,
USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
+    { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO,
USB_DEVICE_ID_LENOVO_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL
},
     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_C007), HID_QUIRK_ALWAYS_POLL },
     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_C077), HID_QUIRK_ALWAYS_POLL },
     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS), HID_QUIRK_NOGET },
--
