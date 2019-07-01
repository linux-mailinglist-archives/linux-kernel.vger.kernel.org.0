Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD5579BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 04:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfF0C5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 22:57:36 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:59784 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbfF0C5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:57:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TVJFREn_1561604240;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVJFREn_1561604240)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Jun 2019 10:57:24 +0800
Subject: Re: [v3 RFC PATCH 0/9] Migrate mode for node reclaim with
 heterogeneous memory hierarchy
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3291d101-e362-4690-0f9d-048e13d3be03@linux.alibaba.com>
Date:   Wed, 26 Jun 2019 19:57:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


Any comment on this version?


Thanks,

Yang



On 6/13/19 4:29 PM, Yang Shi wrote:
> With Dave Hansen's patches merged into Linus's tree
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
>
> PMEM could be hot plugged as NUMA node now.  But, how to use PMEM as NUMA
> node effectively and efficiently is worth exploring.
>
> There have been a couple of proposals posted on the mailing list [1] [2] [3].
>
> I already posted two versions of patchset for demoting/promoting memory pages
> between DRAM and PMEM before this topic was discussed at LSF/MM 2019
> (https://lwn.net/Articles/787418/).  I do appreciate all the great suggestions
> from the community.  This updated version implemented the most discussion,
> please see the below design section for the details.
>
>
> Changelog
> =========
> v2 --> v3:
> * Introduced "migrate mode" for node reclaim.  Just do demotion when
>    "migrate mode" is specified per Michal Hocko and Mel Gorman.
> * Introduced "migrate target" concept for VM per Mel Gorman.  The memory nodes
>    which are under DRAM in the hierarchy (i.e. lower bandwidth, higher latency,
>    larger capacity and cheaper than DRAM) are considered as "migrate target"
>    nodes.  When "migrate mode" is on, memory reclaim would demote pages to
>    the "migrate target" nodes.
> * Dropped "twice access" promotion patch per Michal Hocko.
> * Changed the subject for the patchset to reflect the update.
> * Rebased to 5.2-rc1.
>
> v1 --> v2:
> * Dropped the default allocation node mask.  The memory placement restriction
>    could be achieved by mempolicy or cpuset.
> * Dropped the new mempolicy since its semantic is not that clear yet.
> * Dropped PG_Promote flag.
> * Defined N_CPU_MEM nodemask for the nodes which have both CPU and memory.
> * Extended page_check_references() to implement "twice access" check for
>    anonymous page in NUMA balancing path.
> * Reworked the memory demotion code.
>
> v2: https://lore.kernel.org/linux-mm/1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com/
> v1: https://lore.kernel.org/linux-mm/1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com/
>
>
> Design
> ======
> With the development of new memory technology, we could have cheaper and
> larger memory device on the system, which may have higher latency and lower
> bandwidth than DRAM, i.e. PMEM.  It could be used as persistent storage or
> volatile memory.
>
> It fits into the memory hierarchy as a second tier memory.  The patchset
> tries to explore an approach to utilize such memory to improve the memory
> placement.  Basically, the patchset tries to achieve this goal by doing
> memory promotion/demotion via NUMA balancing and memory reclaim.
>
> Introduce a new "migrate" mode for node reclaim.  When DRAM has memory
> pressure, demote pages to PMEM via node reclaim path if "migrate" mode is
> on.  Then NUMA balancing will promote pages to DRAM as long as the page is
> referenced again.  The memory pressure on PMEM node would push the inactive
> pages of PMEM to disk via swap.
>
> Introduce "primary" node and "migrate target" node concepts for VM (patch 1/9
> and 2/9).  The "primary" node is the node which has both CPU and memory.  The
> "migrate target" node is cpuless node and under DRAM in memory hierarchy
> (i.e. PMEM may be a suitable one, which has lower bandwidth, higher latency,
> larger capacity and is cheaper than DRAM).  The firmware is effectively going
> to enforce "cpu-less" nodes for any memory range that has differentiated
> performance from the conventional memory pool, or differentiated performance
> for a specific initiator.
>
> Defined "N_CPU_MEM" nodemask for the "primary" nodes in order to distinguish
> with cpuless nodes (memory only, i.e. PMEM nodes) and memoryless nodes (some
> architectures, i.e. Power, may have memoryless nodes).
>
> It is a little bit hard to find out suitable "migrate target" node since this
> needs firmware exposes the physical characteristics of the memory devices.
> I'm not quite sure what should be the best way and if it is ready to use now
> or not.  Since PMEM is the only available such device for now, so it sounds
> retrieving the information from SRAT is the easiest way.  We may figure out a
> better way in the future.
>
> The promotion/demotion happens only between "primary" nodes and "migrate target"
> nodes.  No promotion/demotion between "migrate target" nodes and promotion from
> "primary" nodes to "migrate target" nodes and demotion from "primary" nodes to
> "migrate target" nodes.  This guarantees there is no cycles for memory demotion
> or promotion.
>
> According to the discussion at LFS/MM 2019, "there should only be one node to
> which pages could be migrated".   So reclaim code just tries to demote the pages
> to the closest "migrate target" node and only tries once.  Otherwise "if all
> nodes in the system were on a fallback list, a page would have to move through
> every possible option - each RAM-based node and each persistent-memory node -
> before actually being reclaimed. It would be necessary to maintain the history
> of where each page has been, and would be likely to disrupt other workloads on
> the system".  This is what v2 patchset does, so keep doing it in the same way
> in v3.
>
> The demotion code moves all the migration candidate pages into one single list,
> then migrate them together (including THP).  This would improve the efficiency
> of migration according to Zi Yan's research.  If the migration fails, the
> unmigrated pages will be put back to LRU.
>
> Use the most opotimistic GFP flags to allocate pages on the "migrate target"
> node.
>   
> To reduce the failure rate of demotion, check if the "migrate target" node is
> contended or not.  If the "migrate target" node is contended, just do swap
> instead of migrate.  If migration is failed due to -ENOMEM, mark the node as
> contended.  The contended flag will be cleared once the node get balanced.
>
> For now "migrate" mode is not compatible with cpuset and mempolicy since it
> is hard to get the process's task_struct from struct page.  The cpuset and
> process's mempolicy are stored in task_struct instead of mm_struct.
>
> Anonymous page only for the time being since NUMA balancing can't promote
> unmapped page cache.  Page cache can be demoted easily, but promotion is a
> question, may do it via mark_page_accessed().
>
> Added vmstat counters for pgdemote_kswapd, pgdemote_direct and
> numa_pages_promoted.
>
> There are definitely still a lot of details need to be sorted out.  Any
> comment is welcome.
>
>
> Test
> ====
> The stress test was done with mmtests + applications workload (i.e. sysbench,
> grep, etc).
>
> Generate memory pressure by running mmtest's usemem-stress-numa-compact,
> then run other applications as workload to stress the promotion and demotion
> path.  The machine was still alive after the stress test had been running for
> ~30 hours.  The /proc/vmstat also shows:
>
> ...
> pgdemote_kswapd 3316563
> pgdemote_direct 1930721
> ...
> numa_pages_promoted 81838
>
>
> [1]: https://lore.kernel.org/linux-mm/20181226131446.330864849@intel.com/
> [2]: https://lore.kernel.org/linux-mm/20190321200157.29678-1-keith.busch@intel.com/
> [3]: https://lore.kernel.org/linux-mm/20190404071312.GD12864@dhcp22.suse.cz/T/#me1c1ed102741ba945c57071de9749e16a76e9f3d
>
>
> Yang Shi (9):
>        mm: define N_CPU_MEM node states
>        mm: Introduce migrate target nodemask
>        mm: page_alloc: make find_next_best_node find return migration target node
>        mm: migrate: make migrate_pages() return nr_succeeded
>        mm: vmscan: demote anon DRAM pages to migration target node
>        mm: vmscan: don't demote for memcg reclaim
>        mm: vmscan: check if the demote target node is contended or not
>        mm: vmscan: add page demotion counter
>        mm: numa: add page promotion counter
>
>   Documentation/sysctl/vm.txt    |   6 +++
>   drivers/acpi/numa.c            |  12 +++++
>   drivers/base/node.c            |   4 ++
>   include/linux/gfp.h            |  12 +++++
>   include/linux/migrate.h        |   6 ++-
>   include/linux/mmzone.h         |   3 ++
>   include/linux/nodemask.h       |   4 +-
>   include/linux/vm_event_item.h  |   3 ++
>   include/linux/vmstat.h         |   1 +
>   include/trace/events/migrate.h |   3 +-
>   mm/compaction.c                |   3 +-
>   mm/debug.c                     |   1 +
>   mm/gup.c                       |   4 +-
>   mm/huge_memory.c               |   4 ++
>   mm/internal.h                  |  23 ++++++++
>   mm/memory-failure.c            |   7 ++-
>   mm/memory.c                    |   4 ++
>   mm/memory_hotplug.c            |  10 +++-
>   mm/mempolicy.c                 |   7 ++-
>   mm/migrate.c                   |  33 ++++++++----
>   mm/page_alloc.c                |  20 +++++--
>   mm/vmscan.c                    | 186 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>   mm/vmstat.c                    |  14 ++++-
>   23 files changed, 323 insertions(+), 47 deletions(-)

