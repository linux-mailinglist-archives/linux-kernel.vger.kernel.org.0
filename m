Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444E6CE207
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfJGMpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:45:05 -0400
Received: from mtaout.hs-regensburg.de ([194.95.104.10]:60534 "EHLO
        mtaout.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJGMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:45:03 -0400
Received: from pluto.lfdr (im-mob-039.hs-regensburg.de [172.20.37.154])
        by mtaout.hs-regensburg.de (Postfix) with ESMTP id 46n0Q50mWtzy85;
        Mon,  7 Oct 2019 14:38:21 +0200 (CEST)
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        jailhouse-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: [PATCH v5 2/2] x86/jailhouse: Only enable platform UARTs if available
Date:   Mon,  7 Oct 2019 14:38:19 +0200
Message-Id: <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
References: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.3.3.2656215, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2019.10.7.123317, AntiVirus-Engine: 5.65.0, AntiVirus-Data: 2019.10.7.5650001
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODY_SIZE_5000_5999 0, BODY_SIZE_7000_LESS 0, IN_REP_TO 0, LEGITIMATE_SIGNS 0, MSG_THREAD 0, MULTIPLE_REAL_RCPTS 0, NO_URI_HTTPS 0, REFERENCES 0, __ANY_URI 0, __BODY_NO_MAILTO 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CTE 0, __FROM_DOMAIN_IN_ANY_CC1 0, __FROM_DOMAIN_IN_RCPT 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_REFERENCES 0, __HAS_X_MAILER 0, __IN_REP_TO 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __MULTIPLE_RCPTS_CC_X2 0, __MULTIPLE_RCPTS_TO_X5 0, __NO_HTML_TAG_RAW 0, __PHISH_PHRASE2 0, __REFERENCES 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_NO_WWW 0, __URI_NS '
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI tables aren't available if Linux runs as guest of the hypervisor
Jailhouse. This makes the 8250 driver probe for all platform UARTs as
it assumes that all platform are present in case of !ACPI. Jailhouse
will stop execution of Linux guest due to port access violation.

So far, these access violations could be solved by tuning the
8250.nr_uarts parameter but it has limitations: We can, e.g., only map
consecutive platform UARTs to Linux, and only in the sequence 0x3f8,
0x2f8, 0x3e8, 0x2e8.

Beginning from setup_data version 2, Jailhouse will place information of
available platform UARTs in setup_data. This allows for selective
activation of platform UARTs.

This patch queries the setup_data version and activates only available
UARTS. It comes with backward compatibility, and will still support
older setup_data versions. In this case, Linux falls back to the old
behaviour.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 arch/x86/include/uapi/asm/bootparam.h |  3 +
 arch/x86/kernel/jailhouse.c           | 83 +++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 43be437c9c71..db1e24e56e94 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -152,6 +152,9 @@ struct jailhouse_setup_data {
 		__u8	standard_ioapic;
 		__u8	cpu_ids[255];
 	} __attribute__((packed)) v1;
+	struct {
+		__u32	flags;
+	} __attribute__((packed)) v2;
 } __attribute__((packed));
 
 /* The so-called "zeropage" */
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index b9647add0063..95550c08ab23 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -11,6 +11,7 @@
 #include <linux/acpi_pmtmr.h>
 #include <linux/kernel.h>
 #include <linux/reboot.h>
+#include <linux/serial_8250.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/hypervisor.h>
@@ -23,9 +24,22 @@
 
 static __initdata struct jailhouse_setup_data setup_data;
 #define SETUP_DATA_V1_LEN	(sizeof(setup_data.hdr) + sizeof(setup_data.v1))
+#define SETUP_DATA_V2_LEN	(SETUP_DATA_V1_LEN + sizeof(setup_data.v2))
 
 static unsigned int precalibrated_tsc_khz;
 
+static void jailhouse_setup_irq(unsigned int irq)
+{
+	struct mpc_intsrc mp_irq = {
+		.type		= MP_INTSRC,
+		.irqtype	= mp_INT,
+		.irqflag	= MP_IRQPOL_ACTIVE_HIGH | MP_IRQTRIG_EDGE,
+		.srcbusirq	= irq,
+		.dstirq		= irq,
+	};
+	mp_save_irq(&mp_irq);
+}
+
 static uint32_t jailhouse_cpuid_base(void)
 {
 	if (boot_cpu_data.cpuid_level < 0 ||
@@ -79,11 +93,6 @@ static void __init jailhouse_get_smp_config(unsigned int early)
 		.type = IOAPIC_DOMAIN_STRICT,
 		.ops = &mp_ioapic_irqdomain_ops,
 	};
-	struct mpc_intsrc mp_irq = {
-		.type = MP_INTSRC,
-		.irqtype = mp_INT,
-		.irqflag = MP_IRQPOL_ACTIVE_HIGH | MP_IRQTRIG_EDGE,
-	};
 	unsigned int cpu;
 
 	jailhouse_x2apic_init();
@@ -100,12 +109,12 @@ static void __init jailhouse_get_smp_config(unsigned int early)
 	if (setup_data.v1.standard_ioapic) {
 		mp_register_ioapic(0, 0xfec00000, gsi_top, &ioapic_cfg);
 
-		/* Register 1:1 mapping for legacy UART IRQs 3 and 4 */
-		mp_irq.srcbusirq = mp_irq.dstirq = 3;
-		mp_save_irq(&mp_irq);
-
-		mp_irq.srcbusirq = mp_irq.dstirq = 4;
-		mp_save_irq(&mp_irq);
+		if (IS_ENABLED(CONFIG_SERIAL_8250) &&
+		    setup_data.hdr.version < 2) {
+			/* Register 1:1 mapping for legacy UART IRQs 3 and 4 */
+			jailhouse_setup_irq(3);
+			jailhouse_setup_irq(4);
+		}
 	}
 }
 
@@ -138,6 +147,53 @@ static int __init jailhouse_pci_arch_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_SERIAL_8250
+static bool jailhouse_uart_enabled(unsigned int uart_nr)
+{
+	return setup_data.v2.flags & BIT(uart_nr);
+}
+
+static void jailhouse_serial_fixup(int port, struct uart_port *up,
+				   u32 *capabilities)
+{
+	static const u16 pcuart_base[] = {0x3f8, 0x2f8, 0x3e8, 0x2e8};
+	unsigned int n;
+
+	for (n = 0; n < ARRAY_SIZE(pcuart_base); n++) {
+		if (pcuart_base[n] != up->iobase)
+			continue;
+
+		if (jailhouse_uart_enabled(n)) {
+			pr_info("Enabling UART%u (port 0x%lx)\n", n,
+				up->iobase);
+			jailhouse_setup_irq(up->irq);
+		} else {
+			/* Deactivate UART if access isn't allowed */
+			up->iobase = 0;
+		}
+		break;
+	}
+}
+
+static void jailhouse_serial_workaround(void)
+{
+	/*
+	 * There are flags inside setup_data that indicate availability of
+	 * platform UARTs since setup data version 2.
+	 *
+	 * In case of version 1, we don't know which UARTs belong Linux. In
+	 * this case, unconditionally register 1:1 mapping for legacy UART IRQs
+	 * 3 and 4.
+	 */
+	if (setup_data.hdr.version > 1)
+		serial8250_set_isa_configurator(jailhouse_serial_fixup);
+}
+#else /* !CONFIG_SERIAL_8250 */
+static inline void jailhouse_serial_workaround(void)
+{
+}
+#endif /* CONFIG_SERIAL_8250 */
+
 static void __init jailhouse_init_platform(void)
 {
 	u64 pa_data = boot_params.hdr.setup_data;
@@ -188,7 +244,8 @@ static void __init jailhouse_init_platform(void)
 	if (setup_data.hdr.version == 0 ||
 	    setup_data.hdr.compatible_version !=
 		JAILHOUSE_SETUP_REQUIRED_VERSION ||
-	    (setup_data.hdr.version >= 1 && header.len < SETUP_DATA_V1_LEN))
+	    (setup_data.hdr.version == 1 && header.len < SETUP_DATA_V1_LEN) ||
+	    (setup_data.hdr.version >= 2 && header.len < SETUP_DATA_V2_LEN))
 		goto unsupported;
 
 	pmtmr_ioport = setup_data.v1.pm_timer_address;
@@ -204,6 +261,8 @@ static void __init jailhouse_init_platform(void)
 	 * are none in a non-root cell.
 	 */
 	disable_acpi();
+
+	jailhouse_serial_workaround();
 	return;
 
 unsupported:
-- 
2.23.0

