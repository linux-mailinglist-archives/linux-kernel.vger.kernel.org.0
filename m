Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73393168D07
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 08:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBVHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 02:00:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgBVHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:00:16 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01M6vLm0106276
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 02:00:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucq29u8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 02:00:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Sat, 22 Feb 2020 07:00:09 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Feb 2020 07:00:08 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01M706UF8650902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 07:00:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B4A6AE05F;
        Sat, 22 Feb 2020 07:00:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A14E0AE057;
        Sat, 22 Feb 2020 07:00:03 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.88.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 22 Feb 2020 07:00:03 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org, dsmythies@telus.net,
        daniel.lezcano@linaro.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, psampat@linux.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: [RFC 0/1] Weighted approach to gather and use history in TEO governor
Date:   Sat, 22 Feb 2020 12:30:01 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022207-4275-0000-0000-000003A46439
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022207-4276-0000-0000-000038B87481
Message-Id: <20200222070002.12897-1-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_01:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the TEO governor apart from the TEO timer and hit/miss/early
hit buckets; also gathers history of 8 intervals and if there are
significant idle durations less than the current, then it decides if a
shallower state must be chosen.

The current sliding history window does do a fair job at prediction,
however, the hard-coded window can be a limiting factor for an accurate
prediction and having the window size increase can also linearly affect
both space and time complexity of the prediction.

To complement the current moving window history, an approach is devised
where each idle state separately maintains a weight for itself and its
counterpart idle states to form a probability distribution.

When a decision needs to be made, the TEO governor selects an idle state
based on its timer and other hits/early hits metric. After which, the
probability distribution of that selected idle state is looked at which
gives insight into how probable that state is to occur if picked.

The probability distribution is nothing but a n*n matrix, where
n = drv->state_count.
Each entry in the array signifies a weight for that row.
The weights can vary from the range [0-10000].

For example:
state_mat[1][2] = 3000 means that previously when state 1 was selected,
the probability that state 2 will occur is 30%.
The trailing zeros correspond to having more resolution while increasing
or reducing the weights for correction.

Currently, for selection of an idle state based on probabilities, a
weighted random number generator is used to choose one of the idle
states. Naturally, the states with higher weights are more likely to be
chosen.

On wakeup, the weights are updated. The state with which it should have
woken up with (could be the hit / miss / early hit state) is increased
in weight by the "LEARNING_RATE" % and the rest of the states for that
index are reduced by the same factor.

The advantage of this approach is that unlimited history of idle states
can be maintained in constant overhead, which can help in more accurate
prediction for choosing idle states.

The advantage of unlimited history can become a possible disadvantage as
the lifetime history for that thread may make the weights stale and
influence the choosing of idle states which may not be relevant anymore.
Aging the weights could be a solution for that, although this RFC does
not cover the implementation for that.

Having a finer view of the history in addition to weighted randomized
salt seems to show some promise in terms of saving power without
compromising performance.

Benchmarks:
Note: Wt. TEO governor represents the governor after the proposed change

Schbench
========
Benchmarks wakeup latencies
Scale of measurement:
1. 99th percentile latency - usec
2. Power - Watts

Command: $ schbench -c 30000 -s 30000 -m 6 -r 30 -t <Threads>
Varying parameter: -t

Machine: IBM POWER 9

+--------+-------------+-----------------+-----------+-----------------+
| Threads| TEO latency | Wt. TEO latency | TEO power | Wt. TEO power   |
+--------+-------------+-----------------+-----------+-----------------+
| 2      | 979         | 949  ( +3.06%)  | 38        | 36  ( +5.26%)   |
| 4      | 997         | 1042 ( -4.51%)  | 51        | 39  ( +23.52%)  |
| 8      | 1158        | 1050 ( +9.32%)  | 89        | 63  ( +29.21%)  |
| 16     | 1138        | 1135 ( +0.26%)  | 105       | 117 ( -11.42%)  |
+--------+-------------+-----------------+-----------+-----------------+

Sleeping Ebizzy
===============
Program to generate workloads resembling web server workloads.
The benchmark is customized to allow for a sleep interval -i
Scale of measurement:
1. Number of records/s
2. systime (s)

Parameters:
1. -m => Always use mmap instead of malloc
2. -M => Never use mmap
3. -S <seconds> => Number of seconds to run
4. -i <interval> => Sleep interval

Machine: IBM POWER 9

+-------------------+-------------+-------------------+-----------+---------------+
| Parameters        | TEO records | Wt. TEO records   | TEO power | Wt. TEO power |
+-------------------+-------------+-------------------+-----------+---------------+
| -S 60 -i 10000    | 1115000     | 1198081 ( +7.45%) | 149       | 150 ( -0.66%) |
| -m -S 60 -i 10000 | 15879       | 15513   ( -2.30%) | 23        | 22  ( +4.34%) |
| -M -S 60 -i 10000 | 72887       | 77546   ( +6.39%) | 104       | 103 ( +0.96%) |
+-------------------+-------------+-------------------+-----------+---------------+

Hackbench
=========
Creates a specified number of pairs of schedulable entities
which communicate via either sockets or pipes and time how long  it
takes for each pair to send data back and forth.
Scale of measurement:
1. Time (s)
2. Power (watts)

Command: Sockets: $ hackbench -l <Messages>
         Pipes  : $ hackbench --pipe -l <Messages>
Varying parameter: -l

Machine: IBM POWER 9

+----------+------------+-------------------+----------+-------------------+
| Messages | TEO socket | Wt. TEO socket    | TEO pipe | Wt. TEO pipe      |
+----------+------------+-------------------+----------+-------------------+
| 100      | 0.042      | 0.043   ( -2.32%) | 0.031    | 0.032   ( +3.12%) |
| 1000     | 0.258      | 0.272   ( +5.14%) | 0.301    | 0.312   ( -3.65%) |
| 10000    | 2.397      | 2.441   ( +1.80%) | 5.642    | 5.092   ( +9.74%) |
| 100000   | 23.691     | 23.730  ( -0.16%) | 57.762   | 57.857  ( -0.16%) |
| 1000000  | 234.103    | 233.841 ( +0.11%) | 559.807  | 592.304 ( -5.80%) |
+----------+------------+-------------------+----------+-------------------+

Power :Socket: Consistent between 135-140 watts for both TEO and Wt. TEO
       Pipe: Consistent between 125-130 watts for both TEO and Wt. TEO



Pratik Rajesh Sampat (1):
  Weighted approach to gather and use history in TEO governor

 drivers/cpuidle/governors/teo.c | 95 +++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

-- 
2.17.1

