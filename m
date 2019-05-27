Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC632AF06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE0G62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 02:58:28 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57374 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfE0G62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:58:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08441354|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0549198-0.00885414-0.936226;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Edg2x71_1558940305;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Edg2x71_1558940305)
          by smtp.aliyun-inc.com(10.147.41.231);
          Mon, 27 May 2019 14:58:25 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: [PATCH V2 0/5] csky: Add pmu hardware sampling support
Date:   Mon, 27 May 2019 14:57:16 +0800
Message-Id: <cover.1558939831.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add hardware sampling support for csky-pmu, and
also add some properties to pmu node definition. perf can record
on hardware event with this patch applied.

Changes since v1:
  - do not enable/disable irq at start/stop(may lose irq)
  - do not update hpcr when event type is invalid

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org

Guo Ren (1):
  csky: Fixup some error count in 810 & 860.

Mao Han (4):
  csky: Init pmu as a device
  csky: Add reg-io-width property for csky pmu
  csky: Add pmu interrupt support
  dt-bindings: csky: Add csky PMU bindings

 Documentation/devicetree/bindings/csky/pmu.txt |  38 +++
 arch/csky/kernel/perf_event.c                  | 407 +++++++++++++++++++++++--
 2 files changed, 424 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

-- 
2.7.4

