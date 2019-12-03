Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C163C10F5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 04:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfLCDt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 22:49:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbfLCDsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:48:30 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kcFo118297
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 22:48:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wkrj553j6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:48:29 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 3 Dec 2019 03:48:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 03:48:18 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mHuf63307976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 03:48:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 635DCA4057;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11606A4053;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BDAD8A03D3;
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
Subject: [PATCH v2 09/27] ocxl: Free detached contexts in ocxl_context_detach_all()
Date:   Tue,  3 Dec 2019 14:46:37 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120303-0008-0000-0000-0000033C0FDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0009-0000-0000-00004A5B289A
Message-Id: <20191203034655.51561-10-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=3 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=811 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

ocxl_context_detach_all() is called from ocxl_function_close(), so
there is no reason to leave the contexts allocated, as the caller
can do nothing useful with them at that point.

This also has the side-effect of freeing any allocated IRQs
within the context.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/context.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 994563a078eb..6cb36ef96e09 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -259,10 +259,11 @@ void ocxl_context_detach_all(struct ocxl_afu *afu)
 {
 	struct ocxl_context *ctx;
 	int tmp;
+	int rc;
 
 	mutex_lock(&afu->contexts_lock);
 	idr_for_each_entry(&afu->contexts_idr, ctx, tmp) {
-		ocxl_context_detach(ctx);
+		rc = ocxl_context_detach(ctx);
 		/*
 		 * We are force detaching - remove any active mmio
 		 * mappings so userspace cannot interfere with the
@@ -274,6 +275,9 @@ void ocxl_context_detach_all(struct ocxl_afu *afu)
 		if (ctx->mapping)
 			unmap_mapping_range(ctx->mapping, 0, 0, 1);
 		mutex_unlock(&ctx->mapping_lock);
+
+		if (rc != -EBUSY)
+			ocxl_context_free(ctx);
 	}
 	mutex_unlock(&afu->contexts_lock);
 }
-- 
2.23.0

