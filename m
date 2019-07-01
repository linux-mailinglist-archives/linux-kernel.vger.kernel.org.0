Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E09113CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfEBHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 03:10:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45430 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:10:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so664690pfi.12;
        Thu, 02 May 2019 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXKLqNbdKMsr+So4FirwVoM6E4uV1tpbCqLVtQ2RXFk=;
        b=hAMsgSYj4/pC44erKa0nJcbEE9x00q77P2ZEiooSY70YaHRzmwfMQoFNDePNE94vyT
         UQzbWZ6/4UhhJO/n2+ragRDRfJZj0/t9S3TSs3SerXkgpIuRa42sIdZMFQLAubh7n+NL
         ql2q7GaHBWepNd6QjReLpP49THYk3ijkhLKnmXTj8w36O2wSCtCShnKv3iBKpdvVaX4J
         vG4damAt0AjsXuQeq13djenttuK9YRhDpnBAcMMRtJuxWqqZ5UyedYh5Oidu8eJrB0V2
         SHI56BTI7tZMVgI7+9KY8z9xBMbDVRl3YYtMHiJnPyYHCzO/rhJNVocH+H0x5VNC/Zpu
         7dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXKLqNbdKMsr+So4FirwVoM6E4uV1tpbCqLVtQ2RXFk=;
        b=PAGv1uOhjpP+LqcpR2f2pmC+s8V/Jb84uHQra+pPmnXdEikndSNn4RCGThYk4WbIYF
         WlKLzao77BloqIyOHpfy4kjAK2i2xMbeGNdkZYJv0ZKwD5soh0/pIyXBkvjl2jW/jXOn
         HIfV3kjjKjKFL9XWEWrsPzGhdCrIdNHoCY9IeeWpE47OhDSBtcoa9FVYg8DznN4LDOUF
         weBESa8CCZPWguvdEQd9rihTF+PXspj7om2mWjBCpIbEw7txmiNvMDrltnjglnVA6dIy
         91UsfU8DOaW10SKi0BBBPvwD1IEcjfojywLepAtPzFNMwVcXgJ3nc0bA1if6gG2Orubm
         SpCA==
X-Gm-Message-State: APjAAAXqzY2CwtONfRGUGaWwGk1ZF77tyw0/9oyzT3LHon4T7XtZHzRe
        AZKoQstN06+JpXupG8+dxHQ=
X-Google-Smtp-Source: APXvYqxIVI7+3e4SqP71oWsUqzJUrHZRFhsgCUtzkSR3eY8Ihw9EvVD24jMhlBZUcPsPqpgae77zwg==
X-Received: by 2002:a63:6103:: with SMTP id v3mr2453736pgb.48.1556781041380;
        Thu, 02 May 2019 00:10:41 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:10:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 11/27] Documentation: x86: convert pat.txt to reST
Date:   Thu,  2 May 2019 15:06:17 +0800
Message-Id: <20190502070633.9809-12-changbin.du@gmail.com>
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
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst |   1 +
 Documentation/x86/pat.rst   | 242 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/pat.txt   | 230 ----------------------------------
 3 files changed, 243 insertions(+), 230 deletions(-)
 create mode 100644 Documentation/x86/pat.rst
 delete mode 100644 Documentation/x86/pat.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 769c4491e9cb..f7012e4afacd 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -17,3 +17,4 @@ x86-specific Documentation
    zero-page
    tlb
    mtrr
+   pat
diff --git a/Documentation/x86/pat.rst b/Documentation/x86/pat.rst
new file mode 100644
index 000000000000..9a298fd97d74
--- /dev/null
+++ b/Documentation/x86/pat.rst
@@ -0,0 +1,242 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+PAT (Page Attribute Table)
+==========================
+
+x86 Page Attribute Table (PAT) allows for setting the memory attribute at the
+page level granularity. PAT is complementary to the MTRR settings which allows
+for setting of memory types over physical address ranges. However, PAT is
+more flexible than MTRR due to its capability to set attributes at page level
+and also due to the fact that there are no hardware limitations on number of
+such attribute settings allowed. Added flexibility comes with guidelines for
+not having memory type aliasing for the same physical memory with multiple
+virtual addresses.
+
+PAT allows for different types of memory attributes. The most commonly used
+ones that will be supported at this time are:
+
+===  ==============
+WB   Write-back
+UC   Uncached
+WC   Write-combined
+WT   Write-through
+UC-  Uncached Minus
+===  ==============
+
+
+PAT APIs
+========
+
+There are many different APIs in the kernel that allows setting of memory
+attributes at the page level. In order to avoid aliasing, these interfaces
+should be used thoughtfully. Below is a table of interfaces available,
+their intended usage and their memory attribute relationships. Internally,
+these APIs use a reserve_memtype()/free_memtype() interface on the physical
+address range to avoid any aliasing.
+
++------------------------+----------+--------------+------------------+
+| API                    |    RAM   |  ACPI,...    |  Reserved/Holes  |
++------------------------+----------+--------------+------------------+
+| ioremap                |    --    |    UC-       |       UC-        |
++------------------------+----------+--------------+------------------+
+| ioremap_cache          |    --    |    WB        |       WB         |
++------------------------+----------+--------------+------------------+
+| ioremap_uc             |    --    |    UC        |       UC         |
++------------------------+----------+--------------+------------------+
+| ioremap_nocache        |    --    |    UC-       |       UC-        |
++------------------------+----------+--------------+------------------+
+| ioremap_wc             |    --    |    --        |       WC         |
++------------------------+----------+--------------+------------------+
+| ioremap_wt             |    --    |    --        |       WT         |
++------------------------+----------+--------------+------------------+
+| set_memory_uc,         |    UC-   |    --        |       --         |
+| set_memory_wb          |          |              |                  |
++------------------------+----------+--------------+------------------+
+| set_memory_wc,         |    WC    |    --        |       --         |
+| set_memory_wb          |          |              |                  |
++------------------------+----------+--------------+------------------+
+| set_memory_wt,         |    WT    |    --        |       --         |
+| set_memory_wb          |          |              |                  |
++------------------------+----------+--------------+------------------+
+| pci sysfs resource     |    --    |    --        |       UC-        |
++------------------------+----------+--------------+------------------+
+| pci sysfs resource_wc  |    --    |    --        |       WC         |
+| is IORESOURCE_PREFETCH |          |              |                  |
++------------------------+----------+--------------+------------------+
+| pci proc               |    --    |    --        |       UC-        |
+| !PCIIOC_WRITE_COMBINE  |          |              |                  |
++------------------------+----------+--------------+------------------+
+| pci proc               |    --    |    --        |       WC         |
+| PCIIOC_WRITE_COMBINE   |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |   WB/WC/UC-  |    WB/WC/UC-     |
+| read-write             |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |    UC-       |       UC-        |
+| mmap SYNC flag         |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |   WB/WC/UC-  |  WB/WC/UC-       |
+| mmap !SYNC flag        |          |              |                  |
+| and                    |          |(from existing|  (from existing  |
+| any alias to this area |          |alias)        |  alias)          |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |    WB        |       WB         |
+| mmap !SYNC flag        |          |              |                  |
+| no alias to this area  |          |              |                  |
+| and                    |          |              |                  |
+| MTRR says WB           |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |    --        |       UC-        |
+| mmap !SYNC flag        |          |              |                  |
+| no alias to this area  |          |              |                  |
+| and                    |          |              |                  |
+| MTRR says !WB          |          |              |                  |
++------------------------+----------+--------------+------------------+
+
+
+Advanced APIs for drivers
+=========================
+
+A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
+vmf_insert_pfn.
+
+Drivers wanting to export some pages to userspace do it by using mmap
+interface and a combination of:
+
+  1) pgprot_noncached()
+  2) io_remap_pfn_range() or remap_pfn_range() or vmf_insert_pfn()
+
+With PAT support, a new API pgprot_writecombine is being added. So, drivers can
+continue to use the above sequence, with either pgprot_noncached() or
+pgprot_writecombine() in step 1, followed by step 2.
+
+In addition, step 2 internally tracks the region as UC or WC in memtype
+list in order to ensure no conflicting mapping.
+
+Note that this set of APIs only works with IO (non RAM) regions. If driver
+wants to export a RAM region, it has to do set_memory_uc() or set_memory_wc()
+as step 0 above and also track the usage of those pages and use set_memory_wb()
+before the page is freed to free pool.
+
+MTRR effects on PAT / non-PAT systems
+=====================================
+
+The following table provides the effects of using write-combining MTRRs when
+using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
+mtrr_add() usage will be phased out in favor of arch_phys_wc_add() which will
+be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
+is made, should already have been ioremapped with WC attributes or PAT entries,
+this can be done by using ioremap_wc() / set_memory_wc().  Devices which
+combine areas of IO memory desired to remain uncacheable with areas where
+write-combining is desirable should consider use of ioremap_uc() followed by
+set_memory_wc() to white-list effective write-combined areas.  Such use is
+nevertheless discouraged as the effective memory type is considered
+implementation defined, yet this strategy can be used as last resort on devices
+with size-constrained regions where otherwise MTRR write-combining would
+otherwise not be effective.
+::
+
+  ====  =======  ===  =========================  =====================
+  MTRR  Non-PAT  PAT  Linux ioremap value        Effective memory type
+  ====  =======  ===  =========================  =====================
+        PAT                                        Non-PAT |  PAT
+        |PCD                                               |
+        ||PWT                                              |
+        |||                                                |
+  WC    000      WB   _PAGE_CACHE_MODE_WB             WC   |   WC
+  WC    001      WC   _PAGE_CACHE_MODE_WC             WC*  |   WC
+  WC    010      UC-  _PAGE_CACHE_MODE_UC_MINUS       WC*  |   UC
+  WC    011      UC   _PAGE_CACHE_MODE_UC             UC   |   UC
+  ====  =======  ===  =========================  =====================
+
+  (*) denotes implementation defined and is discouraged
+
+.. note:: -- in the above table mean "Not suggested usage for the API". Some
+  of the --'s are strictly enforced by the kernel. Some others are not really
+  enforced today, but may be enforced in future.
+
+For ioremap and pci access through /sys or /proc - The actual type returned
+can be more restrictive, in case of any existing aliasing for that address.
+For example: If there is an existing uncached mapping, a new ioremap_wc can
+return uncached mapping in place of write-combine requested.
+
+set_memory_[uc|wc|wt] and set_memory_wb should be used in pairs, where driver
+will first make a region uc, wc or wt and switch it back to wb after use.
+
+Over time writes to /proc/mtrr will be deprecated in favor of using PAT based
+interfaces. Users writing to /proc/mtrr are suggested to use above interfaces.
+
+Drivers should use ioremap_[uc|wc] to access PCI BARs with [uc|wc] access
+types.
+
+Drivers should use set_memory_[uc|wc|wt] to set access type for RAM ranges.
+
+
+PAT debugging
+=============
+
+With CONFIG_DEBUG_FS enabled, PAT memtype list can be examined by::
+
+  # mount -t debugfs debugfs /sys/kernel/debug
+  # cat /sys/kernel/debug/x86/pat_memtype_list
+  PAT memtype list:
+  uncached-minus @ 0x7fadf000-0x7fae0000
+  uncached-minus @ 0x7fb19000-0x7fb1a000
+  uncached-minus @ 0x7fb1a000-0x7fb1b000
+  uncached-minus @ 0x7fb1b000-0x7fb1c000
+  uncached-minus @ 0x7fb1c000-0x7fb1d000
+  uncached-minus @ 0x7fb1d000-0x7fb1e000
+  uncached-minus @ 0x7fb1e000-0x7fb25000
+  uncached-minus @ 0x7fb25000-0x7fb26000
+  uncached-minus @ 0x7fb26000-0x7fb27000
+  uncached-minus @ 0x7fb27000-0x7fb28000
+  uncached-minus @ 0x7fb28000-0x7fb2e000
+  uncached-minus @ 0x7fb2e000-0x7fb2f000
+  uncached-minus @ 0x7fb2f000-0x7fb30000
+  uncached-minus @ 0x7fb31000-0x7fb32000
+  uncached-minus @ 0x80000000-0x90000000
+
+This list shows physical address ranges and various PAT settings used to
+access those physical address ranges.
+
+Another, more verbose way of getting PAT related debug messages is with
+"debugpat" boot parameter. With this parameter, various debug messages are
+printed to dmesg log.
+
+PAT Initialization
+==================
+
+The following table describes how PAT is initialized under various
+configurations. The PAT MSR must be updated by Linux in order to support WC
+and WT attributes. Otherwise, the PAT MSR has the value programmed in it
+by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
+
+ ==== ===== ==========================  =========  =======
+ MTRR PAT   Call Sequence               PAT State  PAT MSR
+ ==== ===== ==========================  =========  =======
+ E    E     MTRR -> PAT init            Enabled    OS
+ E    D     MTRR -> PAT init            Disabled    -
+ D    E     MTRR -> PAT disable         Disabled   BIOS
+ D    D     MTRR -> PAT disable         Disabled    -
+ -    np/E  PAT  -> PAT disable         Disabled   BIOS
+ -    np/D  PAT  -> PAT disable         Disabled    -
+ E    !P/E  MTRR -> PAT init            Disabled   BIOS
+ D    !P/E  MTRR -> PAT disable         Disabled   BIOS
+ !M   !P/E  MTRR stub -> PAT disable    Disabled   BIOS
+ ==== ===== ==========================  =========  =======
+
+  Legend
+
+ ========= =======================================
+ E         Feature enabled in CPU
+ D	   Feature disabled/unsupported in CPU
+ np	   "nopat" boot option specified
+ !P	   CONFIG_X86_PAT option unset
+ !M	   CONFIG_MTRR option unset
+ Enabled   PAT state set to enabled
+ Disabled  PAT state set to disabled
+ OS        PAT initializes PAT MSR with OS setting
+ BIOS      PAT keeps PAT MSR with BIOS setting
+ ========= =======================================
+
diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
deleted file mode 100644
index 481d8d8536ac..000000000000
--- a/Documentation/x86/pat.txt
+++ /dev/null
@@ -1,230 +0,0 @@
-
-PAT (Page Attribute Table)
-
-x86 Page Attribute Table (PAT) allows for setting the memory attribute at the
-page level granularity. PAT is complementary to the MTRR settings which allows
-for setting of memory types over physical address ranges. However, PAT is
-more flexible than MTRR due to its capability to set attributes at page level
-and also due to the fact that there are no hardware limitations on number of
-such attribute settings allowed. Added flexibility comes with guidelines for
-not having memory type aliasing for the same physical memory with multiple
-virtual addresses.
-
-PAT allows for different types of memory attributes. The most commonly used
-ones that will be supported at this time are Write-back, Uncached,
-Write-combined, Write-through and Uncached Minus.
-
-
-PAT APIs
---------
-
-There are many different APIs in the kernel that allows setting of memory
-attributes at the page level. In order to avoid aliasing, these interfaces
-should be used thoughtfully. Below is a table of interfaces available,
-their intended usage and their memory attribute relationships. Internally,
-these APIs use a reserve_memtype()/free_memtype() interface on the physical
-address range to avoid any aliasing.
-
-
--------------------------------------------------------------------
-API                    |    RAM   |  ACPI,...  |  Reserved/Holes  |
------------------------|----------|------------|------------------|
-                       |          |            |                  |
-ioremap                |    --    |    UC-     |       UC-        |
-                       |          |            |                  |
-ioremap_cache          |    --    |    WB      |       WB         |
-                       |          |            |                  |
-ioremap_uc             |    --    |    UC      |       UC         |
-                       |          |            |                  |
-ioremap_nocache        |    --    |    UC-     |       UC-        |
-                       |          |            |                  |
-ioremap_wc             |    --    |    --      |       WC         |
-                       |          |            |                  |
-ioremap_wt             |    --    |    --      |       WT         |
-                       |          |            |                  |
-set_memory_uc          |    UC-   |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-set_memory_wc          |    WC    |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-set_memory_wt          |    WT    |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-pci sysfs resource     |    --    |    --      |       UC-        |
-                       |          |            |                  |
-pci sysfs resource_wc  |    --    |    --      |       WC         |
- is IORESOURCE_PREFETCH|          |            |                  |
-                       |          |            |                  |
-pci proc               |    --    |    --      |       UC-        |
- !PCIIOC_WRITE_COMBINE |          |            |                  |
-                       |          |            |                  |
-pci proc               |    --    |    --      |       WC         |
- PCIIOC_WRITE_COMBINE  |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
- read-write            |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    UC-     |       UC-        |
- mmap SYNC flag        |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
- mmap !SYNC flag       |          |(from exist-|  (from exist-    |
- and                   |          |  ing alias)|    ing alias)    |
- any alias to this area|          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    WB      |       WB         |
- mmap !SYNC flag       |          |            |                  |
- no alias to this area |          |            |                  |
- and                   |          |            |                  |
- MTRR says WB          |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    --      |       UC-        |
- mmap !SYNC flag       |          |            |                  |
- no alias to this area |          |            |                  |
- and                   |          |            |                  |
- MTRR says !WB         |          |            |                  |
-                       |          |            |                  |
--------------------------------------------------------------------
-
-Advanced APIs for drivers
--------------------------
-A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
-vmf_insert_pfn
-
-Drivers wanting to export some pages to userspace do it by using mmap
-interface and a combination of
-1) pgprot_noncached()
-2) io_remap_pfn_range() or remap_pfn_range() or vmf_insert_pfn()
-
-With PAT support, a new API pgprot_writecombine is being added. So, drivers can
-continue to use the above sequence, with either pgprot_noncached() or
-pgprot_writecombine() in step 1, followed by step 2.
-
-In addition, step 2 internally tracks the region as UC or WC in memtype
-list in order to ensure no conflicting mapping.
-
-Note that this set of APIs only works with IO (non RAM) regions. If driver
-wants to export a RAM region, it has to do set_memory_uc() or set_memory_wc()
-as step 0 above and also track the usage of those pages and use set_memory_wb()
-before the page is freed to free pool.
-
-MTRR effects on PAT / non-PAT systems
--------------------------------------
-
-The following table provides the effects of using write-combining MTRRs when
-using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
-mtrr_add() usage will be phased out in favor of arch_phys_wc_add() which will
-be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
-is made, should already have been ioremapped with WC attributes or PAT entries,
-this can be done by using ioremap_wc() / set_memory_wc().  Devices which
-combine areas of IO memory desired to remain uncacheable with areas where
-write-combining is desirable should consider use of ioremap_uc() followed by
-set_memory_wc() to white-list effective write-combined areas.  Such use is
-nevertheless discouraged as the effective memory type is considered
-implementation defined, yet this strategy can be used as last resort on devices
-with size-constrained regions where otherwise MTRR write-combining would
-otherwise not be effective.
-
-----------------------------------------------------------------------
-MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
-----------------------------------------------------------------------
-                                                  Non-PAT |  PAT
-     PAT
-     |PCD
-     ||PWT
-     |||
-WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
-WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
-WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
-WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
-----------------------------------------------------------------------
-
-(*) denotes implementation defined and is discouraged
-
-Notes:
-
--- in the above table mean "Not suggested usage for the API". Some of the --'s
-are strictly enforced by the kernel. Some others are not really enforced
-today, but may be enforced in future.
-
-For ioremap and pci access through /sys or /proc - The actual type returned
-can be more restrictive, in case of any existing aliasing for that address.
-For example: If there is an existing uncached mapping, a new ioremap_wc can
-return uncached mapping in place of write-combine requested.
-
-set_memory_[uc|wc|wt] and set_memory_wb should be used in pairs, where driver
-will first make a region uc, wc or wt and switch it back to wb after use.
-
-Over time writes to /proc/mtrr will be deprecated in favor of using PAT based
-interfaces. Users writing to /proc/mtrr are suggested to use above interfaces.
-
-Drivers should use ioremap_[uc|wc] to access PCI BARs with [uc|wc] access
-types.
-
-Drivers should use set_memory_[uc|wc|wt] to set access type for RAM ranges.
-
-
-PAT debugging
--------------
-
-With CONFIG_DEBUG_FS enabled, PAT memtype list can be examined by
-
-# mount -t debugfs debugfs /sys/kernel/debug
-# cat /sys/kernel/debug/x86/pat_memtype_list
-PAT memtype list:
-uncached-minus @ 0x7fadf000-0x7fae0000
-uncached-minus @ 0x7fb19000-0x7fb1a000
-uncached-minus @ 0x7fb1a000-0x7fb1b000
-uncached-minus @ 0x7fb1b000-0x7fb1c000
-uncached-minus @ 0x7fb1c000-0x7fb1d000
-uncached-minus @ 0x7fb1d000-0x7fb1e000
-uncached-minus @ 0x7fb1e000-0x7fb25000
-uncached-minus @ 0x7fb25000-0x7fb26000
-uncached-minus @ 0x7fb26000-0x7fb27000
-uncached-minus @ 0x7fb27000-0x7fb28000
-uncached-minus @ 0x7fb28000-0x7fb2e000
-uncached-minus @ 0x7fb2e000-0x7fb2f000
-uncached-minus @ 0x7fb2f000-0x7fb30000
-uncached-minus @ 0x7fb31000-0x7fb32000
-uncached-minus @ 0x80000000-0x90000000
-
-This list shows physical address ranges and various PAT settings used to
-access those physical address ranges.
-
-Another, more verbose way of getting PAT related debug messages is with
-"debugpat" boot parameter. With this parameter, various debug messages are
-printed to dmesg log.
-
-PAT Initialization
-------------------
-
-The following table describes how PAT is initialized under various
-configurations. The PAT MSR must be updated by Linux in order to support WC
-and WT attributes. Otherwise, the PAT MSR has the value programmed in it
-by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
-
- MTRR PAT   Call Sequence               PAT State  PAT MSR
- =========================================================
- E    E     MTRR -> PAT init            Enabled    OS
- E    D     MTRR -> PAT init            Disabled    -
- D    E     MTRR -> PAT disable         Disabled   BIOS
- D    D     MTRR -> PAT disable         Disabled    -
- -    np/E  PAT  -> PAT disable         Disabled   BIOS
- -    np/D  PAT  -> PAT disable         Disabled    -
- E    !P/E  MTRR -> PAT init            Disabled   BIOS
- D    !P/E  MTRR -> PAT disable         Disabled   BIOS
- !M   !P/E  MTRR stub -> PAT disable    Disabled   BIOS
-
- Legend
- ------------------------------------------------
- E         Feature enabled in CPU
- D	   Feature disabled/unsupported in CPU
- np	   "nopat" boot option specified
- !P	   CONFIG_X86_PAT option unset
- !M	   CONFIG_MTRR option unset
- Enabled   PAT state set to enabled
- Disabled  PAT state set to disabled
- OS        PAT initializes PAT MSR with OS setting
- BIOS      PAT keeps PAT MSR with BIOS setting
-
-- 
2.20.1

