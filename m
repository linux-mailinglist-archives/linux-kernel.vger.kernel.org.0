Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0CF585D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfKHUTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 15:19:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbfKHUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:18:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8KI87F103765;
        Fri, 8 Nov 2019 15:18:37 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w5c3yp55b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 15:18:37 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA8KGbps023252;
        Fri, 8 Nov 2019 20:18:36 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 2w41ujw5ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 20:18:36 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8KIZKd47513992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 20:18:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92F12805E;
        Fri,  8 Nov 2019 20:18:35 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F32A52805A;
        Fri,  8 Nov 2019 20:18:34 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 20:18:34 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au,
        maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 01/12] dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
Date:   Fri,  8 Nov 2019 14:18:22 -0600
Message-Id: <1573244313-9190-2-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Aspeed SCU interrupt controller and add an include file
for the interrupts it provides.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt | 26 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++++++
 .../interrupt-controller/aspeed-scu-ic.h           | 23 +++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
new file mode 100644
index 0000000..baa3780
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
@@ -0,0 +1,26 @@
+Aspeed AST25XX and AST26XX SCU Interrupt Controller
+
+Required Properties:
+ - #interrupt-cells		: must be 1
+ - compatible			: must be "aspeed,ast2500-scu-ic",
+				  "aspeed,ast2600-scu-ic0" or
+				  "aspeed,ast2600-scu-ic1"
+ - reg				: address and size of the SCU register
+				  associated with the controller
+ - interrupts			: interrupt from the parent controller
+ - interrupt-controller		: indicates that the controlle receives and
+				  fires new interrupts for child busses
+
+Example:
+
+    syscon@1e6e2000 {
+        ranges = <0 0x1e6e2000 0x1a8>;
+
+        scu_ic: interrupt-controller@18 {
+            #interrupt-cells = <1>;
+            compatible = "aspeed,ast2500-scu-ic";
+            reg = <0x18 0x04>;
+            interrupts = <21>;
+            interrupt-controller;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c4c532c..1cb976f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2675,6 +2675,13 @@ S:	Maintained
 F:	drivers/pinctrl/aspeed/
 F:	Documentation/devicetree/bindings/pinctrl/aspeed,*
 
+ASPEED SCU INTERRUPT CONTROLLER DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
new file mode 100644
index 0000000..f315d5a
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+
+#define ASPEED_SCU_IC_VGA_CURSOR_CHANGE			0
+#define ASPEED_SCU_IC_VGA_SCRATCH_REG_CHANGE		1
+
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI	2
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_HI_TO_LO	3
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_LO_TO_HI	4
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_HI_TO_LO	5
+#define ASPEED_AST2500_SCU_IC_ISSUE_MSI			6
+
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI	2
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_HI_TO_LO	3
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_LO_TO_HI	4
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_HI_TO_LO	5
+
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
+
+#endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
-- 
1.8.3.1

