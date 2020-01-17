Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F3140398
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 06:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAQFat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 00:30:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43786 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgAQFas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 00:30:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H5SsBd157673;
        Fri, 17 Jan 2020 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=aWiEefB1h7tIO6YvK1XsMNLlgppTykwjcM4m1HSnw1I=;
 b=DgKVSt/pr20CKdnnBYvE1aCz2BMU7Nmny7cEtKsz4ovsgY72aQtktRNGEdgj+2FU3rry
 +s0kEyLBFG2cSTQ3k7q/7gLGqMQ08HNXgPI6+Vj02Am+dA4VdTKFxnBgXd0HrWpyGgqt
 Q10GTx+H7rll7S7Qw22UoMq1nGblOqVk1tUkGwKgYKRRDPVjTEbLZz71CL/LhKa/74al
 ygtyWkXrtx2HbH26kmL/RvCdO+CEU9Hl4+KGOCosqsuPYtDz0sL1qQC1x7WokG1JHAtt
 7MI6Vwf5GRodxp3Rm8CZd8vOMfPJEZFCYLI0oMGVR2Yt95T+RAAeWf/UojJkKSH8K+FC ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74spkau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 05:30:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H5TPuk075883;
        Fri, 17 Jan 2020 05:30:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xk24ec533-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 05:30:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00H5UGq1003447;
        Fri, 17 Jan 2020 05:30:16 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 21:30:15 -0800
Date:   Fri, 17 Jan 2020 08:30:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing/boot: Fix an IS_ERR() vs NULL bug
Message-ID: <20200117053007.5h2juv272pokqhtq@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace_array_get_by_name() function doesn't return error pointers,
it returns NULL on error.

Fixes: 4f712a4d04a4 ("tracing/boot: Add instance node support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/trace_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index fa9603dc6469..cd541ac1cbc1 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -322,7 +322,7 @@ trace_boot_init_instances(struct xbc_node *node)
 			continue;
 
 		tr = trace_array_get_by_name(p);
-		if (IS_ERR(tr)) {
+		if (!tr) {
 			pr_err("Failed to get trace instance %s\n", p);
 			continue;
 		}
-- 
2.11.0

