Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3027197E37
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgC3ORR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 10:17:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40841 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgC3ORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:17:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id c20so6094883pfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1BA/+EzZUprzyKG2z2k8xv+DKN8kyB5d20DyklGct+U=;
        b=hEQTy+L5QUjHFFy9HvIuA862khwr+dcNTcnqGoX9MYD23rZtSH2WE1dFMUAJomBuEX
         9NoRKlLDQ9qBTZy43S4zEJGy7oCyQDNYVe5HHTcqjLPZv8+qPog5vCpY59V69NxT/pa0
         QdssDNJ3PiOKf0ydCgslpMlDgxDa3mBAYqpKfMsR/Bpc94HdF21MVPoS4L+xd8vLmcHq
         lVpbwqorBl6WMuPsyIe9kA2Fq/4rgy8JSYVtTGE9x4HvkSwempVi06XtJK9M1KxJM1P6
         f22VN0PFOjlhaU5GVr4PIdbinuHfmXmQGAQuOUfbkYpuwv1TKvSXABFZKSVoUN2scUJB
         +ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1BA/+EzZUprzyKG2z2k8xv+DKN8kyB5d20DyklGct+U=;
        b=CGY6mdERLDgzHCyD5PRWDkD8UReNf0uv2penvY9illJ4KGIm/A2XiCVtPHXY9PdOOM
         vPspMKU82AR3AwWLC3eUBdMErxcQwyX8BN6uTCrKi0l6TaIzJR6dx0TAL+XIWjFd+0mC
         Z7xTU5zd1roj/l0RxvuMELSZVWP7aXwB88Bfepf3q+HCgkb8rXI/1z4j0bxgaPpNSdpA
         ic4vue0H2I9khGA47u3hAyiXIIxZxD0UD6XEb/X5TcvlhluclEIFeijquARHgmZ4QXNC
         rxNfYFcpx0fDb4N4aaKFahT/HFlk3xr/wZwRR1cmUBM+/5Nd1jnW7/onerfClCffks2G
         qFJw==
X-Gm-Message-State: ANhLgQ2JaFbw1Op5CAeWVC8QjtlHvD9sWzvXuP5HGA6Z4CBqpTKK7eZo
        YUcF6Jn4l9icW5NoEV8ScFY=
X-Google-Smtp-Source: ADFU+vtCjTYKqekOM0YDuD1qdXteoTtLiDzhYoTFy6qUg9m6sh/BwIAh7OT6nOcgScsMrNlivQrPSQ==
X-Received: by 2002:a63:790e:: with SMTP id u14mr12317600pgc.361.1585577835411;
        Mon, 30 Mar 2020 07:17:15 -0700 (PDT)
Received: from localhost.net ([131.107.159.147])
        by smtp.googlemail.com with ESMTPSA id o3sm848855pgk.21.2020.03.30.07.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 07:17:14 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [Update PATCH] x86/Hyper-V: Initialize Syn timer clock when it's
Date:   Mon, 30 Mar 2020 07:17:08 -0700
Message-Id: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Current code initializes clock event data structure for syn timer
even when it's not available. Fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
- Fix the wrong title.
 
 drivers/hv/hv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 632d25674e7f..2e893768fc76 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -212,13 +212,16 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
-					  GFP_KERNEL);
-		if (hv_cpu->clk_evt == NULL) {
-			pr_err("Unable to allocate clock event device\n");
-			goto err;
+		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+			hv_cpu->clk_evt =
+				kzalloc(sizeof(struct clock_event_device),
+						  GFP_KERNEL);
+			if (hv_cpu->clk_evt == NULL) {
+				pr_err("Unable to allocate clock event device\n");
+				goto err;
+			}
+			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
 		}
-		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
 
 		hv_cpu->synic_message_page =
 			(void *)get_zeroed_page(GFP_ATOMIC);
-- 
2.14.5

