Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA214F362
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 21:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAaUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 15:52:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38089 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:52:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so10247523wrh.5;
        Fri, 31 Jan 2020 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=22M7Ar2eT/p9hlS7tbHmPUOTKv1AGz+LLVmjgNnoWmA=;
        b=iOrpQfE4vKd9CnytetwG/RUwCgOIhOFUxfdI03Pv94wZozMOKGR15jARje5XOsiMt2
         civHQfX1Diz/vzCIkoa1elqCfTNAP2h5Xg1qIudEtv/I9CZEpywxCuNYFp1uPzSvzACH
         t3B85z7+OISqqpUpVMYgBJE+zDSMNGYVZYwSKQTZbPawG8Pa/NhK7M3xWjuZv2/rJgdU
         UXQnVU6aSmD1xCUCvCwmj68nly2xH5RN/eMfFGvr2ADrMnIK6uRYVvD0XFQOIcStuWC2
         p1FGF2N4xnpmjHHf+8RxmdouOIqziYw0hJ6iCrOK/w4rVDVdHahF/DPDLhu/vHrWdbSt
         CHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=22M7Ar2eT/p9hlS7tbHmPUOTKv1AGz+LLVmjgNnoWmA=;
        b=OwgrGWjeZAeDJ7tVbgkOX8Go4uah92uVni4pma4+hduz3RdfDdMvzj/nkNf+Eq8zXS
         msgKO3qxz5OQz6YPUhK00EONbyPMRSUfQiHcnxsMA4tzRiWDrCvDrbyEU0ykMUsDyY4/
         EXLVFRqhC/mTRCw6e824w7pn5HoAANku9BwHTXwATNaKs6Wily7Rgo7t2o8SEmb3JtLu
         neMqCtzb6a4TiCoT4Q/G+6Ux7PLUJWUf1lMmrfQI6d5qZ0Y2czocT55qrjWV2rJsZwXD
         PmNXZ/ENvcqdsRcY6NJ9iR/4/Pp5pfVCcpjWagfEwyWy5OKBZUYpL9gB7fv33lws6lFC
         BnDQ==
X-Gm-Message-State: APjAAAWEO8nwBHtf8v3xi+ca9m3JqdYpHIF77uHBAEJqb77qFTru/U6w
        BgWpsnehdGD7RDFEshxJ8NqkZ6k7
X-Google-Smtp-Source: APXvYqyrjZpCMTmmnDgbb8YISMmN/jpiok+NgM7AkENKNPPcj++4r5bPBL7o81ZKSCQ+sgt/Of7rNA==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr215635wro.415.1580503972595;
        Fri, 31 Jan 2020 12:52:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id z3sm13483738wrs.94.2020.01.31.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:52:52 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     SeongJae Park <sjpark@amazon.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] docs/locking: Fix outdated section names
Date:   Fri, 31 Jan 2020 21:52:33 +0100
Message-Id: <20200131205237.29535-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131205237.29535-1-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.com>

Commit 2e4f5382d12a ("locking/doc: Rename LOCK/UNLOCK to
ACQUIRE/RELEASE") has not appied to 'spinlock.rst'.  This commit updates
the doc for the change.

Signed-off-by: SeongJae Park <sjpark@amazon.com>
---
 Documentation/locking/spinlocks.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
index 66e3792f8a36..bec96f7a9f2d 100644
--- a/Documentation/locking/spinlocks.rst
+++ b/Documentation/locking/spinlocks.rst
@@ -25,9 +25,9 @@ worry about UP vs SMP issues: the spinlocks work correctly under both.
 
      Documentation/memory-barriers.txt
 
-       (5) LOCK operations.
+       (5) ACQUIRE operations.
 
-       (6) UNLOCK operations.
+       (6) RELEASE operations.
 
 The above is usually pretty simple (you usually need and want only one
 spinlock for most things - using more than one spinlock can make things a
-- 
2.17.1

