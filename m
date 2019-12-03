Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9334610F5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 04:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfLCDte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 22:49:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfLCDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:48:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kn2A076963
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 22:48:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wknuapy7p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:48:29 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 3 Dec 2019 03:48:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 03:48:18 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mHrh28704874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 03:48:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B644011C050;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13AB711C04C;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EB68FA03DD;
        Tue,  3 Dec 2019 14:48:12 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v2 11/27] nvdimm/ocxl: Add register addresses & status values to header
Date:   Tue,  3 Dec 2019 14:46:39 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120303-0012-0000-0000-00000370128A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0013-0000-0000-000021ABCCBE
Message-Id: <20191203034655.51561-12-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=858 phishscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=1 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

These values have been taken from the device specifications.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm_internal.h | 72 ++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
index 6340012e0f8a..d6ab361f5de9 100644
--- a/drivers/nvdimm/ocxl/scm_internal.h
+++ b/drivers/nvdimm/ocxl/scm_internal.h
@@ -6,6 +6,78 @@
 #include <linux/libnvdimm.h>
 #include <linux/mm.h>
 
+#define GLOBAL_MMIO_CHI		0x000
+#define GLOBAL_MMIO_CHIC	0x008
+#define GLOBAL_MMIO_CHIE	0x010
+#define GLOBAL_MMIO_CHIEC	0x018
+#define GLOBAL_MMIO_HCI		0x020
+#define GLOBAL_MMIO_HCIC	0x028
+#define GLOBAL_MMIO_IMA0_OHP	0x040
+#define GLOBAL_MMIO_IMA0_CFP	0x048
+#define GLOBAL_MMIO_IMA1_OHP	0x050
+#define GLOBAL_MMIO_IMA1_CFP	0x058
+#define GLOBAL_MMIO_ACMA_CREQO	0x100
+#define GLOBAL_MMIO_ACMA_CRSPO	0x104
+#define GLOBAL_MMIO_ACMA_CDBO	0x108
+#define GLOBAL_MMIO_ACMA_CDBS	0x10c
+#define GLOBAL_MMIO_NSCMA_CREQO	0x120
+#define GLOBAL_MMIO_NSCMA_CRSPO	0x124
+#define GLOBAL_MMIO_NSCMA_CDBO	0x128
+#define GLOBAL_MMIO_NSCMA_CDBS	0x12c
+#define GLOBAL_MMIO_CSTS	0x140
+#define GLOBAL_MMIO_FWVER	0x148
+#define GLOBAL_MMIO_CCAP0	0x160
+#define GLOBAL_MMIO_CCAP1	0x168
+
+#define GLOBAL_MMIO_CHI_ACRA	BIT_ULL(0)
+#define GLOBAL_MMIO_CHI_NSCRA	BIT_ULL(1)
+#define GLOBAL_MMIO_CHI_CRDY	BIT_ULL(4)
+#define GLOBAL_MMIO_CHI_CFFS	BIT_ULL(5)
+#define GLOBAL_MMIO_CHI_MA	BIT_ULL(6)
+#define GLOBAL_MMIO_CHI_ELA	BIT_ULL(7)
+#define GLOBAL_MMIO_CHI_CDA	BIT_ULL(8)
+#define GLOBAL_MMIO_CHI_CHFS	BIT_ULL(9)
+
+#define GLOBAL_MMIO_CHI_ALL	(GLOBAL_MMIO_CHI_ACRA | \
+				 GLOBAL_MMIO_CHI_NSCRA | \
+				 GLOBAL_MMIO_CHI_CRDY | \
+				 GLOBAL_MMIO_CHI_CFFS | \
+				 GLOBAL_MMIO_CHI_MA | \
+				 GLOBAL_MMIO_CHI_ELA | \
+				 GLOBAL_MMIO_CHI_CDA | \
+				 GLOBAL_MMIO_CHI_CHFS)
+
+#define GLOBAL_MMIO_HCI_ACRW				BIT_ULL(0)
+#define GLOBAL_MMIO_HCI_NSCRW				BIT_ULL(1)
+#define GLOBAL_MMIO_HCI_AFU_RESET			BIT_ULL(2)
+#define GLOBAL_MMIO_HCI_FW_DEBUG			BIT_ULL(3)
+#define GLOBAL_MMIO_HCI_CONTROLLER_DUMP			BIT_ULL(4)
+#define GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED	BIT_ULL(5)
+#define GLOBAL_MMIO_HCI_REQ_HEALTH_PERF			BIT_ULL(6)
+
+#define ADMIN_COMMAND_HEARTBEAT		0x00u
+#define ADMIN_COMMAND_SHUTDOWN		0x01u
+#define ADMIN_COMMAND_FW_UPDATE		0x02u
+#define ADMIN_COMMAND_FW_DEBUG		0x03u
+#define ADMIN_COMMAND_ERRLOG		0x04u
+#define ADMIN_COMMAND_SMART		0x05u
+#define ADMIN_COMMAND_CONTROLLER_STATS	0x06u
+#define ADMIN_COMMAND_CONTROLLER_DUMP	0x07u
+#define ADMIN_COMMAND_CMD_CAPS		0x08u
+#define ADMIN_COMMAND_MAX		0x08u
+
+#define STATUS_SUCCESS		0x00
+#define STATUS_MEM_UNAVAILABLE	0x20
+#define STATUS_BAD_OPCODE	0x50
+#define STATUS_BAD_REQUEST_PARM	0x51
+#define STATUS_BAD_DATA_PARM	0x52
+#define STATUS_DEBUG_BLOCKED	0x70
+#define STATUS_FAIL		0xFF
+
+#define STATUS_FW_UPDATE_BLOCKED 0x21
+#define STATUS_FW_ARG_INVALID	0x51
+#define STATUS_FW_INVALID	0x52
+
 #define SCM_LABEL_AREA_SIZE	(1UL << PA_SECTION_SHIFT)
 
 struct scm_function_0 {
-- 
2.23.0

