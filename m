Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2887C31ABE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 11:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFAJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 05:15:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbfFAJPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:15:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 85489C906D572A0C7651;
        Sat,  1 Jun 2019 17:15:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 17:15:25 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linuxcrypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH v2] crypto: pcrypt: Fix possible deadlock in padata_sysfs_release
Date:   Sat, 1 Jun 2019 17:23:32 +0800
Message-ID: <20190601092332.136481-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1b71b136-3501-db1c-834b-ba7ed1431f4d@huawei.com>
References: <1b71b136-3501-db1c-834b-ba7ed1431f4d@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock issue in pcrypt_init_padata(),

pcrypt_init_padata()
    cpus_read_lock()
      padata_free()
        padata_sysfs_release()
          cpus_read_lock()

Narrow rcu_read_lock/unlock() and move put_online_cpus()
before padata_free() to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 crypto/pcrypt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 0e9ce329fd47..f3dacb714cd4 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -407,16 +407,19 @@ static int pcrypt_init_padata(struct padata_pcrypt *pcrypt,
 	int ret = -ENOMEM;
 	struct pcrypt_cpumask *mask;
 
-	get_online_cpus();
 
 	pcrypt->wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE,
 				     1, name);
 	if (!pcrypt->wq)
 		goto err;
 
+	get_online_cpus();
+
 	pcrypt->pinst = padata_alloc_possible(pcrypt->wq);
-	if (!pcrypt->pinst)
+	if (!pcrypt->pinst) {
+		put_online_cpus();
 		goto err_destroy_workqueue;
+	}
 
 	mask = kmalloc(sizeof(*mask), GFP_KERNEL);
 	if (!mask)
@@ -448,12 +451,11 @@ static int pcrypt_init_padata(struct padata_pcrypt *pcrypt,
 	free_cpumask_var(mask->mask);
 	kfree(mask);
 err_free_padata:
+	put_online_cpus();
 	padata_free(pcrypt->pinst);
 err_destroy_workqueue:
 	destroy_workqueue(pcrypt->wq);
 err:
-	put_online_cpus();
-
 	return ret;
 }
 
-- 
2.20.1

