Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02E7173380
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgB1JIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 04:08:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgB1JII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:08:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S955TK140929
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:08:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepxjq3us-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:08:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 28 Feb 2020 09:08:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 09:07:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S97wpK51511316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:07:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76C9EAE045;
        Fri, 28 Feb 2020 09:07:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6A55AE04D;
        Fri, 28 Feb 2020 09:07:55 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 09:07:55 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        David.Laight@ACULAB.COM, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v5 0/4] Introduce per-task latency_nice for scheduler hints
Date:   Fri, 28 Feb 2020 14:37:51 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 20022809-0016-0000-0000-000002EB1740
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022809-0017-0000-0000-0000334E4F96
Message-Id: <20200228090755.22829-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 5th revision of the patch set to introduce latency_nice as a
per task attribute.

The previous version can be found at:
v1: https://lkml.org/lkml/2019/11/25/151
v2: https://lkml.org/lkml/2019/12/8/10
v3: https://lkml.org/lkml/2020/1/16/319
v4: https://lkml.org/lkml/2020/2/24/216

Changes in this revision are:
v4->v5:
- Added debugging prints in /proc/<pid>/sched for latency_nice ( based on
  suggestion from Pavan Kondeti )
- Initialized init_task with latency_nice = 0
- Collected review tag and added few minor fixes.
v3->v4:
- Based on Chris's comment, added security check to refrain non-root user
  set lower value than the current latency_nice values.
v2 -> v3:
- This series changes the longer attribute name to "latency_nice" as per
  the comment from Dietmar Eggemann https://lkml.org/lkml/2019/12/5/394
v1 -> v2:
- Addressed comments from Qais Yousef
- As per suggestion from Dietmar, moved content from newly created
  include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
- Extend sched_setattr() to support latency_tolerance in tools headers UAPI


Introduction:
==============
This patch series introduces a new per-task attribute latency_nice to
provide the scheduler hints about the latency requirements of the task [1].

Latency_nice is a ranged attribute of a task with the value ranging
from [-20, 19] both inclusive which makes it align with the task nice
value.

The value should provide scheduler hints about the relative latency
requirements of tasks, meaning the task with "latency_nice = -20"
should have lower latency requirements than compared to those tasks with
higher values. Similarly a task with "latency_nice = 19" can have higher
latency and hence such tasks may not care much about latency.

The default value is set to 0. The usecases discussed below can use this
range of [-20, 19] for latency_nice for the specific purpose. This
patch does not implement any use cases for such attribute so that any
change in naming or range does not affect much to the other (future)
patches using this. The actual use of latency_nice during task wakeup
and load-balancing is yet to be coded for each of those usecases.

As per my view, this defined attribute can be used in following ways for a
some of the usecases:
1 Reduce search scan time for select_idle_cpu():
- Reduce search scans for finding idle CPU for a waking task with lower
  latency_nice values.

2 TurboSched:
- Classify the tasks with higher latency_nice values as a small
  background task given that its historic utilization is very low, for
  which the scheduler can search for more number of cores to do task
  packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
  and util <= 12.5% can be background tasks.

3 Optimize AVX512 based workload:
- Bias scheduler to not put a task having (latency_nice == -20) on a
  core occupying AVX512 based workload.


Series Organization:
====================
- Patch 1-3: Add support for latency_nice attr in the task struct using
  	     sched_{set,get}attr syscall
- Patch 4  : Add permission checks for setting the value.


The patch series can be applied on tip/sched/core at the
commit a0f03b617c3b ("sched/numa: Stop an exhastive search if a reasonable swap candidate or idle CPU is found")


References:
============
[1]. Usecases for the per-task latency-nice attribute,
     https://lkml.org/lkml/2019/9/30/215
[2]. Task Latency-nice, "Subhra Mazumdar",
     https://lkml.org/lkml/2019/8/30/829
[3]. Introduce per-task latency_tolerance for scheduler hints,
     https://lkml.org/lkml/2019/12/8/10



Parth Shah (4):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task
  sched/core: Add permission checks for setting the latency_nice value

 include/linux/sched.h            |  1 +
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 init/init_task.c                 |  1 +
 kernel/sched/core.c              | 26 ++++++++++++++++++++++++++
 kernel/sched/debug.c             |  1 +
 kernel/sched/sched.h             | 18 ++++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 8 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.17.2

