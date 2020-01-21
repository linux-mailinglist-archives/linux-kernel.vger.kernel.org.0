Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E29143851
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAUIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:34:12 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49444 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgAUIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ToHX9tq_1579595649;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHX9tq_1579595649)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/mpi: remove unused macro A_LIMB_1
Date:   Tue, 21 Jan 2020 16:34:07 +0800
Message-Id: <1579595647-251293-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro isn't used from commit 7cf4206a99d1 ("Remove unused code from
MPI library"). so better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Cc: linux-kernel@vger.kernel.org 
---
 lib/mpi/mpi-bit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/mpi/mpi-bit.c b/lib/mpi/mpi-bit.c
index 503537e08436..18030a01494f 100644
--- a/lib/mpi/mpi-bit.c
+++ b/lib/mpi/mpi-bit.c
@@ -21,8 +21,6 @@
 #include "mpi-internal.h"
 #include "longlong.h"
 
-#define A_LIMB_1 ((mpi_limb_t) 1)
-
 /****************
  * Sometimes we have MSL (most significant limbs) which are 0;
  * this is for some reasons not good, so this function removes them.
-- 
1.8.3.1

