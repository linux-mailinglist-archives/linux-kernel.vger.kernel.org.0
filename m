Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961F717D939
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgCIG0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 02:26:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgCIG0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:26:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0296KFHP130245
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 02:26:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8g2rw9r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:26:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Mon, 9 Mar 2020 06:26:27 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Mar 2020 06:26:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0296PKl646858612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Mar 2020 06:25:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B5DA4054;
        Mon,  9 Mar 2020 06:26:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 244A7A4062;
        Mon,  9 Mar 2020 06:26:14 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.44.242])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Mar 2020 06:26:13 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v4 1/8] powerpc/perf/hv-24x7: Fix inconsistent output values incase multiple hv-24x7 events run
Date:   Mon,  9 Mar 2020 11:55:45 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200309062552.29911-1-kjain@linux.ibm.com>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030906-0016-0000-0000-000002EE744F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030906-0017-0000-0000-00003351D213
Message-Id: <20200309062552.29911-2-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_01:2020-03-06,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=781 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2b206ee6b0df ("powerpc/perf/hv-24x7: Display change in counter
values")' added to print _change_ in the counter value rather then raw
value for 24x7 counters. Incase of transactions, the event count
is set to 0 at the beginning of the transaction. It also sets
the event's prev_count to the raw value at the time of initialization.
Because of setting event count to 0, we are seeing some weird behaviour,
whenever we run multiple 24x7 events at a time.

For example:

command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
			   hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
	  		   -C 0 -I 1000 sleep 100

     1.000121704                120 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     1.000121704                  5 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     2.000357733                  8 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     2.000357733                 10 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.000641884                 56 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     4.000641884 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     5.000791887 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/

Getting these large values in case we do -I.

As we are setting event_count to 0, for interval case, overall event_count is not
coming in incremental order. As we may can get new delta lesser then previous count.
Because of which when we print intervals, we are getting negative value which create
these large values.

This patch removes part where we set event_count to 0 in function
'h_24x7_event_read'. There won't be much impact as we do set event->hw.prev_count
to the raw value at the time of initialization to print change value.

With this patch
In power9 platform

command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
		           hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
			   -C 0 -I 1000 sleep 100

     1.000117685                 93 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     1.000117685                  1 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     2.000349331                 98 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     2.000349331                  2 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     3.000495900                131 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     3.000495900                  4 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.000645920                204 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     4.000645920                 61 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.284169997                 22 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Suggested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 573e0b309c0c..48e8f4b17b91 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1400,16 +1400,6 @@ static void h_24x7_event_read(struct perf_event *event)
 			h24x7hw = &get_cpu_var(hv_24x7_hw);
 			h24x7hw->events[i] = event;
 			put_cpu_var(h24x7hw);
-			/*
-			 * Clear the event count so we can compute the _change_
-			 * in the 24x7 raw counter value at the end of the txn.
-			 *
-			 * Note that we could alternatively read the 24x7 value
-			 * now and save its value in event->hw.prev_count. But
-			 * that would require issuing a hcall, which would then
-			 * defeat the purpose of using the txn interface.
-			 */
-			local64_set(&event->count, 0);
 		}
 
 		put_cpu_var(hv_24x7_reqb);
-- 
2.18.1

