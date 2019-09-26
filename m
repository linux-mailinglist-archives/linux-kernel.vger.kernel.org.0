Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC6BF686
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfIZQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 12:17:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfIZQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:17:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E1AD28;
        Thu, 26 Sep 2019 09:17:32 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02A13F534;
        Thu, 26 Sep 2019 09:17:31 -0700 (PDT)
Subject: Re: [PATCH 03/35] irqchip/gic-v3-its: Allow LPI invalidation via the
 DirectLPI interface
To:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-4-maz@kernel.org>
 <92ff82ca-ebcb-8f5f-5063-313f65bbc5e3@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <22202880-9a99-f0d9-4737-6112d60b30a6@kernel.org>
Date:   Thu, 26 Sep 2019 17:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <92ff82ca-ebcb-8f5f-5063-313f65bbc5e3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 15:57, Zenghui Yu wrote:
> Hi Marc,
> 
> I get one kernel panic with this patch on D05.

Can you please try this (completely untested for now) on top of the 
whole series? I'll otherwise give it a go next week.

Thanks,

	M.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index bc55327406b7..9d24236d1257 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3461,15 +3461,16 @@ static void its_vpe_send_cmd(struct its_vpe *vpe,
 
 static void its_vpe_send_inv(struct irq_data *d)
 {
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
 	if (gic_rdists->has_direct_lpi) {
-		/*
-		 * Don't mess about. Generating the invalidation is easily
-		 * done by using the parent irq_data, just like below.
-		 */
-		direct_lpi_inv(d->parent_data);
-	} else {
-		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+		void __iomem *rdbase;
 
+		/* Target the redistributor this VPE is currently known on */
+		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
+		wait_for_syncr(rdbase);
+	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
 }

-- 
Jazz is not dead, it just smells funny...
