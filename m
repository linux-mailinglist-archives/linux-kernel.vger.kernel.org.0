Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D417CB8E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 04:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCGDn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 22:43:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34105 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCGDn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:43:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so1993907pgn.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 19:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RyudsTdaiGHdFq2ORRXJ0vk3t3fWMudqINaDB7phCEY=;
        b=J7rgDDLvA1rYGh/ekUcB7X11u9jS0nSXNVPy+Q7X5W2LpPG0jJLdniIuBRGqdQVmAm
         77u75Y7RPHvgPiRn6+Fan50dZS9FifQYM76YNl5YBjCK62GfFScvfuj7CCwzFwOByCO7
         zn9SFf13jig2uPdtsvfaC0BSdq7QbpKX1CNsf2/1SNQprOE0k4GpC8oQ8eghx9alURNR
         NlICFDqKmDbSfjt1bhn4CNFdQPYf0/9JMYW7uSgibTkccJq6AxDN0l5L3sBN8M4fX0mH
         80o8Rm6onazI2VAQa9Xnrcc+dSPCZrBcBefUWVqROSqmk4xy1TrzK4M4ejDZFVESCo/o
         pvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RyudsTdaiGHdFq2ORRXJ0vk3t3fWMudqINaDB7phCEY=;
        b=UnH6Y+CUTlmm961LUDbIHnFpdWUoz+giIERuS1BTrbuX7iyiCRkR4fNpGjFqex25ro
         KjO5dvyWNjhX7jDpqQl216Jwz58RAWd7nQyj4A1NbxxUqunddgJTJF+AerKudQg0qH43
         dyuGAksBvHDuJJAFrnK6q9M0kNwryWkg3Vo8EmWtiT69q6RsZAfnA5e3K7iIDNnG2IQ0
         EVadmiLpalt45r/76idxVP8J+o0NoydZoWtpXLCbx+lRxHHvcxo3AiSvT5s76lHb7ibl
         ynBDIwEAENWLsM16EKiKVfU2eQLK2mauZJuh/nV3IH0LAqUq66Xuc+hf3H+Sy6V+aLrR
         wkbg==
X-Gm-Message-State: ANhLgQ3vFWeOlxoWJ48qHz2+X1uSpvP++S0CARgtWU4wFbuN1vdfT8uA
        dS7bpLp1sp/mlRm5pRk0yeE=
X-Google-Smtp-Source: ADFU+vuSv7ZAxDPkRs6S3la7AoljE7jfHdZexGf8PGawj2OmS/6Mr9r0F9PTxbm7HPXNju7DYOsvBQ==
X-Received: by 2002:a63:5d51:: with SMTP id o17mr4841331pgm.159.1583552635497;
        Fri, 06 Mar 2020 19:43:55 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id 127sm17520262pfb.130.2020.03.06.19.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 19:43:55 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] virtio: silence a -Wunused-label warning
Date:   Sat,  7 Mar 2020 11:43:50 +0800
Message-Id: <1583552630-20799-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The label 'out_del_vqs:' is only used by CONFIG_BALLOON_COMPACTION,
so move it to the region.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365..341458f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -959,8 +959,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
+#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
-- 
1.8.3.1

