Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183A412D9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLaPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 10:16:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37459 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfLaPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:16:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so2069579wmf.2;
        Tue, 31 Dec 2019 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFEPbtJ2S511CCkIMFtcOk5/gDgHZ8Ye+16tjW/UD9o=;
        b=LKMyDsmqGfn1bql2MP/0nyKb8uAih/Pwt+ezwfN4DeqnPzNdh919LNFKvrIN71atyx
         mKzWiGAzR5CgHhmuOyCQ7GUg4ZND3BCzY746BEHwhmgrwN/i5yYY7DwVFp7Gqk910WIv
         tG0mxPXVmU3pEYjKc7Mg30VK7mfTU0Mh1JsNkKQM+zYhClmTj3bu7zg3hFbMBTEbvfTU
         FS8qarJ7QIrZn0WxO9LJNL0rixD3cL61O5CW6KVBI01zhlWgR8uULjkYwYxiPKEL1LkG
         p/B9VK3OJ2Q4GxEP+I/Y5Pzh9f26s1xEau/Q0eZ8xU6u5uzELSyK48VnHHpz3CgBrmSo
         evPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFEPbtJ2S511CCkIMFtcOk5/gDgHZ8Ye+16tjW/UD9o=;
        b=N0AOY8odB3uA8KyGppP9+rzINyPBkaJVZ+YqEemJbyMFbWHSjSQ+9ftFAYRPh5jTtT
         ZpwSd3qi8NhidN2so2arE9VtmriG3AajnT7F65nOAJNFz+L56cZCuRVv7pH/8koJVxRj
         LTMQxFAUcb4uX9izSAWIDrlsamFwIQ42UJpkrOwxLmKZZmsnjqlBeaXPbEWfUIAat8K4
         VZiwuL3mUlSEaucGCyZxq0sqGvdRL+RLvMctUryeNdmX6x6IJGCakVJWWe8IEf/FvDGA
         +QSWu4bVx5lTB+06idxYiuiIgqJ83P8NJoR6DgPQ+4wytAAkhWlRn0vjiOpg0Xe9IPRI
         U2JA==
X-Gm-Message-State: APjAAAVeWkr+qYHTwbc73H02UddObvydE91pwqsJhuHEihNDD3iTvAtB
        wBW9oWtO/XOSDTuxF/oeW62tDjVZi0c=
X-Google-Smtp-Source: APXvYqx5TSkXA3AT/4lpzoe1+B2G1uGY7byT9HDvBGpVsaPp0TMNUItPHSAUsczPlgEymbpmseFaMQ==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr4668521wmm.85.1577805363120;
        Tue, 31 Dec 2019 07:16:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:45f9:d1e3:14f9:8ba2])
        by smtp.gmail.com with ESMTPSA id e12sm49228468wrn.56.2019.12.31.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 07:16:02 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 3/7] doc/RCU/listRCU: Update example function name
Date:   Tue, 31 Dec 2019 16:15:45 +0100
Message-Id: <20191231151549.12797-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231151549.12797-1-sjpark@amazon.de>
References: <20191231151549.12797-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

listRCU.rst document gives an example with 'ipc_lock()', but the
function has dropped off by commit 82061c57ce93 ("ipc: drop
ipc_lock()").  Because the main logic of 'ipc_lock()' has melded in
'shm_lock()' by the commit, this commit updates the document to use
'shm_lock()' instead.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/listRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index e768f56e8fa3..2a643e293fb4 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -286,11 +286,11 @@ time the external state changes before Linux becomes aware of the change,
 additional RCU-induced staleness is generally not a problem.
 
 However, there are many examples where stale data cannot be tolerated.
-One example in the Linux kernel is the System V IPC (see the ipc_lock()
-function in ipc/util.c).  This code checks a *deleted* flag under a
+One example in the Linux kernel is the System V IPC (see the shm_lock()
+function in ipc/shm.c).  This code checks a *deleted* flag under a
 per-entry spinlock, and, if the *deleted* flag is set, pretends that the
 entry does not exist.  For this to be helpful, the search function must
-return holding the per-entry lock, as ipc_lock() does in fact do.
+return holding the per-entry spinlock, as shm_lock() does in fact do.
 
 .. _quick_quiz:
 
-- 
2.17.1

