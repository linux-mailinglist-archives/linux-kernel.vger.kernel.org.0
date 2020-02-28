Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADF174308
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 00:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1X1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 18:27:50 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:40652 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgB1X1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:27:50 -0500
Received: by mail-pj1-f74.google.com with SMTP id md7so1237591pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ob/5oXc1aBLbQ8gDjyGAYrNAMQyHz5Vfyh0BFVF2PXg=;
        b=V68BGD6c6nVMGPh8VWAab/99utI1iJ7FNm8spdAwS9N91x27TbfKcivQxfuwgFhI7n
         sE/ly+W7L/HdZAccinIme+WmvN/1ccX5fPUV3RFFUkjuCYPrggyP4vU4HH1mGvtqxuGE
         1MLt0GpOBFAK8WVDz0iEZayq9PHhyOgOycdeBdEnlDm74IolVteLLaXUQd0uFO3B0kes
         T0hTWrbleB+JbqBQF8Aqphegfm7AG7/xeLCGSkI57lf3/RO76Zlsfmud2z/aolu1KTCE
         7zP3W00/tYkGS/s1WSSnnxGyRCvmZi/ZLozDw60KBefAgB9N3veAzod8F41d5Ukq69UK
         sUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ob/5oXc1aBLbQ8gDjyGAYrNAMQyHz5Vfyh0BFVF2PXg=;
        b=mCZHeZ/+nR+TzoVqh8bjo75nUNbr3Z/KfzedYIUJKaXn2vAghiUsAl3+1AKGD6Lcd4
         5CXldQBU5AXRVDTUpz/SgtyQVwWbnTxm2h0HMWIQ6CednFTPDQJ41NgS1kFV+L4LvPKC
         SvydmegadqerHypPcappDFkva5Bn7K4YUcZzcJb3Gk1w4+L+N5nBw1tMIKctvh6jmNV8
         ktU8zxKwaKzx98KoIz/uClPMCGrbJjDRbu3NzejFLr7OGPmtJizZ6iouOW6wFHf9REpi
         yfm0Au7sU6DEbKmrhcXl5phCRJV+seYkn5ku4jDL2QJpbTk4BDbwqzTye0roJiQd08ja
         stVw==
X-Gm-Message-State: APjAAAWOqhvo0hgmb2ZcYrKLA9nuziw6LHhXOfex4c+2rIoToMUjdfNX
        95pKTmqf7eTsBWEBp4Q1G+03mD0hFLl0uMwj
X-Google-Smtp-Source: APXvYqy+LMQ7kC0uc5IE8dzERpI0LHDaCj6brMoJUpX00hk6yAbzjJv039vBP0TBIJUBGpswJ96ErCym/lWu6FiH
X-Received: by 2002:a63:1210:: with SMTP id h16mr6864227pgl.408.1582932469440;
 Fri, 28 Feb 2020 15:27:49 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:27:36 -0800
Message-Id: <20200228232736.182780-1-rammuthiah@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH RESEND] virtio: virtio_pci_legacy: Remove default y from Kconfig
From:   Ram Muthiah <rammuthiah@google.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ram Muthiah <rammuthiah@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy pci driver should no longer be default enabled. QEMU has
implemented support for Virtio 1 for virtio-pci since June 2015
on SHA dfb8e184db75.

Signed-off-by: Ram Muthiah <rammuthiah@google.com>
---
 drivers/virtio/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 078615cf2afc..eacd0b90d32b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -26,7 +26,6 @@ config VIRTIO_PCI
 
 config VIRTIO_PCI_LEGACY
 	bool "Support for legacy virtio draft 0.9.X and older devices"
-	default y
 	depends on VIRTIO_PCI
 	---help---
           Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
@@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
 	  If disabled, you get a slightly smaller, non-transitional driver,
 	  with no legacy compatibility.
 
-          So look out into your driveway.  Do you have a flying car?  If
-          so, you can happily disable this option and virtio will not
-          break.  Otherwise, leave it set.  Unless you're testing what
-          life will be like in The Future.
-
 	  If unsure, say Y.
 
 config VIRTIO_PMEM
-- 
2.25.0.265.gbab2e86ba0-goog

