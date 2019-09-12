Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1476DB0657
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 02:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfILA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 20:58:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:21544 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfILA6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 20:58:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 17:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,495,1559545200"; 
   d="yaml'?scan'208";a="192274291"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2019 17:58:34 -0700
Date:   Thu, 12 Sep 2019 08:58:27 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, lkp@01.org
Subject: [xfs] 1aabb011bf: aim7.jobs-per-min -17.8% regression
Message-ID: <20190912005827.GW15734@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5KENZRfAmuo1v8rU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -17.8% regression of aim7.jobs-per-min due to commit:


commit: 1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1 ("xfs: deferred inode inactivation")
https://kernel.googlesource.com/pub/scm/linux/kernel/git/djwong/xfs-linux.git rough-fixes

in testcase: aim7
on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID0
	fs: xfs
	test: disk_rw
	load: 3000
	cpufreq_governor: performance

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -35.7% regression                             |
| test machine     | 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory |
| test parameters  | cpufreq_governor=performance                                          |
|                  | disk=4BRD_12G                                                         |
|                  | fs=xfs                                                                |
|                  | load=3000                                                             |
|                  | md=RAID0                                                              |
|                  | test=disk_cp                                                          |
+------------------+-----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
  gcc-7/performance/4BRD_12G/xfs/x86_64-rhel-7.6/3000/RAID0/debian-x86_64-2019-05-14.cgz/lkp-ivb-ep01/disk_rw/aim7

commit: 
  d515962b00 ("xfs: pass around xfs_inode_ag_walk iget/irele helper functions")
  1aabb011bf ("xfs: deferred inode inactivation")

d515962b00d64454 1aabb011bfba5a8942d3e0d0c84 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    139763           -17.8%     114843        aim7.jobs-per-min
    129.25           +21.6%     157.23        aim7.time.elapsed_time
    129.25           +21.6%     157.23        aim7.time.elapsed_time.max
     31367 ±  3%     -39.2%      19066 ± 11%  aim7.time.involuntary_context_switches
      2862            -7.1%       2659        aim7.time.system_time
    798.18            -5.9%     751.02        aim7.time.user_time
   1049629           -21.6%     822793        aim7.time.voluntary_context_switches
 1.016e+09 ± 12%    +111.5%  2.149e+09 ± 11%  cpuidle.C6.time
   1873251 ±  7%     +86.0%    3483843 ± 18%  cpuidle.C6.usage
      2956 ± 10%     +25.2%       3701 ± 17%  cpuidle.POLL.usage
     29.00           +15.7       44.70 ±  2%  mpstat.cpu.all.idle%
     55.41           -12.2       43.21 ±  2%  mpstat.cpu.all.sys%
     15.55            -3.5       12.07        mpstat.cpu.all.usr%
     30.00           +51.2%      45.35 ±  2%  iostat.cpu.idle
     54.65           -21.8%      42.72 ±  2%  iostat.cpu.system
     15.34           -22.2%      11.93        iostat.cpu.user
     42.06 ± 11%    +139.1%     100.59 ±  7%  iostat.md0.w/s
    115553           +14.5%     132340 ±  3%  meminfo.AnonHugePages
     95312           +20.4%     114787        meminfo.KReclaimable
     95312           +20.4%     114787        meminfo.SReclaimable
    261148           +13.4%     296269        meminfo.Slab
     31512           -16.2%      26409 ±  2%  meminfo.max_used_kB
      2740 ± 44%    +108.3%       5707 ± 11%  numa-vmstat.node0.nr_shmem
     10048 ± 35%     +81.5%      18236 ± 11%  numa-vmstat.node0.nr_slab_reclaimable
     16555 ± 52%     +74.7%      28924 ± 28%  numa-vmstat.node0.nr_slab_unreclaimable
      3417 ± 16%     -20.1%       2730 ± 20%  numa-vmstat.node1.nr_mapped
      4555 ± 27%     -66.3%       1533 ± 53%  numa-vmstat.node1.nr_shmem
     29.50           +52.5%      45.00 ±  2%  vmstat.cpu.id
     54.25           -22.6%      42.00 ±  2%  vmstat.cpu.sy
     15.00           -26.7%      11.00        vmstat.cpu.us
     27.50           -22.7%      21.25 ±  2%  vmstat.procs.r
     17205            -9.9%      15509        vmstat.system.cs
     40194 ± 35%     +81.5%      72950 ± 11%  numa-meminfo.node0.KReclaimable
     40194 ± 35%     +81.5%      72950 ± 11%  numa-meminfo.node0.SReclaimable
     66241 ± 52%     +74.7%     115712 ± 28%  numa-meminfo.node0.SUnreclaim
     10965 ± 44%    +108.3%      22838 ± 11%  numa-meminfo.node0.Shmem
    106435 ± 44%     +77.3%     188663 ± 18%  numa-meminfo.node0.Slab
     13273 ± 15%     -18.7%      10793 ± 18%  numa-meminfo.node1.Mapped
     18226 ± 27%     -66.3%       6135 ± 53%  numa-meminfo.node1.Shmem
    346095            -2.0%     339002        proc-vmstat.nr_dirty
    346482            -2.0%     339409        proc-vmstat.nr_inactive_file
     23834           +20.4%      28691        proc-vmstat.nr_slab_reclaimable
     41519            +9.2%      45351        proc-vmstat.nr_slab_unreclaimable
    346482            -2.0%     339409        proc-vmstat.nr_zone_inactive_file
    346479            -2.0%     339510        proc-vmstat.nr_zone_write_pending
    509175           +14.6%     583653        proc-vmstat.pgfault
    871.00           -19.2%     703.50 ±  3%  turbostat.Avg_MHz
     71.90           -15.1       56.80        turbostat.Busy%
   1869906 ±  7%     +86.1%    3479825 ± 19%  turbostat.C6
     19.42 ± 12%     +14.4       33.80 ± 11%  turbostat.C6%
     22.63 ±  2%     +44.9%      32.79 ±  7%  turbostat.CPU%c1
      4.42 ± 34%    +114.8%       9.50 ± 30%  turbostat.CPU%c6
     47.42            -4.3%      45.40 ±  2%  turbostat.CorWatt
  10614698           +20.8%   12819724        turbostat.IRQ
     65.00 ±  3%      +3.8%      67.50        turbostat.PkgTmp
     73.99            -2.8%      71.95        turbostat.PkgWatt
     34.29            -4.1%      32.90        turbostat.RAMWatt
     10450           +21.5%      12696        turbostat.SMI
      2930 ±  5%    +309.5%      12001        slabinfo.dmaengine-unmap-16.active_objs
     73.00 ±  7%    +626.0%     530.00 ±  4%  slabinfo.dmaengine-unmap-16.active_slabs
      3088 ±  7%    +621.4%      22279 ±  4%  slabinfo.dmaengine-unmap-16.num_objs
     73.00 ±  7%    +626.0%     530.00 ±  4%  slabinfo.dmaengine-unmap-16.num_slabs
      2663 ±  3%     +28.7%       3427 ±  6%  slabinfo.kmalloc-128.active_objs
      2663 ±  3%     +28.7%       3427 ±  6%  slabinfo.kmalloc-128.num_objs
     19529          +129.5%      44820 ±  4%  slabinfo.kmalloc-16.active_objs
     75.75          +141.9%     183.25 ±  4%  slabinfo.kmalloc-16.active_slabs
     19529          +140.8%      47025 ±  4%  slabinfo.kmalloc-16.num_objs
     75.75          +141.9%     183.25 ±  4%  slabinfo.kmalloc-16.num_slabs
      2850 ±  3%     +19.0%       3391 ±  3%  slabinfo.kmalloc-2k.active_objs
      2905 ±  3%     +17.8%       3423 ±  3%  slabinfo.kmalloc-2k.num_objs
    769.75           +33.0%       1023 ±  3%  slabinfo.kmalloc-4k.active_objs
    782.75           +34.1%       1049 ±  3%  slabinfo.kmalloc-4k.num_objs
      6379          +151.9%      16067        slabinfo.kmalloc-512.active_objs
    209.25          +187.8%     602.25        slabinfo.kmalloc-512.active_slabs
      6712          +187.4%      19289        slabinfo.kmalloc-512.num_objs
    209.25          +187.8%     602.25        slabinfo.kmalloc-512.num_slabs
    453.75           +41.7%     643.00        slabinfo.kmalloc-8k.active_objs
    469.50           +49.6%     702.25        slabinfo.kmalloc-8k.num_objs
    923.25 ± 14%     +22.9%       1135 ±  7%  slabinfo.task_group.active_objs
    923.25 ± 14%     +22.9%       1135 ±  7%  slabinfo.task_group.num_objs
      1201           +79.2%       2152 ±  2%  slabinfo.xfs_buf_item.active_objs
      1201           +79.2%       2152 ±  2%  slabinfo.xfs_buf_item.num_objs
      1264           +51.1%       1909 ± 13%  slabinfo.xfs_efd_item.active_objs
      1264           +51.1%       1909 ± 13%  slabinfo.xfs_efd_item.num_objs
      2437 ±  2%    +375.6%      11590        slabinfo.xfs_inode.active_objs
     84.25 ±  3%    +688.7%     664.50 ±  4%  slabinfo.xfs_inode.active_slabs
      2710 ±  3%    +685.2%      21283 ±  4%  slabinfo.xfs_inode.num_objs
     84.25 ±  3%    +688.7%     664.50 ±  4%  slabinfo.xfs_inode.num_slabs
     40593           -23.2%      31163 ±  2%  sched_debug.cfs_rq:/.exec_clock.avg
     42413           -22.9%      32721 ±  2%  sched_debug.cfs_rq:/.exec_clock.max
     40001           -23.7%      30528 ±  2%  sched_debug.cfs_rq:/.exec_clock.min
     21776 ± 22%     +54.6%      33663 ± 23%  sched_debug.cfs_rq:/.load.avg
    131390 ±112%    +327.1%     561113 ± 52%  sched_debug.cfs_rq:/.load.max
     26684 ± 79%    +269.6%      98631 ± 45%  sched_debug.cfs_rq:/.load.stddev
    508.00 ± 37%    +133.3%       1185 ± 39%  sched_debug.cfs_rq:/.load_avg.max
      9.00 ± 17%     -44.4%       5.00 ± 33%  sched_debug.cfs_rq:/.load_avg.min
    120.95 ± 40%     +94.6%     235.39 ± 32%  sched_debug.cfs_rq:/.load_avg.stddev
   1315047           -37.2%     825488 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
   1467409 ±  3%     -35.8%     941380 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
   1271354           -38.8%     777738 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
      0.62 ±  5%     -30.4%       0.43 ± 10%  sched_debug.cfs_rq:/.nr_running.avg
     35.08 ±  9%    +449.6%     192.83 ± 63%  sched_debug.cfs_rq:/.runnable_load_avg.max
     10.30          +221.3%      33.10 ± 54%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
     20216 ± 22%     +48.6%      30046 ± 29%  sched_debug.cfs_rq:/.runnable_weight.avg
    120127 ±125%    +287.7%     465751 ± 60%  sched_debug.cfs_rq:/.runnable_weight.max
     25146 ± 87%    +234.5%      84116 ± 53%  sched_debug.cfs_rq:/.runnable_weight.stddev
     14472 ±135%    -101.5%    -211.35        sched_debug.cfs_rq:/.spread0.avg
    166817 ± 25%     -30.7%     115662 ± 20%  sched_debug.cfs_rq:/.spread0.max
    -28876           +66.0%     -47942        sched_debug.cfs_rq:/.spread0.min
    757.34 ±  2%     -27.9%     545.98 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1299 ± 11%     -14.5%       1111        sched_debug.cfs_rq:/.util_avg.max
    397.33 ± 17%     -38.5%     244.17 ± 17%  sched_debug.cfs_rq:/.util_avg.min
    103.73 ± 13%     -38.5%      63.79 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    204770 ±  4%     -10.9%     182535 ±  3%  sched_debug.cpu.avg_idle.stddev
      1795 ± 10%     -27.6%       1300 ± 17%  sched_debug.cpu.curr->pid.avg
      1336           +18.0%       1576 ±  5%  sched_debug.cpu.curr->pid.stddev
      0.64 ±  5%     -28.8%       0.45 ± 10%  sched_debug.cpu.nr_running.avg
     27275           -10.7%      24364        sched_debug.cpu.nr_switches.avg
     34560 ±  3%     +68.3%      58168 ±  4%  sched_debug.cpu.nr_switches.max
     24872           -31.7%      16990        sched_debug.cpu.nr_switches.min
      2128 ±  7%    +328.5%       9122 ±  2%  sched_debug.cpu.nr_switches.stddev
     25106           -11.7%      22178        sched_debug.cpu.sched_count.avg
     27859 ±  2%     +89.0%      52655 ±  3%  sched_debug.cpu.sched_count.max
     23769           -32.1%      16139        sched_debug.cpu.sched_count.min
    874.04 ± 15%    +856.0%       8355        sched_debug.cpu.sched_count.stddev
     11954           -10.8%      10660        sched_debug.cpu.sched_goidle.avg
     13338 ±  2%     +93.1%      25761 ±  3%  sched_debug.cpu.sched_goidle.max
     11339           -32.5%       7653        sched_debug.cpu.sched_goidle.min
    420.12 ± 13%    +887.8%       4149        sched_debug.cpu.sched_goidle.stddev
     12641           -12.2%      11095        sched_debug.cpu.ttwu_count.avg
     14696           +73.7%      25527        sched_debug.cpu.ttwu_count.max
     12080           -33.3%       8056        sched_debug.cpu.ttwu_count.min
    598.46 ±  9%    +580.7%       4073        sched_debug.cpu.ttwu_count.stddev
    470.25 ±  2%     +23.9%     582.47 ±  3%  sched_debug.cpu.ttwu_local.avg
    883.75 ± 10%     +23.9%       1094 ±  9%  sched_debug.cpu.ttwu_local.max
     91.75 ± 12%     +68.5%     154.59 ±  7%  sched_debug.cpu.ttwu_local.stddev
 3.867e+09           -14.4%  3.312e+09        perf-stat.i.branch-instructions
      2.08 ±  2%      -0.1        1.95 ±  3%  perf-stat.i.branch-miss-rate%
  55566907           -12.0%   48886699 ±  2%  perf-stat.i.branch-misses
     26.51            -1.7       24.84 ±  2%  perf-stat.i.cache-miss-rate%
  37534712           -23.4%   28761515        perf-stat.i.cache-misses
 1.407e+08           -16.4%  1.176e+08 ±  2%  perf-stat.i.cache-references
     17417            -9.9%      15689        perf-stat.i.context-switches
      2.05            -6.7%       1.91 ±  3%  perf-stat.i.cpi
 3.442e+10           -19.1%  2.784e+10 ±  4%  perf-stat.i.cpu-cycles
      2461           -48.3%       1271        perf-stat.i.cpu-migrations
    898.31            +4.4%     937.81 ±  4%  perf-stat.i.cycles-between-cache-misses
 1.176e+08 ±  9%     -22.4%   91285096 ±  2%  perf-stat.i.dTLB-load-misses
 6.032e+09           -14.2%  5.174e+09        perf-stat.i.dTLB-loads
  17987322 ±  3%     -17.7%   14796811 ±  3%  perf-stat.i.dTLB-store-misses
 4.184e+09           -15.1%  3.553e+09        perf-stat.i.dTLB-stores
   6915996 ±  2%      -5.9%    6510336        perf-stat.i.iTLB-load-misses
   2586772 ±  8%     -18.9%    2098325 ± 13%  perf-stat.i.iTLB-loads
 1.945e+10           -14.3%  1.667e+10        perf-stat.i.instructions
      2785 ±  3%     -10.5%       2492        perf-stat.i.instructions-per-iTLB-miss
      0.55            +7.4%       0.59 ±  2%  perf-stat.i.ipc
      3723            -5.1%       3534        perf-stat.i.minor-faults
   2160613           -24.3%    1634850 ±  2%  perf-stat.i.node-load-misses
   4136129           -22.3%    3213515        perf-stat.i.node-loads
     23.00            -1.2       21.79 ±  3%  perf-stat.i.node-store-miss-rate%
   8687009           -31.6%    5940686 ±  2%  perf-stat.i.node-store-misses
  29184014           -26.3%   21502342        perf-stat.i.node-stores
      3723            -5.1%       3534        perf-stat.i.page-faults
      7.23            -2.5%       7.05        perf-stat.overall.MPKI
     26.68            -2.2       24.47        perf-stat.overall.cache-miss-rate%
      1.77            -5.7%       1.67 ±  2%  perf-stat.overall.cpi
    917.20            +5.6%     968.21 ±  4%  perf-stat.overall.cycles-between-cache-misses
      2814 ±  2%      -9.0%       2560        perf-stat.overall.instructions-per-iTLB-miss
      0.57            +6.1%       0.60 ±  2%  perf-stat.overall.ipc
     34.31            -0.6       33.71        perf-stat.overall.node-load-miss-rate%
     22.94 ±  2%      -1.3       21.65        perf-stat.overall.node-store-miss-rate%
 3.835e+09           -14.2%  3.291e+09        perf-stat.ps.branch-instructions
  55111206           -11.9%   48573654 ±  2%  perf-stat.ps.branch-misses
  37224107           -23.2%   28577554        perf-stat.ps.cache-misses
 1.395e+08           -16.3%  1.168e+08 ±  2%  perf-stat.ps.cache-references
     17274            -9.8%      15588        perf-stat.ps.context-switches
 3.414e+10           -19.0%  2.766e+10 ±  4%  perf-stat.ps.cpu-cycles
      2441           -48.2%       1263        perf-stat.ps.cpu-migrations
 1.166e+08 ±  9%     -22.2%   90699316 ±  2%  perf-stat.ps.dTLB-load-misses
 5.983e+09           -14.1%  5.141e+09        perf-stat.ps.dTLB-loads
  17837008 ±  3%     -17.6%   14701867 ±  3%  perf-stat.ps.dTLB-store-misses
 4.149e+09           -14.9%   3.53e+09        perf-stat.ps.dTLB-stores
   6858348 ±  2%      -5.7%    6468604        perf-stat.ps.iTLB-load-misses
   2565117 ±  8%     -18.7%    2084894 ± 13%  perf-stat.ps.iTLB-loads
 1.929e+10           -14.1%  1.656e+10        perf-stat.ps.instructions
      3714            -5.4%       3513        perf-stat.ps.minor-faults
   2142679           -24.2%    1624370 ±  2%  perf-stat.ps.node-load-misses
   4101979           -22.2%    3192920        perf-stat.ps.node-loads
   8614251           -31.5%    5902590 ±  2%  perf-stat.ps.node-store-misses
  28939527           -26.2%   21364553        perf-stat.ps.node-stores
      3714            -5.4%       3513        perf-stat.ps.page-faults
 2.506e+12            +4.5%  2.619e+12        perf-stat.total.instructions
    145.25 ± 16%     +54.9%     225.00 ± 18%  interrupts.39:IR-PCI-MSI.524289-edge.eth0-TxRx-0
    103.00 ± 49%   +1794.7%       1951 ±161%  interrupts.44:IR-PCI-MSI.524294-edge.eth0-TxRx-5
      1380 ± 11%     +21.4%       1676 ±  5%  interrupts.CPU0.CAL:Function_call_interrupts
    260369           +21.4%     316051        interrupts.CPU0.LOC:Local_timer_interrupts
      2090 ± 11%     -32.7%       1407 ±  6%  interrupts.CPU0.RES:Rescheduling_interrupts
    259956           +21.7%     316451        interrupts.CPU1.LOC:Local_timer_interrupts
    259976           +21.4%     315572        interrupts.CPU10.LOC:Local_timer_interrupts
      1869 ± 22%     -56.8%     808.50 ± 12%  interrupts.CPU10.RES:Rescheduling_interrupts
      1382 ±  9%     +15.6%       1598 ±  7%  interrupts.CPU11.CAL:Function_call_interrupts
    260390           +21.4%     316071        interrupts.CPU11.LOC:Local_timer_interrupts
      1514 ±  7%     -45.4%     827.00 ± 31%  interrupts.CPU11.RES:Rescheduling_interrupts
      1218 ±  6%     +36.8%       1665 ± 12%  interrupts.CPU12.CAL:Function_call_interrupts
    260198           +21.7%     316720        interrupts.CPU12.LOC:Local_timer_interrupts
      1484 ±  8%     -37.2%     932.50 ± 16%  interrupts.CPU12.RES:Rescheduling_interrupts
      1309 ± 10%     +25.9%       1648 ± 11%  interrupts.CPU13.CAL:Function_call_interrupts
    260491           +21.6%     316752        interrupts.CPU13.LOC:Local_timer_interrupts
      1435 ±  7%     -35.7%     923.00 ± 23%  interrupts.CPU13.RES:Rescheduling_interrupts
    260090           +21.6%     316365        interrupts.CPU14.LOC:Local_timer_interrupts
      2335 ± 33%     -60.6%     920.75 ± 57%  interrupts.CPU14.NMI:Non-maskable_interrupts
      2335 ± 33%     -60.6%     920.75 ± 57%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
      1534 ±  7%     -43.3%     870.50 ± 27%  interrupts.CPU14.RES:Rescheduling_interrupts
    260275           +21.2%     315386        interrupts.CPU15.LOC:Local_timer_interrupts
      1533 ±  7%     -40.2%     916.50 ± 28%  interrupts.CPU15.RES:Rescheduling_interrupts
    259511           +21.3%     314731        interrupts.CPU16.LOC:Local_timer_interrupts
      1530 ±  6%     -47.6%     802.50 ± 13%  interrupts.CPU16.RES:Rescheduling_interrupts
    260066           +21.7%     316545        interrupts.CPU17.LOC:Local_timer_interrupts
    260096           +21.0%     314637        interrupts.CPU18.LOC:Local_timer_interrupts
      1502 ±  8%     -48.9%     767.75 ± 18%  interrupts.CPU18.RES:Rescheduling_interrupts
    260276           +21.4%     315940        interrupts.CPU19.LOC:Local_timer_interrupts
      1540 ±  7%     -33.4%       1025 ± 24%  interrupts.CPU19.RES:Rescheduling_interrupts
    103.00 ± 49%   +1794.7%       1951 ±161%  interrupts.CPU2.44:IR-PCI-MSI.524294-edge.eth0-TxRx-5
    260077           +21.7%     316607        interrupts.CPU2.LOC:Local_timer_interrupts
      1696 ± 22%     -49.0%     865.00 ± 17%  interrupts.CPU2.RES:Rescheduling_interrupts
    260201           +21.8%     316819        interrupts.CPU20.LOC:Local_timer_interrupts
    446.50 ±141%    +283.6%       1712 ± 32%  interrupts.CPU20.NMI:Non-maskable_interrupts
    446.50 ±141%    +283.6%       1712 ± 32%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    260321           +21.6%     316575        interrupts.CPU21.LOC:Local_timer_interrupts
    260161           +21.1%     315079        interrupts.CPU22.LOC:Local_timer_interrupts
      1533 ±  8%     -21.8%       1198 ± 23%  interrupts.CPU22.RES:Rescheduling_interrupts
      1356 ± 10%     +19.9%       1626 ±  4%  interrupts.CPU23.CAL:Function_call_interrupts
    259884           +21.6%     316144        interrupts.CPU23.LOC:Local_timer_interrupts
      1332 ±  5%     -43.3%     755.00        interrupts.CPU23.RES:Rescheduling_interrupts
    260225           +21.2%     315429        interrupts.CPU24.LOC:Local_timer_interrupts
      1388 ±  4%     -47.4%     730.25 ± 19%  interrupts.CPU24.RES:Rescheduling_interrupts
    259779           +21.8%     316330        interrupts.CPU25.LOC:Local_timer_interrupts
      1468 ±  8%     -29.7%       1033 ± 31%  interrupts.CPU25.RES:Rescheduling_interrupts
      1376 ± 11%     +22.5%       1687 ± 10%  interrupts.CPU26.CAL:Function_call_interrupts
    260128           +21.2%     315219        interrupts.CPU26.LOC:Local_timer_interrupts
    259346           +22.3%     317098        interrupts.CPU27.LOC:Local_timer_interrupts
      1465 ±  7%     -42.2%     846.25 ± 31%  interrupts.CPU27.RES:Rescheduling_interrupts
    260225           +21.0%     314795        interrupts.CPU28.LOC:Local_timer_interrupts
      1459 ±  7%     -42.3%     842.00 ± 17%  interrupts.CPU28.RES:Rescheduling_interrupts
    260085           +21.5%     316006        interrupts.CPU29.LOC:Local_timer_interrupts
      1379 ±  4%     -47.2%     727.75 ± 16%  interrupts.CPU29.RES:Rescheduling_interrupts
    260259           +21.7%     316731        interrupts.CPU3.LOC:Local_timer_interrupts
      1567 ±  9%     -39.8%     943.25 ± 30%  interrupts.CPU3.RES:Rescheduling_interrupts
    145.25 ± 16%     +54.9%     225.00 ± 18%  interrupts.CPU30.39:IR-PCI-MSI.524289-edge.eth0-TxRx-0
    260074           +21.1%     314955        interrupts.CPU30.LOC:Local_timer_interrupts
      1390 ±  4%     -50.9%     682.50 ± 14%  interrupts.CPU30.RES:Rescheduling_interrupts
      1358 ± 11%     +18.5%       1609 ± 14%  interrupts.CPU31.CAL:Function_call_interrupts
    260132           +21.7%     316628        interrupts.CPU31.LOC:Local_timer_interrupts
      1392 ± 10%     -31.4%     955.75 ± 17%  interrupts.CPU31.RES:Rescheduling_interrupts
      1360 ± 11%     +15.9%       1576 ± 11%  interrupts.CPU32.CAL:Function_call_interrupts
    260317           +20.9%     314826        interrupts.CPU32.LOC:Local_timer_interrupts
      1464 ± 11%     -45.5%     798.25 ± 18%  interrupts.CPU32.RES:Rescheduling_interrupts
    260012           +21.4%     315686        interrupts.CPU33.LOC:Local_timer_interrupts
      1486 ± 10%     -48.4%     767.00 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
      1265 ± 18%     +25.0%       1582 ± 12%  interrupts.CPU34.CAL:Function_call_interrupts
    260359           +21.0%     315007        interrupts.CPU34.LOC:Local_timer_interrupts
      1603 ± 27%     -52.0%     770.00 ± 27%  interrupts.CPU34.RES:Rescheduling_interrupts
      1390 ±  8%     +16.0%       1612 ± 10%  interrupts.CPU35.CAL:Function_call_interrupts
    260282           +21.7%     316652        interrupts.CPU35.LOC:Local_timer_interrupts
      1434 ± 11%     -42.3%     827.50 ± 14%  interrupts.CPU35.RES:Rescheduling_interrupts
    260380           +20.8%     314555        interrupts.CPU36.LOC:Local_timer_interrupts
      1343 ± 10%     -38.3%     829.25 ±  9%  interrupts.CPU36.RES:Rescheduling_interrupts
    260230           +21.1%     315199        interrupts.CPU37.LOC:Local_timer_interrupts
      1346 ± 12%     +21.2%       1631 ± 13%  interrupts.CPU38.CAL:Function_call_interrupts
    259976           +21.8%     316532        interrupts.CPU38.LOC:Local_timer_interrupts
      1481 ±  6%     -51.1%     724.25 ±  9%  interrupts.CPU38.RES:Rescheduling_interrupts
    260061           +20.9%     314458        interrupts.CPU39.LOC:Local_timer_interrupts
      1436 ±  8%     -44.9%     791.00 ± 34%  interrupts.CPU39.RES:Rescheduling_interrupts
      1359 ± 13%     +22.9%       1671 ± 12%  interrupts.CPU4.CAL:Function_call_interrupts
    260201           +21.7%     316705        interrupts.CPU4.LOC:Local_timer_interrupts
      1668 ± 20%     -43.6%     941.00 ± 10%  interrupts.CPU4.RES:Rescheduling_interrupts
      1385 ±  9%     +12.1%       1552 ±  8%  interrupts.CPU5.CAL:Function_call_interrupts
    260181           +21.7%     316657        interrupts.CPU5.LOC:Local_timer_interrupts
      1164 ± 55%     -74.2%     300.25 ±173%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1164 ± 55%     -74.2%     300.25 ±173%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      1464 ±  9%     -42.8%     838.00 ± 15%  interrupts.CPU5.RES:Rescheduling_interrupts
    260255           +21.7%     316804        interrupts.CPU6.LOC:Local_timer_interrupts
      1497 ±  6%     -50.5%     741.00 ± 19%  interrupts.CPU6.RES:Rescheduling_interrupts
      1372 ±  9%     +19.6%       1642 ±  4%  interrupts.CPU7.CAL:Function_call_interrupts
    259919           +21.5%     315765        interrupts.CPU7.LOC:Local_timer_interrupts
      1481 ± 10%     -26.4%       1089 ± 29%  interrupts.CPU7.RES:Rescheduling_interrupts
      1339 ± 13%     +17.6%       1575 ± 11%  interrupts.CPU8.CAL:Function_call_interrupts
    260401           +21.6%     316700        interrupts.CPU8.LOC:Local_timer_interrupts
      1861 ± 33%     -53.3%     869.50 ± 19%  interrupts.CPU8.RES:Rescheduling_interrupts
      1426 ±  6%     +18.8%       1695 ±  9%  interrupts.CPU9.CAL:Function_call_interrupts
    259391           +22.2%     316922        interrupts.CPU9.LOC:Local_timer_interrupts
      1551           -18.5%       1264 ±  3%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1551           -18.5%       1264 ±  3%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      1646 ± 14%     -47.5%     864.75 ±  8%  interrupts.CPU9.RES:Rescheduling_interrupts
  10404571           +21.5%   12638118        interrupts.LOC:Local_timer_interrupts
     61340 ±  2%     -39.7%      37011 ±  2%  interrupts.RES:Rescheduling_interrupts
    265.00 ±  6%     +76.1%     466.75 ± 12%  interrupts.TLB:TLB_shootdowns
     21780 ±  3%     +34.1%      29206 ±  4%  softirqs.CPU0.RCU
     19352 ±  2%     +14.7%      22198        softirqs.CPU0.SCHED
     50306 ±  4%     +17.8%      59258 ±  8%  softirqs.CPU0.TIMER
     23163 ±  8%     +21.3%      28089 ±  6%  softirqs.CPU1.RCU
     16179           +20.8%      19547        softirqs.CPU1.SCHED
     48867 ±  5%     +16.5%      56934 ±  3%  softirqs.CPU1.TIMER
     21339 ±  2%     +31.5%      28064 ±  4%  softirqs.CPU10.RCU
     15492 ±  2%     +21.8%      18872        softirqs.CPU10.SCHED
     48447 ±  2%     +16.0%      56208 ±  2%  softirqs.CPU10.TIMER
     21278 ±  5%     +31.9%      28067 ±  5%  softirqs.CPU11.RCU
     15581           +20.5%      18770        softirqs.CPU11.SCHED
     48567           +17.7%      57140 ±  4%  softirqs.CPU11.TIMER
     22261 ±  3%     +36.5%      30385 ±  9%  softirqs.CPU12.RCU
     15644           +20.3%      18824 ±  2%  softirqs.CPU12.SCHED
     49536 ±  2%     +32.3%      65518 ± 21%  softirqs.CPU12.TIMER
     21724 ±  2%     +27.9%      27794 ±  4%  softirqs.CPU13.RCU
     15508           +21.1%      18776 ±  2%  softirqs.CPU13.SCHED
     48945           +19.2%      58366 ±  4%  softirqs.CPU13.TIMER
     21297 ±  3%     +35.0%      28761 ±  3%  softirqs.CPU14.RCU
     15583           +23.0%      19162 ±  5%  softirqs.CPU14.SCHED
     48772 ±  2%     +17.2%      57154 ±  4%  softirqs.CPU14.TIMER
     21231 ±  3%     +35.4%      28746 ±  8%  softirqs.CPU15.RCU
     15571           +21.9%      18985 ±  2%  softirqs.CPU15.SCHED
     48486           +17.6%      57020 ±  3%  softirqs.CPU15.TIMER
     21571 ±  7%     +31.7%      28415        softirqs.CPU16.RCU
     15314           +23.3%      18884 ±  2%  softirqs.CPU16.SCHED
     49988 ±  4%     +15.1%      57561 ±  3%  softirqs.CPU16.TIMER
     21326 ±  4%     +31.0%      27927 ±  4%  softirqs.CPU17.RCU
     15434           +22.8%      18960 ±  3%  softirqs.CPU17.SCHED
     48588 ±  2%     +17.1%      56905 ±  2%  softirqs.CPU17.TIMER
     21212 ±  2%     +31.8%      27968 ±  4%  softirqs.CPU18.RCU
     15571           +20.9%      18827 ±  3%  softirqs.CPU18.SCHED
     49151 ±  2%     +33.3%      65535 ± 15%  softirqs.CPU18.TIMER
     21490 ±  4%     +27.9%      27490 ±  5%  softirqs.CPU19.RCU
     15550           +20.6%      18747 ±  2%  softirqs.CPU19.SCHED
     50252 ±  8%     +13.4%      57009 ±  2%  softirqs.CPU19.TIMER
     23244 ± 11%     +32.3%      30747 ±  6%  softirqs.CPU2.RCU
     15982           +30.8%      20905        softirqs.CPU2.SCHED
     50703 ±  5%     +22.8%      62276 ±  4%  softirqs.CPU2.TIMER
     21304 ±  2%     +45.9%      31089 ±  7%  softirqs.CPU20.RCU
     15409 ±  2%     +23.2%      18988 ±  3%  softirqs.CPU20.SCHED
     22317 ±  4%     +28.2%      28608 ±  5%  softirqs.CPU21.RCU
     50492 ±  3%     +18.6%      59868 ±  8%  softirqs.CPU21.TIMER
     21099 ±  4%     +32.6%      27983 ±  3%  softirqs.CPU22.RCU
     15607           +21.3%      18935 ±  2%  softirqs.CPU22.SCHED
     20953 ±  2%     +36.0%      28492 ±  6%  softirqs.CPU23.RCU
     15463           +22.4%      18924 ±  6%  softirqs.CPU23.SCHED
     49790 ±  2%     +17.2%      58355 ±  4%  softirqs.CPU23.TIMER
     21424 ±  2%     +33.5%      28607 ±  4%  softirqs.CPU24.RCU
     15603           +19.8%      18692        softirqs.CPU24.SCHED
     49433 ±  4%     +18.7%      58682 ±  4%  softirqs.CPU24.TIMER
     21527 ±  2%     +34.8%      29025 ±  4%  softirqs.CPU25.RCU
     15413           +22.6%      18891 ±  2%  softirqs.CPU25.SCHED
     48601 ±  2%     +17.9%      57281 ±  3%  softirqs.CPU25.TIMER
     21284 ±  3%     +31.1%      27898 ±  2%  softirqs.CPU26.RCU
     15979 ±  4%     +18.2%      18888        softirqs.CPU26.SCHED
     50363 ±  3%     +12.6%      56721 ±  4%  softirqs.CPU26.TIMER
     21307 ±  2%     +34.4%      28646 ±  5%  softirqs.CPU27.RCU
     15342           +23.2%      18905 ±  3%  softirqs.CPU27.SCHED
     48693 ±  3%     +19.5%      58194 ±  2%  softirqs.CPU27.TIMER
     21278           +30.1%      27694 ±  3%  softirqs.CPU28.RCU
     15623           +20.2%      18773        softirqs.CPU28.SCHED
     49220 ±  2%     +14.4%      56308 ±  3%  softirqs.CPU28.TIMER
     21511 ±  4%     +30.1%      27979 ±  5%  softirqs.CPU29.RCU
     15816 ±  2%     +18.4%      18725        softirqs.CPU29.SCHED
     48698           +17.7%      57323 ±  3%  softirqs.CPU29.TIMER
     21335 ±  2%     +36.2%      29048 ±  6%  softirqs.CPU3.RCU
     15763 ±  2%     +20.0%      18917        softirqs.CPU3.SCHED
     21413 ±  2%     +32.4%      28350 ±  3%  softirqs.CPU30.RCU
     15489 ±  2%     +21.6%      18831 ±  2%  softirqs.CPU30.SCHED
     48627 ±  2%     +16.2%      56482 ±  2%  softirqs.CPU30.TIMER
     21314 ±  4%     +32.2%      28181 ±  5%  softirqs.CPU31.RCU
     15542           +21.2%      18844 ±  3%  softirqs.CPU31.SCHED
     49740 ±  6%     +14.4%      56918 ±  3%  softirqs.CPU31.TIMER
     19067 ± 11%     +19.3%      22739 ±  2%  softirqs.CPU32.RCU
     15786 ±  3%     +19.3%      18839 ±  2%  softirqs.CPU32.SCHED
     51277 ±  4%     +12.1%      57503 ±  4%  softirqs.CPU32.TIMER
     17283 ±  3%     +28.4%      22185 ±  4%  softirqs.CPU33.RCU
     15463 ±  2%     +20.5%      18635        softirqs.CPU33.SCHED
     48637 ±  2%     +32.4%      64412 ± 18%  softirqs.CPU33.TIMER
     17794 ±  3%     +29.8%      23103 ±  4%  softirqs.CPU34.RCU
     15838           +19.2%      18886        softirqs.CPU34.SCHED
     49140 ±  2%     +16.2%      57109 ±  4%  softirqs.CPU34.TIMER
     17452 ±  2%     +28.5%      22432 ±  3%  softirqs.CPU35.RCU
     15466           +19.9%      18543 ±  2%  softirqs.CPU35.SCHED
     48547           +16.8%      56684 ±  3%  softirqs.CPU35.TIMER
     17422 ±  4%     +36.2%      23721 ±  5%  softirqs.CPU36.RCU
     15474           +22.9%      19016 ±  3%  softirqs.CPU36.SCHED
     18024 ±  5%     +25.0%      22537 ±  3%  softirqs.CPU37.RCU
     15591 ±  2%     +21.2%      18892 ±  2%  softirqs.CPU37.SCHED
     49241 ±  2%     +15.7%      56982 ±  3%  softirqs.CPU37.TIMER
     18270 ±  6%     +23.0%      22468 ±  2%  softirqs.CPU38.RCU
     15698           +18.2%      18555 ±  2%  softirqs.CPU38.SCHED
     17354 ±  2%     +29.0%      22393 ±  3%  softirqs.CPU39.RCU
     15582           +18.3%      18430 ±  4%  softirqs.CPU39.SCHED
     48135 ±  2%     +35.5%      65242 ± 18%  softirqs.CPU39.TIMER
     21472           +30.6%      28049        softirqs.CPU4.RCU
     15684           +20.5%      18896 ±  4%  softirqs.CPU4.SCHED
     49567 ±  2%     +14.5%      56732 ±  4%  softirqs.CPU4.TIMER
     21886           +33.1%      29122 ±  8%  softirqs.CPU5.RCU
     15912 ±  4%     +19.3%      18983 ±  4%  softirqs.CPU5.SCHED
     49334 ±  4%     +17.3%      57889 ±  4%  softirqs.CPU5.TIMER
     22759 ± 12%     +28.1%      29150 ±  3%  softirqs.CPU6.RCU
     15561           +23.0%      19144        softirqs.CPU6.SCHED
     50896           +15.8%      58936 ±  3%  softirqs.CPU6.TIMER
     21754 ±  5%     +26.8%      27588 ±  4%  softirqs.CPU7.RCU
     15439           +22.1%      18851 ±  3%  softirqs.CPU7.SCHED
     51023 ±  3%     +12.0%      57169 ±  4%  softirqs.CPU7.TIMER
     21768 ±  3%     +28.9%      28061 ±  3%  softirqs.CPU8.RCU
     15680           +24.5%      19522 ±  5%  softirqs.CPU8.SCHED
     48977 ±  2%     +17.5%      57545 ±  3%  softirqs.CPU8.TIMER
     20951           +32.1%      27683 ±  4%  softirqs.CPU9.RCU
     15426           +20.8%      18638 ±  3%  softirqs.CPU9.SCHED
     48306 ±  3%     +18.3%      57152 ±  3%  softirqs.CPU9.TIMER
    834261 ±  2%     +31.2%    1094511 ±  3%  softirqs.RCU
    629022           +20.9%     760517 ±  2%  softirqs.SCHED
   2001302           +16.7%    2335824 ±  3%  softirqs.TIMER
     63.72           -11.9       51.82        perf-profile.calltrace.cycles-pp.write
     54.54           -10.4       44.19 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     54.05           -10.3       43.78 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     45.97            -9.1       36.91 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     44.57            -8.8       35.77 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.87            -7.6       31.22 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.73            -7.1       29.68 ±  3%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     29.28            -5.2       24.09 ±  3%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
     29.00            -5.1       23.86 ±  3%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
     21.42            -4.1       17.29 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      9.82            -2.0        7.84 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
     10.19            -1.6        8.57 ±  4%  perf-profile.calltrace.cycles-pp.lseek64
      3.70            -1.5        2.15 ±  4%  perf-profile.calltrace.cycles-pp.close
      3.64            -1.5        2.13 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
      3.64            -1.5        2.13 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      3.62            -1.5        2.11 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      3.60            -1.5        2.10 ±  3%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.60            -1.5        2.11 ±  3%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      3.48            -1.5        1.99 ±  4%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      3.46            -1.5        1.98 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_usermode_loop
      7.25 ±  2%      -1.5        5.77        perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      6.93            -1.4        5.53        perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      4.82 ±  2%      -1.2        3.59 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
      4.07 ±  2%      -0.9        3.16        perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      5.73            -0.8        4.89 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.lseek64
      3.46 ±  2%      -0.8        2.65        perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      5.57 ±  2%      -0.8        4.76 ±  7%  perf-profile.calltrace.cycles-pp.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      4.54 ±  3%      -0.8        3.74 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      3.36 ±  3%      -0.8        2.57 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply
      4.53            -0.8        3.74 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      5.46            -0.8        4.69 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.lseek64
      2.63            -0.7        1.91 ±  3%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      2.65            -0.7        1.93 ±  3%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      2.48 ±  4%      -0.7        1.79 ±  8%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      3.72 ±  2%      -0.7        3.06 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      2.42 ±  4%      -0.6        1.83 ±  8%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.57 ±  3%      -0.6        3.98 ±  9%  perf-profile.calltrace.cycles-pp.xfs_file_iomap_begin_delay.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      2.68 ±  2%      -0.6        2.10        perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.69 ±  7%      -0.5        1.18 ± 10%  perf-profile.calltrace.cycles-pp.xfs_vn_update_time.file_update_time.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write
      1.52 ± 17%      -0.5        1.03 ± 17%  perf-profile.calltrace.cycles-pp.xfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      1.93            -0.4        1.49 ±  4%  perf-profile.calltrace.cycles-pp.iomap_read_page_sync.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.72 ±  6%      -0.4        1.30 ±  6%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.92 ±  2%      -0.4        1.51 ±  4%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.80 ±  5%      -0.4        1.40 ±  7%  perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      1.19 ±  2%      -0.4        0.82 ± 12%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_aio_write_checks.xfs_file_buffered_aio_write
      0.70 ± 24%      -0.4        0.33 ±104%  perf-profile.calltrace.cycles-pp.xfs_bmbt_to_iomap.xfs_file_iomap_begin_delay.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write
      1.13 ±  3%      -0.4        0.77 ± 13%  perf-profile.calltrace.cycles-pp.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_aio_write_checks
      1.45            -0.4        1.10 ±  4%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_read_page_sync.iomap_write_begin.iomap_write_actor.iomap_apply
      1.84            -0.3        1.49 ±  5%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.lseek64
      2.22 ±  2%      -0.3        1.88 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.lseek64
      1.12 ±  3%      -0.3        0.79 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      1.14 ±  3%      -0.3        0.81 ±  3%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      0.71 ±  2%      -0.3        0.40 ± 57%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.11 ±  4%      -0.3        0.85 ±  7%  perf-profile.calltrace.cycles-pp.xas_load.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.34            -0.3        1.08 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.06 ±  2%      -0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.66 ±  3%      -0.2        0.43 ± 57%  perf-profile.calltrace.cycles-pp.disk_rw
      1.08 ±  4%      -0.2        0.88 ±  5%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.76            -0.2        0.57 ±  5%  perf-profile.calltrace.cycles-pp.__lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.87 ±  3%      -0.2        1.68 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.14 ±  6%      -0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_iomap_begin_delay.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write
      0.94 ±  6%      -0.2        0.76 ±  4%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
      0.78 ±  9%      -0.2        0.61 ±  5%  perf-profile.calltrace.cycles-pp.xfs_iext_lookup_extent.xfs_file_iomap_begin_delay.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write
      0.72 ±  7%      -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      0.69 ±  6%      -0.2        0.53 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply
      0.94 ±  5%      -0.2        0.79 ±  7%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_iomap_begin_delay.xfs_file_iomap_begin.iomap_apply
      0.78 ±  6%      -0.2        0.62 ±  4%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      0.86 ±  2%      +0.4        1.23 ±  3%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_open
      0.89 ±  2%      +0.4        1.25 ±  2%  perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
      1.59 ±  2%      +0.5        2.13 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      1.58 ±  2%      +0.5        2.13 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      1.57            +0.5        2.12 ±  5%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      1.54 ±  2%      +0.6        2.09 ±  5%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.61            +0.6        2.17 ±  5%  perf-profile.calltrace.cycles-pp.creat
      1.54 ±  2%      +0.6        2.10 ±  5%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +0.6        0.57 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.6        0.62 ±  5%  perf-profile.calltrace.cycles-pp.xfs_check_agi_freecount.xfs_dialloc_ag.xfs_dialloc.xfs_ialloc.xfs_dir_ialloc
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.xfs_dialloc_ag.xfs_dialloc.xfs_ialloc.xfs_dir_ialloc.xfs_create
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_ialloc.xfs_dir_ialloc.xfs_create.xfs_generic_create
      0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
      0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.xfs_ialloc.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat
      0.00            +1.1        1.08 ±  7%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +1.1        1.15 ±  7%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     16.68 ±  2%     +11.8       28.47 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     16.49 ±  4%     +12.5       29.02        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     16.51 ±  4%     +12.6       29.09        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     16.96 ±  4%     +12.9       29.88        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     16.96 ±  4%     +12.9       29.89        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     16.96 ±  4%     +12.9       29.89        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     17.71           +13.0       30.74 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     67.26           -12.2       55.10 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     66.62           -12.1       54.57 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     64.32           -12.0       52.29        perf-profile.children.cycles-pp.write
     45.98            -9.1       36.93 ±  2%  perf-profile.children.cycles-pp.ksys_write
     44.63            -8.8       35.81 ±  2%  perf-profile.children.cycles-pp.vfs_write
     38.90            -7.7       31.25 ±  2%  perf-profile.children.cycles-pp.new_sync_write
     36.78            -7.1       29.72 ±  3%  perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
     29.30            -5.2       24.10 ±  3%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     29.06            -5.2       23.91 ±  4%  perf-profile.children.cycles-pp.iomap_apply
     21.54            -4.2       17.38 ±  2%  perf-profile.children.cycles-pp.iomap_write_actor
      9.86            -2.0        7.88 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
     10.49            -1.7        8.81 ±  4%  perf-profile.children.cycles-pp.lseek64
      3.70            -1.5        2.15 ±  4%  perf-profile.children.cycles-pp.close
      3.63            -1.5        2.12 ±  3%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      3.60            -1.5        2.10 ±  3%  perf-profile.children.cycles-pp.__fput
      3.60            -1.5        2.11 ±  3%  perf-profile.children.cycles-pp.task_work_run
      3.48            -1.5        2.00 ±  4%  perf-profile.children.cycles-pp.dput
      7.29 ±  2%      -1.5        5.80        perf-profile.children.cycles-pp.grab_cache_page_write_begin
      3.46            -1.5        1.98 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      6.98            -1.4        5.57        perf-profile.children.cycles-pp.pagecache_get_page
      4.87 ±  2%      -1.2        3.63 ±  5%  perf-profile.children.cycles-pp.xfs_file_aio_write_checks
      6.78            -1.1        5.67 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      6.23            -1.1        5.12 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.10 ±  2%      -0.9        3.17        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      3.49 ±  2%      -0.8        2.67        perf-profile.children.cycles-pp.copyin
      5.63 ±  2%      -0.8        4.82 ±  7%  perf-profile.children.cycles-pp.xfs_file_iomap_begin
      4.58 ±  3%      -0.8        3.77 ±  3%  perf-profile.children.cycles-pp.iomap_write_end
      3.38 ±  2%      -0.8        2.59 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.65            -0.7        1.93 ±  3%  perf-profile.children.cycles-pp.evict
      2.63            -0.7        1.92 ±  4%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.50 ±  4%      -0.7        1.81 ±  8%  perf-profile.children.cycles-pp.file_update_time
      4.65 ±  3%      -0.6        4.04 ± 10%  perf-profile.children.cycles-pp.xfs_file_iomap_begin_delay
      2.44 ±  4%      -0.6        1.84 ±  8%  perf-profile.children.cycles-pp.security_file_permission
      2.71 ±  2%      -0.6        2.12        perf-profile.children.cycles-pp.find_get_entry
      1.69 ±  7%      -0.5        1.18 ± 10%  perf-profile.children.cycles-pp.xfs_vn_update_time
      1.53 ± 17%      -0.5        1.04 ± 18%  perf-profile.children.cycles-pp.xfs_file_write_iter
      1.94            -0.4        1.50 ±  4%  perf-profile.children.cycles-pp.iomap_read_page_sync
      1.76 ±  6%      -0.4        1.33 ±  5%  perf-profile.children.cycles-pp.iomap_set_page_dirty
      1.20 ±  2%      -0.4        0.77 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
      0.89            -0.4        0.46 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.83 ±  5%      -0.4        1.42 ±  7%  perf-profile.children.cycles-pp.selinux_file_permission
      1.92 ±  2%      -0.4        1.52 ±  4%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      2.17 ±  5%      -0.4        1.81 ±  3%  perf-profile.children.cycles-pp.xfs_ilock
      1.84            -0.4        1.48 ± 14%  perf-profile.children.cycles-pp.xfs_log_commit_cil
      1.19 ±  3%      -0.3        0.85 ±  3%  perf-profile.children.cycles-pp.release_pages
      1.47            -0.3        1.13 ±  4%  perf-profile.children.cycles-pp.memset_erms
      1.81 ±  5%      -0.3        1.47 ±  6%  perf-profile.children.cycles-pp.down_write
      1.14 ±  3%      -0.3        0.81 ±  3%  perf-profile.children.cycles-pp.__pagevec_release
      1.34 ±  4%      -0.3        1.05 ±  5%  perf-profile.children.cycles-pp.xas_load
      1.36 ±  2%      -0.3        1.11 ±  4%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      2.25 ±  4%      -0.3        2.00 ±  4%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.08 ±  2%      -0.2        0.86 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.77            -0.2        0.57 ±  4%  perf-profile.children.cycles-pp.__lru_cache_add
      1.10 ±  4%      -0.2        0.90 ±  5%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.73            -0.2        0.53 ±  7%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      1.35 ±  3%      -0.2        1.18 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.80 ±  8%      -0.2        0.62 ±  5%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.81 ±  4%      -0.2        0.63 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.75 ±  7%      -0.2        0.58 ±  3%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.62 ±  5%      -0.2        0.45 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.70 ±  6%      -0.2        0.53 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty
      0.56 ±  3%      -0.2        0.39 ±  7%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.59 ±  7%      -0.2        0.43 ±  5%  perf-profile.children.cycles-pp.generic_write_checks
      1.16 ±  5%      -0.2        1.00 ±  5%  perf-profile.children.cycles-pp.xfs_iunlock
      0.46 ±  4%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.__cancel_dirty_page
      0.53 ± 10%      -0.1        0.39 ± 11%  perf-profile.children.cycles-pp.xas_start
      0.60 ±  5%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.50 ±  5%      -0.1        0.36 ±  8%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.72 ± 10%      -0.1        0.59 ±  6%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.44 ±  5%      -0.1        0.30 ±  7%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.78 ±  5%      -0.1        0.65 ±  3%  perf-profile.children.cycles-pp.up_write
      0.74 ±  3%      -0.1        0.61 ±  3%  perf-profile.children.cycles-pp._cond_resched
      0.39 ±  8%      -0.1        0.27 ± 15%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.47 ±  2%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.current_time
      0.71 ±  3%      -0.1        0.58 ±  7%  perf-profile.children.cycles-pp.disk_rw
      0.57 ±  8%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.xas_store
      0.42 ± 13%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.61 ± 15%      -0.1        0.49 ±  6%  perf-profile.children.cycles-pp.__inode_security_revalidate
      0.44 ±  4%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.account_page_dirtied
      0.43 ±  5%      -0.1        0.33 ± 13%  perf-profile.children.cycles-pp.iov_iter_advance
      0.42 ±  3%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.34 ±  6%      -0.1        0.24 ±  9%  perf-profile.children.cycles-pp.account_page_cleaned
      0.43 ±  9%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.22 ± 11%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.35 ±  5%      -0.1        0.27        perf-profile.children.cycles-pp.file_remove_privs
      0.38 ±  9%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.file_modified
      0.32 ± 15%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.35 ±  5%      -0.1        0.28 ±  9%  perf-profile.children.cycles-pp.unlock_page
      0.44 ±  6%      -0.1        0.36 ± 10%  perf-profile.children.cycles-pp.__x64_sys_write
      0.17 ±  4%      -0.1        0.11 ± 20%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.24 ±  8%      -0.1        0.19 ± 14%  perf-profile.children.cycles-pp.__x64_sys_lseek
      0.11 ± 22%      -0.1        0.05 ± 70%  perf-profile.children.cycles-pp.xfs_find_daxdev_for_inode
      0.36 ±  4%      -0.1        0.31        perf-profile.children.cycles-pp.rcu_all_qs
      0.24 ±  6%      -0.1        0.19 ± 15%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.12 ±  4%      -0.1        0.07 ± 17%  perf-profile.children.cycles-pp.xfs_isilocked
      0.23 ± 10%      -0.0        0.18 ± 12%  perf-profile.children.cycles-pp.node_dirty_ok
      0.16 ± 12%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.timespec64_trunc
      0.18 ±  9%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.find_get_entries
      0.18 ±  9%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.pagevec_lookup_entries
      0.22 ±  5%      -0.0        0.17 ± 16%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.16 ±  9%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.__xa_set_mark
      0.30 ±  2%      -0.0        0.26 ±  9%  perf-profile.children.cycles-pp.page_mapping
      0.14 ± 15%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.wake_up_q
      0.19 ± 12%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.18 ±  6%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.12 ± 15%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.22 ±  3%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.11 ± 10%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_mod_fdblocks
      0.08 ±  6%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_hole_delay
      0.07 ± 17%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.09 ±  9%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.03 ±100%      +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.run_timer_softirq
      0.09 ± 28%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.rcu_core
      0.06 ± 13%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.xfs_iunlink
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.04 ± 59%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.update_blocked_averages
      0.05 ± 61%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.rebalance_domains
      0.05 ± 58%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.irq_enter
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.46 ±  6%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.11 ± 17%      +0.1        0.23 ± 17%  perf-profile.children.cycles-pp.ktime_get
      0.12 ± 21%      +0.1        0.25 ± 23%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.15 ± 72%  perf-profile.children.cycles-pp.xfs_verify_agino
      0.04 ± 60%      +0.2        0.26 ± 71%  perf-profile.children.cycles-pp.xfs_inobt_get_maxrecs
      0.11 ±  4%      +0.2        0.34 ± 17%  perf-profile.children.cycles-pp.menu_select
      0.15 ± 42%      +0.3        0.41 ± 21%  perf-profile.children.cycles-pp.osq_lock
      0.26 ± 33%      +0.3        0.52 ± 11%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.64 ± 33%      +0.3        0.92 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30 ± 29%      +0.3        0.59 ±  9%  perf-profile.children.cycles-pp.irq_exit
      0.76 ± 10%      +0.3        1.08 ± 12%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.63 ± 12%      +0.4        0.99 ± 11%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.86 ±  2%      +0.4        1.23 ±  3%  perf-profile.children.cycles-pp.xfs_create
      0.89 ±  2%      +0.4        1.25 ±  2%  perf-profile.children.cycles-pp.xfs_generic_create
      0.34 ±  6%      +0.4        0.74 ±  3%  perf-profile.children.cycles-pp.xfs_dialloc
      0.28 ±  7%      +0.4        0.69 ±  4%  perf-profile.children.cycles-pp.xfs_dialloc_ag
      0.38 ±  6%      +0.4        0.79 ±  2%  perf-profile.children.cycles-pp.xfs_dir_ialloc
      0.38 ±  6%      +0.4        0.79 ±  2%  perf-profile.children.cycles-pp.xfs_ialloc
      0.12 ± 19%      +0.4        0.55 ± 68%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.12 ±  7%      +0.4        0.55 ± 70%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.10 ± 27%      +0.4        0.55 ± 70%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.88 ± 27%      +0.5        1.33 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.67            +0.5        2.20 ±  5%  perf-profile.children.cycles-pp.do_sys_open
      1.61 ±  2%      +0.6        2.16 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      1.61            +0.6        2.17 ±  5%  perf-profile.children.cycles-pp.creat
      1.61 ±  2%      +0.6        2.16 ±  5%  perf-profile.children.cycles-pp.path_openat
      0.15 ± 23%      +0.6        0.76 ± 69%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.20 ±  6%      +0.7        0.89 ± 70%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      1.25 ± 27%      +0.8        2.07 ±  8%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      1.36 ± 26%      +0.9        2.23 ±  8%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.41 ±  4%      +1.1        1.54 ± 68%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      0.06 ± 64%      +1.6        1.62 ±107%  perf-profile.children.cycles-pp.worker_thread
      0.06 ± 64%      +1.6        1.62 ±107%  perf-profile.children.cycles-pp.process_one_work
      0.07 ± 59%      +1.6        1.66 ±105%  perf-profile.children.cycles-pp.kthread
      0.07 ± 59%      +1.6        1.66 ±105%  perf-profile.children.cycles-pp.ret_from_fork
     16.80 ±  2%     +11.7       28.49 ±  2%  perf-profile.children.cycles-pp.intel_idle
     17.24           +12.7       29.90 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     17.24           +12.7       29.91 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     16.96 ±  4%     +12.9       29.89        perf-profile.children.cycles-pp.start_secondary
     17.71           +13.0       30.74 ±  2%  perf-profile.children.cycles-pp.do_idle
     17.71           +13.0       30.74 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64
     17.71           +13.0       30.74 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     11.21            -1.7        9.51 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      6.22            -1.1        5.11 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      6.11            -1.0        5.14 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      3.33 ±  3%      -0.8        2.53 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.47 ± 18%      -0.5        1.00 ± 18%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.89            -0.4        0.46 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.10 ±  8%      -0.4        0.75 ±  6%  perf-profile.self.cycles-pp.xfs_file_buffered_aio_write
      1.46            -0.3        1.11 ±  3%  perf-profile.self.cycles-pp.memset_erms
      1.53 ±  3%      -0.3        1.21 ±  2%  perf-profile.self.cycles-pp.find_get_entry
      1.18 ±  5%      -0.3        0.87 ±  8%  perf-profile.self.cycles-pp.selinux_file_permission
      2.19 ±  4%      -0.2        1.96 ±  3%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.83 ±  5%      -0.2        0.65 ±  5%  perf-profile.self.cycles-pp.iomap_apply
      1.31 ±  3%      -0.2        1.13 ±  7%  perf-profile.self.cycles-pp.___might_sleep
      0.60 ±  6%      -0.2        0.42 ± 10%  perf-profile.self.cycles-pp.security_file_permission
      0.77 ±  9%      -0.2        0.60 ±  5%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.81 ±  5%      -0.2        0.65 ±  6%  perf-profile.self.cycles-pp.xas_load
      0.84 ±  6%      -0.2        0.69 ±  9%  perf-profile.self.cycles-pp.xfs_file_iomap_begin
      0.72 ±  3%      -0.2        0.57 ±  4%  perf-profile.self.cycles-pp.write
      0.71 ±  4%      -0.1        0.56 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.49 ± 11%      -0.1        0.36 ± 11%  perf-profile.self.cycles-pp.xas_start
      0.76 ±  3%      -0.1        0.63 ±  7%  perf-profile.self.cycles-pp.down_write
      0.66 ±  8%      -0.1        0.54 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.72 ±  6%      -0.1        0.60 ±  4%  perf-profile.self.cycles-pp.up_write
      0.65            -0.1        0.53 ±  4%  perf-profile.self.cycles-pp.iomap_write_end
      0.60 ±  8%      -0.1        0.48 ±  8%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.58 ±  4%      -0.1        0.48 ± 10%  perf-profile.self.cycles-pp.vfs_write
      0.65 ±  3%      -0.1        0.55 ±  5%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.52 ±  8%      -0.1        0.42 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.41 ±  6%      -0.1        0.31 ± 11%  perf-profile.self.cycles-pp.iov_iter_advance
      0.28 ±  6%      -0.1        0.18 ± 11%  perf-profile.self.cycles-pp.generic_write_checks
      0.42 ±  3%      -0.1        0.32 ±  7%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.31 ±  9%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.50 ±  4%      -0.1        0.41 ±  7%  perf-profile.self.cycles-pp.disk_rw
      0.29 ±  5%      -0.1        0.20 ±  9%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.22 ± 11%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.34 ±  5%      -0.1        0.27 ±  8%  perf-profile.self.cycles-pp.unlock_page
      0.41 ±  8%      -0.1        0.33 ±  5%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.42 ± 13%      -0.1        0.34 ± 17%  perf-profile.self.cycles-pp.new_sync_write
      0.33 ±  7%      -0.1        0.25 ±  2%  perf-profile.self.cycles-pp.file_remove_privs
      0.36            -0.1        0.28 ±  7%  perf-profile.self.cycles-pp.lseek64
      0.30 ± 17%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.23 ±  9%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.22 ±  8%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.__fdget_pos
      0.33 ± 10%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.file_update_time
      0.17 ± 13%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.40 ±  3%      -0.1        0.34 ±  5%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.25 ± 10%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.xas_store
      0.43 ±  2%      -0.1        0.37 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
      0.22 ±  3%      -0.1        0.17 ± 12%  perf-profile.self.cycles-pp.current_time
      0.21 ±  8%      -0.1        0.16 ± 11%  perf-profile.self.cycles-pp.__x64_sys_lseek
      0.21 ± 10%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.release_pages
      0.28 ±  9%      -0.1        0.22        perf-profile.self.cycles-pp.rcu_all_qs
      0.37 ±  7%      -0.1        0.32 ± 10%  perf-profile.self.cycles-pp.__x64_sys_write
      0.35 ±  6%      -0.1        0.30 ±  3%  perf-profile.self.cycles-pp._cond_resched
      0.16 ±  5%      -0.0        0.11 ± 20%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.14 ±  5%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.account_page_cleaned
      0.07 ± 11%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.alloc_pages_current
      0.22 ±  3%      -0.0        0.17 ±  7%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.21 ± 13%      -0.0        0.16 ± 10%  perf-profile.self.cycles-pp.ksys_lseek
      0.37 ±  5%      -0.0        0.33 ±  6%  perf-profile.self.cycles-pp.ksys_write
      0.30 ±  4%      -0.0        0.26 ± 10%  perf-profile.self.cycles-pp.page_mapping
      0.18 ± 12%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.xfs_log_commit_cil
      0.14 ± 17%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.account_page_dirtied
      0.15 ± 10%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.find_get_entries
      0.17 ±  6%      -0.0        0.13 ± 10%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.11 ±  7%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.xfs_isilocked
      0.07 ± 14%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.09 ± 12%      -0.0        0.05 ± 60%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.09 ± 11%      -0.0        0.06 ± 58%  perf-profile.self.cycles-pp.__x86_indirect_thunk_r15
      0.17 ± 13%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.13 ± 11%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp.workingset_update_node
      0.14 ±  7%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.timespec64_trunc
      0.11 ±  9%      -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.10 ± 15%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.iomap_read_page_sync
      0.07 ± 12%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.10 ±  8%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.09 ±  8%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.09 ±  9%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.xfs_dir3_data_entsize
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.copyin
      0.00            +0.1        0.11 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.06 ± 58%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.ktime_get
      0.07 ±  5%      +0.1        0.19 ± 15%  perf-profile.self.cycles-pp.menu_select
      0.45 ±  5%      +0.1        0.57 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.04 ± 60%      +0.2        0.22 ± 72%  perf-profile.self.cycles-pp.xfs_inobt_get_maxrecs
      0.04 ± 58%      +0.2        0.29 ± 68%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.14 ± 36%      +0.3        0.41 ± 22%  perf-profile.self.cycles-pp.osq_lock
     16.78 ±  2%     +11.7       28.46 ±  2%  perf-profile.self.cycles-pp.intel_idle


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  160000 +-+----------------------------------------------------------------+   
  155000 +-+                +                                               |   
         |                  :                                    +          |   
  150000 +-+               ::                                    ::         |   
  145000 +-+               : :                                  : :         |   
         |                :  :    .+.                           :  :     .+.|   
  140000 +-+.+.++.+.+.+.+.+  +.+.+   +.+.+.++.+.+. .+.+.++.+. .+   +.++.+   |   
  135000 +-+                                      +          +              |   
  130000 +-+                                                                |   
         |                                                                  |   
  125000 +-+                                                                |   
  120000 +-+                                                                |   
         |                               O                                  |   
  115000 O-O O OO O O O O O OO O O O O O   O                                |   
  110000 +-+----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  165 +-+-------------------------------------------------------------------+   
  160 O-O O O O O O O O OO               O                                  |   
      |                    O O O O O O                                      |   
  155 +-+                              O                                    |   
  150 +-+                                                                   |   
      |                                                                     |   
  145 +-+                                                                   |   
  140 +-+                                                                   |   
  135 +-+                                                                   |   
      |.+. .+.+. .+.+.+.                    .+. .+.+.+.+.+.++.              |   
  130 +-+ +     +       +  +.+.+.+.+.+.+.+.+   +              +   +.+.+.+.+.|   
  125 +-+               :  :                                   : :          |   
      |                  ::                                    : :          |   
  120 +-+                ::                                     +           |   
  115 +-+-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  165 +-+-------------------------------------------------------------------+   
  160 O-O O O O O O O O OO               O                                  |   
      |                    O O O O O O                                      |   
  155 +-+                              O                                    |   
  150 +-+                                                                   |   
      |                                                                     |   
  145 +-+                                                                   |   
  140 +-+                                                                   |   
  135 +-+                                                                   |   
      |.+. .+.+. .+.+.+.                    .+. .+.+.+.+.+.++.              |   
  130 +-+ +     +       +  +.+.+.+.+.+.+.+.+   +              +   +.+.+.+.+.|   
  125 +-+               :  :                                   : :          |   
      |                  ::                                    : :          |   
  120 +-+                ::                                     +           |   
  115 +-+-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         aim7.time.voluntary_context_switches                   
                                                                                
   1.1e+06 +-+--------------------------------------------------------------+   
           |                                                                |   
  1.05e+06 +-+.++.+.+.+.++.+.+.+.++.+.+.+.+.++.+.+.+.++.+.+.+.++.+.+.+.++.+.|   
           |                                                                |   
     1e+06 +-+                                                              |   
           |                                                                |   
    950000 +-+                                                              |   
           |                                                                |   
    900000 +-+                                                              |   
           |                                                                |   
    850000 O-+           O   O      O                                       |   
           | O OO O O O O  O   O OO   O O   O                               |   
    800000 +-+                            O                                 |   
           |                                                                |   
    750000 +-+--------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-ivb-ep01: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
  gcc-7/performance/4BRD_12G/xfs/x86_64-rhel-7.6/3000/RAID0/debian-x86_64-2019-05-14.cgz/lkp-ivb-ep01/disk_cp/aim7

commit: 
  d515962b00 ("xfs: pass around xfs_inode_ag_walk iget/irele helper functions")
  1aabb011bf ("xfs: deferred inode inactivation")

d515962b00d64454 1aabb011bfba5a8942d3e0d0c84 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    204959           -35.7%     131770 ±  3%  aim7.jobs-per-min
     88.12           +55.7%     137.19 ±  3%  aim7.time.elapsed_time
     88.12           +55.7%     137.19 ±  3%  aim7.time.elapsed_time.max
     72330 ±  3%     +12.2%      81167 ±  4%  aim7.time.involuntary_context_switches
    151188            +6.4%     160846 ±  2%  aim7.time.minor_page_faults
      2437           +33.6%       3257 ±  3%  aim7.time.system_time
    305.87           +45.8%     446.05 ±  5%  aim7.time.user_time
    737855           -13.0%     642174 ±  3%  aim7.time.voluntary_context_switches
     22.63            +9.0       31.68        mpstat.cpu.all.idle%
     68.59            -8.5       60.06        mpstat.cpu.all.sys%
  61676265 ± 55%    +177.3%  1.711e+08 ± 18%  cpuidle.C1.time
    612540 ± 47%    +231.9%    2032764 ± 14%  cpuidle.C1.usage
 5.694e+08 ± 13%    +157.5%  1.466e+09 ±  6%  cpuidle.C6.time
    872994 ±  2%    +116.8%    1892610 ±  6%  cpuidle.C6.usage
     23.75 ±  3%     +34.7%      32.00 ±  2%  vmstat.cpu.id
     66.75           -11.6%      59.00        vmstat.cpu.sy
      1534 ± 26%     +87.2%       2873 ±  8%  vmstat.io.bo
     17277 ±  2%     -14.2%      14823        vmstat.system.cs
     24.17           +34.6%      32.54        iostat.cpu.idle
     67.23           -11.8%      59.31        iostat.cpu.system
      8.60            -5.2%       8.15        iostat.cpu.user
     46.02 ±  5%    +114.0%      98.46 ±  3%  iostat.md0.w/s
      1601 ± 25%     +86.8%       2991 ±  7%  iostat.md0.wkB/s
     81296 ±  2%     +47.8%     120146 ±  2%  meminfo.AnonHugePages
     16049 ±  7%     -14.2%      13766        meminfo.Dirty
     16741 ±  6%     -13.7%      14450 ±  2%  meminfo.Inactive(file)
     91250           +22.9%     112105        meminfo.KReclaimable
    109853 ±  5%      -7.0%     102116 ±  8%  meminfo.PageTables
     91250           +22.9%     112105        meminfo.SReclaimable
     36157 ±  2%     -12.9%      31489 ±  4%  meminfo.Shmem
    255575           +14.2%     291816        meminfo.Slab
     27539           -34.1%      18158 ±  4%  meminfo.max_used_kB
      2265           -45.2%       1241 ±  7%  turbostat.Avg_MHz
     77.95            -8.8       69.19        turbostat.Busy%
      2905           -38.3%       1793 ±  7%  turbostat.Bzy_MHz
    608401 ± 47%    +233.6%    2029542 ± 15%  turbostat.C1
      3.84 ± 73%      -3.2        0.68 ±  7%  turbostat.C3%
    868860 ±  2%    +117.3%    1888276 ±  6%  turbostat.C6
     15.87 ± 13%     +10.5       26.42 ±  2%  turbostat.C6%
     14.37 ±  8%     +46.5%      21.05        turbostat.CPU%c1
      6.78 ± 20%     +41.9%       9.62 ±  4%  turbostat.CPU%c6
    121.47           -44.3%      67.72 ±  8%  turbostat.CorWatt
   7419316           +52.0%   11279514 ±  4%  turbostat.IRQ
      3.43 ± 19%     -31.4%       2.35 ± 19%  turbostat.Pkg%pc2
     71.50            -4.0%      68.67        turbostat.PkgTmp
    148.87           -36.5%      94.53 ±  6%  turbostat.PkgWatt
     36.86            -5.5%      34.83        turbostat.RAMWatt
      7146           +55.8%      11133 ±  3%  turbostat.SMI
    623.50 ±105%    +220.2%       1996 ± 37%  numa-meminfo.node0.Active(file)
      8186 ±  3%     -17.1%       6789        numa-meminfo.node0.Dirty
     15459 ± 10%     -26.0%      11435 ±  5%  numa-meminfo.node0.Inactive
      7151 ± 19%     -41.4%       4190 ± 21%  numa-meminfo.node0.Inactive(anon)
      8307 ±  3%     -12.8%       7245 ±  4%  numa-meminfo.node0.Inactive(file)
   1057156 ± 15%     +30.0%    1374548 ±  4%  numa-meminfo.node0.MemUsed
     27710 ±145%    +258.8%      99419 ±  8%  numa-meminfo.node0.PageTables
     65500 ± 45%     +93.9%     126976        numa-meminfo.node0.SUnreclaim
    113557 ± 26%     +57.4%     178704 ±  6%  numa-meminfo.node0.Slab
      1849 ± 35%     -72.2%     513.33 ±141%  numa-meminfo.node1.Active(file)
      8087 ±  6%     -14.6%       6906        numa-meminfo.node1.Dirty
      8654 ±  9%     -17.9%       7105 ±  7%  numa-meminfo.node1.Inactive(file)
     43179 ± 16%     +39.7%      60339 ± 13%  numa-meminfo.node1.KReclaimable
     38009 ± 50%     -89.6%       3961 ±  9%  numa-meminfo.node1.KernelStack
   1284978 ± 12%     -21.8%    1004429 ±  4%  numa-meminfo.node1.MemUsed
     81947 ± 54%     -96.7%       2695        numa-meminfo.node1.PageTables
     43179 ± 16%     +39.7%      60339 ± 13%  numa-meminfo.node1.SReclaimable
    156.25 ±105%    +218.3%     497.33 ± 37%  numa-vmstat.node0.nr_active_file
  16205972 ±  2%     +14.6%   18577156        numa-vmstat.node0.nr_dirtied
      2062 ±  3%     -17.9%       1694 ±  3%  numa-vmstat.node0.nr_dirty
      1788 ± 19%     -41.2%       1051 ± 21%  numa-vmstat.node0.nr_inactive_anon
      2090 ±  7%     -13.2%       1814 ±  4%  numa-vmstat.node0.nr_inactive_file
      6975 ±145%    +255.1%      24766 ±  8%  numa-vmstat.node0.nr_page_table_pages
     16397 ± 45%     +93.3%      31699        numa-vmstat.node0.nr_slab_unreclaimable
    156.25 ±105%    +218.3%     497.33 ± 37%  numa-vmstat.node0.nr_zone_active_file
      1788 ± 19%     -41.2%       1051 ± 21%  numa-vmstat.node0.nr_zone_inactive_anon
      2093 ±  7%     -13.2%       1816 ±  4%  numa-vmstat.node0.nr_zone_inactive_file
  16642980 ±  3%     +14.9%   19130375        numa-vmstat.node0.numa_hit
  16605490 ±  2%     +14.9%   19079593        numa-vmstat.node0.numa_local
    461.25 ± 35%     -72.2%     128.33 ±141%  numa-vmstat.node1.nr_active_file
      2046           -15.2%       1735        numa-vmstat.node1.nr_dirty
      2184 ±  5%     -18.2%       1786 ±  6%  numa-vmstat.node1.nr_inactive_file
     37823 ± 50%     -89.5%       3960 ±  9%  numa-vmstat.node1.nr_kernel_stack
     20375 ± 54%     -96.7%     672.67        numa-vmstat.node1.nr_page_table_pages
     10793 ± 16%     +39.7%      15083 ± 13%  numa-vmstat.node1.nr_slab_reclaimable
    461.25 ± 35%     -72.2%     128.33 ±141%  numa-vmstat.node1.nr_zone_active_file
      2183 ±  5%     -18.3%       1785 ±  6%  numa-vmstat.node1.nr_zone_inactive_file
     91478            -2.1%      89547        proc-vmstat.nr_active_anon
    617.75            +1.5%     627.00        proc-vmstat.nr_active_file
      4045 ±  2%     -15.8%       3405        proc-vmstat.nr_dirty
      5069            -3.6%       4888        proc-vmstat.nr_inactive_anon
      4217 ±  2%     -15.4%       3567        proc-vmstat.nr_inactive_file
     53612            -1.9%      52592        proc-vmstat.nr_kernel_stack
      6369            -3.5%       6149        proc-vmstat.nr_mapped
      9055 ±  2%     -13.1%       7871 ±  4%  proc-vmstat.nr_shmem
     22808           +22.8%      28015        proc-vmstat.nr_slab_reclaimable
     41043            +9.4%      44903        proc-vmstat.nr_slab_unreclaimable
     91478            -2.1%      89547        proc-vmstat.nr_zone_active_anon
    617.75            +1.5%     627.00        proc-vmstat.nr_zone_active_file
      5069            -3.6%       4888        proc-vmstat.nr_zone_inactive_anon
      4217 ±  2%     -15.4%       3567        proc-vmstat.nr_zone_inactive_file
      3453 ±  2%      -8.4%       3163        proc-vmstat.nr_zone_write_pending
      1737 ±142%    +716.8%      14190 ±  3%  proc-vmstat.numa_hint_faults
      2731 ±113%    +389.5%      13370 ±  3%  proc-vmstat.numa_pages_migrated
      4460 ±  7%     -39.5%       2697 ± 14%  proc-vmstat.pgactivate
    402077           +31.0%     526544 ±  2%  proc-vmstat.pgfault
      2731 ±113%    +389.5%      13370 ±  3%  proc-vmstat.pgmigrate_success
    139264 ± 25%    +188.9%     402269 ± 12%  proc-vmstat.pgpgout
      2856          +360.5%      13152 ±  3%  slabinfo.dmaengine-unmap-16.active_objs
     77.75          +589.0%     535.67 ±  3%  slabinfo.dmaengine-unmap-16.active_slabs
      3292          +584.1%      22520 ±  3%  slabinfo.dmaengine-unmap-16.num_objs
     77.75          +589.0%     535.67 ±  3%  slabinfo.dmaengine-unmap-16.num_slabs
      2332 ±  7%     +39.7%       3257        slabinfo.kmalloc-128.active_objs
      2332 ±  7%     +39.7%       3257        slabinfo.kmalloc-128.num_objs
     19136          +126.1%      43271 ±  3%  slabinfo.kmalloc-16.active_objs
     74.75          +139.5%     179.00 ±  3%  slabinfo.kmalloc-16.active_slabs
     19136          +140.5%      46024 ±  3%  slabinfo.kmalloc-16.num_objs
     74.75          +139.5%     179.00 ±  3%  slabinfo.kmalloc-16.num_slabs
    741.00           +24.5%     922.67 ±  2%  slabinfo.kmalloc-4k.active_objs
    751.25           +24.4%     934.67 ±  2%  slabinfo.kmalloc-4k.num_objs
      6130          +175.2%      16869 ±  2%  slabinfo.kmalloc-512.active_objs
    202.00          +207.8%     621.67 ±  2%  slabinfo.kmalloc-512.active_slabs
      6484          +207.0%      19906 ±  2%  slabinfo.kmalloc-512.num_objs
    202.00          +207.8%     621.67 ±  2%  slabinfo.kmalloc-512.num_slabs
    461.50 ±  2%     +43.6%     662.67        slabinfo.kmalloc-8k.active_objs
    476.25 ±  2%     +54.5%     735.67        slabinfo.kmalloc-8k.num_objs
      1160           +72.2%       1998 ±  2%  slabinfo.xfs_buf_item.active_objs
      1160           +72.2%       1998 ±  2%  slabinfo.xfs_buf_item.num_objs
      1186           +64.4%       1950        slabinfo.xfs_efd_item.active_objs
      1186           +64.4%       1950        slabinfo.xfs_efd_item.num_objs
      2168          +487.1%      12729 ±  3%  slabinfo.xfs_inode.active_objs
     87.50          +676.8%     679.67 ±  4%  slabinfo.xfs_inode.active_slabs
      2819          +671.9%      21761 ±  4%  slabinfo.xfs_inode.num_objs
     87.50          +676.8%     679.67 ±  4%  slabinfo.xfs_inode.num_slabs
     13.63 ±  4%      -8.1%      12.53        perf-stat.i.MPKI
  4.74e+09           -32.0%  3.224e+09 ±  4%  perf-stat.i.branch-instructions
  59710263           -29.8%   41920989 ±  3%  perf-stat.i.branch-misses
  24239162 ±  2%     -29.6%   17056459 ±  6%  perf-stat.i.cache-misses
 2.448e+08           -32.9%  1.644e+08 ±  4%  perf-stat.i.cache-references
     17563 ±  2%     -14.8%      14962        perf-stat.i.context-switches
      3.90 ±  2%     -22.0%       3.04 ±  3%  perf-stat.i.cpi
 9.031e+10           -45.5%  4.926e+10 ±  8%  perf-stat.i.cpu-cycles
      3006           -59.5%       1218 ±  2%  perf-stat.i.cpu-migrations
      3432           -23.3%       2633        perf-stat.i.cycles-between-cache-misses
      1.64 ± 12%      -0.4        1.25 ±  2%  perf-stat.i.dTLB-load-miss-rate%
 1.328e+08 ± 13%     -50.8%   65422884 ±  5%  perf-stat.i.dTLB-load-misses
 7.404e+09           -31.8%  5.052e+09 ±  4%  perf-stat.i.dTLB-loads
  16794433 ±  5%     -37.4%   10521517 ±  3%  perf-stat.i.dTLB-store-misses
 4.914e+09           -32.9%    3.3e+09 ±  4%  perf-stat.i.dTLB-stores
     87.61            -3.8       83.84        perf-stat.i.iTLB-load-miss-rate%
   7267620           -33.6%    4828701 ±  2%  perf-stat.i.iTLB-load-misses
 2.391e+10           -31.8%   1.63e+10 ±  4%  perf-stat.i.instructions
      0.28 ±  2%     +28.8%       0.36 ±  2%  perf-stat.i.ipc
      4279           -14.3%       3669        perf-stat.i.minor-faults
     45.88            +0.6       46.48        perf-stat.i.node-load-miss-rate%
  13857418 ±  2%     -33.2%    9253829 ±  7%  perf-stat.i.node-load-misses
  15830808 ±  2%     -33.8%   10483641 ±  7%  perf-stat.i.node-loads
   5925929           -28.2%    4252744 ±  5%  perf-stat.i.node-store-misses
   7451625           -27.1%    5432276 ±  5%  perf-stat.i.node-stores
      4279           -14.3%       3669        perf-stat.i.page-faults
      1.26            +0.0        1.30        perf-stat.overall.branch-miss-rate%
      9.90            +0.5       10.37 ±  2%  perf-stat.overall.cache-miss-rate%
      3.78           -20.1%       3.02 ±  3%  perf-stat.overall.cpi
      3726           -22.6%       2884        perf-stat.overall.cycles-between-cache-misses
      1.76 ± 12%      -0.5        1.28 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.34 ±  5%      -0.0        0.32        perf-stat.overall.dTLB-store-miss-rate%
     87.44            -3.8       83.60        perf-stat.overall.iTLB-load-miss-rate%
      3290            +2.6%       3374        perf-stat.overall.instructions-per-iTLB-miss
      0.26           +25.4%       0.33 ±  3%  perf-stat.overall.ipc
 4.685e+09           -31.7%  3.199e+09 ±  4%  perf-stat.ps.branch-instructions
  59020206           -29.5%   41606551 ±  3%  perf-stat.ps.branch-misses
  23958401 ±  2%     -29.3%   16929391 ±  6%  perf-stat.ps.cache-misses
  2.42e+08           -32.6%  1.631e+08 ±  4%  perf-stat.ps.cache-references
     17359 ±  2%     -14.5%      14848        perf-stat.ps.context-switches
 8.926e+10           -45.2%   4.89e+10 ±  8%  perf-stat.ps.cpu-cycles
      2971           -59.3%       1208 ±  2%  perf-stat.ps.cpu-migrations
 1.313e+08 ± 13%     -50.5%   64933807 ±  5%  perf-stat.ps.dTLB-load-misses
 7.318e+09           -31.5%  5.014e+09 ±  4%  perf-stat.ps.dTLB-loads
  16598516 ±  5%     -37.1%   10442914 ±  3%  perf-stat.ps.dTLB-store-misses
 4.857e+09           -32.6%  3.275e+09 ±  4%  perf-stat.ps.dTLB-stores
   7182997           -33.3%    4792440 ±  2%  perf-stat.ps.iTLB-load-misses
 2.363e+10           -31.5%  1.618e+10 ±  4%  perf-stat.ps.instructions
      4233           -14.0%       3642        perf-stat.ps.minor-faults
  13695799 ±  2%     -32.9%    9184667 ±  7%  perf-stat.ps.node-load-misses
  15646175 ±  2%     -33.5%   10405160 ±  7%  perf-stat.ps.node-loads
   5856803           -27.9%    4221222 ±  5%  perf-stat.ps.node-store-misses
   7364898           -26.8%    5392052 ±  5%  perf-stat.ps.node-stores
      4233           -14.0%       3642        perf-stat.ps.page-faults
 2.091e+12            +6.2%  2.221e+12        perf-stat.total.instructions
     21578           +80.2%      38887        sched_debug.cfs_rq:/.exec_clock.avg
     23353           +75.3%      40945 ±  2%  sched_debug.cfs_rq:/.exec_clock.max
     21322           +79.5%      38269        sched_debug.cfs_rq:/.exec_clock.min
    304.37 ±  8%     +41.5%     430.55 ± 25%  sched_debug.cfs_rq:/.exec_clock.stddev
    632.50 ± 12%     +29.7%     820.11 ± 12%  sched_debug.cfs_rq:/.load_avg.max
    780200           +60.8%    1254863        sched_debug.cfs_rq:/.min_vruntime.avg
    872093           +58.1%    1378898 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
    762295           +57.2%    1198056        sched_debug.cfs_rq:/.min_vruntime.min
     17394 ±  5%     +57.7%      27431 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.40 ±  5%     +15.0%       0.46 ±  8%  sched_debug.cfs_rq:/.nr_running.stddev
      0.13 ± 38%    +111.6%       0.28 ± 18%  sched_debug.cfs_rq:/.nr_spread_over.avg
      0.31 ± 29%     +63.8%       0.50 ± 13%  sched_debug.cfs_rq:/.nr_spread_over.stddev
     -1508          -590.1%       7393 ± 78%  sched_debug.cfs_rq:/.spread0.avg
    -19404          +154.1%     -49302        sched_debug.cfs_rq:/.spread0.min
     17422 ±  5%     +57.4%      27431 ± 14%  sched_debug.cfs_rq:/.spread0.stddev
    777.17           -15.3%     658.55 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
      1497 ±  8%     -16.1%       1256 ± 15%  sched_debug.cfs_rq:/.util_avg.max
    123.49 ± 11%     -31.9%      84.04 ± 20%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    473039 ±  7%     +37.9%     652433 ±  2%  sched_debug.cpu.avg_idle.avg
    236058 ± 12%     -18.6%     192130 ±  4%  sched_debug.cpu.avg_idle.stddev
     71615           +43.2%     102524        sched_debug.cpu.clock.avg
     71626           +43.2%     102548        sched_debug.cpu.clock.max
     71600           +43.2%     102498        sched_debug.cpu.clock.min
      7.20 ± 22%    +102.5%      14.59 ± 12%  sched_debug.cpu.clock.stddev
     71615           +43.2%     102524        sched_debug.cpu.clock_task.avg
     71626           +43.2%     102548        sched_debug.cpu.clock_task.max
     71600           +43.2%     102498        sched_debug.cpu.clock_task.min
      7.20 ± 22%    +102.5%      14.59 ± 12%  sched_debug.cpu.clock_task.stddev
      1820 ± 11%     -18.6%       1482 ± 14%  sched_debug.cpu.curr->pid.avg
      3837 ±  8%     +37.7%       5283        sched_debug.cpu.curr->pid.max
      0.00 ±  3%     +32.7%       0.00 ± 15%  sched_debug.cpu.next_balance.stddev
      0.42 ±  8%     +17.3%       0.49 ±  4%  sched_debug.cpu.nr_running.stddev
     14410 ±  2%     +63.7%      23596        sched_debug.cpu.nr_switches.avg
     20732          +148.7%      51565 ±  9%  sched_debug.cpu.nr_switches.max
     12235           +29.2%      15807 ±  2%  sched_debug.cpu.nr_switches.min
      1916 ±  5%    +373.8%       9082 ±  8%  sched_debug.cpu.nr_switches.stddev
     37.10           +17.6%      43.62 ±  4%  sched_debug.cpu.nr_uninterruptible.avg
    -42.25           -35.6%     -27.22        sched_debug.cpu.nr_uninterruptible.min
     12279 ±  2%     +74.6%      21437        sched_debug.cpu.sched_count.avg
     14279 ±  2%    +231.0%      47258 ± 10%  sched_debug.cpu.sched_count.max
     11249 ±  2%     +31.0%      14739        sched_debug.cpu.sched_count.min
    621.89 ± 12%   +1268.2%       8508 ± 10%  sched_debug.cpu.sched_count.stddev
      5282 ±  3%     +80.1%       9514        sched_debug.cpu.sched_goidle.avg
      6253 ±  2%    +253.4%      22097 ± 10%  sched_debug.cpu.sched_goidle.max
      4834 ±  2%     +32.4%       6403        sched_debug.cpu.sched_goidle.min
    301.81 ± 13%   +1275.2%       4150 ± 10%  sched_debug.cpu.sched_goidle.stddev
      6298 ±  2%     +69.2%      10658        sched_debug.cpu.ttwu_count.avg
      7777          +200.5%      23368 ± 10%  sched_debug.cpu.ttwu_count.max
      5825 ±  3%     +23.6%       7199        sched_debug.cpu.ttwu_count.min
    379.64 ±  7%   +1010.1%       4214 ± 11%  sched_debug.cpu.ttwu_count.stddev
    526.01           +69.8%     893.13 ±  2%  sched_debug.cpu.ttwu_local.avg
    773.75 ±  8%    +125.6%       1745 ±  9%  sched_debug.cpu.ttwu_local.max
    424.12           +40.9%     597.78 ±  3%  sched_debug.cpu.ttwu_local.min
     68.72 ± 10%    +219.5%     219.59 ± 10%  sched_debug.cpu.ttwu_local.stddev
     71601           +43.1%     102497        sched_debug.cpu_clk
     68011           +45.4%      98899        sched_debug.ktime
     71961           +42.9%     102856        sched_debug.sched_clk
     13240 ±  4%     +36.2%      18033 ±  3%  softirqs.CPU0.RCU
     12004 ±  3%     +24.9%      14997 ±  3%  softirqs.CPU0.SCHED
     35478 ±  3%     +57.3%      55794        softirqs.CPU0.TIMER
      9817 ±  7%     +18.1%      11592 ±  7%  softirqs.CPU1.SCHED
     38872 ±  3%     +42.3%      55318        softirqs.CPU1.TIMER
     13094 ±  5%     +33.8%      17518 ±  5%  softirqs.CPU10.RCU
      8546 ±  8%     +35.4%      11568 ±  6%  softirqs.CPU10.SCHED
     33896 ±  3%     +59.6%      54082 ±  2%  softirqs.CPU10.TIMER
     12959 ±  4%     +33.4%      17288 ±  4%  softirqs.CPU11.RCU
      8569           +32.8%      11380 ±  4%  softirqs.CPU11.SCHED
     34467 ±  2%     +56.0%      53759        softirqs.CPU11.TIMER
     14180 ± 12%     +52.6%      21643 ±  4%  softirqs.CPU12.RCU
      8429 ±  3%     +36.6%      11515 ±  6%  softirqs.CPU12.SCHED
     36338 ±  7%     +59.4%      57933 ±  6%  softirqs.CPU12.TIMER
     13213 ±  5%     +33.5%      17641 ±  5%  softirqs.CPU13.RCU
      8630           +33.2%      11498 ±  4%  softirqs.CPU13.SCHED
     38830 ± 17%     +40.0%      54352        softirqs.CPU13.TIMER
     12844           +39.2%      17877 ±  3%  softirqs.CPU14.RCU
      8556           +37.5%      11765 ±  4%  softirqs.CPU14.SCHED
     39110 ± 16%     +38.8%      54296 ±  3%  softirqs.CPU14.TIMER
     13167 ±  4%     +35.0%      17771 ±  3%  softirqs.CPU15.RCU
      8742           +29.3%      11303 ±  4%  softirqs.CPU15.SCHED
     35002 ±  2%     +53.5%      53737        softirqs.CPU15.TIMER
     13022           +35.7%      17668 ±  5%  softirqs.CPU16.RCU
      8456 ±  2%     +37.4%      11616 ±  3%  softirqs.CPU16.SCHED
     35793 ±  3%     +52.5%      54602 ±  2%  softirqs.CPU16.TIMER
     13010 ±  2%     +36.1%      17702 ± 10%  softirqs.CPU17.RCU
      8813 ±  4%     +26.7%      11168 ±  3%  softirqs.CPU17.SCHED
     35279           +53.4%      54103        softirqs.CPU17.TIMER
      8652 ±  2%     +29.9%      11243        softirqs.CPU18.SCHED
     35157 ±  4%     +55.9%      54825 ±  5%  softirqs.CPU18.TIMER
     13004           +44.6%      18807 ± 12%  softirqs.CPU19.RCU
      8658           +28.9%      11159 ±  2%  softirqs.CPU19.SCHED
     34629           +55.5%      53864        softirqs.CPU19.TIMER
      8765 ±  7%     +35.4%      11871 ±  3%  softirqs.CPU2.SCHED
     35122 ±  6%     +53.9%      54041 ±  2%  softirqs.CPU2.TIMER
     12585           +54.3%      19421 ± 14%  softirqs.CPU20.RCU
      8327 ±  2%     +40.1%      11666        softirqs.CPU20.SCHED
     33760 ±  2%     +59.5%      53863 ±  2%  softirqs.CPU20.TIMER
     12746 ±  2%     +45.1%      18498 ± 10%  softirqs.CPU21.RCU
      8471 ±  4%     +41.3%      11968 ±  4%  softirqs.CPU21.SCHED
     35143 ±  2%     +73.9%      61115 ±  7%  softirqs.CPU21.TIMER
     13098           +34.9%      17671 ±  4%  softirqs.CPU22.RCU
      8566           +30.3%      11165 ±  6%  softirqs.CPU22.SCHED
     34415 ±  2%     +60.1%      55110        softirqs.CPU22.TIMER
     13351 ±  5%     +31.5%      17556 ±  5%  softirqs.CPU23.RCU
      9174 ±  8%     +26.7%      11622 ±  6%  softirqs.CPU23.SCHED
     37855 ± 13%     +54.2%      58371 ±  4%  softirqs.CPU23.TIMER
     13334 ±  4%     +35.3%      18035 ±  9%  softirqs.CPU24.RCU
      9011 ±  9%     +28.1%      11546 ± 11%  softirqs.CPU24.SCHED
     35153 ±  5%     +56.0%      54856        softirqs.CPU24.TIMER
     13056           +35.1%      17633 ±  5%  softirqs.CPU25.RCU
      8668           +31.9%      11435 ±  6%  softirqs.CPU25.SCHED
     34832 ±  2%     +56.5%      54499        softirqs.CPU25.TIMER
     13612 ±  6%     +31.1%      17846 ±  4%  softirqs.CPU26.RCU
      8564           +33.0%      11392 ±  5%  softirqs.CPU26.SCHED
     34752 ±  3%     +67.9%      58356 ±  9%  softirqs.CPU26.TIMER
     13063           +38.7%      18123 ±  5%  softirqs.CPU27.RCU
      8692           +24.6%      10831 ±  4%  softirqs.CPU27.SCHED
     34964 ±  2%     +57.0%      54889        softirqs.CPU27.TIMER
     12612           +37.8%      17376 ±  4%  softirqs.CPU28.RCU
      8625 ±  2%     +34.5%      11605 ±  7%  softirqs.CPU28.SCHED
     34376 ±  3%     +59.0%      54672        softirqs.CPU28.TIMER
     12943 ±  4%     +33.9%      17333 ±  6%  softirqs.CPU29.RCU
      8678 ±  2%     +28.6%      11158 ±  5%  softirqs.CPU29.SCHED
     36977 ± 14%     +47.1%      54377        softirqs.CPU29.TIMER
     12972           +42.8%      18526 ± 14%  softirqs.CPU3.RCU
      9119 ±  5%     +25.9%      11481 ±  6%  softirqs.CPU3.SCHED
     35879           +75.6%      63012 ± 17%  softirqs.CPU3.TIMER
     12581           +39.8%      17591 ±  5%  softirqs.CPU30.RCU
      8255           +31.4%      10844 ±  7%  softirqs.CPU30.SCHED
     33406 ±  3%     +58.7%      53003 ±  3%  softirqs.CPU30.TIMER
     13201 ±  5%     +32.6%      17503 ±  5%  softirqs.CPU31.RCU
      8582           +30.9%      11232 ±  5%  softirqs.CPU31.SCHED
     34045           +57.9%      53746        softirqs.CPU31.TIMER
     10821 ±  8%     +37.8%      14913        softirqs.CPU32.RCU
      8508 ±  3%     +37.7%      11712 ±  4%  softirqs.CPU32.SCHED
     34901 ±  3%     +59.6%      55704 ±  3%  softirqs.CPU32.TIMER
     10359           +34.3%      13912 ±  5%  softirqs.CPU33.RCU
      8624           +29.3%      11149 ±  3%  softirqs.CPU33.SCHED
     35940 ±  5%     +51.3%      54362 ±  2%  softirqs.CPU33.TIMER
     10512 ±  2%     +36.5%      14346 ±  6%  softirqs.CPU34.RCU
      8604           +28.7%      11077 ±  3%  softirqs.CPU34.SCHED
     34636 ±  2%     +53.5%      53154 ±  3%  softirqs.CPU34.TIMER
     10444 ±  2%     +35.0%      14100 ±  7%  softirqs.CPU35.RCU
      8547           +27.7%      10915 ±  5%  softirqs.CPU35.SCHED
     34476           +55.8%      53719        softirqs.CPU35.TIMER
     10196 ±  2%     +44.4%      14724 ±  4%  softirqs.CPU36.RCU
      8427 ±  2%     +34.3%      11321 ±  3%  softirqs.CPU36.SCHED
     34764 ±  2%     +56.2%      54288 ±  3%  softirqs.CPU36.TIMER
     10273 ±  2%     +33.6%      13728 ±  5%  softirqs.CPU37.RCU
      8527 ±  2%     +27.6%      10885 ±  3%  softirqs.CPU37.SCHED
     34727           +54.0%      53489        softirqs.CPU37.TIMER
     10103 ±  2%     +44.2%      14571 ±  2%  softirqs.CPU38.RCU
      8356 ±  2%     +37.1%      11454 ±  4%  softirqs.CPU38.SCHED
     35884 ±  9%     +68.3%      60394 ± 12%  softirqs.CPU38.TIMER
     10341 ±  3%     +32.3%      13681 ±  5%  softirqs.CPU39.RCU
      8556           +27.0%      10868 ±  6%  softirqs.CPU39.SCHED
     34267           +56.6%      53654        softirqs.CPU39.TIMER
     13012           +35.5%      17627 ±  5%  softirqs.CPU4.RCU
      8735 ±  2%     +27.5%      11142 ±  5%  softirqs.CPU4.SCHED
     38127 ± 18%     +44.2%      54976        softirqs.CPU4.TIMER
     12911           +35.8%      17529 ±  4%  softirqs.CPU5.RCU
      8699           +38.2%      12025 ± 13%  softirqs.CPU5.SCHED
     34819 ±  2%     +61.8%      56335 ±  2%  softirqs.CPU5.TIMER
     12740 ±  2%     +35.8%      17297 ±  5%  softirqs.CPU6.RCU
      8761 ±  2%     +27.0%      11124 ±  4%  softirqs.CPU6.SCHED
     35057 ±  3%     +74.8%      61271 ± 16%  softirqs.CPU6.TIMER
     12939           +36.1%      17608 ±  7%  softirqs.CPU7.RCU
      8556 ±  2%     +28.7%      11015 ±  4%  softirqs.CPU7.SCHED
     35488 ±  4%     +54.8%      54918        softirqs.CPU7.TIMER
     12719 ±  2%     +37.1%      17432 ±  2%  softirqs.CPU8.RCU
      8648           +32.3%      11438 ±  6%  softirqs.CPU8.SCHED
     34507 ±  2%     +58.6%      54712        softirqs.CPU8.TIMER
     12769 ±  3%     +35.1%      17249 ±  7%  softirqs.CPU9.RCU
      8597 ±  3%     +33.3%      11461 ±  2%  softirqs.CPU9.SCHED
     38857 ± 19%     +40.5%      54604        softirqs.CPU9.TIMER
    503590           +36.6%     688115 ±  4%  softirqs.RCU
    349541           +31.1%     458229 ±  4%  softirqs.SCHED
   1420004           +56.1%    2216175        softirqs.TIMER
     77.00 ± 51%   +3025.1%       2406 ±130%  interrupts.40:IR-PCI-MSI.524290-edge.eth0-TxRx-1
     77.00 ± 39%     +71.4%     132.00 ± 30%  interrupts.43:IR-PCI-MSI.524293-edge.eth0-TxRx-4
     54.75 ±  8%     +64.4%      90.00 ± 21%  interrupts.46:IR-PCI-MSI.524296-edge.eth0-TxRx-7
     38565           +40.0%      54002 ±  4%  interrupts.CAL:Function_call_interrupts
    983.50 ±  4%     +36.0%       1338 ±  8%  interrupts.CPU0.CAL:Function_call_interrupts
    177382           +55.8%     276400 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
      4852 ± 66%     -87.6%     601.33 ±141%  interrupts.CPU0.NMI:Non-maskable_interrupts
      4852 ± 66%     -87.6%     601.33 ±141%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    177458           +55.6%     276134 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
      2399 ± 34%     -39.3%       1456 ±  8%  interrupts.CPU1.RES:Rescheduling_interrupts
      1007           +38.4%       1394 ±  7%  interrupts.CPU10.CAL:Function_call_interrupts
    175614 ±  2%     +57.4%     276332 ±  4%  interrupts.CPU10.LOC:Local_timer_interrupts
      4849 ± 33%     -54.8%       2193 ± 27%  interrupts.CPU10.NMI:Non-maskable_interrupts
      4849 ± 33%     -54.8%       2193 ± 27%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      2487 ± 31%     -33.4%       1655 ± 15%  interrupts.CPU10.RES:Rescheduling_interrupts
      1005 ±  2%     +33.0%       1337 ±  3%  interrupts.CPU11.CAL:Function_call_interrupts
    177053           +56.1%     276460 ±  3%  interrupts.CPU11.LOC:Local_timer_interrupts
      3695 ±  9%     -52.1%       1768 ±  4%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3695 ±  9%     -52.1%       1768 ±  4%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    972.00 ±  5%     +41.8%       1378 ±  2%  interrupts.CPU12.CAL:Function_call_interrupts
    175821 ±  2%     +57.2%     276353 ±  4%  interrupts.CPU12.LOC:Local_timer_interrupts
      1947 ±  5%     -23.8%       1483 ± 16%  interrupts.CPU12.RES:Rescheduling_interrupts
    922.25 ±  6%     +42.0%       1309        interrupts.CPU13.CAL:Function_call_interrupts
    176892           +55.9%     275829 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
    979.25 ±  5%     +31.0%       1282 ±  4%  interrupts.CPU14.CAL:Function_call_interrupts
    176168 ±  2%     +56.8%     276178 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
    955.75 ±  3%     +40.3%       1341 ±  6%  interrupts.CPU15.CAL:Function_call_interrupts
    176793 ±  2%     +56.1%     276062 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
      1858 ±  4%     -19.4%       1497 ± 13%  interrupts.CPU15.RES:Rescheduling_interrupts
    969.50 ±  3%     +35.7%       1315 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
    176054 ±  2%     +56.8%     276087 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
      1927 ±  5%     -24.2%       1461 ±  8%  interrupts.CPU16.RES:Rescheduling_interrupts
    937.25 ±  2%     +39.8%       1310 ±  9%  interrupts.CPU17.CAL:Function_call_interrupts
    176586 ±  2%     +55.6%     274709 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
    972.00 ±  4%     +41.1%       1371 ±  9%  interrupts.CPU18.CAL:Function_call_interrupts
    175927 ±  2%     +56.9%     275969 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
      2285 ± 18%     -42.0%       1325 ±  7%  interrupts.CPU18.RES:Rescheduling_interrupts
    958.25 ±  4%     +37.9%       1321 ±  6%  interrupts.CPU19.CAL:Function_call_interrupts
    176354 ±  2%     +56.0%     275068 ±  4%  interrupts.CPU19.LOC:Local_timer_interrupts
      1007 ±  4%     +34.8%       1357 ± 11%  interrupts.CPU2.CAL:Function_call_interrupts
    176971           +56.1%     276231 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
    948.00 ±  5%     +46.7%       1390 ±  6%  interrupts.CPU20.CAL:Function_call_interrupts
    176878           +56.1%     276171 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
    970.25 ±  4%     +33.5%       1295 ±  3%  interrupts.CPU21.CAL:Function_call_interrupts
    177571           +55.5%     276093 ±  4%  interrupts.CPU21.LOC:Local_timer_interrupts
      1893           -34.6%       1237 ±  6%  interrupts.CPU21.RES:Rescheduling_interrupts
    963.50 ±  2%     +34.6%       1296 ±  2%  interrupts.CPU22.CAL:Function_call_interrupts
    176684           +56.3%     276201 ±  3%  interrupts.CPU22.LOC:Local_timer_interrupts
      1975 ±  2%     -35.7%       1270 ± 12%  interrupts.CPU22.RES:Rescheduling_interrupts
    949.50 ±  3%     +32.7%       1260 ±  2%  interrupts.CPU23.CAL:Function_call_interrupts
    177742           +55.1%     275624 ±  3%  interrupts.CPU23.LOC:Local_timer_interrupts
      1937 ±  4%     -34.9%       1261 ±  9%  interrupts.CPU23.RES:Rescheduling_interrupts
    968.75 ±  5%     +41.5%       1370 ±  7%  interrupts.CPU24.CAL:Function_call_interrupts
    176809           +56.1%     275962 ±  3%  interrupts.CPU24.LOC:Local_timer_interrupts
      1893           -30.5%       1316 ± 14%  interrupts.CPU24.RES:Rescheduling_interrupts
    949.00 ±  2%     +41.6%       1344 ±  4%  interrupts.CPU25.CAL:Function_call_interrupts
    177584           +55.4%     275974 ±  4%  interrupts.CPU25.LOC:Local_timer_interrupts
    922.50 ±  9%     +43.9%       1327 ±  4%  interrupts.CPU26.CAL:Function_call_interrupts
    177144           +55.9%     276093 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
      4881 ± 35%     -76.1%       1165 ±141%  interrupts.CPU26.NMI:Non-maskable_interrupts
      4881 ± 35%     -76.1%       1165 ±141%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    961.75 ±  5%     +32.1%       1270 ±  7%  interrupts.CPU27.CAL:Function_call_interrupts
    177543           +55.6%     276207 ±  4%  interrupts.CPU27.LOC:Local_timer_interrupts
      1920           -39.2%       1167 ±  7%  interrupts.CPU27.RES:Rescheduling_interrupts
    948.25 ±  3%     +43.4%       1359 ± 10%  interrupts.CPU28.CAL:Function_call_interrupts
    176358 ±  2%     +56.6%     276170 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
    926.25 ±  2%     +52.0%       1408 ±  3%  interrupts.CPU29.CAL:Function_call_interrupts
    177193           +56.0%     276457 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
      1014 ±112%    +163.8%       2677 ± 24%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1014 ±112%    +163.8%       2677 ± 24%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      1927 ±  2%     -30.8%       1334 ±  9%  interrupts.CPU29.RES:Rescheduling_interrupts
    983.25 ±  4%     +43.7%       1413        interrupts.CPU3.CAL:Function_call_interrupts
    177682           +55.6%     276520 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
      1974 ±  2%     -27.2%       1436 ±  9%  interrupts.CPU3.RES:Rescheduling_interrupts
    924.75 ±  2%     +54.0%       1424 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
    176131 ±  2%     +56.7%     276051 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
      1888 ±  3%     -35.4%       1221        interrupts.CPU30.RES:Rescheduling_interrupts
    960.50 ±  4%     +42.4%       1367 ±  6%  interrupts.CPU31.CAL:Function_call_interrupts
    177002           +56.1%     276368 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
      1939           -29.2%       1373 ± 14%  interrupts.CPU31.RES:Rescheduling_interrupts
     77.00 ± 51%   +3025.1%       2406 ±130%  interrupts.CPU32.40:IR-PCI-MSI.524290-edge.eth0-TxRx-1
    914.25 ± 14%     +51.8%       1388 ±  8%  interrupts.CPU32.CAL:Function_call_interrupts
    176087 ±  2%     +56.7%     276010 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
      1947 ±  2%     -27.7%       1407 ± 11%  interrupts.CPU32.RES:Rescheduling_interrupts
    994.25 ±  3%     +39.9%       1390 ±  5%  interrupts.CPU33.CAL:Function_call_interrupts
    176835           +56.1%     276100 ±  3%  interrupts.CPU33.LOC:Local_timer_interrupts
      1923 ±  2%     -32.0%       1308 ± 15%  interrupts.CPU33.RES:Rescheduling_interrupts
    976.75 ±  3%     +43.2%       1398 ±  7%  interrupts.CPU34.CAL:Function_call_interrupts
    175901 ±  2%     +56.8%     275892 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
      1920 ±  3%     -35.9%       1230 ±  6%  interrupts.CPU34.RES:Rescheduling_interrupts
    995.75 ±  3%     +35.5%       1349 ±  2%  interrupts.CPU35.CAL:Function_call_interrupts
    176626           +56.4%     276218 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
      2002 ±  6%     -34.0%       1322 ±  4%  interrupts.CPU35.RES:Rescheduling_interrupts
    977.75 ±  3%     +41.3%       1381 ±  5%  interrupts.CPU36.CAL:Function_call_interrupts
    175681 ±  2%     +57.0%     275759 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
      1944           -35.9%       1245 ±  3%  interrupts.CPU36.RES:Rescheduling_interrupts
    967.00 ±  5%     +42.5%       1378 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
    176570 ±  2%     +55.7%     274976 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
      4719 ± 35%     -74.9%       1184 ± 67%  interrupts.CPU37.NMI:Non-maskable_interrupts
      4719 ± 35%     -74.9%       1184 ± 67%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      1897           -31.3%       1302 ± 13%  interrupts.CPU37.RES:Rescheduling_interrupts
     77.00 ± 39%     +71.4%     132.00 ± 30%  interrupts.CPU38.43:IR-PCI-MSI.524293-edge.eth0-TxRx-4
    953.50 ±  2%     +42.8%       1361        interrupts.CPU38.CAL:Function_call_interrupts
    175461 ±  3%     +57.2%     275862 ±  4%  interrupts.CPU38.LOC:Local_timer_interrupts
      1919 ±  3%     -32.3%       1300 ± 10%  interrupts.CPU38.RES:Rescheduling_interrupts
    977.75 ±  4%     +34.6%       1316 ±  6%  interrupts.CPU39.CAL:Function_call_interrupts
    176475 ±  2%     +56.5%     276208 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
      1884           -33.0%       1263 ±  7%  interrupts.CPU39.RES:Rescheduling_interrupts
    897.00 ± 12%     +56.3%       1402 ±  8%  interrupts.CPU4.CAL:Function_call_interrupts
    176870           +56.2%     276260 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
      2133 ± 10%     -36.2%       1361 ± 20%  interrupts.CPU4.RES:Rescheduling_interrupts
    995.00 ±  3%     +36.3%       1356 ±  5%  interrupts.CPU5.CAL:Function_call_interrupts
    177709           +55.3%     275932 ±  4%  interrupts.CPU5.LOC:Local_timer_interrupts
      5802 ± 33%     -62.7%       2163 ± 72%  interrupts.CPU5.NMI:Non-maskable_interrupts
      5802 ± 33%     -62.7%       2163 ± 72%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     54.75 ±  8%     +64.4%      90.00 ± 21%  interrupts.CPU6.46:IR-PCI-MSI.524296-edge.eth0-TxRx-7
    931.75 ±  3%     +46.4%       1364 ±  7%  interrupts.CPU6.CAL:Function_call_interrupts
    176814           +56.1%     275995 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
      1.25 ± 66%  +1.4e+05%       1764 ± 77%  interrupts.CPU6.NMI:Non-maskable_interrupts
      1.25 ± 66%  +1.4e+05%       1764 ± 77%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
      2020 ±  4%     -26.1%       1493 ± 21%  interrupts.CPU6.RES:Rescheduling_interrupts
    951.50 ±  3%     +42.3%       1353 ±  5%  interrupts.CPU7.CAL:Function_call_interrupts
    177433           +55.7%     276226 ±  4%  interrupts.CPU7.LOC:Local_timer_interrupts
      1961           -39.5%       1187 ±  2%  interrupts.CPU7.RES:Rescheduling_interrupts
    958.00 ±  4%     +46.1%       1400 ±  3%  interrupts.CPU8.CAL:Function_call_interrupts
    176160 ±  2%     +56.6%     275946 ±  3%  interrupts.CPU8.LOC:Local_timer_interrupts
      2051 ±  3%     -33.9%       1356 ±  5%  interrupts.CPU8.RES:Rescheduling_interrupts
      1045 ±  2%     +26.9%       1326 ±  6%  interrupts.CPU9.CAL:Function_call_interrupts
    177126           +55.9%     276223 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
      4878 ± 34%     -63.5%       1780 ± 80%  interrupts.CPU9.NMI:Non-maskable_interrupts
      4878 ± 34%     -63.5%       1780 ± 80%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
   7069159           +56.2%   11041322 ±  3%  interrupts.LOC:Local_timer_interrupts
    118316 ±  7%     -46.4%      63378 ± 17%  interrupts.NMI:Non-maskable_interrupts
    118316 ±  7%     -46.4%      63378 ± 17%  interrupts.PMI:Performance_monitoring_interrupts
     79699           -24.7%      60027 ±  2%  interrupts.RES:Rescheduling_interrupts
    176.75 ± 10%     +71.8%     303.67 ± 10%  interrupts.TLB:TLB_shootdowns
     58.95           -15.1       43.86 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     59.10           -15.1       44.02 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     54.72           -14.7       39.98 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     54.25           -14.7       39.52 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     61.93           -14.6       47.29 ±  3%  perf-profile.calltrace.cycles-pp.read
     45.30           -12.1       33.15 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.88           -10.1       28.73 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     36.45 ±  2%      -9.5       26.96        perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read
     20.84            -5.5       15.37 ±  3%  perf-profile.calltrace.cycles-pp.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read.vfs_read
      9.89 ±  4%      -3.2        6.69 ±  7%  perf-profile.calltrace.cycles-pp.touch_atime.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read
      9.80 ±  4%      -3.2        6.62 ±  8%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter
      9.55 ±  6%      -2.6        6.97 ±  5%  perf-profile.calltrace.cycles-pp.down_read.xfs_ilock.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read
      9.61 ±  7%      -2.6        7.04 ±  5%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read.vfs_read
      5.55 ± 10%      -1.7        3.83 ± 11%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.80 ±  5%      -1.5        4.32        perf-profile.calltrace.cycles-pp.up_read.xfs_iunlock.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read
      5.86 ±  5%      -1.4        4.41        perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read.vfs_read
      4.33 ±  4%      -1.4        2.96 ±  3%  perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      2.97 ±  4%      -1.0        2.01        perf-profile.calltrace.cycles-pp.__inode_security_revalidate.selinux_file_permission.security_file_permission.vfs_read.ksys_read
      2.46 ±  3%      -0.5        2.00 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      1.56 ± 21%      -0.4        1.20 ±  9%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.08 ±  3%      -0.3        1.78 ±  6%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.14 ±  2%      -0.3        1.84 ±  6%  perf-profile.calltrace.cycles-pp.close
      2.09 ±  3%      -0.3        1.79 ±  6%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      2.11 ±  3%      -0.3        1.81 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
      2.11 ±  2%      -0.3        1.81 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      2.09 ±  3%      -0.3        1.79 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      2.05 ±  3%      -0.3        1.75 ±  6%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_usermode_loop
      2.06 ±  3%      -0.3        1.77 ±  6%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      1.39 ±  3%      -0.3        1.10 ±  5%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.97 ±  6%      -0.3        1.70 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
      2.28 ±  6%      -0.2        2.07 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_open.do_syscall_64
      2.22 ±  6%      -0.2        2.03 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_open
      0.59 ±  2%      +0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_read_page_sync.iomap_write_begin.iomap_write_actor.iomap_apply
      0.87 ±  2%      +0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.iomap_read_page_sync.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.79 ±  5%      +0.1        0.89 ±  4%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.19            +0.1        1.32        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      1.15 ±  5%      +0.1        1.28        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      1.56 ±  2%      +0.2        1.72 ±  6%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      1.55 ±  2%      +0.2        1.71 ±  6%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      1.40 ±  3%      +0.2        1.59        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      1.38 ±  2%      +0.2        1.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      3.72 ±  2%      +0.3        3.97        perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      3.86 ±  2%      +0.3        4.15        perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.72 ±  2%      +0.4        2.12        perf-profile.calltrace.cycles-pp.xfs_file_iomap_begin_delay.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      2.90 ±  5%      +0.4        3.31 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.91 ±  5%      +0.4        3.31 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      2.92 ±  5%      +0.4        3.33 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      2.92 ±  5%      +0.4        3.32 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      2.92 ±  5%      +0.4        3.33 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      2.94 ±  5%      +0.4        3.35 ±  2%  perf-profile.calltrace.cycles-pp.creat
      5.01 ±  2%      +0.5        5.47        perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_ialloc.xfs_dir_ialloc.xfs_create.xfs_generic_create
      2.00 ±  2%      +0.6        2.59 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ialloc.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
      0.00            +0.6        0.65 ±  3%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.77 ±  4%      +0.7        1.45 ±  2%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.78 ±  5%      +0.7        1.46 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      0.78 ±  5%      +0.7        1.46 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81 ±  5%      +0.7        1.51 ±  2%  perf-profile.calltrace.cycles-pp.unlink
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     12.46 ±  2%      +0.8       13.22        perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
     12.37 ±  2%      +0.8       13.13        perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      0.13 ±173%      +0.9        1.02        perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.00            +1.0        1.00 ±  2%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_open
     15.73 ±  4%      +1.3       17.05        perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     22.72 ±  3%      +1.5       24.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     22.86 ±  3%      +1.5       24.35        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     16.41 ±  3%      +1.5       17.94        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.33 ±  3%      +1.7       19.99        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     18.75 ±  3%      +1.7       20.47        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.76 ±  3%      +1.9       27.68        perf-profile.calltrace.cycles-pp.write
      5.47 ± 15%     +10.7       16.19 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.55 ± 15%     +11.2       16.79 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      5.56 ± 15%     +11.3       16.82 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      5.89 ± 12%     +11.5       17.42 ±  8%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      5.69 ± 14%     +11.6       17.25 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      5.69 ± 14%     +11.6       17.26 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      5.69 ± 14%     +11.6       17.26 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     54.73           -14.7       40.00 ±  4%  perf-profile.children.cycles-pp.ksys_read
     54.28           -14.7       39.56 ±  4%  perf-profile.children.cycles-pp.vfs_read
     62.12           -14.6       47.49 ±  3%  perf-profile.children.cycles-pp.read
     87.70           -12.8       74.92 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     87.98           -12.8       75.22 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     45.31           -12.1       33.16 ±  2%  perf-profile.children.cycles-pp.new_sync_read
     38.88           -10.1       28.74 ±  2%  perf-profile.children.cycles-pp.xfs_file_read_iter
     36.47 ±  2%      -9.5       26.98        perf-profile.children.cycles-pp.xfs_file_buffered_aio_read
     20.86            -5.5       15.39 ±  3%  perf-profile.children.cycles-pp.generic_file_read_iter
      9.89 ±  4%      -3.2        6.70 ±  7%  perf-profile.children.cycles-pp.touch_atime
      9.80 ±  4%      -3.2        6.63 ±  8%  perf-profile.children.cycles-pp.atime_needs_update
      9.60 ±  6%      -2.6        7.02 ±  4%  perf-profile.children.cycles-pp.down_read
     10.44 ±  7%      -2.5        7.95 ±  5%  perf-profile.children.cycles-pp.xfs_ilock
      6.35 ±  9%      -1.7        4.67 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      5.81 ±  5%      -1.5        4.34        perf-profile.children.cycles-pp.up_read
      6.41 ±  5%      -1.5        4.93        perf-profile.children.cycles-pp.xfs_iunlock
      4.94 ±  4%      -1.3        3.60 ±  3%  perf-profile.children.cycles-pp.selinux_file_permission
      3.17 ±  3%      -0.9        2.27        perf-profile.children.cycles-pp.__inode_security_revalidate
      2.47 ±  3%      -0.5        2.02 ±  3%  perf-profile.children.cycles-pp.iomap_write_end
      1.75 ± 18%      -0.3        1.41 ±  7%  perf-profile.children.cycles-pp.fsnotify
      2.14 ±  2%      -0.3        1.84 ±  6%  perf-profile.children.cycles-pp.close
      2.09 ±  3%      -0.3        1.79 ±  6%  perf-profile.children.cycles-pp.task_work_run
      2.08 ±  3%      -0.3        1.79 ±  6%  perf-profile.children.cycles-pp.__fput
      2.06 ±  3%      -0.3        1.77 ±  6%  perf-profile.children.cycles-pp.dput
      2.10 ±  3%      -0.3        1.81 ±  6%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      2.05 ±  3%      -0.3        1.76 ±  6%  perf-profile.children.cycles-pp.__dentry_kill
      1.40 ±  3%      -0.3        1.12 ±  5%  perf-profile.children.cycles-pp.iomap_set_page_dirty
      0.74 ±  7%      -0.2        0.53 ±  8%  perf-profile.children.cycles-pp.rw_verify_area
      0.34 ±  3%      -0.2        0.17 ±  7%  perf-profile.children.cycles-pp.page_mapping
      0.43 ±  9%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.up_write
      0.22 ±  7%      -0.0        0.20 ±  8%  perf-profile.children.cycles-pp.unlock_page
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.10 ±  4%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.workingset_update_node
      0.07 ± 10%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xfs_lookup
      0.07 ± 14%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.18 ±  7%      +0.0        0.21 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.13 ±  5%      +0.0        0.16        perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.16            +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.__x64_sys_read
      0.07 ±  7%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.66 ±  2%      +0.0        0.69        perf-profile.children.cycles-pp.down_write
      0.17 ±  9%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.disk_cp
      0.38 ±  2%      +0.0        0.41 ±  4%  perf-profile.children.cycles-pp.xas_store
      0.21 ±  3%      +0.0        0.25 ±  9%  perf-profile.children.cycles-pp.rcu_all_qs
      0.05 ±  8%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.unwind_next_frame
      0.04 ± 57%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.21 ±  3%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.18 ±  4%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.xfs_dir3_data_check
      0.18 ±  4%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__xfs_dir3_data_check
      0.35 ±  3%      +0.0        0.39 ±  3%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.44 ±  2%      +0.0        0.48 ±  5%  perf-profile.children.cycles-pp._cond_resched
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.kmem_zone_alloc
      0.05 ± 58%      +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.04 ± 57%      +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.21 ±  6%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ± 10%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.11 ±  9%      +0.1        0.17 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.xlog_space_left
      0.10 ±  9%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.08 ±  5%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.arch_stack_walk
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.xfs_verify_ino
      0.27 ±  5%      +0.1        0.33        perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.11 ±  4%      +0.1        0.17 ± 19%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.06 ± 14%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.11 ±  7%      +0.1        0.17 ± 20%  perf-profile.children.cycles-pp.uart_console_write
      0.45 ±  4%      +0.1        0.52 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.28 ±  5%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.08 ± 58%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.xlog_ungrant_log_space
      0.01 ±173%      +0.1        0.08        perf-profile.children.cycles-pp.xfs_iunlink
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.12 ± 10%      +0.1        0.19 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      0.30 ±  4%      +0.1        0.38 ±  6%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.12 ± 10%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.10 ± 58%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.xfs_log_done
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.native_write_msr
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.xfs_agino_range
      0.12 ± 10%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.12 ± 10%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.activate_task
      0.12 ±  8%      +0.1        0.21 ± 20%  perf-profile.children.cycles-pp.console_unlock
      0.08 ±  8%      +0.1        0.17 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      0.12 ±  8%      +0.1        0.21 ± 17%  perf-profile.children.cycles-pp.irq_work_run_list
      0.35 ±  8%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.xfs_file_iomap_end
      0.00            +0.1        0.09 ± 50%  perf-profile.children.cycles-pp.xfs_inobt_get_maxrecs
      0.11 ± 11%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp.irq_work_interrupt
      0.11 ± 11%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp.smp_irq_work_interrupt
      0.11 ± 11%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp.irq_work_run
      0.11 ± 11%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp.printk
      0.11 ± 11%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp.vprintk_emit
      0.04 ± 57%      +0.1        0.13 ± 25%  perf-profile.children.cycles-pp.clockevents_program_event
      0.60            +0.1        0.69 ±  4%  perf-profile.children.cycles-pp.memset_erms
      0.88 ±  2%      +0.1        0.98 ±  3%  perf-profile.children.cycles-pp.iomap_read_page_sync
      0.14 ±  9%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.71 ±  2%      +0.1        0.82 ±  2%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.ktime_get
      0.11 ± 61%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.42 ±  8%      +0.1        0.55 ± 13%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.06 ± 11%      +0.1        0.20 ± 47%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.10 ± 15%      +0.1        0.24 ± 24%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.06 ±  6%      +0.2        0.22 ± 35%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.06 ±  7%      +0.2        0.22 ± 41%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      1.56 ±  2%      +0.2        1.72 ±  6%  perf-profile.children.cycles-pp.evict
      0.17 ±  8%      +0.2        0.34 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      1.55 ±  2%      +0.2        1.71 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.11 ± 14%      +0.2        0.29 ± 25%  perf-profile.children.cycles-pp.irq_exit
      0.00            +0.2        0.18 ± 27%  perf-profile.children.cycles-pp.menu_select
      0.43 ±  3%      +0.2        0.62 ±  3%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.43 ±  3%      +0.2        0.62 ±  3%  perf-profile.children.cycles-pp.xfs_remove
      0.23 ± 41%      +0.2        0.42 ± 11%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.21 ± 46%      +0.2        0.40 ± 11%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.45 ±  2%      +0.2        0.65 ±  3%  perf-profile.children.cycles-pp.vfs_unlink
      0.34 ±  5%      +0.2        0.55 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.08 ±  5%      +0.2        0.29 ± 42%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.28 ± 36%      +0.2        0.50 ±  9%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.26 ±  4%      +0.3        0.51        perf-profile.children.cycles-pp.update_process_times
      0.26 ±  3%      +0.3        0.52 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.10 ±  8%      +0.3        0.36 ± 36%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      2.49 ±  6%      +0.3        2.75 ±  3%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      3.88 ±  2%      +0.3        4.17        perf-profile.children.cycles-pp.grab_cache_page_write_begin
      0.29 ±  3%      +0.3        0.59 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      2.61 ±  2%      +0.3        2.94        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.12 ±  8%      +0.4        0.52 ±  4%  perf-profile.children.cycles-pp.xfs_dialloc_ag
      3.00 ±  5%      +0.4        3.40 ±  2%  perf-profile.children.cycles-pp.do_sys_open
      2.97 ±  5%      +0.4        3.37 ±  2%  perf-profile.children.cycles-pp.path_openat
      2.97 ±  5%      +0.4        3.37 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      0.20 ±  8%      +0.4        0.61 ± 37%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      1.75 ±  2%      +0.4        2.15        perf-profile.children.cycles-pp.xfs_file_iomap_begin_delay
      2.94 ±  5%      +0.4        3.35 ±  2%  perf-profile.children.cycles-pp.creat
      0.15 ± 10%      +0.4        0.58 ±  5%  perf-profile.children.cycles-pp.xfs_dialloc
      0.39 ±  3%      +0.4        0.83 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.79 ±  2%      +0.4        3.23        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.18 ±  7%      +0.4        0.63 ±  3%  perf-profile.children.cycles-pp.xfs_ialloc
      0.18 ±  7%      +0.5        0.63 ±  3%  perf-profile.children.cycles-pp.xfs_dir_ialloc
      5.03 ±  2%      +0.5        5.49        perf-profile.children.cycles-pp.iomap_write_begin
      0.45 ±  7%      +0.6        1.00        perf-profile.children.cycles-pp.xfs_create
      0.46 ±  7%      +0.6        1.02        perf-profile.children.cycles-pp.xfs_generic_create
      0.50 ±  4%      +0.6        1.08 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.02 ±  2%      +0.6        2.62        perf-profile.children.cycles-pp.xfs_file_iomap_begin
      0.77 ±  4%      +0.7        1.45 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      0.81 ±  5%      +0.7        1.51 ±  2%  perf-profile.children.cycles-pp.unlink
     12.39 ±  2%      +0.8       13.15        perf-profile.children.cycles-pp.iomap_apply
     12.46 ±  2%      +0.8       13.22        perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.64 ±  5%      +0.8        1.46 ±  8%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.69 ±  4%      +0.9        1.56 ±  8%  perf-profile.children.cycles-pp.apic_timer_interrupt
     15.75 ±  4%      +1.3       17.07        perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
     16.43 ±  3%      +1.5       17.95        perf-profile.children.cycles-pp.new_sync_write
     18.36 ±  3%      +1.7       20.02        perf-profile.children.cycles-pp.vfs_write
     18.77 ±  3%      +1.7       20.48        perf-profile.children.cycles-pp.ksys_write
     25.94 ±  3%      +2.0       27.92        perf-profile.children.cycles-pp.write
      5.65 ± 12%     +10.7       16.35 ±  7%  perf-profile.children.cycles-pp.intel_idle
      5.75 ± 13%     +11.2       16.98 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter_state
      5.75 ± 13%     +11.2       16.98 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
      5.89 ± 12%     +11.5       17.42 ±  8%  perf-profile.children.cycles-pp.secondary_startup_64
      5.89 ± 12%     +11.5       17.42 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
      5.89 ± 12%     +11.5       17.42 ±  8%  perf-profile.children.cycles-pp.do_idle
      5.69 ± 14%     +11.6       17.26 ±  9%  perf-profile.children.cycles-pp.start_secondary
      9.36 ±  3%      -3.2        6.20 ±  7%  perf-profile.self.cycles-pp.atime_needs_update
      9.38 ±  6%      -2.6        6.74 ±  5%  perf-profile.self.cycles-pp.down_read
      7.04 ±  2%      -2.2        4.82 ±  3%  perf-profile.self.cycles-pp.generic_file_read_iter
      6.34            -2.0        4.32 ±  6%  perf-profile.self.cycles-pp.new_sync_read
      5.76 ±  5%      -1.5        4.27        perf-profile.self.cycles-pp.up_read
      2.93 ±  4%      -1.0        1.96        perf-profile.self.cycles-pp.__inode_security_revalidate
      7.79            -0.6        7.14        perf-profile.self.cycles-pp.do_syscall_64
      1.73 ±  6%      -0.5        1.27 ±  6%  perf-profile.self.cycles-pp.selinux_file_permission
      1.73 ± 18%      -0.4        1.36 ±  8%  perf-profile.self.cycles-pp.fsnotify
      0.72 ±  7%      -0.2        0.51 ±  9%  perf-profile.self.cycles-pp.rw_verify_area
      0.34 ±  3%      -0.2        0.17 ± 10%  perf-profile.self.cycles-pp.page_mapping
      0.42 ±  4%      -0.1        0.30 ±  6%  perf-profile.self.cycles-pp.iomap_write_end
      0.24 ±  6%      -0.1        0.16 ± 10%  perf-profile.self.cycles-pp.iomap_set_page_dirty
      0.16 ± 11%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.42 ±  8%      -0.1        0.34 ±  5%  perf-profile.self.cycles-pp.up_write
      0.33 ±  2%      -0.0        0.29 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28 ±  5%      -0.0        0.24 ±  5%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.workingset_update_node
      0.05 ±  8%      +0.0        0.07 ± 17%  perf-profile.self.cycles-pp.__lock_text_start
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__x64_sys_read
      0.22            +0.0        0.25 ±  6%  perf-profile.self.cycles-pp.read
      0.16            +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.rcu_all_qs
      0.18 ±  2%      +0.0        0.21 ±  7%  perf-profile.self.cycles-pp._cond_resched
      0.11 ±  4%      +0.0        0.15 ±  9%  perf-profile.self.cycles-pp.xfs_file_aio_write_checks
      0.32 ±  5%      +0.0        0.35        perf-profile.self.cycles-pp.xfs_file_buffered_aio_write
      0.14 ±  6%      +0.0        0.17 ± 10%  perf-profile.self.cycles-pp.ksys_write
      0.04 ± 57%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.copyin
      0.41 ±  4%      +0.0        0.45 ±  3%  perf-profile.self.cycles-pp.__might_sleep
      0.20 ±  4%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.20 ±  7%      +0.0        0.25 ±  6%  perf-profile.self.cycles-pp.iomap_write_begin
      0.03 ±100%      +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.xfs_get_extsz_hint
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.27 ±  6%      +0.1        0.32 ±  6%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.17 ± 13%      +0.1        0.23 ± 10%  perf-profile.self.cycles-pp.new_sync_write
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.memcpy_erms
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.xlog_space_left
      0.20 ±  4%      +0.1        0.26        perf-profile.self.cycles-pp.write
      0.10 ± 25%      +0.1        0.16 ± 18%  perf-profile.self.cycles-pp.xfs_log_commit_cil
      0.08 ± 58%      +0.1        0.14 ± 10%  perf-profile.self.cycles-pp.xlog_ungrant_log_space
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.update_load_avg
      0.25 ±  4%      +0.1        0.32 ±  5%  perf-profile.self.cycles-pp.xfs_file_iomap_end
      0.23 ±  9%      +0.1        0.30 ±  8%  perf-profile.self.cycles-pp.pagecache_get_page
      0.00            +0.1        0.08 ± 30%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.native_write_msr
      0.00            +0.1        0.08 ± 53%  perf-profile.self.cycles-pp.xfs_inobt_get_maxrecs
      0.59            +0.1        0.68 ±  4%  perf-profile.self.cycles-pp.memset_erms
      0.17 ±  9%      +0.1        0.26 ±  7%  perf-profile.self.cycles-pp.xfs_iunlock
      0.00            +0.1        0.09 ± 44%  perf-profile.self.cycles-pp.menu_select
      0.68 ±  2%      +0.1        0.79 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.40 ± 10%      +0.1        0.52 ± 13%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.00            +0.1        0.12 ± 38%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.11 ± 61%      +0.1        0.24 ± 12%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.24 ±  7%      +0.2        0.40        perf-profile.self.cycles-pp.xfs_file_iomap_begin
      0.31 ±  6%      +0.2        0.53 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.32 ± 12%      +0.2        0.57        perf-profile.self.cycles-pp.xfs_file_iomap_begin_delay
      2.60 ±  2%      +0.3        2.94        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.52 ±  2%      +0.4        2.91        perf-profile.self.cycles-pp.entry_SYSCALL_64
      5.65 ± 12%     +10.7       16.34 ±  7%  perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.3.0-rc7-00093-g1aabb011bfba5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.3.0-rc7 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BD70528 is not set
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='/lkp/lkp/.src-20190906-164721/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-ep01/aim7-fs-raid.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-ep01'
	export tbox_group='lkp-ivb-ep01'
	export submit_id='5d78dc8e7532321c786a82c0'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-ep01/aim7-performance-4BRD_12G-xfs-3000-RAID0-disk_rw-debian-x86_64-20-20190911-7288-1axhf6h-3.yaml'
	export id='520e000b9e9660e6aa9f5f516b261cd0fbacb8e9'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='Ivy Bridge-EP'
	export nr_node=2
	export nr_cpu=40
	export memory='384G'
	export hdd_partitions='/dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part1 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part2 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part3 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part4 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part5 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part6 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part7 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part8'
	export swap_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export brand='Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz'
	export commit='1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1'
	export rootfs='debian-x86_64-2019-05-14.cgz'
	export kernel_cmdline_hw='cma=0'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_MEGARAID_SAS'
	export need_kconfig='CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV=y
CONFIG_BLOCK=y
CONFIG_MD_RAID0
CONFIG_XFS_FS'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2019-09-11 19:37:59 +0800'
	export _id='5d78dc977532321c786a82c1'
	export _rt='/result/aim7/performance-4BRD_12G-xfs-3000-RAID0-disk_rw/lkp-ivb-ep01/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1'
	export user='lkp'
	export head_commit='9c5b4564866290e20d03572ed6613ff088c8db10'
	export base_commit='f74c2bb98776e2de508f4d607cd519873065118e'
	export branch='linux-devel/devel-hourly-2019091008'
	export result_root='/result/aim7/performance-4BRD_12G-xfs-3000-RAID0-disk_rw/lkp-ivb-ep01/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/3'
	export scheduler_version='/lkp/lkp/.src-20190911-112636'
	export LKP_SERVER='inn'
	export max_uptime=949.6800000000001
	export initrd='/osimage/debian/debian-x86_64-2019-05-14.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-ep01/aim7-performance-4BRD_12G-xfs-3000-RAID0-disk_rw-debian-x86_64-20-20190911-7288-1axhf6h-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019091008
commit=1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/vmlinuz-5.3.0-rc7-00093-g1aabb011bfba5
cma=0
max_uptime=949
RESULT_ROOT=/result/aim7/performance-4BRD_12G-xfs-3000-RAID0-disk_rw/lkp-ivb-ep01/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-08-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-git-1_2019-09-06.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/md_2019-06-26.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fs_2019-08-21.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/aim7-x86_64-_2019-08-18.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-08-12.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-08-17.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-08-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-08-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-08-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-08-21.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/vmlinuz-5.3.0-rc7-00093-g1aabb011bfba5'
	export dequeue_time='2019-09-11 19:46:57 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-ep01/aim7-performance-4BRD_12G-xfs-3000-RAID0-disk_rw-debian-x86_64-20-20190911-7288-1axhf6h-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_brd=4 ramdisk_size=12884901888 $LKP_SRC/setup/disk

	run_setup raid_level='raid0' $LKP_SRC/setup/md

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='disk_rw' load=3000 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper aim7
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/aim7-fs-raid.yaml
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 4BRD_12G
md: RAID0
fs: xfs
aim7:
  test: disk_rw
  load: 3000
job_origin: "/lkp/lkp/.src-20190906-164721/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-ep01/aim7-fs-raid.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-ivb-ep01
tbox_group: lkp-ivb-ep01
submit_id: 5d78c75e7532321bed47754a
job_file: "/lkp/jobs/scheduled/lkp-ivb-ep01/aim7-performance-4BRD_12G-xfs-3000-RAID0-disk_rw-debian-x86_64-2019-20190911-7149-1tiwxnj-0.yaml"
id: d308b73a574a4987c236d6f34d0ac11e8e0c4783
queuer_version: "/lkp-src"
arch: x86_64

#! hosts/lkp-ivb-ep01
model: Ivy Bridge-EP
nr_node: 2
nr_cpu: 40
memory: 384G
hdd_partitions: "/dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part1 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part2
  /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part3 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part4
  /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part5 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part6
  /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part7 /dev/disk/by-id/scsi-36b8ca3a0e650e100228623a40f936347-part8"
swap_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS
brand: Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz

#! include/category/benchmark
kmsg: 
boot-time: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1

#! include/testbox/lkp-ivb-ep01
rootfs: debian-x86_64-2019-05-14.cgz
kernel_cmdline_hw: cma=0
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_MEGARAID_SAS

#! include/disk/nr_brd
need_kconfig:
- CONFIG_BLK_DEV_RAM=m
- CONFIG_BLK_DEV=y
- CONFIG_BLOCK=y
- CONFIG_MD_RAID0
- CONFIG_XFS_FS

#! include/md/raid_level

#! include/fs/OTHERS

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2019-09-11 18:07:33.024073812 +08:00
_id: 5d78c75e7532321bed47754a
_rt: "/result/aim7/performance-4BRD_12G-xfs-3000-RAID0-disk_rw/lkp-ivb-ep01/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1"

#! schedule options
user: lkp
head_commit: 9c5b4564866290e20d03572ed6613ff088c8db10
base_commit: f74c2bb98776e2de508f4d607cd519873065118e
branch: linux-devel/devel-hourly-2019091008
result_root: "/result/aim7/performance-4BRD_12G-xfs-3000-RAID0-disk_rw/lkp-ivb-ep01/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/0"
scheduler_version: "/lkp/lkp/.src-20190911-112636"
LKP_SERVER: inn
max_uptime: 949.6800000000001
initrd: "/osimage/debian/debian-x86_64-2019-05-14.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-ep01/aim7-performance-4BRD_12G-xfs-3000-RAID0-disk_rw-debian-x86_64-2019-20190911-7149-1tiwxnj-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2019091008
- commit=1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/vmlinuz-5.3.0-rc7-00093-g1aabb011bfba5
- cma=0
- max_uptime=949
- RESULT_ROOT=/result/aim7/performance-4BRD_12G-xfs-3000-RAID0-disk_rw/lkp-ivb-ep01/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/0
- LKP_SERVER=inn
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-08-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-git-1_2019-09-06.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/md_2019-06-26.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fs_2019-08-21.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/aim7-x86_64-_2019-08-18.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-08-12.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-08-17.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-08-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-08-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/mpstat-x86_64-git-1_2019-08-24.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-08-21.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190910-192646/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/1aabb011bfba5a8942d3e0d0c84a4ac7cad277b1/vmlinuz-5.3.0-rc7-00093-g1aabb011bfba5"
dequeue_time: 2019-09-11 19:22:53.065697874 +08:00

#! /lkp/lkp/.src-20190911-112636/include/site/inn
job_state: finished
loadavg: 2249.19 1099.80 423.90 1/458 8938
start_time: '1568201034'
end_time: '1568201193'
version: "/lkp/lkp/.src-20190911-112703"

--5KENZRfAmuo1v8rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=4" "rd_size=12582912"
 "mdadm" "-q" "--stop" "/dev/md0"
 "dmsetup" "remove_all"
 "wipefs" "-a" "--force" "/dev/ram0"
 "wipefs" "-a" "--force" "/dev/ram1"
 "wipefs" "-a" "--force" "/dev/ram2"
 "wipefs" "-a" "--force" "/dev/ram3"
 "mdadm" "-q" "--create" "/dev/md0" "--chunk=256" "--level=raid0" "--raid-devices=4" "--force" "--assume-clean" "/dev/ram0" "/dev/ram1" "/dev/ram2" "/dev/ram3"
wipefs -a --force /dev/md0
mkfs -t xfs /dev/md0
mkdir -p /fs/md0
mount -t xfs -o inode64 /dev/md0 /fs/md0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo "500 32000 128 512" > /proc/sys/kernel/sem
cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 disk_rw
EOF
echo "/fs/md0" > config

	(
		echo lkp-ivb-ep01
		echo disk_rw

		echo 1
		echo 3000
		echo 2
		echo 3000
		echo 1
	) | ./multitask -t &

--5KENZRfAmuo1v8rU--
