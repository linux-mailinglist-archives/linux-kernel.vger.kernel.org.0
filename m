Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9770136D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfFFHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 03:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFHiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:38:06 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00890207E0;
        Thu,  6 Jun 2019 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559806685;
        bh=kUhxb6y9/x7K/KEBo2rYjsmRiInlugkMcXaHDaMG5jE=;
        h=From:To:Cc:Subject:Date:From;
        b=ykQxP54n53i4lIc5K1Cpz3oe+oxrNvwwljXXmG3lBM8FQDN3uB/OyatN5vf95X/Nu
         cDPF8BUXAhQH3LL5wiQ6j0wvUVJqh7CzdhhZG03g5HPFmeSGUwH2tMYKuQdDa3tGCL
         D/jCFhjhyRhR/HGjyU1a/D4WxpngLsSQZ5Lx7btk=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 0/3] irqchip/irq-csky-mpintc: Update some features
Date:   Thu,  6 Jun 2019 15:37:30 +0800
Message-Id: <1559806653-11249-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Here are some patches for irq-csky-mpintc. Any feedback is welcome.

Changes for V5:
 - Remove "auto irq deliver patch" in this patchset, because it has been
   queued as a fix already.
 - Move "remove INTCL_HPPIR define" into remove-unnecessary-loop.patch
   to make patch's sequence better.

Changes for V4:
 - Remove priority setting
 - Add remove loop in csky_mpintc_handler in a seperate patch
 - Add auto irq deliver fixup patch
 - Add include file for devicetree document's example
 - Add --cover-letter

Changes for V3:
 - Use IRQ_TYPE_LEVEL_HIGH as default instead of IRQ_TYPE_NONE
 - Remove unnecessary loop in csky_mpintc_handler
 - Update commit log msg

Changes for V2:
 - Fixup this_cpu_read() preempted problem
 - Optimize the coding style
 - Optimize #interrupt-cells to one style

Guo Ren (3):
  irqchip/irq-csky-mpintc: Add triger type
  dt-bindings: interrupt-controller: Update csky mpintc
  irqchip/irq-csky-mpintc: Remove unnecessary loop in interrupt handler

 .../bindings/interrupt-controller/csky,mpintc.txt  | 20 ++++-
 drivers/irqchip/irq-csky-mpintc.c                  | 86 ++++++++++++++++++++--
 2 files changed, 95 insertions(+), 11 deletions(-)

-- 
2.7.4

