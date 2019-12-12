Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD511D075
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfLLPEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 10:04:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:25637 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbfLLPEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:04:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 07:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="225952345"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2019 07:04:41 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH v3 0/2] perf x86: Exposing IO stack to IO PMON mapping through sysfs
Date:   Thu, 12 Dec 2019 18:04:38 +0300
Message-Id: <20191212150440.11377-1-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

The previous version can be found at:
v2: https://lkml.org/lkml/2019/12/10/185

Changes in this revision are:
v2 -> v3:
- Addressed comments from Peter and Kan

The previous version can be found at:
v1: https://lkml.org/lkml/2019/11/26/447

Changes in this revision are:
v1 -> v2:
- Fixed process related issues;
- This patch set includes kernel support for IIO stack to PMON mapping;
- Stephane raised concerns regarding output format which may require
code changes in the user space part of the feature only. We will continue 
output format discussion in the context of user space update.

Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
significant changes in the integrated I/O (IIO) architecture. The new
solution introduces IIO stacks which are responsible for managing traffic
between the PCIe domain and the Mesh domain. Each IIO stack has its own
PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
or various built-in accelerators. IIO PMON blocks allow concurrent
monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.

Software is supposed to program required perf counters within each IIO
stack and gather performance data. The tricky thing here is that IIO PMON
reports data per IIO stack but users have no idea what IIO stacks are -
they only know devices which are connected to the platform.

Understanding IIO stack concept to find which IIO stack that particular
IO device is connected to, or to identify an IIO PMON block to program
for monitoring specific IIO stack assumes a lot of implicit knowledge
about given Intel server platform architecture.

This patch set introduces:
1. An infrastructure for exposing an Uncore unit to Uncore PMON mapping
   through sysfs-backend;
2. A new --iiostat mode in perf stat to provide I/O performance metrics
   per I/O device.

Usage examples:

1. List all devices below IIO stacks
  ./perf stat --iiostat=show

Sample output w/o libpci:

    S0-RootPort0-uncore_iio_0<00:00.0>
    S1-RootPort0-uncore_iio_0<81:00.0>
    S0-RootPort1-uncore_iio_1<18:00.0>
    S1-RootPort1-uncore_iio_1<86:00.0>
    S1-RootPort1-uncore_iio_1<88:00.0>
    S0-RootPort2-uncore_iio_2<3d:00.0>
    S1-RootPort2-uncore_iio_2<af:00.0>
    S1-RootPort3-uncore_iio_3<da:00.0>

Sample output with libpci:

    S0-RootPort0-uncore_iio_0<00:00.0 Sky Lake-E DMI3 Registers>
    S1-RootPort0-uncore_iio_0<81:00.0 Ethernet Controller X710 for 10GbE SFP+>
    S0-RootPort1-uncore_iio_1<18:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
    S1-RootPort1-uncore_iio_1<86:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
    S1-RootPort1-uncore_iio_1<88:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
    S0-RootPort2-uncore_iio_2<3d:00.0 Ethernet Connection X722 for 10GBASE-T>
    S1-RootPort2-uncore_iio_2<af:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
    S1-RootPort3-uncore_iio_3<da:00.0 NVMe Datacenter SSD [Optane]>

2. Collect metrics for all I/O devices below IIO stack

  ./perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
    357708+0 records in
    357707+0 records out
    375083606016 bytes (375 GB, 349 GiB) copied, 215.381 s, 1.7 GB/s

  Performance counter stats for 'system wide':

     device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
    00:00.0                    0                    0                    0                    0
    81:00.0                    0                    0                    0                    0
    18:00.0                    0                    0                    0                    0
    86:00.0                    0                    0                    0                    0
    88:00.0                    0                    0                    0                    0
    3b:00.0                    3                    0                    0                    0
    3c:03.0                    3                    0                    0                    0
    3d:00.0                    3                    0                    0                    0
    af:00.0                    0                    0                    0                    0
    da:00.0               358559                   44                    0                   22

    215.383783574 seconds time elapsed


3. Collect metrics for comma separted list of I/O devices 

  ./perf stat --iiostat=da:00.0 -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
    381555+0 records in
    381554+0 records out
    400088457216 bytes (400 GB, 373 GiB) copied, 374.044 s, 1.1 GB/s

  Performance counter stats for 'system wide':

     device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
    da:00.0               382462                   47                    0                   23

    374.045775505 seconds time elapsed


Roman Sudarikov (2):
  perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
  perf x86: Exposing an Uncore unit to PMON for Intel Xeon® server
    platform

 arch/x86/events/intel/uncore.c       |  39 ++++++-
 arch/x86/events/intel/uncore.h       |  10 +-
 arch/x86/events/intel/uncore_snbep.c | 162 +++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 3 deletions(-)


base-commit: 219d54332a09e8d8741c1e1982f5eae56099de85
-- 
2.19.1

