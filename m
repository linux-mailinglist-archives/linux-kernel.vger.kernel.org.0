Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2615FA28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 16:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfGDOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 10:35:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727246AbfGDOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:35:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64EPXrN048754
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jul 2019 10:35:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2thjeba4fh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 10:35:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 4 Jul 2019 15:34:58 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 15:34:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64EYtVg45547656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 14:34:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BD11AE053;
        Thu,  4 Jul 2019 14:34:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5843AE04D;
        Thu,  4 Jul 2019 14:34:53 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.70.183])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 14:34:53 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ftrace: Fix NULL pointer dereference in t_probe_next()
Date:   Thu,  4 Jul 2019 20:04:41 +0530
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070414-0016-0000-0000-0000028F3BAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070414-0017-0000-0000-000032ECDB16
Message-Id: <05e021f757625cbbb006fad41380323dbe4e3b43.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP testsuite on powerpc results in the below crash:

  Unable to handle kernel paging request for data at address 0x00000000
  Faulting instruction address: 0xc00000000029d800
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE SMP NR_CPUS=2048 NUMA PowerNV
  ...
  CPU: 68 PID: 96584 Comm: cat Kdump: loaded Tainted: G        W
  NIP:  c00000000029d800 LR: c00000000029dac4 CTR: c0000000001e6ad0
  REGS: c0002017fae8ba10 TRAP: 0300   Tainted: G        W
  MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28022422  XER: 20040000
  CFAR: c00000000029d90c DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
  ...
  NIP [c00000000029d800] t_probe_next+0x60/0x180
  LR [c00000000029dac4] t_mod_start+0x1a4/0x1f0
  Call Trace:
  [c0002017fae8bc90] [c000000000cdbc40] _cond_resched+0x10/0xb0 (unreliable)
  [c0002017fae8bce0] [c0000000002a15b0] t_start+0xf0/0x1c0
  [c0002017fae8bd30] [c0000000004ec2b4] seq_read+0x184/0x640
  [c0002017fae8bdd0] [c0000000004a57bc] sys_read+0x10c/0x300
  [c0002017fae8be30] [c00000000000b388] system_call+0x5c/0x70

The test (ftrace_set_ftrace_filter.sh) is part of ftrace stress tests
and the crash happens when the test does 'cat
$TRACING_PATH/set_ftrace_filter'.

The address points to the second line below, in t_probe_next(), where
filter_hash is dereferenced:
  hash = iter->probe->ops.func_hash->filter_hash;
  size = 1 << hash->size_bits;

This happens due to a race with register_ftrace_function_probe(). A new
ftrace_func_probe is created and added into the func_probes list in
trace_array under ftrace_lock. However, before initializing the filter,
we drop ftrace_lock, and re-acquire it after acquiring regex_lock. If
another process is trying to read set_ftrace_filter, it will be able to
acquire ftrace_lock during this window and it will end up seeing a NULL
filter_hash.

Fix this by just checking for a NULL filter_hash in t_probe_next(). If
the filter_hash is NULL, then this probe is just being added and we can
simply return from here.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7b037295a1f1..0791eafb693d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3093,6 +3093,10 @@ t_probe_next(struct seq_file *m, loff_t *pos)
 		hnd = &iter->probe_entry->hlist;
 
 	hash = iter->probe->ops.func_hash->filter_hash;
+
+	if (!hash)
+		return NULL;
+
 	size = 1 << hash->size_bits;
 
  retry:
-- 
2.22.0

