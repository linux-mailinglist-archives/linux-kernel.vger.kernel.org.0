Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF3184609
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCMLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:38:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42359 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCMLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:38:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id t3so4120378plz.9;
        Fri, 13 Mar 2020 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ACCT/yAEbIU04yqe8VXHom7r1pDUJ/Q1TtIR8BaFHv0=;
        b=dI9nuEyiKfwXRX2jC48koOIuRspfd95Nqgzu/6b9h5lCDmc46xPFM98pK0R3Yp35iO
         y9tLJDh7zlBpOJ0hr8VrnJZ+wdM13bDNH053cUTjG5pdkDWX/ikoFVjnv2ochrNtHZRL
         XMc1Ei8Ejj5AsvZeDhiSkx5B6nVqD1pnlPqQzYxKFO+CpWuLe/Bl4qutXBqr1yDYrhnB
         kEoyPNHGkDMT4fxylCIvLbXX9ER3CVhhq/9B4jeM8fIcQRkEyl3LytsdOJV7dLFZ3vpI
         9Ad6JmarxShP6Almiwb3FWKusWCRE9CThAIByChY4CsdMbxjBNIpKKjB62UjrmC8PKAn
         j22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ACCT/yAEbIU04yqe8VXHom7r1pDUJ/Q1TtIR8BaFHv0=;
        b=dc1aT8FOodeILj4/lmbBeUjFgUpzfHjVvUrJT1xZaSY8QKtb8LQ5dNbybNWGpiODfW
         HQ+920s9hFn/HZXzLujOdmY7jOGiofu0453G22frWWgk38/rXMEu/EGZoVlURfkXRsNb
         m+dMI8+ILZEgCRvieFAk35wwX8UocmQ4JYIPOE0KY88AI2E0l5jDv3HcqL9m4T9lDxBC
         0fdYXFu2AyGvIZiZBWajRVYmiRH8IeuGcRn4koWhB845FNGe+E7GpRFmRMTMQt52qY0c
         4mzDGLHJlvIKgxDwfG2ni48QvP1qpzhqPu5TokxQOCPLp7jP9xmUlteUejO1S+TSnvvk
         ezpg==
X-Gm-Message-State: ANhLgQ22K5sxQuKlbL3dcJtAnrPZr3xzvDHQ35GN9oT8sYXu6efZ1Sil
        Xw1XT83VWsR6kQN6ODfJ5xA=
X-Google-Smtp-Source: ADFU+vvrLiPqnJkhF6yo+wd94RHACkXtF/siGFZBBQfGZsb/fysa8j0bFtndSvprcCXTx+k8XKKlfg==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr13154575plo.36.1584099494918;
        Fri, 13 Mar 2020 04:38:14 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id v133sm47423715pfc.68.2020.03.13.04.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 04:38:14 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH -next] rcu-tasks: fix a modpost warning for rcu_tasks_rude_wait_gp
Date:   Fri, 13 Mar 2020 19:38:10 +0800
Message-Id: <20200313113810.3840-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by gcc:
WARNING: modpost: "rcu_tasks_rude_wait_gp" [vmlinux] is a static
EXPORT_SYMBOL_GPL

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index cd071b5d4274..04d3c583a9fc 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -447,7 +447,7 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 }
 
 // Wait for one rude RCU-tasks grace period.
-static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
+void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
-- 
2.17.1

