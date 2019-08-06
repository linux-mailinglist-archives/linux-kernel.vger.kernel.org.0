Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2239C82ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 07:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfHFFX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 01:23:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfHFFX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:23:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x765Lv5l055743;
        Tue, 6 Aug 2019 01:23:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u739ar48q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 01:23:05 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x765N48Y058815;
        Tue, 6 Aug 2019 01:23:04 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u739ar48a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 01:23:04 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x765KLqw027119;
        Tue, 6 Aug 2019 05:23:04 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 2u51w628gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 05:23:04 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x765N3gt48103796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 05:23:03 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A030A112062;
        Tue,  6 Aug 2019 05:23:03 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929BF112061;
        Tue,  6 Aug 2019 05:23:01 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.207.254])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 05:23:01 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 02/16] powerpc/pseries: Introduce option to build secure virtual machines
Date:   Tue,  6 Aug 2019 02:22:23 -0300
Message-Id: <20190806052237.12525-3-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806052237.12525-1-bauerman@linux.ibm.com>
References: <20190806052237.12525-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce CONFIG_PPC_SVM to control support for secure guests and include
Ultravisor-related helpers when it is selected

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/asm-prototypes.h |  2 +-
 arch/powerpc/kernel/Makefile              |  4 +++-
 arch/powerpc/platforms/pseries/Kconfig    | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index e698f48cbc6d..49196d35e3bb 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -36,7 +36,7 @@ void __trace_hcall_entry(unsigned long opcode, unsigned long *args);
 void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf);
 
 /* Ultravisor */
-#ifdef CONFIG_PPC_POWERNV
+#if defined(CONFIG_PPC_POWERNV) || defined(CONFIG_PPC_SVM)
 long ucall_norets(unsigned long opcode, ...);
 #else
 static inline long ucall_norets(unsigned long opcode, ...)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c6c4ea240b2a..ba379dfb8b83 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -156,7 +156,9 @@ endif
 
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
-obj-$(CONFIG_PPC_POWERNV)	+= ucall.o
+ifneq ($(CONFIG_PPC_POWERNV)$(CONFIG_PPC_SVM),)
+obj-y				+= ucall.o
+endif
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7b484f55553..d09deb05bb66 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -145,3 +145,14 @@ config PAPR_SCM
 	tristate "Support for the PAPR Storage Class Memory interface"
 	help
 	  Enable access to hypervisor provided storage class memory.
+
+config PPC_SVM
+	bool "Secure virtual machine (SVM) support for POWER"
+	depends on PPC_PSERIES
+	help
+	 There are certain POWER platforms which support secure guests using
+	 the Protected Execution Facility, with the help of an Ultravisor
+	 executing below the hypervisor layer. This enables support for
+	 those guests.
+
+	 If unsure, say "N".
