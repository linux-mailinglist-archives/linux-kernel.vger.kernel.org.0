Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A65FC73E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 08:22:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfKNNWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:22:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAED9IEK101068
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:22:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w97hurekv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:22:39 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 14 Nov 2019 13:22:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Nov 2019 13:22:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEDMYWo38207690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 13:22:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD22A4053;
        Thu, 14 Nov 2019 13:22:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22947A4051;
        Thu, 14 Nov 2019 13:22:31 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.57.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 13:22:30 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, kan.liang@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2 2/3] perf report: Make -F more strict like -s
Date:   Thu, 14 Nov 2019 18:52:12 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
References: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111413-0020-0000-0000-00000386262B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111413-0021-0000-0000-000021DC3D11
Message-Id: <20191114132213.5419-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=651 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently -F allows branch-mode / mem-mode fields with -F even
when perf report is not running in that mode. Don't allow that.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/sort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index cba8f22e4ffb..9999f6853440 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2974,6 +2974,9 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
+		if (sort__mode != SORT_MODE__BRANCH)
+			return -EINVAL;
+
 		return __sort_dimension__add_output(list, sd);
 	}
 
@@ -2983,6 +2986,9 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
+		if (sort__mode != SORT_MODE__MEMORY)
+			return -EINVAL;
+
 		return __sort_dimension__add_output(list, sd);
 	}
 
-- 
2.21.0

