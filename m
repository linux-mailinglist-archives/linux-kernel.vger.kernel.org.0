Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB05BCEAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfJGRtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 13:49:51 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42468 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:49:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id 4so1294307ybq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnR5MVeSfmkd08lK4ffzp778Oq2vekAUBJq9yoLn9b8=;
        b=fd4Tb+2Yp/pikdXybI5knLc615UbbMcFORwSgAlrnFG/eDG4sPuvSRJw6ihE9x13tv
         MCxS27PkjSZZ10iGcnsF7h/xa9qyEpaPkKsguH31LrpEF4ZVzZ65eoGm3jFLCRJBvLdx
         oVIub0eY1AhumoEIAHWD1oUsTjN1q5QziIpL1JO2sd1s9EdctkIWfrs7gPcYmHNUGnTa
         GcX6MKhboEQnREOtpkV5O89UWHklnVnDFqalyP+l7/aEX6w+LPB8aKAm9qxeNEMk6kHA
         afdP66atY7coWxujzKxu+iVe8mnTCfnTFZYvNnpk+rgbOBDeym2S+FFIinxjnbDPtTkg
         mPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnR5MVeSfmkd08lK4ffzp778Oq2vekAUBJq9yoLn9b8=;
        b=TQO5wlAuxcZWupWIhBgP7+oM13YJvZjzfN37fXT8lTmpGUPmp9Lyc43ilekBtFcdx1
         FUSalzJ002avomC6HfmFgRysbBdp4IyZ8iGdKwAPl0pbV9btx6wyKfLqcEMO4fCxK/F7
         XkgIjN01PqlIBwHR+LZ1PlBKJxQa7g9kKF+Q+PU6CMkJJwlwOXrEKUFygCtDSXt3fgEJ
         lzX1UtOQQ4DhHh1vBMTFSiVrHOeKzz0b/dC8UtL8zl4Kr0sCk5wtBi5LAUJ/2UQtLw82
         aN8WFeM0drRZuHdCKsuBmWIrkJZEP0EvZIQ1jDOR3bfLBnm0oWyJtlyTHTPcmvXDuSAH
         wZgQ==
X-Gm-Message-State: APjAAAW1N+tenjFRbMUiAmuT+695aoMPYe8j4BsP2GNSVNsjYBwneEnj
        sLSAGnXGOeBBUs85O+XMJwM=
X-Google-Smtp-Source: APXvYqxa63PHzkGDflW2kegP8uwWWr/EiK668PHw+cW+ACIsZPGXXEZNwb3D/sLMNFHngR0b/npSDw==
X-Received: by 2002:a25:7506:: with SMTP id q6mr10435190ybc.25.1570470588791;
        Mon, 07 Oct 2019 10:49:48 -0700 (PDT)
Received: from Serenity.nc.rr.com (cpe-2606-A000-1125-4300-3224-32FF-FE82-DC91.dyn6.twc.com. [2606:a000:1125:4300:3224:32ff:fe82:dc91])
        by smtp.gmail.com with ESMTPSA id v204sm3943455ywb.23.2019.10.07.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:49:48 -0700 (PDT)
From:   Tyler Ramer <tyaramer@gmail.com>
To:     tyaramer@gmail.com
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-pci: Shutdown when removing dead controller
Date:   Mon,  7 Oct 2019 13:50:11 -0400
Message-Id: <20191007175011.6753-1-tyaramer@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007154448.GA3818@C02WT3WMHTD6>
References: <20191007154448.GA3818@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shutdown the controller when nvme_remove_dead_controller is
reached.

If nvme_remove_dead_controller() is called, the controller won't
be comming back online, so we should shut it down rather than just
disabling.

Remove nvme_kill_queues() as nvme_dev_remove() will take care of
unquiescing queues.

Signed-off-by: Tyler Ramer <tyaramer@gmail.com>

---

Changes since v1:
    * Clean up commit message
    * Remove nvme_kill_queues()
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..68d5fb880d80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,8 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
-	nvme_kill_queues(&dev->ctrl);
+	nvme_dev_disable(dev, true);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
-- 
2.23.0

