Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231D62C6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE1MqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 08:46:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47000 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1MqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:46:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id bb3so686694plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XvWy9Ige1sfP5GT/Mh8G7qthYrtAUw/mgPzDC+qwoHk=;
        b=cr2OoF5u8MSTKsvY/gLN7KgwgDBZUvBCyMu2Sqv0yCZ6PpmYvKmwkPNReE5EAAoyM+
         HEBryq1nDjFjfWMvv53j2p6Hz4O9m8eNIu0DOl7qcFcZ7H92rd5xW8ojKO5Hd9hXwD52
         Wd+qGdkYYOGPgfijfHrYVphUEB/CM6SoA9jHrY/7/GYf2jvRqV6M3wJ9j2Mv4/dVjp71
         CTReIWRvBT/HtYraVwssqi1Dg6QjqU/PK6hyFITABkrk9LaUYyMe/evuYiDwVhUeG65p
         qWc/fTWz0SuPyKTZrtbhTFw8sGW8721cYMEcJyDRi27vVk3y8snn1ChcwCENhvS+AwIz
         tF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XvWy9Ige1sfP5GT/Mh8G7qthYrtAUw/mgPzDC+qwoHk=;
        b=ah7RbzDHIgT/Z0RuPXXG+tRt9vg+U7+sYuVSEbM6PXuFHUAj27YgxWlkNxWieNp2c4
         V9k+2NNcahRdAnCq9qGm7k5tftqcqdXRnKUqWL73anfwMDTUY/4C5J8ls6aaPyewXxzL
         LddFrTEDUsAaWCIso4ow0NdEXQVn8KHkQ1ak+z+rZLjShDTSeECy3K9NwRSN2CPt2q72
         4+sKDE7OJOAhmnlnXnG9UAB/caPqHoFyTIc47kQXV+VfPggFYJKRqSLm4kKtWsuND7fH
         UjEeOFhAIukONGfiQN5JaJ02zqFUvvZIsRJ/1vbse77Ozy+KmhyA9GYT1Dff3p8xQrSh
         k8Kw==
X-Gm-Message-State: APjAAAVWuI2INHRjZXOoI51aRrf0N13t6WGXVzT9KdGXSMcnHYDqODxW
        LqQ2pTDBAm0cp1WJ0IHwfV5qprmZyLd8rg==
X-Google-Smtp-Source: APXvYqxld67kNB13v1BW26lIQKvJ4FpVM4r/RxPZZUhNibQWsp/E10jdZPhdr4PXOyZg8rwF4x7T9g==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr39631175pla.108.1559047565330;
        Tue, 28 May 2019 05:46:05 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id r18sm22811868pfg.141.2019.05.28.05.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 05:46:04 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     hdegoede@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] vboxguest: check for private_data before trying to close it.
Date:   Tue, 28 May 2019 20:47:14 +0800
Message-Id: <1559047634-24397-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vbg_misc_device_close doesn't check that filp->private_data is non-NULL
before trying to close_session, where vbg_core_close_session uses pointer
session whithout checking, too. That can cause an oops in certain error
conditions that can occur on open or lookup before the private_data is set.

This vulnerability is similar to CVE-2011-1771.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 6e8c0f1..b03c16f 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -88,8 +88,10 @@ static int vbg_misc_device_user_open(struct inode *inode, struct file *filp)
  */
 static int vbg_misc_device_close(struct inode *inode, struct file *filp)
 {
-	vbg_core_close_session(filp->private_data);
-	filp->private_data = NULL;
+	if (file->private_data != NULL) {
+		vbg_core_close_session(filp->private_data);
+		filp->private_data = NULL;
+	}
 	return 0;
 }
 
-- 
2.7.4

