Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6519457F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCZRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:35:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54620 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZRfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:35:02 -0400
Received: by mail-pf1-f202.google.com with SMTP id t19so5696102pfq.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G+G8SzoTNYm3INTXZnya/9BfrExbp6FOm4lsdACc9gY=;
        b=VktKbXpg0Ao5yMu4T3/zZ0IkunVLznTzi3YISxgzT27E2R21Mq9W4obdxBrjpWmvpW
         dYfL86TNZPqhACrwLiin0og2QiAUeF31QIbNU4NjDDt0P5ZkG2tZDuTUGtAZ84D97Gu8
         EGS9/riz8VU7cuM1TuixG/Fzcy0QO11pY36A2ME+BtirqMOUmpT9LhgkoG2/06m5E5w6
         KwwPh3ZMMeOoARPq+4atwfAS34STDNHOgousf97A+DntfBawLWCT8WN7hSRP1vfpRP0D
         zQs31npcQxr9R9IYGS1lLBF09sEmAQi0Yz2lD9mBYppJvvXDTBMadqecDI4hU5tGQbPM
         FLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G+G8SzoTNYm3INTXZnya/9BfrExbp6FOm4lsdACc9gY=;
        b=UKKODutt7OsRIrbFJozECPQXpGDep9yocTTDItQ6IGJadW614ipv64+YK1Mgqc4TJN
         QXL6bbLM/PQroX00F/SyVNIjMoEgvKEfIzZ68d0EbKIpNu1XD27lOXF6AITQTQ04McGT
         lq1fPDNFDLkJ9ExbvVP+Y+3rIvtawU4l61X0q+1BpocupVapeYWgIlj2emO0h9Rfhhb7
         SAZ1cHMQdFxVIvmNSJlHgVbUrpMM43cBfG3WPNPVYruLsamWk0C3wjAonkMV+ITvUbK+
         +h8koDP41rPYrIZ1yLkFAzgMWNTcfo4ikDM3cWp2/dpvvs0YIxJVJZY2aO0UtB+2mSbU
         JJAw==
X-Gm-Message-State: ANhLgQ1YFmBtKl24EvtiwG4GcqeIZyZf9O+BgWK7rhh83dO5wHB6ldxD
        SNswRj7zLDrNn3PdOdcRDL2C/j5jbq4P9VY=
X-Google-Smtp-Source: ADFU+vvrbubNnjF/Quaud6R8eOUsieihvCBBg9WfH4mP4HFBuqBith01Gbz68HRn3tEjfLibzAYBTR1d8Ti89yY=
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr1230411pji.23.1585244101710;
 Thu, 26 Mar 2020 10:35:01 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:34:56 -0700
Message-Id: <20200326173457.29233-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] slimbus: core: Fix mismatch in of_node_get/put
From:   Saravana Kannan <saravanak@google.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, remove some unnecessary NULL checks. The functions in question
already do NULL checks.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/slimbus/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 44228a5b246d..ae1e248a8fb8 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -162,11 +162,8 @@ static int slim_add_device(struct slim_controller *ctrl,
 	sbdev->ctrl = ctrl;
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
-
-	if (node) {
-		sbdev->dev.of_node = of_node_get(node);
-		sbdev->dev.fwnode = of_fwnode_handle(node);
-	}
+	sbdev->dev.of_node = of_node_get(node);
+	sbdev->dev.fwnode = of_fwnode_handle(node);
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
@@ -285,6 +282,7 @@ EXPORT_SYMBOL_GPL(slim_register_controller);
 /* slim_remove_device: Remove the effect of slim_add_device() */
 static void slim_remove_device(struct slim_device *sbdev)
 {
+	of_node_put(sbdev->dev.of_node);
 	device_unregister(&sbdev->dev);
 }
 
-- 
2.25.1.696.g5e7596f4ac-goog

