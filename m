Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED9344DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 12:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfFDK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 06:56:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43221 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbfFDK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:56:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0782919|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.102947-0.0128022-0.88425;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07391;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.EhJTrBQ_1559645764;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EhJTrBQ_1559645764)
          by smtp.aliyun-inc.com(10.147.40.7);
          Tue, 04 Jun 2019 18:56:04 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V5 0/6] csky: Add pmu hardware sampling support
Date:   Tue,  4 Jun 2019 18:54:43 +0800
Message-Id: <cover.1559644961.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add hardware sampling support for csky-pmu, and
also add some properties to pmu node definition. perf can record
on hardware event with this patch applied.

Cc: Guo Ren <guoren@kernel.org>

Changes since v4:
  - remove some function hook registration

Changes since v3:
  - change reg-io-width to count-width
  - use macro sign_extend64
  - update commit log

Changes since v2:
  - update dt-binding(csky pmu use rising edge interrupt)
  - use cpuhp_setup_state to enable irq(fix irq enable on smp)

Changes since v1:
  - do not update hpcr when event type is invalid(fix option
    --all-kernel/--all-user)

Guo Ren (1):
  csky: Fixup some error count in 810 & 860.

Mao Han (5):
  csky: Init pmu as a device
  csky: Add count-width property for csky pmu
  csky: Add pmu interrupt support
  dt-bindings: csky: Add csky PMU bindings
  csky: Fix perf record in kernel/user space

 Documentation/devicetree/bindings/csky/pmu.txt |  38 +++
 arch/csky/kernel/perf_event.c                  | 422 +++++++++++++++++++++++--
 2 files changed, 425 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

-- 
2.7.4

