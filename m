Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9398708C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfGVSgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:36:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42134 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbfGVSgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:36:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so26932740vsf.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u4izuYmo+kNsiUwAXM6ygOEvVOhLNkyI5KbJVUzFn+o=;
        b=OE9sSa6dSyW4rlvqEDZqiHHMx+zdjcFF4nHX2Nq43G5o3nY4FdO7e6I5aDPhCLSA63
         ezt/SzN3dDHfet/eOU6H0EwFFnIcgIn8Mjfh66eKyeV5oWlAxjhxaTz0hE2HqekLlPSJ
         v1t0e3jrQjruBL+j5X+5YBkMZzQSkFre1JrXIf1BtoMXFFST5cZ41eoq3IFLJDcmhC8t
         1oxieSfa81Ww5oADkfMC4Cu5tYy3XVMCNC2nZ6OTdHqoW2hJVjoR5wCjqwHbAqZVVHrJ
         GyOEtxyjdVMQIEQmZ7BdOdNO5pCQvhDFVVY1aWkta8d7V37HJuj2RG60UxVtTEfxsVrm
         F7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u4izuYmo+kNsiUwAXM6ygOEvVOhLNkyI5KbJVUzFn+o=;
        b=l0sKgXzQcseFVfwk7uZW6nO7wXZ81yLyDo7PPUGMjRV7N4y4o4tuu5t1Ye1pw9tcTh
         To7uErwMjBfq5wfY1qI8xJuymnNnbIsN54SZCreUwg0y01O7ZBhmsbZyfKJNJQIRWvos
         KTBjnrF5du1X5yMqBhOSeq0GGNfKNVev1x6hCX4i15PusrnprLbFkYpr70MZVypzitii
         P727KUGIAfLCCWD88F/u/a234Pi7mQ/iAllH6V24q8VD6+VDEKkm/dbeiaksxsfk7x4+
         SCmuisgvpgk+0FHKgW4wiuQ5gGl6mcXYFQuf7YdoF7evW0jly6r31gliDonF2Cjlkqm4
         ErRQ==
X-Gm-Message-State: APjAAAW4Ww8wAWDbnJZBq+2edxtikmCpiU6uwcLp8e2Qg270aVVjrZsD
        27WXpAb/IvpFcAb3naVwKLAiW+35e06N5Q==
X-Google-Smtp-Source: APXvYqy8GqANbo1n0A4eT5yNcA1w8us81IfhVKmDbX5eAg+yaJE5Y3SUHdM77HMytoD0nZomDxDIug==
X-Received: by 2002:a67:8cc7:: with SMTP id o190mr44487527vsd.24.1563820594813;
        Mon, 22 Jul 2019 11:36:34 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 10sm15371158vkl.33.2019.07.22.11.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:36:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     saeedm@mellanox.com, leonro@mellanox.com
Cc:     yishaih@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] net/mlx5: fix -Wtype-limits compilation warnings
Date:   Mon, 22 Jul 2019 14:34:42 -0400
Message-Id: <1563820482-10302-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b9a7ba556207 ("net/mlx5: Use event mask based on device
capabilities") introduced a few compilation warnings due to it bumps
MLX5_EVENT_TYPE_MAX from 0x27 to 0x100 which is always greater than
an "struct {mlx5_eqe|mlx5_nb}.type" that is an "u8".

drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function
'mlx5_eq_notifier_register':
drivers/net/ethernet/mellanox/mlx5/core/eq.c:948:21: warning: comparison
is always false due to limited range of data type [-Wtype-limits]
  if (nb->event_type >= MLX5_EVENT_TYPE_MAX)
                     ^~
drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function
'mlx5_eq_notifier_unregister':
drivers/net/ethernet/mellanox/mlx5/core/eq.c:959:21: warning: comparison
is always false due to limited range of data type [-Wtype-limits]
  if (nb->event_type >= MLX5_EVENT_TYPE_MAX)

Fix them by removing unnecessary checkings.

Fixes: b9a7ba556207 ("net/mlx5: Use event mask based on device capabilities")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 41f25ea2e8d9..2df9aaa421c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -215,11 +215,7 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
 		 */
 		dma_rmb();
 
-		if (likely(eqe->type < MLX5_EVENT_TYPE_MAX))
-			atomic_notifier_call_chain(&eqt->nh[eqe->type], eqe->type, eqe);
-		else
-			mlx5_core_warn_once(dev, "notifier_call_chain is not setup for eqe: %d\n", eqe->type);
-
+		atomic_notifier_call_chain(&eqt->nh[eqe->type], eqe->type, eqe);
 		atomic_notifier_call_chain(&eqt->nh[MLX5_EVENT_TYPE_NOTIFY_ANY], eqe->type, eqe);
 
 		++eq->cons_index;
@@ -945,9 +941,6 @@ int mlx5_eq_notifier_register(struct mlx5_core_dev *dev, struct mlx5_nb *nb)
 {
 	struct mlx5_eq_table *eqt = dev->priv.eq_table;
 
-	if (nb->event_type >= MLX5_EVENT_TYPE_MAX)
-		return -EINVAL;
-
 	return atomic_notifier_chain_register(&eqt->nh[nb->event_type], &nb->nb);
 }
 EXPORT_SYMBOL(mlx5_eq_notifier_register);
@@ -956,9 +949,6 @@ int mlx5_eq_notifier_unregister(struct mlx5_core_dev *dev, struct mlx5_nb *nb)
 {
 	struct mlx5_eq_table *eqt = dev->priv.eq_table;
 
-	if (nb->event_type >= MLX5_EVENT_TYPE_MAX)
-		return -EINVAL;
-
 	return atomic_notifier_chain_unregister(&eqt->nh[nb->event_type], &nb->nb);
 }
 EXPORT_SYMBOL(mlx5_eq_notifier_unregister);
-- 
1.8.3.1

