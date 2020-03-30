Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B21978B2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgC3KTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 06:19:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53642 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgC3KTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:19:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jIrVV-0002HO-Dx; Mon, 30 Mar 2020 10:19:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>, tiwei.bie@intel.com,
        Wang Xiao <xiao.w.wang@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] virtio: fix spelling mistake "confiugration" -> "configuration"
Date:   Mon, 30 Mar 2020 11:19:01 +0100
Message-Id: <20200330101901.162407-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes of configuration in IFCVF_ERR error
messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/virtio/vdpa/ifcvf/ifcvf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
index 8d54dc5b08d2..111ac12f6c8e 100644
--- a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
@@ -340,14 +340,14 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (ret) {
-		IFCVF_ERR(pdev, "No usable DMA confiugration\n");
+		IFCVF_ERR(pdev, "No usable DMA configuration\n");
 		return ret;
 	}
 
 	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (ret) {
 		IFCVF_ERR(pdev,
-			  "No usable coherent DMA confiugration\n");
+			  "No usable coherent DMA configuration\n");
 		return ret;
 	}
 
-- 
2.25.1

