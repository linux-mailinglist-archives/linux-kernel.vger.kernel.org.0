Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7D1314A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 16:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 10:17:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37045 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgAFPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so37415222wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTATKa1I/brNCXy5ctrzq/kPifJjU9NvH+Rz1RlC3aY=;
        b=f/IKZyl31LfJrVY5YXqZ05+9WggKo9IvavhNUEF3sn2p9ifbHP+sHHltb0/vhMx03d
         +Hyg9f5TdWLmTloyEtb0XDHBLeNsf5Pg4/wEyusGE+DkfI9/1qc8uTy3IDZeiYBjIKSw
         p1X0tDS2ywc6HfqxZS7zTiXond0ArEScI94dvXa+uwexiefD8cOzqaQMeDfdPHQbBmNr
         uV2/AjaGDa9/gBNAgseF2i5QjfF6ReIaJODeDgs66OUm8SgPWA+coo/NjK/hOqVlbn7j
         1j3VyC0fkWrhQZeByjZWRymR2eaUTn2Zafqu7kI1qm4IIxpeDtTX3dfBhf5YJRXaaSSb
         +kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTATKa1I/brNCXy5ctrzq/kPifJjU9NvH+Rz1RlC3aY=;
        b=FDjNFp9aj1zp+jlzTsUUvZdrsO1nmVJnar9zmXwPzsI9FqxMiF8NzQuOHdkDnqWJ1C
         o2Ky923afdqZ/CrZDIm0ezS068oh7nmX5RQt4R+5e52EVMw8ATcISx9jgsWHdByidP4l
         z6Vhcb0WkfBOgWJfT7LO2feH7C4ostAwwnfYKNFjDCaS0k+GyEeDr5wfZl/nedxN0/Tg
         fEZM26q5Fvynol9z+gTcoFVcWJBeSiarujU33Py+YEGV1lzfUq2aWTsAXTTZBzdPmS27
         mIEFFSNsnHitAkLpg7FMk+t2s0LcqGlKmkn1qNU8h5OHFbspRiSb5ADCZ+Wu+A6kNQEc
         BKpw==
X-Gm-Message-State: APjAAAWNl7PH/xSDzs6Fn+bmUXZwWb3vFnXh5ENYdwX7XAg5QCVfROPF
        HQlp/8z3g6mJh1KQfGTx1B7esYyFOGVO6g==
X-Google-Smtp-Source: APXvYqwOfDIXvuUaoerrXnYtTZ+//ZcXM5cJgHB0dNnbhq/StXLT19K7hNjaZNl0VgAAc85dhTA7lw==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr107260578wrq.72.1578323830130;
        Mon, 06 Jan 2020 07:17:10 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:17:09 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/6] drm/etnaviv: show identity information in debugfs
Date:   Mon,  6 Jan 2020 16:16:48 +0100
Message-Id: <20200106151655.311413-4-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 7ee67e12141d..151033d58bfb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -860,6 +860,13 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
 
 	verify_dma(gpu, &debug);
 
+	seq_puts(m, "\tidentity\n");
+	seq_printf(m, "\t model: 0x%x\n", gpu->identity.model);
+	seq_printf(m, "\t revision: 0x%x\n", gpu->identity.revision);
+	seq_printf(m, "\t product_id: 0x%x\n", gpu->identity.product_id);
+	seq_printf(m, "\t customer_id: 0x%x\n", gpu->identity.customer_id);
+	seq_printf(m, "\t eco_id: 0x%x\n", gpu->identity.eco_id);
+
 	seq_puts(m, "\tfeatures\n");
 	seq_printf(m, "\t major_features: 0x%08x\n",
 		   gpu->identity.features);
-- 
2.24.1

