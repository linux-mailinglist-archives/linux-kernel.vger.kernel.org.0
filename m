Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6FAED02
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbfIJOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 10:32:08 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59326 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfIJOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:32:05 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEQx25023212;
        Tue, 10 Sep 2019 14:31:49 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2uxc4t1f3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:31:48 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 35F169A;
        Tue, 10 Sep 2019 14:31:47 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 2F495201FCF1E; Tue, 10 Sep 2019 09:31:46 -0500 (CDT)
Message-Id: <20190910143101.662882180@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910143100.962781883@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:31:08 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/8] x86/platform/uv: Account for UV Hubless in is_uvX_hub Ops
Content-Disposition: inline; filename=mod-is_uvX_hub
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=577 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909100141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The references in the is_uvX_hub() function uses the hub_info pointer
which will be NULL when the system is hubless.  This change avoids
that NULL dereference.  It is also an optimization in performance.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
V2: Add WARNING that the is UVx supported defines will be removed.
---
 arch/x86/include/asm/uv/.uv_hub.h.swp |binary
 arch/x86/include/asm/uv/uv_hub.h |   61 ++++++++++++---------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

Binary files linux.orig/arch/x86/include/asm/uv/.uv_hub.h.swp and linux/arch/x86/include/asm/uv/.uv_hub.h.swp differ
--- linux.orig/arch/x86/include/asm/uv/uv_hub.h
+++ linux/arch/x86/include/asm/uv/uv_hub.h
@@ -19,6 +19,7 @@
 #include <linux/topology.h>
 #include <asm/types.h>
 #include <asm/percpu.h>
+#include <asm/uv/uv.h>
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/bios.h>
 #include <asm/irq_vectors.h>
@@ -243,83 +244,61 @@ static inline int uv_hub_info_check(int
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-#ifdef	UV1_HUB_IS_SUPPORTED
+/* WARNING: UVx_HUB_IS_SUPPORTED defines are deprecated and will be removed */
 static inline int is_uv1_hub(void)
 {
-	return uv_hub_info->hub_revision < UV2_HUB_REVISION_BASE;
-}
+#ifdef	UV1_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(1));
 #else
-static inline int is_uv1_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
-#ifdef	UV2_HUB_IS_SUPPORTED
 static inline int is_uv2_hub(void)
 {
-	return ((uv_hub_info->hub_revision >= UV2_HUB_REVISION_BASE) &&
-		(uv_hub_info->hub_revision < UV3_HUB_REVISION_BASE));
-}
+#ifdef	UV2_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(2));
 #else
-static inline int is_uv2_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
-#ifdef	UV3_HUB_IS_SUPPORTED
 static inline int is_uv3_hub(void)
 {
-	return ((uv_hub_info->hub_revision >= UV3_HUB_REVISION_BASE) &&
-		(uv_hub_info->hub_revision < UV4_HUB_REVISION_BASE));
-}
+#ifdef	UV3_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(3));
 #else
-static inline int is_uv3_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
 /* First test "is UV4A", then "is UV4" */
-#ifdef	UV4A_HUB_IS_SUPPORTED
-static inline int is_uv4a_hub(void)
-{
-	return (uv_hub_info->hub_revision >= UV4A_HUB_REVISION_BASE);
-}
-#else
 static inline int is_uv4a_hub(void)
 {
+#ifdef	UV4A_HUB_IS_SUPPORTED
+	if (is_uv_hubbed(uv(4)))
+		return (uv_hub_info->hub_revision == UV4A_HUB_REVISION_BASE);
+#endif
 	return 0;
 }
-#endif
 
-#ifdef	UV4_HUB_IS_SUPPORTED
 static inline int is_uv4_hub(void)
 {
-	return uv_hub_info->hub_revision >= UV4_HUB_REVISION_BASE;
-}
+#ifdef	UV4_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(4));
 #else
-static inline int is_uv4_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
 static inline int is_uvx_hub(void)
 {
-	if (uv_hub_info->hub_revision >= UV2_HUB_REVISION_BASE)
-		return uv_hub_info->hub_revision;
-
-	return 0;
+	return (is_uv_hubbed(-2) >= uv(2));
 }
 
 static inline int is_uv_hub(void)
 {
-#ifdef	UV1_HUB_IS_SUPPORTED
-	return uv_hub_info->hub_revision;
-#endif
-	return is_uvx_hub();
+	return is_uv1_hub() || is_uvx_hub();
 }
 
 union uvh_apicid {

-- 

