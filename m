Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6442412DE38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 09:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgAAIU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 03:20:59 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56964 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgAAIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 03:20:15 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="429578759"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 09:20:08 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] powerpc/mpic: constify copied structure
Date:   Wed,  1 Jan 2020 08:43:27 +0100
Message-Id: <1577864614-5543-10-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mpic_ipi_chip and mpic_irq_ht_chip structures are only copied
into other structures, so make them const.

The opportunity for this change was found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/sysdev/mpic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 934a77324f6b..a3a72b780e67 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -964,7 +964,7 @@ static struct irq_chip mpic_irq_chip = {
 };
 
 #ifdef CONFIG_SMP
-static struct irq_chip mpic_ipi_chip = {
+static const struct irq_chip mpic_ipi_chip = {
 	.irq_mask	= mpic_mask_ipi,
 	.irq_unmask	= mpic_unmask_ipi,
 	.irq_eoi	= mpic_end_ipi,
@@ -978,7 +978,7 @@ static struct irq_chip mpic_tm_chip = {
 };
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
-static struct irq_chip mpic_irq_ht_chip = {
+static const struct irq_chip mpic_irq_ht_chip = {
 	.irq_startup	= mpic_startup_ht_irq,
 	.irq_shutdown	= mpic_shutdown_ht_irq,
 	.irq_mask	= mpic_mask_irq,

