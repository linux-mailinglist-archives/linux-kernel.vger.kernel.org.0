Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBCBD6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 06:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633858AbfIYEGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 00:06:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730570AbfIYEGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:06:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8P41sDs085469
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:06:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v7yve1yyr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 00:06:48 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 25 Sep 2019 05:06:46 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Sep 2019 05:06:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8P46foG36962778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 04:06:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A213A405B;
        Wed, 25 Sep 2019 04:06:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC4F0A4059;
        Wed, 25 Sep 2019 04:06:39 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.69])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Sep 2019 04:06:39 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org, christophe.leroy@c-s.fr
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v4 4/5] Powerpc/Watchpoint: Add dar outside test in perf-hwbreak.c selftest
Date:   Wed, 25 Sep 2019 09:36:29 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092504-0020-0000-0000-000003713D55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092504-0021-0000-0000-000021C700EC
Message-Id: <20190925040630.6948-5-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we used to ignore exception if dar points outside of user
specified range. But now we are ignoring it only if actual load/
store range does not overlap with user specified range. Include
selftests for the same:

  # ./tools/testing/selftests/powerpc/ptrace/perf-hwbreak
  ...
  TESTED: No overlap
  TESTED: Partial overlap
  TESTED: Partial overlap
  TESTED: No overlap
  TESTED: Full overlap
  success: perf_hwbreak

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 111 +++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
index 200337daec42..389c545675c6 100644
--- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
@@ -148,6 +148,113 @@ static int runtestsingle(int readwriteflag, int exclude_user, int arraytest)
 	return 0;
 }
 
+static int runtest_dar_outside(void)
+{
+	volatile char target[8];
+	volatile __u16 temp16;
+	volatile __u64 temp64;
+	struct perf_event_attr attr;
+	int break_fd;
+	unsigned long long breaks;
+	int fail = 0;
+	size_t res;
+
+	/* setup counters */
+	memset(&attr, 0, sizeof(attr));
+	attr.disabled = 1;
+	attr.type = PERF_TYPE_BREAKPOINT;
+	attr.exclude_kernel = 1;
+	attr.exclude_hv = 1;
+	attr.exclude_guest = 1;
+	attr.bp_type = HW_BREAKPOINT_RW;
+	/* watch middle half of target array */
+	attr.bp_addr = (__u64)(target + 2);
+	attr.bp_len = 4;
+	break_fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (break_fd < 0) {
+		perror("sys_perf_event_open");
+		exit(1);
+	}
+
+	/* Shouldn't hit. */
+	ioctl(break_fd, PERF_EVENT_IOC_RESET);
+	ioctl(break_fd, PERF_EVENT_IOC_ENABLE);
+	temp16 = *((__u16 *)target);
+	*((__u16 *)target) = temp16;
+	ioctl(break_fd, PERF_EVENT_IOC_DISABLE);
+	res = read(break_fd, &breaks, sizeof(unsigned long long));
+	assert(res == sizeof(unsigned long long));
+	if (breaks == 0) {
+		printf("TESTED: No overlap\n");
+	} else {
+		printf("FAILED: No overlap: %lld != 0\n", breaks);
+		fail = 1;
+	}
+
+	/* Hit */
+	ioctl(break_fd, PERF_EVENT_IOC_RESET);
+	ioctl(break_fd, PERF_EVENT_IOC_ENABLE);
+	temp16 = *((__u16 *)(target + 1));
+	*((__u16 *)(target + 1)) = temp16;
+	ioctl(break_fd, PERF_EVENT_IOC_DISABLE);
+	res = read(break_fd, &breaks, sizeof(unsigned long long));
+	assert(res == sizeof(unsigned long long));
+	if (breaks == 2) {
+		printf("TESTED: Partial overlap\n");
+	} else {
+		printf("FAILED: Partial overlap: %lld != 2\n", breaks);
+		fail = 1;
+	}
+
+	/* Hit */
+	ioctl(break_fd, PERF_EVENT_IOC_RESET);
+	ioctl(break_fd, PERF_EVENT_IOC_ENABLE);
+	temp16 = *((__u16 *)(target + 5));
+	*((__u16 *)(target + 5)) = temp16;
+	ioctl(break_fd, PERF_EVENT_IOC_DISABLE);
+	res = read(break_fd, &breaks, sizeof(unsigned long long));
+	assert(res == sizeof(unsigned long long));
+	if (breaks == 2) {
+		printf("TESTED: Partial overlap\n");
+	} else {
+		printf("FAILED: Partial overlap: %lld != 2\n", breaks);
+		fail = 1;
+	}
+
+	/* Shouldn't Hit */
+	ioctl(break_fd, PERF_EVENT_IOC_RESET);
+	ioctl(break_fd, PERF_EVENT_IOC_ENABLE);
+	temp16 = *((__u16 *)(target + 6));
+	*((__u16 *)(target + 6)) = temp16;
+	ioctl(break_fd, PERF_EVENT_IOC_DISABLE);
+	res = read(break_fd, &breaks, sizeof(unsigned long long));
+	assert(res == sizeof(unsigned long long));
+	if (breaks == 0) {
+		printf("TESTED: No overlap\n");
+	} else {
+		printf("FAILED: No overlap: %lld != 0\n", breaks);
+		fail = 1;
+	}
+
+	/* Hit */
+	ioctl(break_fd, PERF_EVENT_IOC_RESET);
+	ioctl(break_fd, PERF_EVENT_IOC_ENABLE);
+	temp64 = *((__u64 *)target);
+	*((__u64 *)target) = temp64;
+	ioctl(break_fd, PERF_EVENT_IOC_DISABLE);
+	res = read(break_fd, &breaks, sizeof(unsigned long long));
+	assert(res == sizeof(unsigned long long));
+	if (breaks == 2) {
+		printf("TESTED: Full overlap\n");
+	} else {
+		printf("FAILED: Full overlap: %lld != 2\n", breaks);
+		fail = 1;
+	}
+
+	close(break_fd);
+	return fail;
+}
+
 static int runtest(void)
 {
 	int rwflag;
@@ -172,7 +279,9 @@ static int runtest(void)
 				return ret;
 		}
 	}
-	return 0;
+
+	ret = runtest_dar_outside();
+	return ret;
 }
 
 
-- 
2.21.0

