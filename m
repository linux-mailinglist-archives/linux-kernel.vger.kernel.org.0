Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00D4EE12
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfFURqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:46:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36480 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFURqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:46:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3362519plt.3;
        Fri, 21 Jun 2019 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wmG7nQ3ZjeGAL8zXM/I+ejbwhwcOiIHr07HrLaqN1Q=;
        b=RnotmZVXBFchEowbf6FK0c/eWPGJWs9KlEvJ2+A/e1EIyVVj+ZbrUd+QFDY9+XTEOD
         SpsIOdoODiNI/99KaH/G0d4sqNFAkGEJy5cP/nLsjw4G/ZGT8FBEBl9VeDeMFIxmlBuX
         vvftVvGv/1v8iCADNwd34/kC+RtAWZj1fEkO75yqHLYrN17SvRDLzFRxDEcZ3Ty02csv
         AeSMnJSVxCBEPnsD+o1I4C3R8i9veGE3TBDGO8+hMQrmMZnIvpYgq1WeKoBV5yzAWI4m
         l6rfcEmXSF6pJXuQzALPnoQSMCf0ll33+Yg3fsEiAycLRK7FlDJ3TKejzZlJsrtUH+zQ
         dzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wmG7nQ3ZjeGAL8zXM/I+ejbwhwcOiIHr07HrLaqN1Q=;
        b=FazCrFNFGj+KJMKdPzt4EDQF3y3ixERISioE+H6PgwSFqeHsqAN9P4Pq0hj7sreFcD
         /WvMdDX1iBuAOwD7sKFfJmdKZDz/xjmz6G8944oGEZO7N+QnDe84vUadBR9ZikG/XGO5
         LaS9aP9B5vz/8mszZ8CIiJCDUJCsQjB+voAo1bcPN0IXfnhRlhA5AYthjj63Cmhxa+oS
         p55psgq7CF0l0wPRyz2e49oKxd2czbPCTFlQ9px6sI6yc8vLHdKEJ69J3tX75nyquebO
         p7VolIG13WHPMDIaHiyc+oc5pt0pEUBXDJsLWsteeiG3R0butuH1o3HbsDIR8aVhTjrS
         AE3g==
X-Gm-Message-State: APjAAAWT5Y8le9Hsm+1VsVIO3w7Oin9wXfSYixBg7Hl2tXdTc7YCEqu3
        rvm7xb3j/IJLuxdhdw50twM=
X-Google-Smtp-Source: APXvYqzIp3eJOksZiHm6o1LHpxx6BAgXNLvQxHLi05/+Fw436Ir+ffk2BaMRp8kzb/l+4PCX0ChUfA==
X-Received: by 2002:a17:902:a517:: with SMTP id s23mr4891858plq.306.1561139168667;
        Fri, 21 Jun 2019 10:46:08 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id e6sm3884820pfn.71.2019.06.21.10.46.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 10:46:08 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, stern@rowland.harvard.edu,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 0/2] usbip: Implement SG support to vhci
Date:   Sat, 22 Jun 2019 02:45:51 +0900
Message-Id: <20190621174553.28862-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are bugs on vhci with usb 3.0 storage device. Originally, vhci
doesn't supported SG. So, USB storage driver on vhci divides SG list
into multiple URBs and it causes buffer overflow on the xhci of the
server. So we need to add SG support to vhci

In this patch series, vhci doesn't map and unmap URB for DMA to use
native SG list (urb->num_sgs). When vhci supports SG, it is useful
to use native SG list instead of mapped SG list because dma mapping
fnuction can adjust the number of SG list that is urb->num_mapped_sgs.

"usbip: Skip DMA mapping and unmapping for urb at vhci" is originally
submitted as separate patch, but I include it in this patch series
because it is needed to implement SG support of vhci.

In this patch, vhci basically support SG and it sends each SG list
entry to the stub driver. Then, the stub driver sees total length of
the buffer and allocates SG table and pages according to the total
buffer length calling sgl_alloc(). After the stub driver receives
completed URB, it again sends each SG list entry to the vhci.
    
If HCD of server doesn't support SG, the stub driver allocates
big buffer using kmalloc() instead of using sgl_alloc() which
allocates SG list and pages.
    
Alan fixed vhci bug with the USB 3.0 storage device by modifying
USB storage driver.
("usb-storage: Set virt_boundary_mask to avoid SG overflows")
But the fundamental solution of it is to add SG support to vhci.
 
This patch works well with the USB 3.0 storage devices without Alan's
patch, and we can revert Alan's patch if it causes some troubles.

Suwan Kim (2):
  usbip: Skip DMA mapping and unmapping for urb at vhci
  usbip: Implement SG support to vhci

 drivers/usb/usbip/stub_rx.c      | 32 +++++++++++++----
 drivers/usb/usbip/stub_tx.c      | 53 +++++++++++++++++++++++-----
 drivers/usb/usbip/usbip_common.c | 60 +++++++++++++++++++++++++++-----
 drivers/usb/usbip/usbip_common.h |  2 ++
 drivers/usb/usbip/vhci_hcd.c     | 23 +++++++++++-
 drivers/usb/usbip/vhci_tx.c      | 49 ++++++++++++++++++++------
 6 files changed, 184 insertions(+), 35 deletions(-)

-- 
2.20.1

