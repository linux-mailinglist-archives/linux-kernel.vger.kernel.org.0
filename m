Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3179A45DE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHaTYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 15:24:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33822 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 15:24:07 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so21131625ioa.1;
        Sat, 31 Aug 2019 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oaHmXaw2yPz0umTTJFpjPjSHfSCisDn+J54HsZ0/sx0=;
        b=Z7zt88n/JThY9/taLIJq8U2fmyGpaukSGv5zPuITP0JqqNAzadGRHkxYKrzu4YwCPl
         tnlzxv9ywnEODjBhPKTnHbj7i0Ovtehj3MTb5+mmVZxUSfWY8qIos7HGSTHyburRa/uk
         qU/v0ykpLj2O2Nk/tRX333lWpa0pjuh9JM0mH2rYZjPkhjikBNgyuV7RQNr64VYrDto8
         5c/uVh40Gh3rXWlAbQWahkvSr5Wm5jX3m6+suXinwnXoQmqu2dZytId0Ut+NitMKaeaB
         VquNn61XKb85Sg0iim7vmvHgO6b/SVJ52Qm/yk2OsXeAphfrRjbss2b7d6DQI1587XI/
         gxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oaHmXaw2yPz0umTTJFpjPjSHfSCisDn+J54HsZ0/sx0=;
        b=gGtTB2h+p8KlT4NGilydU3I/zfOd883jBX0HGyjllNuDdLCuckaXFOWzhApDf44K6j
         a6SHDwdpoEIg0Oko6x4QIvJz2srpqQng8ynYFX/EeJPqMZXC8MUu05mtKgTLWds0HXfb
         1Nj8Lr/xweKPWqbBIVUs8BWWvAUYtYN4RwVgZAFAithixetmva2slR9uXZq7/heq0Zdh
         wMIX7gC+sIz488CUYuNZlsIPqAtaQjqI1YrMyKewe8Kxag0cSnOxRCh1mnOTUi3T88Lp
         iZXfWPhLJ1TMkcrVy8WC/3PtfUBrVPv9Ad7hCOpUPK8bIvdVyxQ0HPGcI2L6JxyeWkwu
         rmgQ==
X-Gm-Message-State: APjAAAXMBN9JttrnrNrtT7OxHHYsq3tvAL/2z+k9Qu3HXsT5V4kt2eW9
        Zq6yjFSBcfBiI2gpCxv5RUIqiZal
X-Google-Smtp-Source: APXvYqyp4+WUNod3hb3zn2ZiZKW54EA9jSMX+g5g51j9rn4vYxvGLCPN8yafHdoGPiaTB58QnWyczw==
X-Received: by 2002:a5d:9842:: with SMTP id p2mr14054858ios.226.1567279446858;
        Sat, 31 Aug 2019 12:24:06 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id 8sm8669250ion.26.2019.08.31.12.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 12:24:06 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: bpa10x: change return value
Date:   Sat, 31 Aug 2019 14:23:40 -0500
Message-Id: <20190831192341.32539-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When returning from bpa10x_send_frame, it is necessary to propagate any
potential errno returned from usb_submit_urb.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/bluetooth/bpa10x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index a0e84538cec8..1fa58c059cbf 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -337,7 +337,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 static int bpa10x_set_diag(struct hci_dev *hdev, bool enable)
-- 
2.17.1

