Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4E113D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 09:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEBHLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 03:11:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42113 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfEBHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so639138pgh.9;
        Thu, 02 May 2019 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVHYLdBH93nXe/f09g3Uhp0GlZtUchFRLOT7axCjcvY=;
        b=E6w8HifrJGG0wLXZORMdJxfGYuk6zhjSGJPquxGGiKW9NpdEf6JtGu5G/d181/HTkz
         itw90yo8E0jUiYfhXnhqTOx+lG88u6q6Fc1lF2yNd2KeEfeZTfBf3uqYqYSi3Fgn/nfo
         R4nZwE+v0LF2ME2rXV5EjTSeqjKoIYCEByosYAoSz+G+rhgx3fnJz9SXXmCEWHqoLLW0
         gWHUM5MvxNoTNDVQKAtLGjiO6oiFjmo6nDnhhzgeAsl6WIzd3FZtTr5iUNVNNUPtUbtw
         qpNW8yxPqzFdQKIHxgDOBMBplpTgkoZIZsgWHyOKv8JODulU4ukXLk12ZcOEfU0NsQgg
         08tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVHYLdBH93nXe/f09g3Uhp0GlZtUchFRLOT7axCjcvY=;
        b=es2CoUitH9mL0FZSYy5d61IrW350tgTumNHjzpgTmBvQvkLwl+5RASdpxgDgZ0qxkp
         UvszHEgLwXPlBSGZgK9y3g+gUrgWkRoUAlKXKcx5U1BxKJu5H5j0xcqbo/NgpecxuLM7
         g/ciIRf4lNtJuKht+LsJH5KpWYBXkB3EO12m9iAk3qAVv5+2ZcvN/+PzPo59GtV+lWYN
         bTunEco0CwYy4m8onvDbUw/8vigg3JD6JoPujlWLLBtD9KJliozn7bTcSGLHONI1Mhfy
         9exuSfHUJqmCv87Tn47fysF94abz2+ry3VS7we3XIUxBWqsBX7qbIrrURE/c0bppe+Dr
         fV9A==
X-Gm-Message-State: APjAAAWaM+lqvQcALTFADu40fmhE454CQ5azGn6s8zVowrdRnMfALAvv
        gooEIXg6us+PaRDZxq2blFtGnTED
X-Google-Smtp-Source: APXvYqy8hLdgV2DRgrFlGWUCUThpLh0KC+oyrUFtL844ONpG0ArBhdXyN7D6ekR3EWOeVheODbbu+g==
X-Received: by 2002:a63:1b04:: with SMTP id b4mr2357094pgb.305.1556781074533;
        Thu, 02 May 2019 00:11:14 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 17/27] Documentation: x86: convert resctrl_ui.txt to reST
Date:   Thu,  2 May 2019 15:06:23 +0800
Message-Id: <20190502070633.9809-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst                   |   1 +
 .../x86/{resctrl_ui.txt => resctrl_ui.rst}    | 916 ++++++++++--------
 2 files changed, 494 insertions(+), 423 deletions(-)
 rename Documentation/x86/{resctrl_ui.txt => resctrl_ui.rst} (68%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index ae29c026be72..6e3c887a0c3b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -23,3 +23,4 @@ x86-specific Documentation
    amd-memory-encryption
    pti
    microcode
+   resctrl_ui
diff --git a/Documentation/x86/resctrl_ui.txt b/Documentation/x86/resctrl_ui.rst
similarity index 68%
rename from Documentation/x86/resctrl_ui.txt
rename to Documentation/x86/resctrl_ui.rst
index c1f95b59e14d..225cfd4daaee 100644
--- a/Documentation/x86/resctrl_ui.txt
+++ b/Documentation/x86/resctrl_ui.rst
@@ -1,33 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===========================================
 User Interface for Resource Control feature
+===========================================
 
-Intel refers to this feature as Intel Resource Director Technology(Intel(R) RDT).
-AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
+:Copyright: |copy| 2016 Intel Corporation
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Tony Luck <tony.luck@intel.com>
+          - Vikas Shivappa <vikas.shivappa@intel.com>
 
-Copyright (C) 2016 Intel Corporation
 
-Fenghua Yu <fenghua.yu@intel.com>
-Tony Luck <tony.luck@intel.com>
-Vikas Shivappa <vikas.shivappa@intel.com>
+Intel refers to this feature as Intel Resource Director Technology(Intel(R) RDT).
+AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
 
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
-RDT (Resource Director Technology) Allocation - "rdt_a"
-CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
-CDP (Code and Data Prioritization ) - "cdp_l3", "cdp_l2"
-CQM (Cache QoS Monitoring) - "cqm_llc", "cqm_occup_llc"
-MBM (Memory Bandwidth Monitoring) - "cqm_mbm_total", "cqm_mbm_local"
-MBA (Memory Bandwidth Allocation) - "mba"
 
-To use the feature mount the file system:
+=============================================	================================
+RDT (Resource Director Technology) Allocation	"rdt_a"
+CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
+CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
+CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
+MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
+MBA (Memory Bandwidth Allocation)		"mba"
+=============================================	================================
+
+To use the feature mount the file system::
 
  # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
 
 mount options are:
 
-"cdp": Enable code/data prioritization in L3 cache allocations.
-"cdpl2": Enable code/data prioritization in L2 cache allocations.
-"mba_MBps": Enable the MBA Software Controller(mba_sc) to specify MBA
- bandwidth in MBps
+"cdp":
+	Enable code/data prioritization in L3 cache allocations.
+"cdpl2":
+	Enable code/data prioritization in L2 cache allocations.
+"mba_MBps":
+	Enable the MBA Software Controller(mba_sc) to specify MBA
+	bandwidth in MBps
 
 L2 and L3 CDP are controlled seperately.
 
@@ -44,7 +55,7 @@ For more details on the behavior of the interface during monitoring
 and allocation, see the "Resource alloc and monitor groups" section.
 
 Info directory
---------------
+==============
 
 The 'info' directory contains information about the enabled
 resources. Each resource has its own subdirectory. The subdirectory
@@ -56,77 +67,93 @@ allocation:
 Cache resource(L3/L2)  subdirectory contains the following files
 related to allocation:
 
-"num_closids":  	The number of CLOSIDs which are valid for this
-			resource. The kernel uses the smallest number of
-			CLOSIDs of all enabled resources as limit.
-
-"cbm_mask":     	The bitmask which is valid for this resource.
-			This mask is equivalent to 100%.
-
-"min_cbm_bits": 	The minimum number of consecutive bits which
-			must be set when writing a mask.
-
-"shareable_bits":	Bitmask of shareable resource with other executing
-			entities (e.g. I/O). User can use this when
-			setting up exclusive cache partitions. Note that
-			some platforms support devices that have their
-			own settings for cache use which can over-ride
-			these bits.
-"bit_usage":		Annotated capacity bitmasks showing how all
-			instances of the resource are used. The legend is:
-			"0" - Corresponding region is unused. When the system's
+"num_closids":
+		The number of CLOSIDs which are valid for this
+		resource. The kernel uses the smallest number of
+		CLOSIDs of all enabled resources as limit.
+"cbm_mask":
+		The bitmask which is valid for this resource.
+		This mask is equivalent to 100%.
+"min_cbm_bits":
+		The minimum number of consecutive bits which
+		must be set when writing a mask.
+
+"shareable_bits":
+		Bitmask of shareable resource with other executing
+		entities (e.g. I/O). User can use this when
+		setting up exclusive cache partitions. Note that
+		some platforms support devices that have their
+		own settings for cache use which can over-ride
+		these bits.
+"bit_usage":
+		Annotated capacity bitmasks showing how all
+		instances of the resource are used. The legend is:
+
+			"0":
+			      Corresponding region is unused. When the system's
 			      resources have been allocated and a "0" is found
 			      in "bit_usage" it is a sign that resources are
 			      wasted.
-			"H" - Corresponding region is used by hardware only
+
+			"H":
+			      Corresponding region is used by hardware only
 			      but available for software use. If a resource
 			      has bits set in "shareable_bits" but not all
 			      of these bits appear in the resource groups'
 			      schematas then the bits appearing in
 			      "shareable_bits" but no resource group will
 			      be marked as "H".
-			"X" - Corresponding region is available for sharing and
+			"X":
+			      Corresponding region is available for sharing and
 			      used by hardware and software. These are the
 			      bits that appear in "shareable_bits" as
 			      well as a resource group's allocation.
-			"S" - Corresponding region is used by software
+			"S":
+			      Corresponding region is used by software
 			      and available for sharing.
-			"E" - Corresponding region is used exclusively by
+			"E":
+			      Corresponding region is used exclusively by
 			      one resource group. No sharing allowed.
-			"P" - Corresponding region is pseudo-locked. No
+			"P":
+			      Corresponding region is pseudo-locked. No
 			      sharing allowed.
 
 Memory bandwitdh(MB) subdirectory contains the following files
 with respect to allocation:
 
-"min_bandwidth":	The minimum memory bandwidth percentage which
-			user can request.
+"min_bandwidth":
+		The minimum memory bandwidth percentage which
+		user can request.
 
-"bandwidth_gran":	The granularity in which the memory bandwidth
-			percentage is allocated. The allocated
-			b/w percentage is rounded off to the next
-			control step available on the hardware. The
-			available bandwidth control steps are:
-			min_bandwidth + N * bandwidth_gran.
+"bandwidth_gran":
+		The granularity in which the memory bandwidth
+		percentage is allocated. The allocated
+		b/w percentage is rounded off to the next
+		control step available on the hardware. The
+		available bandwidth control steps are:
+		min_bandwidth + N * bandwidth_gran.
 
-"delay_linear": 	Indicates if the delay scale is linear or
-			non-linear. This field is purely informational
-			only.
+"delay_linear":
+		Indicates if the delay scale is linear or
+		non-linear. This field is purely informational
+		only.
 
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
 
-"num_rmids":		The number of RMIDs available. This is the
-			upper bound for how many "CTRL_MON" + "MON"
-			groups can be created.
+"num_rmids":
+		The number of RMIDs available. This is the
+		upper bound for how many "CTRL_MON" + "MON"
+		groups can be created.
 
-"mon_features":	Lists the monitoring events if
-			monitoring is enabled for the resource.
+"mon_features":
+		Lists the monitoring events if
+		monitoring is enabled for the resource.
 
 "max_threshold_occupancy":
-			Read/write file provides the largest value (in
-			bytes) at which a previously used LLC_occupancy
-			counter can be considered for re-use.
+		Read/write file provides the largest value (in
+		bytes) at which a previously used LLC_occupancy
+		counter can be considered for re-use.
 
 Finally, in the top level of the "info" directory there is a file
 named "last_cmd_status". This is reset with every "command" issued
@@ -134,6 +161,7 @@ via the file system (making new directories or writing to any of the
 control files). If the command was successful, it will read as "ok".
 If the command failed, it will provide more information that can be
 conveyed in the error returns from file operations. E.g.
+::
 
 	# echo L3:0=f7 > schemata
 	bash: echo: write error: Invalid argument
@@ -141,7 +169,7 @@ conveyed in the error returns from file operations. E.g.
 	mask f7 has non-consecutive 1-bits
 
 Resource alloc and monitor groups
----------------------------------
+=================================
 
 Resource groups are represented as directories in the resctrl file
 system.  The default group is the root directory which, immediately
@@ -226,6 +254,7 @@ When monitoring is enabled all MON groups will also contain:
 
 Resource allocation rules
 -------------------------
+
 When a task is running the following rules define which resources are
 available to it:
 
@@ -252,7 +281,7 @@ Resource monitoring rules
 
 
 Notes on cache occupancy monitoring and control
------------------------------------------------
+===============================================
 When moving a task from one group to another you should remember that
 this only affects *new* cache allocations by the task. E.g. you may have
 a task in a monitor group showing 3 MB of cache occupancy. If you move
@@ -321,7 +350,7 @@ of the capacity of the cache. You could partition the cache into four
 equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
 Memory bandwidth Allocation and monitoring
-------------------------------------------
+==========================================
 
 For Memory bandwidth resource, by default the user controls the resource
 by indicating the percentage of total memory bandwidth.
@@ -369,7 +398,7 @@ In order to mitigate this and make the interface more user friendly,
 resctrl added support for specifying the bandwidth in MBps as well.  The
 kernel underneath would use a software feedback mechanism or a "Software
 Controller(mba_sc)" which reads the actual bandwidth using MBM counters
-and adjust the memowy bandwidth percentages to ensure
+and adjust the memowy bandwidth percentages to ensure::
 
 	"actual bandwidth < user specified bandwidth".
 
@@ -380,14 +409,14 @@ sections.
 
 L3 schemata file details (code and data prioritization disabled)
 ----------------------------------------------------------------
-With CDP disabled the L3 schemata format is:
+With CDP disabled the L3 schemata format is::
 
 	L3:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
 
 L3 schemata file details (CDP enabled via mount option to resctrl)
 ------------------------------------------------------------------
 When CDP is enabled L3 control is split into two separate resources
-so you can specify independent masks for code and data like this:
+so you can specify independent masks for code and data like this::
 
 	L3data:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
 	L3code:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
@@ -395,7 +424,7 @@ so you can specify independent masks for code and data like this:
 L2 schemata file details
 ------------------------
 L2 cache does not support code and data prioritization, so the
-schemata format is always:
+schemata format is always::
 
 	L2:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
 
@@ -403,6 +432,7 @@ Memory bandwidth Allocation (default mode)
 ------------------------------------------
 
 Memory b/w domain is L3 cache.
+::
 
 	MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
 
@@ -410,6 +440,7 @@ Memory bandwidth Allocation specified in MBps
 ---------------------------------------------
 
 Memory bandwidth domain is L3 cache.
+::
 
 	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
 
@@ -418,17 +449,18 @@ Reading/writing the schemata file
 Reading the schemata file will show the state of all resources
 on all domains. When writing you only need to specify those values
 which you wish to change.  E.g.
+::
 
-# cat schemata
-L3DATA:0=fffff;1=fffff;2=fffff;3=fffff
-L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
-# echo "L3DATA:2=3c0;" > schemata
-# cat schemata
-L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
-L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
+  # cat schemata
+  L3DATA:0=fffff;1=fffff;2=fffff;3=fffff
+  L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
+  # echo "L3DATA:2=3c0;" > schemata
+  # cat schemata
+  L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
+  L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
 Cache Pseudo-Locking
---------------------
+====================
 CAT enables a user to specify the amount of cache space that an
 application can fill. Cache pseudo-locking builds on the fact that a
 CPU can still read and write data pre-allocated outside its current
@@ -442,6 +474,7 @@ a region of memory with reduced average read latency.
 The creation of a cache pseudo-locked region is triggered by a request
 from the user to do so that is accompanied by a schemata of the region
 to be pseudo-locked. The cache pseudo-locked region is created as follows:
+
 - Create a CAT allocation CLOSNEW with a CBM matching the schemata
   from the user of the cache region that will contain the pseudo-locked
   memory. This region must not overlap with any current CAT allocation/CLOS
@@ -480,6 +513,7 @@ initial mmap() handling, there is no enforcement afterwards and the
 application self needs to ensure it remains affine to the correct cores.
 
 Pseudo-locking is accomplished in two stages:
+
 1) During the first stage the system administrator allocates a portion
    of cache that should be dedicated to pseudo-locking. At this time an
    equivalent portion of memory is allocated, loaded into allocated
@@ -506,7 +540,7 @@ by user space in order to obtain access to the pseudo-locked memory region.
 An example of cache pseudo-locked region creation and usage can be found below.
 
 Cache Pseudo-Locking Debugging Interface
----------------------------------------
+----------------------------------------
 The pseudo-locking debugging interface is enabled by default (if
 CONFIG_DEBUG_FS is enabled) and can be found in /sys/kernel/debug/resctrl.
 
@@ -514,6 +548,7 @@ There is no explicit way for the kernel to test if a provided memory
 location is present in the cache. The pseudo-locking debugging interface uses
 the tracing infrastructure to provide two ways to measure cache residency of
 the pseudo-locked region:
+
 1) Memory access latency using the pseudo_lock_mem_latency tracepoint. Data
    from these measurements are best visualized using a hist trigger (see
    example below). In this test the pseudo-locked region is traversed at
@@ -529,87 +564,97 @@ it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
 write-only file, pseudo_lock_measure, is present in this directory. The
 measurement of the pseudo-locked region depends on the number written to this
 debugfs file:
-1 -  writing "1" to the pseudo_lock_measure file will trigger the latency
+
+1:
+     writing "1" to the pseudo_lock_measure file will trigger the latency
      measurement captured in the pseudo_lock_mem_latency tracepoint. See
      example below.
-2 -  writing "2" to the pseudo_lock_measure file will trigger the L2 cache
+2:
+     writing "2" to the pseudo_lock_measure file will trigger the L2 cache
      residency (cache hits and misses) measurement captured in the
      pseudo_lock_l2 tracepoint. See example below.
-3 -  writing "3" to the pseudo_lock_measure file will trigger the L3 cache
+3:
+     writing "3" to the pseudo_lock_measure file will trigger the L3 cache
      residency (cache hits and misses) measurement captured in the
      pseudo_lock_l3 tracepoint.
 
 All measurements are recorded with the tracing infrastructure. This requires
 the relevant tracepoints to be enabled before the measurement is triggered.
 
-Example of latency debugging interface:
+Example of latency debugging interface
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In this example a pseudo-locked region named "newlock" was created. Here is
 how we can measure the latency in cycles of reading from this region and
 visualize this data with a histogram that is available if CONFIG_HIST_TRIGGERS
-is set:
-# :> /sys/kernel/debug/tracing/trace
-# echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
-# echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
-# echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-# echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
-# cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist
-
-# event histogram
-#
-# trigger info: hist:keys=latency:vals=hitcount:sort=hitcount:size=2048 [active]
-#
-
-{ latency:        456 } hitcount:          1
-{ latency:         50 } hitcount:         83
-{ latency:         36 } hitcount:         96
-{ latency:         44 } hitcount:        174
-{ latency:         48 } hitcount:        195
-{ latency:         46 } hitcount:        262
-{ latency:         42 } hitcount:        693
-{ latency:         40 } hitcount:       3204
-{ latency:         38 } hitcount:       3484
-
-Totals:
-    Hits: 8192
-    Entries: 9
-   Dropped: 0
-
-Example of cache hits/misses debugging:
+is set::
+
+  # :> /sys/kernel/debug/tracing/trace
+  # echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
+  # echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+  # echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+  # echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+  # cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist
+
+  # event histogram
+  #
+  # trigger info: hist:keys=latency:vals=hitcount:sort=hitcount:size=2048 [active]
+  #
+
+  { latency:        456 } hitcount:          1
+  { latency:         50 } hitcount:         83
+  { latency:         36 } hitcount:         96
+  { latency:         44 } hitcount:        174
+  { latency:         48 } hitcount:        195
+  { latency:         46 } hitcount:        262
+  { latency:         42 } hitcount:        693
+  { latency:         40 } hitcount:       3204
+  { latency:         38 } hitcount:       3484
+
+  Totals:
+      Hits: 8192
+      Entries: 9
+    Dropped: 0
+
+Example of cache hits/misses debugging
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In this example a pseudo-locked region named "newlock" was created on the L2
 cache of a platform. Here is how we can obtain details of the cache hits
 and misses using the platform's precision counters.
+::
 
-# :> /sys/kernel/debug/tracing/trace
-# echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
-# echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-# echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
-# cat /sys/kernel/debug/tracing/trace
+  # :> /sys/kernel/debug/tracing/trace
+  # echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+  # echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+  # echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+  # cat /sys/kernel/debug/tracing/trace
 
-# tracer: nop
-#
-#                              _-----=> irqs-off
-#                             / _----=> need-resched
-#                            | / _---=> hardirq/softirq
-#                            || / _--=> preempt-depth
-#                            ||| /     delay
-#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
-#              | |       |   ||||       |         |
- pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=4097 miss=0
+  # tracer: nop
+  #
+  #                              _-----=> irqs-off
+  #                             / _----=> need-resched
+  #                            | / _---=> hardirq/softirq
+  #                            || / _--=> preempt-depth
+  #                            ||| /     delay
+  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+  #              | |       |   ||||       |         |
+  pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=4097 miss=0
 
 
-Examples for RDT allocation usage:
+Examples for RDT allocation usage
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1) Example 1
 
-Example 1
----------
 On a two socket machine (one L3 cache per socket) with just four bits
 for cache bit masks, minimum b/w of 10% with a memory bandwidth
-granularity of 10%
+granularity of 10%.
+::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p0 p1
-# echo "L3:0=3;1=c\nMB:0=50;1=50" > /sys/fs/resctrl/p0/schemata
-# echo "L3:0=3;1=3\nMB:0=50;1=50" > /sys/fs/resctrl/p1/schemata
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+  # echo "L3:0=3;1=c\nMB:0=50;1=50" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3;1=3\nMB:0=50;1=50" > /sys/fs/resctrl/p1/schemata
 
 The default resource group is unmodified, so we have access to all parts
 of all caches (its schemata file reads "L3:0=f;1=f").
@@ -628,100 +673,106 @@ the b/w accordingly.
 
 If the MBA is specified in MB(megabytes) then user can enter the max b/w in MB
 rather than the percentage values.
+::
 
-# echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
-# echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata
+  # echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata
 
 In the above example the tasks in "p1" and "p0" on socket 0 would use a max b/w
 of 1024MB where as on socket 1 they would use 500MB.
 
-Example 2
----------
+2) Example 2
+
 Again two sockets, but this time with a more realistic 20-bit mask.
 
 Two real time tasks pid=1234 running on processor 0 and pid=5678 running on
 processor 1 on socket 0 on a 2-socket and dual core machine. To avoid noisy
 neighbors, each of the two real-time tasks exclusively occupies one quarter
 of L3 cache on socket 0.
+::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
 
 First we reset the schemata for the default group so that the "upper"
 50% of the L3 cache on socket 0 and 50% of memory b/w cannot be used by
-ordinary tasks:
+ordinary tasks::
 
-# echo "L3:0=3ff;1=fffff\nMB:0=50;1=100" > schemata
+  # echo "L3:0=3ff;1=fffff\nMB:0=50;1=100" > schemata
 
 Next we make a resource group for our first real time task and give
 it access to the "top" 25% of the cache on socket 0.
+::
 
-# mkdir p0
-# echo "L3:0=f8000;1=fffff" > p0/schemata
+  # mkdir p0
+  # echo "L3:0=f8000;1=fffff" > p0/schemata
 
 Finally we move our first real time task into this resource group. We
 also use taskset(1) to ensure the task always runs on a dedicated CPU
 on socket 0. Most uses of resource groups will also constrain which
 processors tasks run on.
+::
 
-# echo 1234 > p0/tasks
-# taskset -cp 1 1234
+  # echo 1234 > p0/tasks
+  # taskset -cp 1 1234
 
-Ditto for the second real time task (with the remaining 25% of cache):
+Ditto for the second real time task (with the remaining 25% of cache)::
 
-# mkdir p1
-# echo "L3:0=7c00;1=fffff" > p1/schemata
-# echo 5678 > p1/tasks
-# taskset -cp 2 5678
+  # mkdir p1
+  # echo "L3:0=7c00;1=fffff" > p1/schemata
+  # echo 5678 > p1/tasks
+  # taskset -cp 2 5678
 
 For the same 2 socket system with memory b/w resource and CAT L3 the
 schemata would look like(Assume min_bandwidth 10 and bandwidth_gran is
 10):
 
-For our first real time task this would request 20% memory b/w on socket
-0.
+For our first real time task this would request 20% memory b/w on socket 0.
+::
 
-# echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
+  # echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
 
 For our second real time task this would request an other 20% memory b/w
 on socket 0.
+::
 
-# echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
+  # echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
 
-Example 3
----------
+3) Example 3
 
 A single socket system which has real-time tasks running on core 4-7 and
 non real-time workload assigned to core 0-3. The real-time tasks share text
 and data, so a per task association is not required and due to interaction
 with the kernel it's desired that the kernel on these cores shares L3 with
 the tasks.
+::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
 
 First we reset the schemata for the default group so that the "upper"
 50% of the L3 cache on socket 0, and 50% of memory bandwidth on socket 0
-cannot be used by ordinary tasks:
+cannot be used by ordinary tasks::
 
-# echo "L3:0=3ff\nMB:0=50" > schemata
+  # echo "L3:0=3ff\nMB:0=50" > schemata
 
 Next we make a resource group for our real time cores and give it access
 to the "top" 50% of the cache on socket 0 and 50% of memory bandwidth on
 socket 0.
+::
 
-# mkdir p0
-# echo "L3:0=ffc00\nMB:0=50" > p0/schemata
+  # mkdir p0
+  # echo "L3:0=ffc00\nMB:0=50" > p0/schemata
 
 Finally we move core 4-7 over to the new group and make sure that the
 kernel and the tasks running there get 50% of the cache. They should
 also get 50% of memory bandwidth assuming that the cores 4-7 are SMT
 siblings and only the real time threads are scheduled on the cores 4-7.
+::
 
-# echo F0 > p0/cpus
+  # echo F0 > p0/cpus
 
-Example 4
----------
+4) Example 4
 
 The resource groups in previous examples were all in the default "shareable"
 mode allowing sharing of their cache allocations. If one resource group
@@ -732,157 +783,168 @@ In this example a new exclusive resource group will be created on a L2 CAT
 system with two L2 cache instances that can be configured with an 8-bit
 capacity bitmask. The new exclusive resource group will be configured to use
 25% of each cache instance.
+::
 
-# mount -t resctrl resctrl /sys/fs/resctrl/
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cd /sys/fs/resctrl
 
 First, we observe that the default group is configured to allocate to all L2
-cache:
+cache::
 
-# cat schemata
-L2:0=ff;1=ff
+  # cat schemata
+  L2:0=ff;1=ff
 
 We could attempt to create the new resource group at this point, but it will
-fail because of the overlap with the schemata of the default group:
-# mkdir p0
-# echo 'L2:0=0x3;1=0x3' > p0/schemata
-# cat p0/mode
-shareable
-# echo exclusive > p0/mode
--sh: echo: write error: Invalid argument
-# cat info/last_cmd_status
-schemata overlaps
+fail because of the overlap with the schemata of the default group::
+
+  # mkdir p0
+  # echo 'L2:0=0x3;1=0x3' > p0/schemata
+  # cat p0/mode
+  shareable
+  # echo exclusive > p0/mode
+  -sh: echo: write error: Invalid argument
+  # cat info/last_cmd_status
+  schemata overlaps
 
 To ensure that there is no overlap with another resource group the default
 resource group's schemata has to change, making it possible for the new
 resource group to become exclusive.
-# echo 'L2:0=0xfc;1=0xfc' > schemata
-# echo exclusive > p0/mode
-# grep . p0/*
-p0/cpus:0
-p0/mode:exclusive
-p0/schemata:L2:0=03;1=03
-p0/size:L2:0=262144;1=262144
+::
+
+  # echo 'L2:0=0xfc;1=0xfc' > schemata
+  # echo exclusive > p0/mode
+  # grep . p0/*
+  p0/cpus:0
+  p0/mode:exclusive
+  p0/schemata:L2:0=03;1=03
+  p0/size:L2:0=262144;1=262144
 
 A new resource group will on creation not overlap with an exclusive resource
-group:
-# mkdir p1
-# grep . p1/*
-p1/cpus:0
-p1/mode:shareable
-p1/schemata:L2:0=fc;1=fc
-p1/size:L2:0=786432;1=786432
-
-The bit_usage will reflect how the cache is used:
-# cat info/L2/bit_usage
-0=SSSSSSEE;1=SSSSSSEE
-
-A resource group cannot be forced to overlap with an exclusive resource group:
-# echo 'L2:0=0x1;1=0x1' > p1/schemata
--sh: echo: write error: Invalid argument
-# cat info/last_cmd_status
-overlaps with exclusive group
+group::
+
+  # mkdir p1
+  # grep . p1/*
+  p1/cpus:0
+  p1/mode:shareable
+  p1/schemata:L2:0=fc;1=fc
+  p1/size:L2:0=786432;1=786432
+
+The bit_usage will reflect how the cache is used::
+
+  # cat info/L2/bit_usage
+  0=SSSSSSEE;1=SSSSSSEE
+
+A resource group cannot be forced to overlap with an exclusive resource group::
+
+  # echo 'L2:0=0x1;1=0x1' > p1/schemata
+  -sh: echo: write error: Invalid argument
+  # cat info/last_cmd_status
+  overlaps with exclusive group
 
 Example of Cache Pseudo-Locking
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Lock portion of L2 cache from cache id 1 using CBM 0x3. Pseudo-locked
 region is exposed at /dev/pseudo_lock/newlock that can be provided to
 application for argument to mmap().
+::
 
-# mount -t resctrl resctrl /sys/fs/resctrl/
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cd /sys/fs/resctrl
 
 Ensure that there are bits available that can be pseudo-locked, since only
 unused bits can be pseudo-locked the bits to be pseudo-locked needs to be
-removed from the default resource group's schemata:
-# cat info/L2/bit_usage
-0=SSSSSSSS;1=SSSSSSSS
-# echo 'L2:1=0xfc' > schemata
-# cat info/L2/bit_usage
-0=SSSSSSSS;1=SSSSSS00
+removed from the default resource group's schemata::
+
+  # cat info/L2/bit_usage
+  0=SSSSSSSS;1=SSSSSSSS
+  # echo 'L2:1=0xfc' > schemata
+  # cat info/L2/bit_usage
+  0=SSSSSSSS;1=SSSSSS00
 
 Create a new resource group that will be associated with the pseudo-locked
 region, indicate that it will be used for a pseudo-locked region, and
-configure the requested pseudo-locked region capacity bitmask:
+configure the requested pseudo-locked region capacity bitmask::
 
-# mkdir newlock
-# echo pseudo-locksetup > newlock/mode
-# echo 'L2:1=0x3' > newlock/schemata
+  # mkdir newlock
+  # echo pseudo-locksetup > newlock/mode
+  # echo 'L2:1=0x3' > newlock/schemata
 
 On success the resource group's mode will change to pseudo-locked, the
 bit_usage will reflect the pseudo-locked region, and the character device
-exposing the pseudo-locked region will exist:
-
-# cat newlock/mode
-pseudo-locked
-# cat info/L2/bit_usage
-0=SSSSSSSS;1=SSSSSSPP
-# ls -l /dev/pseudo_lock/newlock
-crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
-
-/*
- * Example code to access one page of pseudo-locked cache region
- * from user space.
- */
-#define _GNU_SOURCE
-#include <fcntl.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/mman.h>
-
-/*
- * It is required that the application runs with affinity to only
- * cores associated with the pseudo-locked region. Here the cpu
- * is hardcoded for convenience of example.
- */
-static int cpuid = 2;
-
-int main(int argc, char *argv[])
-{
-	cpu_set_t cpuset;
-	long page_size;
-	void *mapping;
-	int dev_fd;
-	int ret;
-
-	page_size = sysconf(_SC_PAGESIZE);
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(cpuid, &cpuset);
-	ret = sched_setaffinity(0, sizeof(cpuset), &cpuset);
-	if (ret < 0) {
-		perror("sched_setaffinity");
-		exit(EXIT_FAILURE);
-	}
-
-	dev_fd = open("/dev/pseudo_lock/newlock", O_RDWR);
-	if (dev_fd < 0) {
-		perror("open");
-		exit(EXIT_FAILURE);
-	}
-
-	mapping = mmap(0, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-		       dev_fd, 0);
-	if (mapping == MAP_FAILED) {
-		perror("mmap");
-		close(dev_fd);
-		exit(EXIT_FAILURE);
-	}
-
-	/* Application interacts with pseudo-locked memory @mapping */
-
-	ret = munmap(mapping, page_size);
-	if (ret < 0) {
-		perror("munmap");
-		close(dev_fd);
-		exit(EXIT_FAILURE);
-	}
-
-	close(dev_fd);
-	exit(EXIT_SUCCESS);
-}
+exposing the pseudo-locked region will exist::
+
+  # cat newlock/mode
+  pseudo-locked
+  # cat info/L2/bit_usage
+  0=SSSSSSSS;1=SSSSSSPP
+  # ls -l /dev/pseudo_lock/newlock
+  crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
+
+::
+
+  /*
+  * Example code to access one page of pseudo-locked cache region
+  * from user space.
+  */
+  #define _GNU_SOURCE
+  #include <fcntl.h>
+  #include <sched.h>
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <unistd.h>
+  #include <sys/mman.h>
+
+  /*
+  * It is required that the application runs with affinity to only
+  * cores associated with the pseudo-locked region. Here the cpu
+  * is hardcoded for convenience of example.
+  */
+  static int cpuid = 2;
+
+  int main(int argc, char *argv[])
+  {
+    cpu_set_t cpuset;
+    long page_size;
+    void *mapping;
+    int dev_fd;
+    int ret;
+
+    page_size = sysconf(_SC_PAGESIZE);
+
+    CPU_ZERO(&cpuset);
+    CPU_SET(cpuid, &cpuset);
+    ret = sched_setaffinity(0, sizeof(cpuset), &cpuset);
+    if (ret < 0) {
+      perror("sched_setaffinity");
+      exit(EXIT_FAILURE);
+    }
+
+    dev_fd = open("/dev/pseudo_lock/newlock", O_RDWR);
+    if (dev_fd < 0) {
+      perror("open");
+      exit(EXIT_FAILURE);
+    }
+
+    mapping = mmap(0, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+            dev_fd, 0);
+    if (mapping == MAP_FAILED) {
+      perror("mmap");
+      close(dev_fd);
+      exit(EXIT_FAILURE);
+    }
+
+    /* Application interacts with pseudo-locked memory @mapping */
+
+    ret = munmap(mapping, page_size);
+    if (ret < 0) {
+      perror("munmap");
+      close(dev_fd);
+      exit(EXIT_FAILURE);
+    }
+
+    close(dev_fd);
+    exit(EXIT_SUCCESS);
+  }
 
 Locking between applications
 ----------------------------
@@ -921,86 +983,86 @@ Read lock:
  B) If success read the directory structure.
  C) funlock
 
-Example with bash:
-
-# Atomically read directory structure
-$ flock -s /sys/fs/resctrl/ find /sys/fs/resctrl
-
-# Read directory contents and create new subdirectory
-
-$ cat create-dir.sh
-find /sys/fs/resctrl/ > output.txt
-mask = function-of(output.txt)
-mkdir /sys/fs/resctrl/newres/
-echo mask > /sys/fs/resctrl/newres/schemata
-
-$ flock /sys/fs/resctrl/ ./create-dir.sh
-
-Example with C:
-
-/*
- * Example code do take advisory locks
- * before accessing resctrl filesystem
- */
-#include <sys/file.h>
-#include <stdlib.h>
-
-void resctrl_take_shared_lock(int fd)
-{
-	int ret;
-
-	/* take shared lock on resctrl filesystem */
-	ret = flock(fd, LOCK_SH);
-	if (ret) {
-		perror("flock");
-		exit(-1);
-	}
-}
-
-void resctrl_take_exclusive_lock(int fd)
-{
-	int ret;
-
-	/* release lock on resctrl filesystem */
-	ret = flock(fd, LOCK_EX);
-	if (ret) {
-		perror("flock");
-		exit(-1);
-	}
-}
-
-void resctrl_release_lock(int fd)
-{
-	int ret;
-
-	/* take shared lock on resctrl filesystem */
-	ret = flock(fd, LOCK_UN);
-	if (ret) {
-		perror("flock");
-		exit(-1);
-	}
-}
-
-void main(void)
-{
-	int fd, ret;
-
-	fd = open("/sys/fs/resctrl", O_DIRECTORY);
-	if (fd == -1) {
-		perror("open");
-		exit(-1);
-	}
-	resctrl_take_shared_lock(fd);
-	/* code to read directory contents */
-	resctrl_release_lock(fd);
-
-	resctrl_take_exclusive_lock(fd);
-	/* code to read and write directory contents */
-	resctrl_release_lock(fd);
-}
-
-Examples for RDT Monitoring along with allocation usage:
-
+Example with bash::
+
+  # Atomically read directory structure
+  $ flock -s /sys/fs/resctrl/ find /sys/fs/resctrl
+
+  # Read directory contents and create new subdirectory
+
+  $ cat create-dir.sh
+  find /sys/fs/resctrl/ > output.txt
+  mask = function-of(output.txt)
+  mkdir /sys/fs/resctrl/newres/
+  echo mask > /sys/fs/resctrl/newres/schemata
+
+  $ flock /sys/fs/resctrl/ ./create-dir.sh
+
+Example with C::
+
+  /*
+  * Example code do take advisory locks
+  * before accessing resctrl filesystem
+  */
+  #include <sys/file.h>
+  #include <stdlib.h>
+
+  void resctrl_take_shared_lock(int fd)
+  {
+    int ret;
+
+    /* take shared lock on resctrl filesystem */
+    ret = flock(fd, LOCK_SH);
+    if (ret) {
+      perror("flock");
+      exit(-1);
+    }
+  }
+
+  void resctrl_take_exclusive_lock(int fd)
+  {
+    int ret;
+
+    /* release lock on resctrl filesystem */
+    ret = flock(fd, LOCK_EX);
+    if (ret) {
+      perror("flock");
+      exit(-1);
+    }
+  }
+
+  void resctrl_release_lock(int fd)
+  {
+    int ret;
+
+    /* take shared lock on resctrl filesystem */
+    ret = flock(fd, LOCK_UN);
+    if (ret) {
+      perror("flock");
+      exit(-1);
+    }
+  }
+
+  void main(void)
+  {
+    int fd, ret;
+
+    fd = open("/sys/fs/resctrl", O_DIRECTORY);
+    if (fd == -1) {
+      perror("open");
+      exit(-1);
+    }
+    resctrl_take_shared_lock(fd);
+    /* code to read directory contents */
+    resctrl_release_lock(fd);
+
+    resctrl_take_exclusive_lock(fd);
+    /* code to read and write directory contents */
+    resctrl_release_lock(fd);
+  }
+
+Examples for RDT Monitoring along with allocation usage
+=======================================================
 Reading monitored data
 ----------------------
 Reading an event file (for ex: mon_data/mon_L3_00/llc_occupancy) would
@@ -1009,17 +1071,17 @@ group or CTRL_MON group.
 
 
 Example 1 (Monitor CTRL_MON group and subset of tasks in CTRL_MON group)
----------
+------------------------------------------------------------------------
 On a two socket machine (one L3 cache per socket) with just four bits
-for cache bit masks
+for cache bit masks::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p0 p1
-# echo "L3:0=3;1=c" > /sys/fs/resctrl/p0/schemata
-# echo "L3:0=3;1=3" > /sys/fs/resctrl/p1/schemata
-# echo 5678 > p1/tasks
-# echo 5679 > p1/tasks
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+  # echo "L3:0=3;1=c" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3;1=3" > /sys/fs/resctrl/p1/schemata
+  # echo 5678 > p1/tasks
+  # echo 5679 > p1/tasks
 
 The default resource group is unmodified, so we have access to all parts
 of all caches (its schemata file reads "L3:0=f;1=f").
@@ -1029,47 +1091,51 @@ Tasks that are under the control of group "p0" may only allocate from the
 Tasks in group "p1" use the "lower" 50% of cache on both sockets.
 
 Create monitor groups and assign a subset of tasks to each monitor group.
+::
 
-# cd /sys/fs/resctrl/p1/mon_groups
-# mkdir m11 m12
-# echo 5678 > m11/tasks
-# echo 5679 > m12/tasks
+  # cd /sys/fs/resctrl/p1/mon_groups
+  # mkdir m11 m12
+  # echo 5678 > m11/tasks
+  # echo 5679 > m12/tasks
 
 fetch data (data shown in bytes)
+::
 
-# cat m11/mon_data/mon_L3_00/llc_occupancy
-16234000
-# cat m11/mon_data/mon_L3_01/llc_occupancy
-14789000
-# cat m12/mon_data/mon_L3_00/llc_occupancy
-16789000
+  # cat m11/mon_data/mon_L3_00/llc_occupancy
+  16234000
+  # cat m11/mon_data/mon_L3_01/llc_occupancy
+  14789000
+  # cat m12/mon_data/mon_L3_00/llc_occupancy
+  16789000
 
 The parent ctrl_mon group shows the aggregated data.
+::
 
-# cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
-31234000
+  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
+  31234000
 
 Example 2 (Monitor a task from its creation)
----------
-On a two socket machine (one L3 cache per socket)
+--------------------------------------------
+On a two socket machine (one L3 cache per socket)::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p0 p1
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
 
 An RMID is allocated to the group once its created and hence the <cmd>
 below is monitored from its creation.
+::
 
-# echo $$ > /sys/fs/resctrl/p1/tasks
-# <cmd>
+  # echo $$ > /sys/fs/resctrl/p1/tasks
+  # <cmd>
 
-Fetch the data
+Fetch the data::
 
-# cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
-31789000
+  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
+  31789000
 
 Example 3 (Monitor without CAT support or before creating CAT groups)
----------
+---------------------------------------------------------------------
 
 Assume a system like HSW has only CQM and no CAT support. In this case
 the resctrl will still mount but cannot create CTRL_MON directories.
@@ -1078,27 +1144,29 @@ able to monitor all tasks including kernel threads.
 
 This can also be used to profile jobs cache size footprint before being
 able to allocate them to different allocation groups.
+::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir mon_groups/m01
-# mkdir mon_groups/m02
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir mon_groups/m01
+  # mkdir mon_groups/m02
 
-# echo 3478 > /sys/fs/resctrl/mon_groups/m01/tasks
-# echo 2467 > /sys/fs/resctrl/mon_groups/m02/tasks
+  # echo 3478 > /sys/fs/resctrl/mon_groups/m01/tasks
+  # echo 2467 > /sys/fs/resctrl/mon_groups/m02/tasks
 
 Monitor the groups separately and also get per domain data. From the
 below its apparent that the tasks are mostly doing work on
 domain(socket) 0.
+::
 
-# cat /sys/fs/resctrl/mon_groups/m01/mon_L3_00/llc_occupancy
-31234000
-# cat /sys/fs/resctrl/mon_groups/m01/mon_L3_01/llc_occupancy
-34555
-# cat /sys/fs/resctrl/mon_groups/m02/mon_L3_00/llc_occupancy
-31234000
-# cat /sys/fs/resctrl/mon_groups/m02/mon_L3_01/llc_occupancy
-32789
+  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_00/llc_occupancy
+  31234000
+  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_01/llc_occupancy
+  34555
+  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_00/llc_occupancy
+  31234000
+  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_01/llc_occupancy
+  32789
 
 
 Example 4 (Monitor real time tasks)
@@ -1107,15 +1175,17 @@ Example 4 (Monitor real time tasks)
 A single socket system which has real time tasks running on cores 4-7
 and non real time tasks on other cpus. We want to monitor the cache
 occupancy of the real time threads on these cores.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p1
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p1
+Move the cpus 4-7 over to p1::
 
-Move the cpus 4-7 over to p1
-# echo f0 > p1/cpus
+  # echo f0 > p1/cpus
 
-View the llc occupancy snapshot
+View the llc occupancy snapshot::
 
-# cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
-11234000
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
+  11234000
-- 
2.20.1

