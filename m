Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7A1971FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 03:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgC3BZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 21:25:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40317 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgC3BZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:25:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so19407250wro.7;
        Sun, 29 Mar 2020 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+wn7qClZIa1xvjg8Kd2b3s4VLOFfaASUxeqUySTijI=;
        b=sgKwu5+n0Uia+KnlO6EcWuTWx2zJhARlhaC8BOxOqymlDv3KuvEI3GAqdKg1NfdIgp
         wxvHQU/506JbLYgU3N2WMFFRr1qAr5pqG3xky5hX+1W1jGhGiSSw83t1WEeWTq32LNAE
         zEXII4fxL31YhcHVSiAM9gZN5An/uIbWoDDjkn0exd8aNgGpt7tN+2JMGdDfPrSayC1E
         +yC/WGNhxquiyTAFUECW+mysVcQqmBui3f0aYe4DtbcchOSow4iSiH7p4eN5yCe+sGzJ
         q4Vq4ifoWADg32vf5AcXTzGjVDDUast+dxIpA1yTnAfhOIKhk2eK6PhoZ3zabZNP9oTh
         VWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+wn7qClZIa1xvjg8Kd2b3s4VLOFfaASUxeqUySTijI=;
        b=MwHuQQr6o14FpL9YzoHeLShpYQGNVWLzDHIf3cCrbdBRyetvG0kFD9em0HO0rsMtfJ
         pH39izUMtrQTDLdwAXrn12vT7oydiYYED8sBmEfQcItUUtWDPzca2oft/ZJT6L1JxRYR
         gReLaVUB5BMnnbnEKxxFwkVM5ii8N1qjcrrIj6yA7ANkQtaFyqCgn6NUu2K16js3wYZf
         ueNNhAGTqVYF3UXueKms5XoowzjElYRzjtUx9HJ02nvb8PcMa5xpyUt+rM4b55PDh+B+
         J7fdOp0C5Hw9BrhYSiFNhq4+Kr9yYznAAIVQqjnuKkOHIUe1u5mzrWRjuyg2i/m7k6Wn
         pBQA==
X-Gm-Message-State: ANhLgQ1BKT8kaUHOD1au5MjBmv4yTmW+IJPtSL9cO5N6K3kkCDijXzIV
        lJT74AmM38IsE4G9Kw73pcUb2VjPZoVy
X-Google-Smtp-Source: ADFU+vt/BinZeFR3M5L3M0ZA506SMS9BDChv5VylzMerY3FGrvGMI7yNrAru49PShwTyG8C6eogAgQ==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr5565280wrs.2.1585531506703;
        Sun, 29 Mar 2020 18:25:06 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id f12sm18679545wmh.4.2020.03.29.18.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:25:06 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Subject: [PATCH v2 2/4] rcu: Replace 1 by true
Date:   Mon, 30 Mar 2020 02:24:48 +0100
Message-Id: <20200330012450.312155-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330012450.312155-1-jbi.octave@gmail.com>
References: <0/4>
 <20200330012450.312155-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning at use_softirq declaration

WARNING: Assignment of 0/1 to bool variable

The root cause is
use_softirq a variable of bool type is initialised with the integer 1
Replacing 1 with value true solve the issue.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2..c2ffea31eae8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -100,7 +100,7 @@ static struct rcu_state rcu_state = {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq = 1;
+static bool use_softirq = true;
 module_param(use_softirq, bool, 0444);
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
-- 
2.25.1

