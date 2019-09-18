Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229F8B5AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfIRFWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 01:22:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727606AbfIRFV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:21:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8I5LsQj101926
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:21:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3b35wud5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:21:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 18 Sep 2019 06:21:55 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 06:21:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8I5LOQJ39256538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 05:21:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E90DAE053;
        Wed, 18 Sep 2019 05:21:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE3BAE04D;
        Wed, 18 Sep 2019 05:21:49 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 05:21:49 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 80C7BA01E6;
        Wed, 18 Sep 2019 15:21:48 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] powerpc: Don't flush caches when adding memory
Date:   Wed, 18 Sep 2019 15:20:59 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918052106.14113-1-alastair@au1.ibm.com>
References: <20190918052106.14113-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091805-4275-0000-0000-00000367E292
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091805-4276-0000-0000-0000387A49F4
Message-Id: <20190918052106.14113-6-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=626 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

This operation takes a significant amount of time when hotplugging
large amounts of memory (~50 seconds with 890GB of persistent memory).

This was orignally in commit fb5924fddf9e
("powerpc/mm: Flush cache on memory hot(un)plug") to support memtrace,
but the flush on add is not needed as it is flushed on remove.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/mm/mem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 4f892da59a6a..dd1aa80e854a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -142,8 +142,6 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 		return -EFAULT;
 	}
 
-	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
-
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 
-- 
2.21.0

