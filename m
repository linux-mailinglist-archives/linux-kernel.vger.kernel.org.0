Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABA4127215
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 01:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLTAPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 19:15:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36123 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTAPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:15:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so4219020pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Xza35VKEvSvjMP8PzRVZ35j7UizUwWQ11TtoEWfsA3Q=;
        b=NNy98T7dz4IUNnNLaJQft6RAEhtwCcTFXv02GozymvM1Ea1jNkJFQv2PQ+QRRXSLFk
         Mk5zTLKbBusvQPv+bg/u7qv8XzRqAPNTtdH+4maUWOK8PwJVrv6imA3+TuoGotcjr/rq
         WeaXXWd19uZ6bdYkMrnQAJmo+Q55zv1IfdYygUO/CGVTxuS5zngvmsySsLuWoGoKa2zG
         PxqsjNI4ya8KxN5qjphBTmkxJTPQoMpLZ6fLFikgoG2+MMx6ywYVBEYidrg7wqU/s40N
         8g6m8CfYBp5/K3xC38QRkgsNQ2VUJEBe9gbcJJnF5RGAFwvBjneY+pxLSV0c3juCFZnW
         T5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xza35VKEvSvjMP8PzRVZ35j7UizUwWQ11TtoEWfsA3Q=;
        b=Wl7AP9FLS1qmVj7tjPiMcgFMyD0K9NftQyZu0nVDZjOt15apcUEWlWRrkBfQ3RaboK
         ET7gdFg9Wf7rA61yWQ6HiP4VQtDzClC6DOIVYNqTfxvs4tKGJj2tC/8o3TUjabLw5kYh
         W8O+a2dTMEDDNvSQgU94cVjG41b9PQURHbG536Ezmupb8T6y1e6MsdpnhJiPUrTbf+jR
         aFBFiHryFXF8qIEMWtno+PDypmSoJixPMdmhB66nKj2imOYjOzbyyL4VKMUmZliN0j0h
         89VHXy6ckK1hf0+QL/vBHQfdP0lMFveW1xN9nI59ORCWMVx+jg6brtZPgerdUHWaUQQf
         qmgQ==
X-Gm-Message-State: APjAAAVRZE/lNQOkMwnHptE/L5jWIyosmrbguFmtwbD+tDkHKL6CkyPD
        DNhBx4oPDy3IOqgsVKUR4yG+xrlqEgpfLw==
X-Google-Smtp-Source: APXvYqzHTcFOfPjIOzxBXsbVb01FSma/OGljIvD3S6xqG+A2sFrTNEZIUktiv1IzutARjpJbzkpXRg==
X-Received: by 2002:a65:58ce:: with SMTP id e14mr11807199pgu.153.1576800939356;
        Thu, 19 Dec 2019 16:15:39 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id e16sm8603679pgk.77.2019.12.19.16.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 16:15:37 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH] net/mlx5e: Fix printk format warning
Date:   Thu, 19 Dec 2019 16:15:17 -0800
Message-Id: <20191220001517.105297-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "%zu" for size_t. Seen on ARM allmodconfig:

drivers/net/ethernet/mellanox/mlx5/core/wq.c: In function 'mlx5_wq_cyc_wqe_dump':
include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

Fixes: 130c7b46c93d ("net/mlx5e: TX, Dump WQs wqe descriptors on CQE with error events")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/net/ethernet/mellanox/mlx5/core/wq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wq.c b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
index f2a0e72285bac..02f7e4a39578a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
@@ -89,7 +89,7 @@ void mlx5_wq_cyc_wqe_dump(struct mlx5_wq_cyc *wq, u16 ix, u8 nstrides)
 	len = nstrides << wq->fbc.log_stride;
 	wqe = mlx5_wq_cyc_get_wqe(wq, ix);
 
-	pr_info("WQE DUMP: WQ size %d WQ cur size %d, WQE index 0x%x, len: %ld\n",
+	pr_info("WQE DUMP: WQ size %d WQ cur size %d, WQE index 0x%x, len: %zu\n",
 		mlx5_wq_cyc_get_size(wq), wq->cur_sz, ix, len);
 	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, wqe, len, false);
 }
-- 
2.11.0

