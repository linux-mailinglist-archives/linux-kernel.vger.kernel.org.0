Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD080145A31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 17:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgAVQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 11:47:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:42792 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:46:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="222087533"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2020 08:46:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D57881AD; Wed, 22 Jan 2020 18:46:19 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] platform/x86: intel_pmc_ipc: Cleanups
Date:   Wed, 22 Jan 2020 19:46:10 +0300
Message-Id: <20200122164619.73563-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is another independent cleanup series that I split out from my SCU/PMC
IPC rework patch set [1] as suggested by Greg. This removes code that is
not used anywhere and makes certain functions static as they are not called
outside of the driver. We also make the driver to use driver->dev_groups to
expose sysfs attributes.

[1] https://lkml.org/lkml/2020/1/21/678

Mika Westerberg (9):
  platform/x86: intel_pmc_ipc: Make intel_pmc_gcr_update() static
  platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
  platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_raw_cmd() static
  platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
  platform/x86: intel_pmc_ipc: Drop ipc_data_readb()
  platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
  platform/x86: intel_pmc_ipc: Use octal permissions in sysfs attributes
  platform/x86: intel_pmc_ipc: Propagate error from kstrtoul()
  platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups

 arch/x86/include/asm/intel_pmc_ipc.h |  32 --------
 drivers/platform/x86/intel_pmc_ipc.c | 114 ++++-----------------------
 2 files changed, 16 insertions(+), 130 deletions(-)

-- 
2.24.1

