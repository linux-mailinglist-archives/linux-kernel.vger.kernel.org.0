Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207C161ECE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfGHMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 08:51:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:51:29 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mvs2R-1ibkHp1Zwt-00swZe; Mon, 08 Jul 2019 14:51:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nandor Han <nandor.han@vaisala.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: fix nvmem_cell_write() prototype
Date:   Mon,  8 Jul 2019 14:51:07 +0200
Message-Id: <20190708125115.3731543-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F5W/srgO0603YyWyAzNz5lIxzMjkSTkeFBySmMdsEFHEfRskmBX
 ED6CC28DmE6kleszwxB00hZUJc8Zi5eyhyD3h4ituhNtJI1R83Ltankhoy1RIz+QELI0dtl
 /PnFdUAMHhj458aogrU6S0psh/NEF/9u0gGPD/+IkTF15/iswWi8wMRWE3Ifb6ZFu7TOKd0
 hBypeMnjduLMmMk1ZO64g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EbiKBLLcMBA=:RPSnkgPAS4fb6sKFiJ4QiN
 Pd0pNmawvwiTJ8rW5DQYBeXnEAYt008n8FPDsnNkL5Y8U7Ihc6G5/jWnyI4BTOoaEb8Uxk3u6
 v17Fq2EseW6ctmdDDxd8ttwFb6w0lzulEArbgaisuauzHYGtbpWi2tz3MQAua+nV9u4BlTNhK
 LzNCy+B8M9Uv+4vZj/8/NXLGtVDHiOdinsuFmFlnL3cETfmjx+wG2WXwX91Rmo+El2GZyYv96
 Ht4da7S7AVXfvMzbA3jBkGRPYN4a8jFlgInkAQ9Ubyn6u0YF9nbPJHPvz/FHFqnQmZZgptDs6
 pswvQBSLFonyVygArR8tnpxw5Rs7bW0N3aV31GcwseCp/96WeVB2g1k7B5yFRxGSPQ/xeikU2
 xzC9t9B0YV9KNsGnxhAwEu4qnDOdNe51INCkjPy4klnC6V+0hn9Ag7tVNXRdM1kJEe+nVvb6U
 v5xTXPYwWztfBkBqpzCk9ba1w6UL8eFprzjQJHz+S9YXQduCr3RUS7H6XylP8VCDIdSL8t5De
 /D0zLZDqAyhbRnf5n9ZdI5Hr9wg+rI3pAmlZN0rMaN5AXeVQIw2XD6rmXIPuSNSX9lWbMHsxj
 bQtzrVarLcPPnJ5/StdpzDNmLvMN4cRLeuh96QUtPfl8DLZJg6fkRyLMKVM+aVTsdR81DUGQJ
 oss0uRWpbiJ/bg6X76D14+b99mj3vRxT8A4ZYWZ5HSZ5s71kXiOk/t8jMiz82cz5CNCQ/VmwF
 tF4WiYHxlyLsbrk5wIsOtRRIESPVVy5ZStpX4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy declaration for nvmem_cell_write() has a different prototype
from the one that is normally used, and it causes a warning when
CONFIG_NVMEM is disabled:

drivers/power/reset/nvmem-reboot-mode.c:27:42: error: incompatible pointer types passing 'unsigned int *' to parameter
      of type 'const char *' [-Werror,-Wincompatible-pointer-types]
        ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));

Make the second argument a void pointer like the other prototype has.

Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")
Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/nvmem-consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 8f8be5b00060..459df4ba5408 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -118,7 +118,7 @@ static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 }
 
 static inline int nvmem_cell_write(struct nvmem_cell *cell,
-				    const char *buf, size_t len)
+				    const void *buf, size_t len)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.20.0

