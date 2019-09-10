Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D08AE1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 03:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392370AbfIJB1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 21:27:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46571 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390949AbfIJB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:27:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so10491336pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 18:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0ivIH0CLLNNjAWBlrwIKDFI2cokRF0sKteG5gWpNc4=;
        b=CwKvZC/r+gmvybd4uHXDOj6GImjAwuSp/3ZG529ovEbvTmzdB+ugI3QMZykaj8Vj0b
         +3cW7ORGPP38mahjYemQIFY/ZLI2B20X3aL2SSMn+G/+VM3m9Wznt4MwsSZo/MUw5A7t
         IZdcmAk2HpK4IVD0MQ8IOVzv+gqHN7182CP9plZhTaT5FkAUrHLHoz0f7ntiZR3FwipF
         U9Dkjds7cDIfUDgvErgcoSjEJ3wGlvku1xZeq5aARNTJTDSg6LEm0wrNzk55E62e8ifk
         UmdOds+v5ABGh2/f14kh4MZqCAZDFiSIDQBaFJtIbz14tCnH8GMbflVYQSqmpZp1dlyw
         pevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0ivIH0CLLNNjAWBlrwIKDFI2cokRF0sKteG5gWpNc4=;
        b=VbBO8nnLixNLRvgv4sS953hlz1oqGtjF2Ov1XPRFjMj0F10J46sT2jc5aNsZyLnrF/
         M1iLR0RZWyOiUpfG1Ur8P8UHHuDq23Xl3z1v2Wxw5K4+K0nCpHyS3vycQ1WaJGK+GFVz
         VDbJHZf/99mxCGdiFVLbtP3KHsmAD7WbALoaBWDzsBTgMp3xdGLFb6qiLDnpn3wSA4Fa
         jNiojbm4Sa3rscpbjeYgxIBaTp7OXj/NQ5KtD67we6IzzD4U+/sMzxhkISy5i5yN5m6Y
         spY0544ZoJ+okzb0JT1/r0px4VZrOdQ5UihXpgqV47QeQ3bczrsEhQWp0sFZTC6Y9e7J
         2Iug==
X-Gm-Message-State: APjAAAUMf45qs1i1ZVjwCWScSfswrQ63I7NVfVQdRibm53PdMaF1+x++
        WWbPi4HPEw47ft5etuK3fqo=
X-Google-Smtp-Source: APXvYqzzsQDdtbXZUkzusTKy4WxRxPWuZxQNE+lSoOl5lbcBkgjJohKXfZw/PYBmP5eYuUnatXVOUg==
X-Received: by 2002:a62:3893:: with SMTP id f141mr15612910pfa.221.1568078864996;
        Mon, 09 Sep 2019 18:27:44 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id b20sm19558629pff.158.2019.09.09.18.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:27:44 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v3 4/4] mm, slab_common: Make the loop for initializing KMALLOC_DMA start from 1
Date:   Tue, 10 Sep 2019 09:26:52 +0800
Message-Id: <20190910012652.3723-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910012652.3723-1-lpf.vector@gmail.com>
References: <20190910012652.3723-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMALLOC_DMA will be initialized only if KMALLOC_NORMAL with
the same index exists.

And kmalloc_caches[KMALLOC_NORMAL][0] is always NULL.

Therefore, the loop that initializes KMALLOC_DMA should start
at 1 instead of 0, which will reduce 1 meaningless attempt.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index af45b5278fdc..c81fc7dc2946 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1236,7 +1236,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 
 #ifdef CONFIG_ZONE_DMA
-	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
+	for (i = 1; i <= KMALLOC_SHIFT_HIGH; i++) {
 		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
 
 		if (s) {
-- 
2.21.0

