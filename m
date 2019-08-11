Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8F8903C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfHKHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 03:46:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51964 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfHKHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:46:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so9541793wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=MJn0KjzR9d9qhDLXLThhDOGcv5ptliBo2sRHufx7aiU=;
        b=PnQLt8QAAvhfqSz08Txnsr55jybar27DrtE8+XnOhCK/Mp1bodGPji4KI9X03t+gS8
         lioj2qNTKuirI+UL/e5AZ/kEv6j/TnJu10KUOqk2WemDNWjsys7nHRinBzi3IUx/gquO
         GO+oW/8w2ZiIOqK4SfPVYAvngbNpXW8FXchMT41qv/Q3Ik6nJNINaEcV1Wm92h6K0eyg
         mulrAIV/+pYnhuQwn6WqFrTlETC7DOwXAJzJnLXQBBjG+BNC+tkmiih7c1O6NjR4CWpy
         XkQcUcsWt1yFXSbKrdGFwH6W0aPLUsbUO2WpLG1X3QHLW2BhwztNjw16/bL5MDZiLF0L
         ZVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=MJn0KjzR9d9qhDLXLThhDOGcv5ptliBo2sRHufx7aiU=;
        b=LQDRTd8P5t3rcOXUI++sPtxgfIcd8PRAJI6MLgqgDreXuCiFJ89ahYy7cPT9wTIdCO
         DEpWdunBdfgOFo4EiXrm0As9zc3+5WTqMtkiXfDao9oPNDg9f4mCWtI6Uk34CQbzsgjd
         qUHLpOl5djL6H25WyBOqKwJSga8PtYRC3yYJzZuSncoL9O0g21hmwbgFQOLa7+/iK1Dv
         sV3u5O+clw4o0duJkB9j0o5RFsPE1gZPCa2qZyeTk4ZREF/f64Pw9oqACpmWg+1AjVe3
         2oQ2ILGdl1AyNs87S5K3iSfr6LTjC3rteRvFCywWej1bJVdjF4tQTdUhaCoW+AJm5+lC
         NDUQ==
X-Gm-Message-State: APjAAAUOqgZBPT6G3D2zerc/lbiXE6DrPs78AjzE4WfzC4w/KcEbhcMp
        6A7qP1kfQRXpp9kZMPM2TQfcrRPEy9w=
X-Google-Smtp-Source: APXvYqyiepx8aC80YwvTay5g1PhCt+1KLhnqwhvPF0NUtLAAaJt5hbqJEiVQfqY9xKElMo5XGh3zGQ==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr22308405wmf.161.1565509616227;
        Sun, 11 Aug 2019 00:46:56 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x11sm8722636wmi.26.2019.08.11.00.46.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 00:46:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2] habanalabs: print to kernel log when reset is finished
Date:   Sun, 11 Aug 2019 10:46:53 +0300
Message-Id: <20190811074653.5655-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't print the queue testing messages, we need to print when
the reset is finished so whoever looks at the kernel log will know the
reset process was finished successfully and the driver is not stuck.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
- Changed message level to dev_warn to match up with the message level
  when the reset starts
 
 drivers/misc/habanalabs/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 9a5926888b99..a35b155add11 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	else
 		hdev->soft_reset_cnt++;
 
+	dev_warn(hdev->dev, "Successfully finished resetting the device\n");
+
 	return 0;
 
 out_err:
-- 
2.17.1

