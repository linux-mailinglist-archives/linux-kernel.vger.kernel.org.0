Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBE34ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 19:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFDRbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 13:31:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43366 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFDRbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:31:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so10748031pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8548ahNIiNfZOmNZGvAfjcomKImaYWHxzGsRMnII4c8=;
        b=Jwrr8OxWF2ZF45rqbpkpmf0LoUi0OrM0izOLHBoS88YLVrLh+AhzsrS+ODHGVwTSal
         i9V6EGrJE0BA9TSUzJc1rEEe4X4xjS01X8DT/mBQR8JSD3VB4lPRyl5hPThycCK2KVeI
         QoRnWMcKAIeRpVxoiI579ZetsiR5g/Hh8brSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8548ahNIiNfZOmNZGvAfjcomKImaYWHxzGsRMnII4c8=;
        b=ObyXOdNYA2v+fc9Q8hqcs5t1c3PN+Yc0ZixK/Hc3qmubZuIUf7wwsLXNq6BC8DAwbA
         Naoawx3ePuwUXYnBpOwNJDxN9WCfWU4DjrhCZPdsBjCWtVic2l95hJbJcwEW1qoG41ig
         MoEbM+Xyz/fzug++pY7KdGn6WJQWDg00ybpftJFkUEJB5qNFjx7W/yHj+LGuUgIzIpvG
         DB8ENxQ7UwrrMxmfIzEcoMSxpOo+V72+p63s/xmnIMQ2TR3JNx59sPFqXmSwNTyzueS3
         BN9TjMoGd6tXozVbgHqV5zuOMvE4VlPwwzn4YhKbeGGC9EpQ+ztI7m7E7v6V0tfzWZmG
         ZMLQ==
X-Gm-Message-State: APjAAAVy17O/rqXKOKFjtpMdUL+7GmnnskkQ/qCd7m2zhMiXjqdPqZIQ
        yZqUKE59iyC4ks2lYgOw6P6pZQ==
X-Google-Smtp-Source: APXvYqwfHjgtY5SiYME01mj7y6hPrwiq80g8qEIZz6RZp0jn3tm9VHBdf9FZsrH8258Quqrh7vm/DQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr36045566pgl.380.1559669507811;
        Tue, 04 Jun 2019 10:31:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id j97sm17565184pje.5.2019.06.04.10.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:31:47 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: print PCI mmap with %pK
Date:   Tue,  4 Jun 2019 10:31:44 -0700
Message-Id: <20190604173144.109142-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unadorned '%p' has restrictive policies these days, such that it usually
just prints garbage at early boot (see
Documentation/core-api/printk-formats.rst, "kernel will print
``(ptrval)`` until it gathers enough entropy"). Annotating with %pK
(for "kernel pointer") allows the kptr_restrict sysctl to control
printing policy better.

We might just as well drop this message entirely, but this fix was easy
enough for now.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 82f58bf0fc43..b54f73e3d508 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2959,7 +2959,7 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 		goto err_iomap2;
 	}
 
-	pr_notice("PCI memory map Virt0: %p PCI memory map Virt2: %p\n",
+	pr_notice("PCI memory map Virt0: %pK PCI memory map Virt2: %pK\n",
 		  card->pci_mmap, card->pci_mmap1);
 
 	ret = mwifiex_pcie_alloc_buffers(adapter);
-- 
2.22.0.rc1.311.g5d7573a151-goog

