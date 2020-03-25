Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122721921FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 08:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCYHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 03:52:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45510 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgCYHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:52:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9so485940pls.12;
        Wed, 25 Mar 2020 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OyMSybDgjLtBHyJeIkj6VwbC+46L2Aw6n03o91VqgKc=;
        b=nDoDTTiZHzzvB2jsefFabUvkfery3Bpl/g896+EwqGpDCT7TNqR+Q2Z0BzX6L5vYAM
         +InqIY1XHQwQZ1/FcisFl9Y8B5CR6BYVZY9n+Z+SwdBhbV9onGUnbQKVR4aIwLuzAv2N
         pt0Ake4CWdDmNbDqTROYP61jfMc4XuipXIgu/EcDnItlPET8j5LZG+rWtrPY74VXplMV
         cIFZM2MH8wy6hcUxrY8+1fxM9EWY2tBwR9rnY1QBoNXWiLEZWi8ddHcSxEfDV1ZDVCk+
         yMDwvOKjz4LRS93sphkoQYIihVQ7WwP9EevTJSZnZYIrm2QbD/bA6ReivYNxZnuQ4F9E
         h8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OyMSybDgjLtBHyJeIkj6VwbC+46L2Aw6n03o91VqgKc=;
        b=euvAYWUFadfIcI+Wqy5ToxsWlGvEarK8e9WaDm/ygiEsxUSBmcLRhJgplLghB4O9OQ
         0f6g9q6V6TiwML9IjTTQdcAPBRLDIsLSUFbSLOiIqoPzG26ubGz29G8VCIneAtBpQAOQ
         kSitu3XDvqQuUQQz2f1EomBcQcJiXnxDF952PGPyQLnsfT89bv+PI+EpbKa5N54wSTRv
         LRmx6yrvCHtd1xgp5jGxh/KZCY9OBf5eFm5KgcgDoWpPB++SIewRdFSXhexswu3NqNKJ
         +spoplIPS2qtcDdgCFbLJuMaEE67bMQEcL3SWNI0IrZamcCjOaa7x851K3Z7Q4zK5o4n
         aPTw==
X-Gm-Message-State: ANhLgQ3sf/wW7qf6HdAFsHEx+I9E/WrlgaTA4wxZGEIvuK8lqVBNUi88
        CzZimFVc+JlGRBulj9BW1CM=
X-Google-Smtp-Source: ADFU+vusxnk8kCNRrmLC5fNeF93JDBXccwRLn9rmfHjTAzwr5ifIQ6m8rVp2oEFRvDTkZdkjUU3uYQ==
X-Received: by 2002:a17:90b:11d6:: with SMTP id gv22mr2357583pjb.31.1585122761049;
        Wed, 25 Mar 2020 00:52:41 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id ev21sm3994786pjb.24.2020.03.25.00.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 00:52:40 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        anenbupt@gmail.com, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] USB: io_edgeport: fix  slab-out-of-bounds Read in edge_interrupt_callback
Date:   Wed, 25 Mar 2020 15:52:37 +0800
Message-Id: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary condition should be (length - 1) as we access data[position+1].

Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/usb/serial/io_edgeport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 5737add..4cca0b8 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -710,7 +710,7 @@ static void edge_interrupt_callback(struct urb *urb)
 		/* grab the txcredits for the ports if available */
 		position = 2;
 		portNumber = 0;
-		while ((position < length) &&
+		while ((position < length - 1) &&
 				(portNumber < edge_serial->serial->num_ports)) {
 			txCredits = data[position] | (data[position+1] << 8);
 			if (txCredits) {
-- 
1.8.3.1

