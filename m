Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF1AD815
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404279AbfIILlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 07:41:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404242AbfIILln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:41:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89BRH0j077225
        for <linux-kernel@vger.kernel.org>; Mon, 9 Sep 2019 07:41:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwmbfvxnb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:41:41 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 9 Sep 2019 12:41:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 12:41:37 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x89BfZqj27131912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 11:41:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6899EA4051;
        Mon,  9 Sep 2019 11:41:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23BECA4053;
        Mon,  9 Sep 2019 11:41:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 11:41:35 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.ibm.com, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/3] perf/java: Add detection of java-11-openjdk-devel package
Date:   Mon,  9 Sep 2019 13:41:16 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909114116.50469-1-tmricht@linux.ibm.com>
References: <20190909114116.50469-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19090911-0020-0000-0000-00000369BF83
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090911-0021-0000-0000-000021BF400F
Message-Id: <20190909114116.50469-4-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Java 11 there is no seperate JRE anymore.
Details: https://coderanch.com/t/701603/java/JRE-JDK
Therefore the detection of the JRE needs to be adapted.

This change works for s390 and x86.
I have not tested other platforms.

Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 89ac5a1f1550..3da374911852 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -908,7 +908,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
     endif
   endif
   ifndef JDIR
-- 
2.21.0

