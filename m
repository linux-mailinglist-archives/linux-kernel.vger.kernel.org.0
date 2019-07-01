Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09F84C79E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 08:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfFTGrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 02:47:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:58599 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730267AbfFTGrM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:47:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 23:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,395,1557212400"; 
   d="scan'208";a="160573373"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2019 23:47:08 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/7] perf diff: diff cycles at basic block level
Date:   Thu, 20 Jun 2019 22:36:35 +0800
Message-Id: <1561041402-29444-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases small changes in hot loops can show big differences.
But it's difficult to identify these differences.

perf diff currently can only diff symbols (functions). We can also expand
it to diff cycles of individual programs blocks as reported by timed LBR.
This would allow to identify changes in specific code accurately.

With this patch set, for example,

 $ perf record -b ./div
 $ perf record -b ./div
 $ perf diff -c cycles

 # Event 'cycles'
 #
 # Baseline                                       [Program Block Range] Cycles Diff  Shared Object     Symbol
 # ........  ......................................................................  ................  ..................................
 #
     48.75%                                             [div.c:42 -> div.c:45]  147  div               [.] main
     48.75%                                             [div.c:31 -> div.c:40]    4  div               [.] main
     48.75%                                             [div.c:40 -> div.c:40]    0  div               [.] main
     48.75%                                             [div.c:42 -> div.c:42]    0  div               [.] main
     48.75%                                             [div.c:42 -> div.c:44]    0  div               [.] main
     19.02%                                 [random_r.c:357 -> random_r.c:360]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:373]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:376]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:380]    0  libc-2.23.so      [.] __random_r
     19.02%                                 [random_r.c:357 -> random_r.c:392]    0  libc-2.23.so      [.] __random_r
     16.17%                                     [random.c:288 -> random.c:291]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:288 -> random.c:291]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:288 -> random.c:295]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:288 -> random.c:297]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:291 -> random.c:291]    0  libc-2.23.so      [.] __random
     16.17%                                     [random.c:293 -> random.c:293]    0  libc-2.23.so      [.] __random
      8.21%                                             [div.c:22 -> div.c:22]  148  div               [.] compute_flag
      8.21%                                             [div.c:22 -> div.c:25]    0  div               [.] compute_flag
      8.21%                                             [div.c:27 -> div.c:28]    0  div               [.] compute_flag
      5.52%                                           [rand.c:26 -> rand.c:27]    0  libc-2.23.so      [.] rand
      5.52%                                           [rand.c:26 -> rand.c:28]    0  libc-2.23.so      [.] rand
      2.27%                                         [rand@plt+0 -> rand@plt+0]    0  div               [.] rand@plt
      0.01%                                 [entry_64.S:694 -> entry_64.S:694]   16  [kernel.vmlinux]  [k] native_irq_return_iret
      0.00%                                       [fair.c:7676 -> fair.c:7665]  162  [kernel.vmlinux]  [k] update_blocked_averages

 '[Program Block Range]' indicates the range of program basic block
 (start -> end). If we can find the source line it prints the source
 line otherwise it prints the symbol+offset instead.

 v4:
 ---
 Use source lines or symbol+offset to indicate the basic block.

 Changed patches:
  perf diff: Print the basic block cycles diff
  perf diff: Documentation -c cycles option  

 v3:
 ---
 In v3, the major change is to move most of block stuffs from
 'struct hist_entry' to new structure 'struct block_hist' and
 update the code accordingly. But we still have to keep the
 block_info in 'struct hist_entry' since we need to compare by
 block info when inserting new entry to hists.

 Others are minor changes, such as abs() -> labs(), removing
 duplicated ops and etc.

 Changed patches:
  perf diff: Use hists to manage basic blocks per symbol
  perf diff: Link same basic blocks among different data
  perf diff: Print the basic block cycles diff

 v2:
 ---
 Keep standard perf diff format.

 Following is the v1 output.

 # perf diff --basic-block

 # Cycles diff  Basic block (start:end)
 # ...........  .......................
 #
          -208  hrtimer_interrupt (30b9e0:30ba42)
          -157  update_blocked_averages (2bf9f2:2bfa63)
          -126  interrupt_entry (c00880:c0093a)
           -86  hrtimer_interrupt (30bb29:30bb32)
           -74  hrtimer_interrupt (30ba65:30bac4)
           -56  update_blocked_averages (2bf980:2bf9d3)
            48  update_blocked_averages (2bf934:2bf942)
           -35  native_write_msr (267900:26790b)
            26  native_irq_return_iret (c00a27:c00a27)
            22  rcu_check_callbacks (2febb6:2febdc)
           -21  __hrtimer_run_queues (30b220:30b2a3)
            19  pvclock_gtod_notify (14ba0:14c1b)
           -18  task_tick_fair (2c5d29:2c5d41)

Jin Yao (7):
  perf util: Create block_info structure
  perf util: Add block_info in hist_entry
  perf diff: Check if all data files with branch stacks
  perf diff: Use hists to manage basic blocks per symbol
  perf diff: Link same basic blocks among different data
  perf diff: Print the basic block cycles diff
  perf diff: Documentation -c cycles option

 tools/perf/Documentation/perf-diff.txt |  17 +-
 tools/perf/builtin-diff.c              | 404 ++++++++++++++++++++++++++++++++-
 tools/perf/ui/stdio/hist.c             |  27 +++
 tools/perf/util/hist.c                 |  40 +++-
 tools/perf/util/hist.h                 |   9 +
 tools/perf/util/sort.h                 |  13 ++
 tools/perf/util/srcline.c              |   4 +-
 tools/perf/util/symbol.c               |  22 ++
 tools/perf/util/symbol.h               |  23 ++
 tools/perf/util/symbol_conf.h          |   4 +-
 10 files changed, 551 insertions(+), 12 deletions(-)

-- 
2.7.4

