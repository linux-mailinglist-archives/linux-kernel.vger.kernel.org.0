Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0484881A10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfHEM4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 08:56:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43773 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:56:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id r26so3745959pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qt1QV6t5hUTx3i8OgY0RqIfL0WykavKRmBolDxnqU3Y=;
        b=f5d5jeFRkVcioH77XhZphHlPc7Lq7bRZaUZ+U2BBPpXiIn7PmuLQqMUldxsELWwyAm
         wcr0+Y++5Wv3vgvGFGjrJHI6PBFzNzVLoo8/OvJ5x+ovGiRX7WLMgLkXLDympL/Ads62
         PdrVJGtcJA0q0Z5uVM6BrSr+WGPfAHs8mA5Io5HYZ88MOxoYifJ6hcGfykrXLH4+1jfw
         CxqIGYhQVN3EHJujNmLpCyQmBqLUDs51TKhOQrNSH85YD3vr6/VwwbaXRYpVCtTAYKRv
         o19g3s3kNhZPiEDA/bF9OrfPfs7ya5L6VTGki/pm6W4Ma8sVhzjoBdwzHdefwe4aZjvo
         ukfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qt1QV6t5hUTx3i8OgY0RqIfL0WykavKRmBolDxnqU3Y=;
        b=eX/byuYd/AocfkXP2rmws9Gm3UnJU7D8SQ6ugH2psGuPsiLTYauen+f8A9p2zquk8b
         qpOfyBqcsyuqXLFFZfRNbKr+kCTPPGHrPWwkup5nmFKa7NQuD7qiLKwDP8zurcBYSiFR
         b+5L6dkesSUEgUNHKuT2N/PCXrYSGhy00tUJjnc18W4Yc+p4LnkC0pwDpUk2WkGM4dNW
         kOSoJAMkhzrXgCvwi6d7Fz7Ccp+MtAz0+ua7MVqatsaQ6+e3hHGbxbRzK2DH5jWjw36C
         6jiAWizXUsBQuysDyTnXEueKfyDxrGzkRwSZa6YzsDnQicqbF2V0FND9X/BJNtcs2UYB
         s+8w==
X-Gm-Message-State: APjAAAVP5ILeybZGA9hExRfz9nYT9mUytTLs/u9vMzRN4UhQb5qRio+8
        dPZj9J1i1bVXg8WpeBYTSQ0=
X-Google-Smtp-Source: APXvYqykHMnrtHTNW5F4aDYA6lFvjMIUZBUrYKlMABbB2vm8/WVpI8tW6hrJvKHIi2m7feLaTdOkTQ==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr18033205pjc.63.1565009796240;
        Mon, 05 Aug 2019 05:56:36 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q126sm43372324pfb.56.2019.08.05.05.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:56:35 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] sgi-xpc: Use GFP_ATOMIC for kmalloc in atomic context.
Date:   Mon,  5 Aug 2019 20:56:25 +0800
Message-Id: <20190805125625.24963-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xpc_send_activate_IRQ_uv is called from
 <-xpc_send_activate_IRQ_part_uv
 <-xpc_indicate_partition_disengaged_uv
  (xpc_arch_ops.indicate_partition_disengaged)
 <-xpc_die_deactivate
 <-xpc_system_die

xpc_system_die is registered by atomic_notifier_chain_register,
which indicates xpc_system_die may be called in atomic context.
So the kmalloc in xpc_send_activate_IRQ_uv may be in atomic context.

Use GFP_ATOMIC instead of GFP_KERNEL in kmalloc.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 0c6de97dd347..422341e3234b 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -694,7 +694,7 @@ xpc_send_activate_IRQ_uv(struct xpc_partition *part, void *msg, size_t msg_size,
 		if (gru_mq_desc == NULL) {
 			gru_mq_desc = kmalloc(sizeof(struct
 					      gru_message_queue_desc),
-					      GFP_KERNEL);
+					      GFP_ATOMIC);
 			if (gru_mq_desc == NULL) {
 				ret = xpNoMemory;
 				goto done;
-- 
2.11.0

