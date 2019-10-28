Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB9E7BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfJ1V4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:56:53 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55561 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1V4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:56:52 -0400
Received: by mail-pg1-f202.google.com with SMTP id b14so9363379pgm.22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UtGhKKNcMrwHGBNHOnspoVolNucvfChffjDhkf56Qew=;
        b=ou+FqvgYLi5WelaPVkj2Yc12VFdOY5Sq5OnD59DIPUDn94kwQEAaAvFKhCE3f1iRbN
         stxWQs0AgsbsTbv52NZDnB6eKbw0SzWTzU3DOkvmo5ZXg/jJvq2h3ORptPM3mzZSYjyM
         gDgkgHLKafzlcO2/4ysSfhDgyrvP4u+EJIMM0YVSY8zBJ6SJgiFNArBx/uCTO7YkfqJ2
         qSGX6AAOlcrq+O6n8p67xzlv+3k0DZ++D74N2sW3WASuFtw9nfpTsVtAt7W3qJw50fKK
         U7VSkW/avTGiWXhFg3OJoaE6G6r7yqqpQskouef6RDevPsTdzxrc24Clq5NS9SVHn+Dh
         7EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UtGhKKNcMrwHGBNHOnspoVolNucvfChffjDhkf56Qew=;
        b=qpG1uf6aVMdcBDrMVKrN7t5p1E9x+0jIVuXmwYuU6OoF5hqVXjrsFAPz9dHKRGzQWi
         pd9giz+4Spgl8atIPWFvwxyMCbE8mPKERkgZbA4tCKIs3MIk+pnsUEJmPO8H32foPMSn
         6T/0+n+CerEQjFvqeAy1X6fFejtihtGQHKPOD+dc15sRE0yrMj+Hd210WmcpIhHF4fgr
         OP+c2mTFOLfjvSYIxujxSoji5dhMsXlLkjujpM2Waz31JtTE3W2rs8J+aUWuVjRTPUOa
         5uDZLHzRM+8XjEle1Npieay7lIbjbhy3YWZIILTru+/Pj+XhdC35BXU/4v8I9enqIYMP
         fG7g==
X-Gm-Message-State: APjAAAWiphl76aQkSrqJbaV5/5wwCxT0haK7Q6JN9stMPTr8WIH91Yd1
        vOJkUwTLWqi3blYKUmC/v5/ocIa0ND/avg==
X-Google-Smtp-Source: APXvYqyAPyMKSAS2cUPYIdxFIRy94JkwO6if0eJ3sgUmx6VI8CH77s6xexhkCyTAnNRO6glE1dRh4JJGT5mg+A==
X-Received: by 2002:a63:cf18:: with SMTP id j24mr13166518pgg.406.1572299810069;
 Mon, 28 Oct 2019 14:56:50 -0700 (PDT)
Date:   Mon, 28 Oct 2019 14:56:46 -0700
Message-Id: <20191028215646.16638-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] dma-debug: add a schedule point in debug_dma_dump_mappings()
From:   Eric Dumazet <edumazet@google.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_dma_dump_mappings() can take a lot of cpu cycles :

lpk43:/# time wc -l /sys/kernel/debug/dma-api/dump
163435 /sys/kernel/debug/dma-api/dump

real	0m0.463s
user	0m0.003s
sys	0m0.459s

Let's add a cond_resched() to avoid holding cpu for too long.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f466af0a8e421d035ac8eb119e08bd8..4ad74f5987ea9e95f9bb5e2d1592254e367d24fb 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -420,6 +420,7 @@ void debug_dma_dump_mappings(struct device *dev)
 		}
 
 		spin_unlock_irqrestore(&bucket->lock, flags);
+		cond_resched();
 	}
 }
 
-- 
2.24.0.rc0.303.g954a862665-goog

