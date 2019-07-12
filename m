Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E666C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 14:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGLMGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 08:06:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfGLMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:06:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3w0x008648;
        Fri, 12 Jul 2019 12:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=YuCOXIRb/dHuU0bztnXWfWAbrWp+ScSgOTP4KoY+oi4=;
 b=DDXy799dLKIIzXw5g+O0VFzQNqNZN4eUI0vkngwwQ8vP2u2FK/wUhdmgkwpKR2lcFeKC
 BYdjKm2s26ZzACiuJaeLvjKQP3on05T7HQrPgf0/2xaxLFNThsuN+nOOnlINBCIQk3ma
 QvFtENroV1rM6EsupkrzStZGhRFmIGOolGVvt4IvITWBZeiR/dggVJbVbfv9UuzFLWS3
 IIkvenxZhyzA1BM67dybsKlxmpA/gf6zeDnw/kycnk8+KyRQaQvMh5zfOIKhX0WE0oB/
 sED72dbfEP7ghsm7BBJXWL3TTTVlQslU8OrqNMHc7X6KSFiNYrR+i511ENDak5Y2vObf Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9r57ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:06:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3R7l095743;
        Fri, 12 Jul 2019 12:04:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tpefd28y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:04:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6CC44JO006192;
        Fri, 12 Jul 2019 12:04:04 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 04:58:32 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v7 1/5] x86/xen: Mark xen_hvm_need_lapic() and xen_x2apic_para_available() as __init
Date:   Thu, 11 Jul 2019 20:02:08 +0800
Message-Id: <1562846532-32152-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. as they are only called at early bootup stage. In fact, other
functions in x86_hyper_xen_hvm.init.* are all marked as __init.

Unexport xen_hvm_need_lapic as it's never used outside.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/include/asm/xen/hypervisor.h | 6 +++---
 arch/x86/xen/enlighten_hvm.c          | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 39171b3..42e1245 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -44,14 +44,14 @@ static inline uint32_t xen_cpuid_base(void)
 }
 
 #ifdef CONFIG_XEN
-extern bool xen_hvm_need_lapic(void);
+extern bool __init xen_hvm_need_lapic(void);
 
-static inline bool xen_x2apic_para_available(void)
+static inline bool __init xen_x2apic_para_available(void)
 {
 	return xen_hvm_need_lapic();
 }
 #else
-static inline bool xen_x2apic_para_available(void)
+static inline bool __init xen_x2apic_para_available(void)
 {
 	return (xen_cpuid_base() != 0);
 }
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 0e75642..ac4943c 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -218,7 +218,7 @@ static __init int xen_parse_nopv(char *arg)
 }
 early_param("xen_nopv", xen_parse_nopv);
 
-bool xen_hvm_need_lapic(void)
+bool __init xen_hvm_need_lapic(void)
 {
 	if (xen_nopv)
 		return false;
@@ -230,7 +230,6 @@ bool xen_hvm_need_lapic(void)
 		return false;
 	return true;
 }
-EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
 static uint32_t __init xen_platform_hvm(void)
 {
-- 
1.8.3.1

