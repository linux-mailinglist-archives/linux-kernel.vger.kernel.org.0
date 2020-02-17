Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08005161311
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgBQNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 08:16:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:31120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgBQNOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:14:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 05:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="253413948"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2020 05:14:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5FA9A189; Mon, 17 Feb 2020 15:14:46 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/19] platform/x86: Rework intel_scu_ipc and intel_pmc_ipc drivers
Date:   Mon, 17 Feb 2020 16:14:27 +0300
Message-Id: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
IPC communications with minor differences. This duplication does not make
much sense so this series reworks the two drivers so that there is only a
single implementation of the SCU IPC. In addition to that the API will be
updated to take SCU instance pointer as an argument, and most of the
callers will be converted to this new API. The old API is left there but
the plan is to get rid the callers and then the old API as well (this is
something we are working with Andy Shevchenko).

The intel_pmc_ipc.c is then moved under MFD which suits better for this
kind of a driver that pretty much sets up the SCU IPC and then creates a
bunch of platform devices for the things sitting behind the PMC. The driver
is renamed to intel_pmc_bxt.c which should follow the existing conventions
under drivers/mfd (and it is only meant for Intel Broxton derivatives).

This is on top of platform-driver-x86.git/for-next branch because there is
already some cleanup work queued that re-organizes Kconfig and Makefile
entries.

I have tested this on Intel Joule (Broxton-M) board.

Previous versions can be found:

  v5: https://www.spinics.net/lists/platform-driver-x86/msg20841.html
  v4: https://www.spinics.net/lists/platform-driver-x86/msg20658.html
  v3: https://www.spinics.net/lists/platform-driver-x86/msg20583.html
  v2: https://www.spinics.net/lists/platform-driver-x86/msg20446.html
  v1: https://www.spinics.net/lists/platform-driver-x86/msg20359.html

Changes from v5:

  * Order config symbols the same in both Kconfig and Makefile
  * Move error log outside of critical section, keep in one line
  * Move legacy API functions into legacy header in a separate patch (this
  * is new patch 3/19).
  * Rename devres -> dr and put kzalloc into single line
  * Capitalize words used in abbreviation in kernel-doc comments of struct
    intel_soc_pmic.
  * Use DEVICE_ATTR_WO() in MFD driver attributes
  * Put MAINTAINERS entries into correct place

Changes from v4:

  * Cleanups already merged in v5.6-rc1 reducing this series to 18 patches.
  * Make SCU IPC a simple class, and now intel_scu_ipc_register() creates
    a new device that belongs to the SCU IPC class under the parent.
  * Handle refcounting using the newly created device.
  * We still call try_module_get() in intel_scu_ipc_dev_get() because we
    need to make sure the SCU IPC provider module is not unloaded but the
    SCU IPC device refcount is now increased and decreased as well.
  * Make SCU IPC code to log an error if there is a failure so that callers
    don't need to do that.
  * Replace telemetry_pltconfig_valid() with telemetry_get_pltdata().
  * Move intel_pmc_gcr_update() closer to intel_pmc_gcr_read64().
  * Use more standard "update" pattern in intel_pmc_gcr_update() and move
    check outside of the lock.
  * Use platform_get_irq_optional() instead.
  * Move iTCO resource extraction into separate helper function
    (intel_pmc_get_tco_resources()).

Changes from v3:

  * Rename intel_scu_ipc_probe() to intel_scu_ipc_register() and _remove()
    to _unregister() accordingly.
  * Make intel_scu_ipc_register() to perform handle resource request and
    ioremap itself.
  * Add devm_intel_scu_ipc_register().
  * Improve kernel-docs of struct intel_soc_pmic.
  * Add Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt to document the
    two sysfs attributes the driver exposes.
  * Fix typos in the MFD driver
  * Drop gcr_data_readq() wrapper
  * No need to check for !pmcdev.gcr_mem_base in the MFD accessors
  * Allocate PMC instance dynamically and pass this from the callers
    (telemetry) as well
  * Take the lock in intel_pmc_s0ix_counter_read() to be consistent with other
    register accessors (and serialize them).
  * Use kstrtoul() return value directly (new patch)
  * Use static const MFD cell and resources where possible. Take a copy of
    these before they get populated and passed to the MFD code.
  * Use module_platform_driver() in the MFD driver
  * Drop dev_dbg() prints.
  * Return -EINVAL instead of -ENXIO when platform_get_resource() for
    mandatory resources.
  * Clarify "residency" in intel_pmc_s0ix_counter_read().

Changes from v2:

  * Added review tags from Andy
  * Patch 12: Put intel_scu_ipc_probe() prototype and implementation in one line
  * Patch 12: Correct wording in Kconfig description.
  * Patch 12: Put devm_request_irq() in one line.
  * Patch 14: Add blank line before intel_scu_ipc_dev_update() in header.
  * Patch 14: intel_scu_ipc_dev_update() move 'u8 data' to the next line in header.
  * Patch 14: Drop outlen check in intel_scu_ipc_dev_command_with_size().
  * Patch 16: Added Guenter's ack.
  * Patch 25: Put intel_scu_ipc_dev_command() call in one line.
  * Patch 25: Put intel_scu_ipc_dev_simple_command() call in one line.
  * Patch 32: Drop X86_INTEL_MID dependency from INTEL_SCU_PCI.
  * Patch 34: Split MFD_INTEL_PMC_BXT dependencies one per line.
  * Patch 35: Reorder to happen before patch 34.
  * Patch 35: Drop comma from terminating line.

Changes from v1:

  * Update changelog of patch 16 according to what the patch actually does.
  * Add kernel-doc for struct intel_soc_pmic.
  * Move octal permission patch to be before MFD conversion.
  * Convert the intel_pmc_bxt.c to MFD APIs whilst it is being moved under
    drivers/mfd.

Mika Westerberg (19):
  platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
  platform/x86: intel_scu_ipc: Log more information if SCU IPC command fails
  platform/x86: intel_scu_ipc: Move legacy SCU IPC API to a separate header
  platform/x86: intel_scu_ipc: Introduce new SCU IPC API
  platform/x86: intel_mid_powerbtn: Convert to use new SCU IPC API
  watchdog: intel-mid_wdt: Convert to use new SCU IPC API
  platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
  platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
  platform/x86: intel_pmc_ipc: Start using SCU IPC
  mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
  mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
  mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
  platform/x86: intel_telemetry: Convert to use new SCU IPC API
  platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
  x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
  platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
  platform/x86: intel_telemetry: Add telemetry_get_pltdata()
  platform/x86: intel_pmc_ipc: Convert to MFD
  MAINTAINERS: Update entry for Intel Broxton PMC driver

 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
 MAINTAINERS                                   |  23 +-
 arch/x86/Kconfig                              |   2 +-
 arch/x86/include/asm/intel-mid.h              |   9 +-
 arch/x86/include/asm/intel_pmc_ipc.h          |  59 --
 arch/x86/include/asm/intel_scu_ipc.h          | 114 ++-
 arch/x86/include/asm/intel_scu_ipc_legacy.h   |  91 ++
 arch/x86/include/asm/intel_telemetry.h        |   6 +-
 drivers/mfd/Kconfig                           |  20 +-
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel_pmc_bxt.c                   | 489 +++++++++
 drivers/mfd/intel_soc_pmic_bxtwc.c            |  34 +-
 drivers/mfd/intel_soc_pmic_mrfld.c            |  10 +-
 drivers/platform/x86/Kconfig                  |  46 +-
 drivers/platform/x86/Makefile                 |   2 +-
 drivers/platform/x86/intel_mid_powerbtn.c     |  15 +-
 drivers/platform/x86/intel_pmc_ipc.c          | 949 ------------------
 drivers/platform/x86/intel_scu_ipc.c          | 447 +++++++--
 drivers/platform/x86/intel_scu_ipcutil.c      |  43 +-
 drivers/platform/x86/intel_scu_pcidrv.c       |  68 ++
 drivers/platform/x86/intel_telemetry_core.c   |  17 +-
 .../platform/x86/intel_telemetry_debugfs.c    |  15 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c |  97 +-
 drivers/usb/typec/tcpm/Kconfig                |   2 +-
 drivers/watchdog/intel-mid_wdt.c              |  53 +-
 include/linux/mfd/intel_pmc_bxt.h             |  21 +
 include/linux/mfd/intel_soc_pmic.h            |  15 +
 27 files changed, 1365 insertions(+), 1305 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h

-- 
2.25.0

