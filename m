Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441CDA655D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfICJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 05:32:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfICJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V+f2G+cgKLc1xmd5cIRO1ilePI+Z6rsbxxfmORin59I=; b=n2UGEt1gkac6QXtWZ19kZvTwgQ
        UNi5fFjzebdd1eUqmNZo3z6ob3Yj+15njNMRbd0JtL8PDXqtiw2vlYTeykrPxSm3t+GNjzgz5Bg+E
        Dkuw9Bue+V4gjZOtqo+5sjxSY+2n/jYSK81yMV2vzPWcnif5xmqvHYlf1foom67w0tyqTg9vaI5Lx
        ei0SUYl1FvJhCbc5hhxAzG0ONOUExibGdF9xM8/lpyyZY0sFBbsH0knYs6Yxl6NOlwGx0uOPOKVlg
        KcotyV5hdTGIv6mEy7zMpyC4OdbpdJqdcu2lRmzEUIGP/3kt0GoR7u/abj8MJlilxpQAmmt6AKUwX
        +6jMmxzw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55B7-0004Ha-NS; Tue, 03 Sep 2019 09:32:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 02/20] riscv: refactor the IPI code
Date:   Tue,  3 Sep 2019 11:32:21 +0200
Message-Id: <20190903093239.21278-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for adding native non-SBI IPI code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c | 55 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 5a9834503a2f..8cd730239613 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -78,13 +78,38 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
+static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+{
+	int cpuid, hartid;
+	struct cpumask hartid_mask;
+
+	cpumask_clear(&hartid_mask);
+	mb();
+	for_each_cpu(cpuid, mask) {
+		set_bit(op, &ipi_data[cpuid].bits);
+		hartid = cpuid_to_hartid_map(cpuid);
+		cpumask_set_cpu(hartid, &hartid_mask);
+	}
+	mb();
+	sbi_send_ipi(cpumask_bits(&hartid_mask));
+}
+
+static void send_ipi_single(int cpu, enum ipi_message_type op)
+{
+	send_ipi_mask(cpumask_of(cpu), op);
+}
+
+static inline void clear_ipi(void)
+{
+	csr_clear(CSR_SIP, SIE_SSIE);
+}
+
 void riscv_software_interrupt(void)
 {
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
 	unsigned long *stats = ipi_data[smp_processor_id()].stats;
 
-	/* Clear pending IPI */
-	csr_clear(CSR_SIP, SIE_SSIE);
+	clear_ipi();
 
 	while (true) {
 		unsigned long ops;
@@ -118,23 +143,6 @@ void riscv_software_interrupt(void)
 	}
 }
 
-static void
-send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
-{
-	int cpuid, hartid;
-	struct cpumask hartid_mask;
-
-	cpumask_clear(&hartid_mask);
-	mb();
-	for_each_cpu(cpuid, to_whom) {
-		set_bit(operation, &ipi_data[cpuid].bits);
-		hartid = cpuid_to_hartid_map(cpuid);
-		cpumask_set_cpu(hartid, &hartid_mask);
-	}
-	mb();
-	sbi_send_ipi(cpumask_bits(&hartid_mask));
-}
-
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
@@ -156,12 +164,12 @@ void show_ipi_stats(struct seq_file *p, int prec)
 
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
 {
-	send_ipi_message(mask, IPI_CALL_FUNC);
+	send_ipi_mask(mask, IPI_CALL_FUNC);
 }
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+	send_ipi_single(cpu, IPI_CALL_FUNC);
 }
 
 void smp_send_stop(void)
@@ -176,7 +184,7 @@ void smp_send_stop(void)
 
 		if (system_state <= SYSTEM_RUNNING)
 			pr_crit("SMP: stopping secondary CPUs\n");
-		send_ipi_message(&mask, IPI_CPU_STOP);
+		send_ipi_mask(&mask, IPI_CPU_STOP);
 	}
 
 	/* Wait up to one second for other CPUs to stop */
@@ -191,6 +199,5 @@ void smp_send_stop(void)
 
 void smp_send_reschedule(int cpu)
 {
-	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
-
-- 
2.20.1

