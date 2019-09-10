Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0686EAEDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405456AbfIJPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 11:00:15 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:30898 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393484AbfIJPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:00:14 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEpgx8024495;
        Tue, 10 Sep 2019 15:00:00 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ux8e44m6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:00:00 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 339F68F;
        Tue, 10 Sep 2019 14:59:59 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 9B64E201FCF1D; Tue, 10 Sep 2019 09:59:58 -0500 (CDT)
Message-Id: <20190910145840.135325066@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:58:45 -0500
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
Subject: [PATCH V2 6/8] x86/platform/uv: Decode UVsystab Info
Content-Disposition: inline; filename=decode-hubless-uvst
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode the hubless UVsystab passed from BIOS to the kernel saving
pertinent info in a similar manner that hubbed UVsystabs are decoded.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
V2: Removed redundant error message after call to uv_bios_init.
    Removed redundant error message after call to decode_uv_systab.
    Clarify selection of UV4 and higher when checking for extended UVsystab
    in decode_uv_systab().
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1303,7 +1303,8 @@ static int __init decode_uv_systab(void)
 	struct uv_systab *st;
 	int i;
 
-	if (uv_hub_info->hub_revision < UV4_HUB_REVISION_BASE)
+	/* If system is uv3 or lower, there is no extended UVsystab */
+	if (is_uv_hubbed(0xfffffe) < uv(4) && is_uv_hubless(0xfffffe) < uv(4))
 		return 0;	/* No extended UVsystab required */
 
 	st = uv_systab;
@@ -1554,8 +1555,15 @@ static __init int uv_system_init_hubless
 
 	/* Init kernel/BIOS interface */
 	rc = uv_bios_init();
+	if (rc < 0)
+		return rc;
 
-	/* Create user access node if UVsystab available */
+	/* Process UVsystab */
+	rc = decode_uv_systab();
+	if (rc < 0)
+		return rc;
+
+	/* Create user access node */
 	if (rc >= 0)
 		uv_setup_proc_files(1);
 

-- 

