Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EAA18C823
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 08:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCTHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 03:31:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:44358 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgCTHbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:31:16 -0400
IronPort-SDR: xyR9PVkL7ORHhatlppD6+IcjC6PpbfO/dobL8BjW/uK/kcyQL1YSk4TISBtbFX9y2WZJVoqI+b
 wV5I0eUv0xeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 00:31:15 -0700
IronPort-SDR: Dv2rHBkMF6Aji8poRBpaGvrfdk8DQm32NBmcjr71Cs+UOz38m+hDhFOkIcOaVfKbADjFH9WQos
 F0Qxeqd5kD/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="234429344"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2020 00:31:11 -0700
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH v8 0/3] perf x86: Exposing IO stack to IO PMON mapping through sysfs
Date:   Fri, 20 Mar 2020 10:31:07 +0300
Message-Id: <20200320073110.4761-1-roman.sudarikov@linux.intel.com>
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
v7: https://lkml.kernel.org/r/20200303135418.9621-1-roman.sudarikov@linux.intel.com/
Changes in this revision are:
v7 -> v8:
- Addressed comments from Kan Liang:
  1. Fixed coding style issues (gotos in error path, comments style)

The previous version can be found at:
v6: https://lkml.kernel.org/r/20200213150148.5627-1-roman.sudarikov@linux.intel.com/

Changes in this revision are:
v6 -> v7:
- Addressed comments from Greg Kroah-Hartman:
  1. Added proper handling of load/unload path
  2. Simplified the mapping attribute show procedure by using the segment value
     of the first available root bus for all mapping attributes which is safe
     due to current implementation supports single segment configuration only
  3. Fixed coding style issues (extra lines, gotos in error path, macros etc)

The previous version can be found at:
v5: https://lkml.kernel.org/r/20200211161549.19828-1-roman.sudarikov@linux.intel.com/

Changes in this revision are:
v5 -> v6:
  1. Changed the mapping attribute name to "dieX"
  2. Called sysfs_attr_init() prior to dynamically creating the mapping attrs
  3. Removed redundant "empty" attribute
  4. Got an agreement on the mapping attribute format

The previous version can be found at:
v4: https://lkml.kernel.org/r/20200117133759.5729-1-roman.sudarikov@linux.intel.com/

Changes in this revision are:
v4 -> v5:
- Addressed comments from Greg Kroah-Hartman:
  1. Using the attr_update flow for newly introduced optional attributes
  2. No subfolder, optional attributes are created the same level as 'cpumask'
  3. No symlinks, optional attributes are created as files
  4. Single file for each IIO PMON block to node mapping
  5. Added Documentation/ABI/sysfs-devices-mapping

The previous version can be found at:
v3: https://lkml.kernel.org/r/20200113135444.12027-1-roman.sudarikov@linux.intel.com

Changes in this revision are:
v3 -> v4:
- Addressed comments from Greg Kroah-Hartman:
  1. Reworked handling of newly introduced attribute.
  2. Required Documentation update is expected in the follow up patchset


The previous version can be found at:
v2: https://lkml.kernel.org/r/20191210091451.6054-1-roman.sudarikov@linux.intel.com

Changes in this revision are:
v2 -> v3:
  1. Addressed comments from Peter and Kan

The previous version can be found at:
v1: https://lkml.kernel.org/r/20191126163630.17300-1-roman.sudarikov@linux.intel.com

Changes in this revision are:
v1 -> v2:
  1. Fixed process related issues;
  2. This patch set includes kernel support for IIO stack to PMON mapping;
  3. Stephane raised concerns regarding output format which may require
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

Roman Sudarikov (3):
  perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
  perf x86: Topology max dies for whole system
  perf x86: Exposing an Uncore unit to PMON for Intel Xeon® server
    platform

 .../ABI/testing/sysfs-devices-mapping         |  33 +++
 arch/x86/events/intel/uncore.c                |  21 +-
 arch/x86/events/intel/uncore.h                |  18 ++
 arch/x86/events/intel/uncore_snbep.c          | 191 ++++++++++++++++++
 4 files changed, 257 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-mapping


base-commit: 6c90b86a745a446717fdf408c4a8a4631a5e8ee3
-- 
2.19.1

