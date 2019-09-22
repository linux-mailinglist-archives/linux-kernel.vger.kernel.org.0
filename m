Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28ABA169
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfIVIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 04:09:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40451 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfIVIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 04:09:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so6029203wmj.5;
        Sun, 22 Sep 2019 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Wf5z+Rm13hw8aXOmRiiJRXlrz0DWVsNJTijjp3sDN8=;
        b=K/xOoDlfMbe+qlFn2KYQhsbEoGG46RQ4dcXfRr3fKJlQLbtL9EPdgxt+/T/8g6b53J
         URfnwyKh7t/nkt+brA1+jpiisnkFlxo21TjKGVTfKktPPZYFWMrunNTXNygQrgnaEf3D
         EKYQmmXyd759EJqVsRg77FRcqAYWi2Bz+UQceN4f2hgT86Fi00OOcDO+V4QA4VbNHBI8
         RaujcDlCWcbtHdLsYGqRku+a6lR2lDxChO5sT9C855wwGajB/c66C8AZ7h1e0fIrbLyh
         bsdEF3y92lqbMmsT3zgpsHBEfINZv07ZoLfe6e0G5t9mRoL+JHwm2qH29e6dtTQNnm2T
         JmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Wf5z+Rm13hw8aXOmRiiJRXlrz0DWVsNJTijjp3sDN8=;
        b=Ht8jBnci40uqQkUOiAXbkNF9DtRpyegQCsobzT+5m3d2E37KhQl9uAR6K0QPZD79a+
         hGXmUcraEuNFKRfN0Neb//gbRnN+kDotBuMrmslt8YnhbXEqsr9+mmYEyqFVmFnCY9cc
         U4j+zjVEppvvkdGSka8ecMscBUKi5+MLn4KuDmA+6T8InLv58Yayu9CoHskxFQNNHqr6
         DUSxKAQZavEuBT7bZl0PONWdXR/5ZIqsTfvZ3/GVORD4BKnL1EsyYWIIzOwCNJYeDZ0A
         IeGAA2jgel5lUtic2qqWZAaLnX+v2DtKWDSJr7PqUcm0t6xk/KtNY2Xcf5oNZxElplW5
         nO7A==
X-Gm-Message-State: APjAAAWMHDNty5hQS/EDJK0q1GjXFBGuv3GNR/wycVnkx6YU936ViX0W
        vRZKw7gSn1wrSzgMiHM93s0=
X-Google-Smtp-Source: APXvYqzqDc3GZW8l7YFA5DwbbFS1OYmwVdTF89UO62EpyIUc+DCOWGFnRolEdJu26WODIVbJyAOLbA==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr9656814wme.15.1569139754446;
        Sun, 22 Sep 2019 01:09:14 -0700 (PDT)
Received: from localhost.localdomain ([109.126.147.119])
        by smtp.gmail.com with ESMTPSA id x5sm7726983wrt.75.2019.09.22.01.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 01:09:13 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 0/2] Optimise io_uring completion waiting
Date:   Sun, 22 Sep 2019 11:08:49 +0300
Message-Id: <cover.1569139018.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

There could be a lot of overhead within generic wait_event_*() used for
waiting for large number of completions. The patchset removes much of
it by using custom wait event (wait_threshold).

Synthetic test showed ~40% performance boost. (see patch 2)

v2: rebase

Pavel Begunkov (2):
  sched/wait: Add wait_threshold
  io_uring: Optimise cq waiting with wait_threshold

 fs/io_uring.c                  | 35 ++++++++++++------
 include/linux/wait_threshold.h | 67 ++++++++++++++++++++++++++++++++++
 kernel/sched/Makefile          |  2 +-
 kernel/sched/wait_threshold.c  | 26 +++++++++++++
 4 files changed, 118 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/wait_threshold.h
 create mode 100644 kernel/sched/wait_threshold.c

-- 
2.23.0

