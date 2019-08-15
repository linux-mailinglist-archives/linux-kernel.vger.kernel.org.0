Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B508E648
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfHOI1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:27:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHOI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:27:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8O6UG178572;
        Thu, 15 Aug 2019 08:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=/VeJ/ULSrkY3giefUij2/RQL4HQqUqSwXDm2k76sEqU=;
 b=g1SIgiyCg+fgk2lE16t2nfXSnyeo+jG/4x9Y1JA3O/Jv/iMIjI7nh1amCdIN/iejEb+e
 BFMWAy0nI+Km+vRgEhNAG0dNEXT5ox6nCegdRcm6lKJiefolDZ86QHFRTClhda7VnG7H
 TK+n2nV1M+ne4NkDPgqRwHzNLqV7UbPpxYtN+82KyaAA9DR1aZ5lud5V9YQXG7Bd/OME
 08Md+1Be46EV/LOc3ooFf8MCxGKY08MbGHG5KVkXBxs/p3QEbXef4yy0fvVcbraKreYV
 b7DuxVl45YX4XO5sfcQm1DqzOhsLsUSYn6a7/3XuGFsUQbNX9bB6ifMk1bUWBsAWtjED Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u9nbtsm6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:27:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8NYRj073364;
        Thu, 15 Aug 2019 08:27:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ucs87rtpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:27:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7F8RPcD018544;
        Thu, 15 Aug 2019 08:27:25 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 01:27:25 -0700
Date:   Thu, 15 Aug 2019 11:27:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steve Winslow <swinslow@gmail.com>, Len Brown <len.brown@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Winslow <swinslow@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] tools/power x86_energy_perf_policy: remove unneeded check
Message-ID: <20190815082717.GB27238@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "i" variable is an int.  The condition doesn't really make sense.
Since we ensure that "i" is in the 0 to 0xff range on the following
lines it's not required and this patch deletes it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 34a796b303fe..ce9a3fcf4a6c 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -331,8 +331,6 @@ int parse_optarg_string(char *s)
 		fprintf(stderr, "no digits in \"%s\"\n", s);
 		usage();
 	}
-	if (i == LONG_MIN || i == LONG_MAX)
-		errx(-1, "%s", s);
 
 	if (i > 0xFF)
 		errx(-1, "%d (0x%x) must be < 256", i, i);
-- 
2.20.1

