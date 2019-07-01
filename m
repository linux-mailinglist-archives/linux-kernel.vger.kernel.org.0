Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9213A2D6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 03:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfFIBzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 21:55:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfFIBzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:55:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sm14023595;
        Sun, 9 Jun 2019 01:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=KCrs5iBEx2VgCEpyKzOOf6pM+sVEH3sJA2xO0ODJ5Qg=;
 b=wuZzM9bJ6H2x49auxWDQd510RRjvlP//K7zOlqRApFzjUz3+NYfZx+/lagf/0ZpJdVzb
 7/0fl+KQBDy4urCPXw44MSeu8q+fwnOHD0DYRGKzXvC0TbBPBCXJrSAeJ9tJCLzBdbD8
 V4pZuZacveqE2IPn5sHSPLmew41jjFa8uYiUW8rA5wNkCWDlpLtWwyOOSaZ4TCoDQuK7
 k+5lqfmSKFVi3UftqIcMh57xDooWTOAfTkWKoPtHOBHkOP6LpGN5Q8VwafVkj4fGr6tv
 VQnAubk+UBCp6zbuTeoOj+xTb6jnO/++d084kJHivSJ+2kYZEZLQ73UGQcwKGyJaAEhQ bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t04eta46x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sktU182576;
        Sun, 9 Jun 2019 01:54:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t04hxawn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x591scUs024569;
        Sun, 9 Jun 2019 01:54:39 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 18:54:37 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: [PATCH v3 0/7] Improve scheduler scalability for fast path
Date:   Sat,  8 Jun 2019 18:49:47 -0700
Message-Id: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=696
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906090012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=744 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906090013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current select_idle_sibling first tries to find a fully idle core using
select_idle_core which can potentially search all cores and if it fails it
finds any idle cpu using select_idle_cpu. select_idle_cpu can potentially
search all cpus in the llc domain. This doesn't scale for large llc domains
and will only get worse with more cores in future.

This patch solves the scalability problem by:
 - Setting an upper and lower limit of idle cpu search in select_idle_cpu
   to keep search time low and constant
 - Adding a new sched feature SIS_CORE to disable select_idle_core

Additionally it also introduces a new per-cpu variable next_cpu to track
the limit of search so that every time search starts from where it ended.
This rotating search window over cpus in LLC domain ensures that idle
cpus are eventually found in case of high load.

Following are the performance numbers with various benchmarks with SIS_CORE
true (idle core search enabled).

Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):
groups  baseline           %stdev  patch           %stdev
1       0.5816             8.94    0.5903 (-1.5%)  11.28 
2       0.6428             10.64   0.5843 (9.1%)   4.93
4       1.0152             1.99    0.9965 (1.84%)  1.83
8       1.8128             1.4     1.7921 (1.14%)  1.76
16      3.1666             0.8     3.1345 (1.01%)  0.81
32      5.6084             0.83    5.5677 (0.73%)  0.8 

Sysbench MySQL on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
threads baseline     %stdev     patch              %stdev
8       2095.45      1.82       2102.6 (0.34%)     2.11
16      4218.45      0.06       4221.35 (0.07%)    0.38
32      7531.36      0.49       7607.18 (1.01%)    0.25
48      10206.42     0.21       10324.26 (1.15%)   0.13
64      12053.73     0.1        12158.3 (0.87%)    0.24
128     14810.33     0.04       14840.4 (0.2%)     0.38

Oracle DB on 2 socket, 44 core and 88 threads Intel x86 machine
(normalized, higher is better):
users   baseline        %stdev  patch            %stdev
20      1               0.9     1.0068 (0.68%)   0.27
40      1               0.8     1.0103 (1.03%)   1.24
60      1               0.34    1.0178 (1.78%)   0.49
80      1               0.53    1.0092 (0.92%)   1.5
100     1               0.79    1.0090 (0.9%)    0.88
120     1               0.06    1.0048 (0.48%)   0.72
140     1               0.22    1.0116 (1.16%)   0.05
160     1               0.57    1.0264 (2.64%)   0.67
180     1               0.81    1.0194 (1.94%)   0.91
200     1               0.44    1.028 (2.8%)     3.09
220     1               1.74    1.0229 (2.29%)   0.21

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline        %stdev  patch            %stdev
8       45.36           0.43    46.28 (2.01%)    0.29
16      87.81           0.82    89.67 (2.12%)    0.38
32      151.19          0.02    153.5 (1.53%)    0.41
48      190.2           0.21    194.79 (2.41%)   0.07
64      190.42          0.35    202.9 (6.55%)    1.66
128     323.86          0.28    343.56 (6.08%)   1.34 

Dbench on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
clients baseline        patch
1       629.8           603.83 (-4.12%)
2       1159.65         1155.75 (-0.34%)
4       2121.61         2093.99 (-1.3%)
8       2620.52         2641.51 (0.8%)
16      2879.31         2897.6 (0.64%)

Tbench on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
clients baseline        patch
1       256.41          255.8 (-0.24%)
2       509.89          504.52 (-1.05%)
4       999.44          1003.74 (0.43%)
8       1982.7          1976.42 (-0.32%)
16      3891.51         3916.04 (0.63%)
32      6819.24         6845.06 (0.38%)
64      8542.95         8568.28 (0.3%)
128     15277.6         15754.6 (3.12%)

Schbench on 2 socket, 44 core and 88 threads Intel x86 machine with 44
tasks (lower is better):
percentile      baseline      %stdev   patch             %stdev
50              94            2.82     92 (2.13%)        2.17
75              124           2.13     122 (1.61%)       1.42
90              152           1.74     151 (0.66%)       0.66 
95              171           2.11     170 (0.58%)       0
99              512.67        104.96   208.33 (59.36%)   1.2
99.5            2296          82.55    3674.66 (-60.05%) 22.19
99.9            12517.33      2.38     12784 (-2.13%)    0.66

Hackbench process on 2 socket, 16 core and 128 threads SPARC machine
(lower is better):
groups  baseline           %stdev  patch             %stdev
1       1.3085             6.65    1.2213 (6.66%)    10.32 
2       1.4559             8.55    1.5048 (-3.36%)   4.72
4       2.6271             1.74    2.5532 (2.81%)    2.02
8       4.7089             3.01    4.5118 (4.19%)    2.74
16      8.7406             2.25    8.6801 (0.69%)    4.78
32      17.7835            1.01    16.759 (5.76%)    1.38
64      36.1901            0.65    34.6652 (4.21%)   1.24
128     72.6585            0.51    70.9762 (2.32%)   0.9

Following are the performance numbers with various benchmarks with SIS_CORE
false (idle core search disabled). This improves throughput of certain
workloads but increases latency of other workloads.

Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):
groups  baseline           %stdev  patch            %stdev
1       0.5816             8.94    0.5835 (-0.33%)  8.21  
2       0.6428             10.64   0.5752 (10.52%)  4.05  
4       1.0152             1.99    0.9946 (2.03%)   2.56  
8       1.8128             1.4     1.7619 (2.81%)   1.88  
16      3.1666             0.8     3.1275 (1.23%)   0.42  
32      5.6084             0.83    5.5856 (0.41%)   0.89   

Sysbench MySQL on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
threads baseline     %stdev     patch              %stdev
8       2095.45      1.82       2084.72 (-0.51%)   1.65
16      4218.45      0.06       4179.69 (-0.92%)   0.18
32      7531.36      0.49       7623.18 (1.22%)    0.39
48      10206.42     0.21       10159.16 (-0.46%)  0.21
64      12053.73     0.1        12087.21 (0.28%)   0.19
128     14810.33     0.04       14894.08 (0.57%)   0.08

Oracle DB on 2 socket, 44 core and 88 threads Intel x86 machine
(normalized, higher is better):
users   baseline        %stdev  patch            %stdev
20      1               0.9     1.0056 (0.56%)   0.34
40      1               0.8     1.0173 (1.73%)   0.13
60      1               0.34    0.9995 (-0.05%)  0.85
80      1               0.53    1.0175 (1.75%)   1.56
100     1               0.79    1.0151 (1.51%)   1.31
120     1               0.06    1.0244 (2.44%)   0.5 
140     1               0.22    1.034 (3.4%)     0.66
160     1               0.57    1.0362 (3.62%)   0.07
180     1               0.81    1.041 (4.1%)     0.8
200     1               0.44    1.0233 (2.33%)   1.4  
220     1               1.74    1.0125 (1.25%)   1.41

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline        %stdev  patch            %stdev
8       45.36           0.43    46.94 (3.48%)    0.2  
16      87.81           0.82    91.75 (4.49%)    0.43 
32      151.19          0.02    167.74 (10.95%)  1.29 
48      190.2           0.21    200.57 (5.45%)   0.89 
64      190.42          0.35    226.74 (19.07%)  1.79 
128     323.86          0.28    348.12 (7.49%)   0.77 

Dbench on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
clients baseline        patch
1       629.8           600.19 (-4.7%)  
2       1159.65         1162.07 (0.21%) 
4       2121.61         2112.27 (-0.44%)
8       2620.52         2645.55 (0.96%) 
16      2879.31         2828.87 (-1.75%)
32      2791.24         2760.97 (-1.08%)
64      1853.07         1747.66 (-5.69%)
128     1484.95         1459.81 (-1.69%)

Tbench on 2 socket, 44 core and 88 threads Intel x86 machine
(higher is better):
clients baseline        patch
1       256.41          258.11 (0.67%)  
2       509.89          509.13 (-0.15%) 
4       999.44          1016.58 (1.72%) 
8       1982.7          2006.53 (1.2%)  
16      3891.51         3964.43 (1.87%) 
32      6819.24         7376.92 (8.18%) 
64      8542.95         9660.45 (13.08%) 
128     15277.6         15438.4 (1.05%) 

Schbench on 2 socket, 44 core and 88 threads Intel x86 machine with 44
tasks (lower is better):
percentile      baseline      %stdev   patch                %stdev
50              94            2.82     94.67 (-0.71%)       2.2  
75              124           2.13     124.67 (-0.54%)      1.67 
90              152           1.74     154.33 (-1.54%)      0.75 
95              171           2.11     176.67 (-3.31%)      0.86 
99              512.67        104.96   4130.33 (-705.65%)   79.41
99.5            2296          82.55    10066.67 (-338.44%)  26.15
99.9            12517.33      2.38     12869.33 (-2.81%)    0.8 

Hackbench process on 2 socket, 16 core and 128 threads SPARC machine
(lower is better):
groups  baseline           %stdev  patch             %stdev
1       1.3085             6.65    1.2514 (4.36%)    11.1
2       1.4559             8.55    1.5433 (-6%)      3.05
4       2.6271             1.74    2.5626 (2.5%)     2.69
8       4.7089             3.01    4.5316 (3.77%)    2.95
16      8.7406             2.25    8.6585 (0.94%)    2.91
32      17.7835            1.01    17.175 (3.42%)    1.38
64      36.1901            0.65    35.5294 (1.83%)   1.02
128     72.6585            0.51    71.8821 (1.07%)   1.05

Following are the schbench performance numbers with SIS_CORE false and
SIS_PROP false. This recovers the latency increase by having SIS_CORE
false.

Schbench on 2 socket, 44 core and 88 threads Intel x86 machine with 44
tasks (lower is better):
percentile      baseline      %stdev   patch               %stdev
50              94            2.82     93.33 (0.71%)       1.24  
75              124           2.13     122.67 (1.08%)      1.7   
90              152           1.74     149.33 (1.75%)      2.35  
95              171           2.11     167 (2.34%)         2.74
99              512.67        104.96   206 (59.82%)        8.86
99.5            2296          82.55    3121.67 (-35.96%)   97.37 
99.9            12517.33      2.38     12592 (-0.6%)       1.67

Changes from v2->v3:
-Use shift operator instead of multiplication to compute limit
-Use per-CPU variable to precompute the number of sibling SMTs for x86

subhra mazumdar (7):
  sched: limit cpu search in select_idle_cpu
  sched: introduce per-cpu var next_cpu to track search limit
  sched: rotate the cpu search window for better spread
  sched: add sched feature to disable idle core search
  sched: SIS_CORE to disable idle core search
  x86/smpboot: introduce per-cpu variable for HT siblings
  sched: use per-cpu variable cpumask_weight_sibling

 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 17 ++++++++++++++++-
 include/linux/topology.h        |  4 ++++
 kernel/sched/core.c             |  2 ++
 kernel/sched/fair.c             | 31 +++++++++++++++++++++++--------
 kernel/sched/features.h         |  1 +
 kernel/sched/sched.h            |  1 +
 8 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.9.3

