Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D507B8E883
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfHOJq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 05:46:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:33322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfHOJq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:46:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 02:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="188449129"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 02:46:50 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 0/3] x86: cpu: Add new Airmont CPU model
Date:   Thu, 15 Aug 2019 17:46:44 +0800
Message-Id: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Atom CPU based Lightning Mountain(LGM) network processor SoC has recently
taped out. Although the Atom CPU used in LGM is based upon Airmont uArch but it
has a few differences. Its a new variant of Atom Airmont cpu model.

This series of patches adds support for this new CPU model.

Patches are baselined upon Linux 5.3-rc4 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core

Patch 1 replaces existing direct values usage with constant definitions when
access CPU models.

Patch 2 adds a constant definition for the new Atom CPU model.

Patch 3 updates capabilities & vulnerabilities applicable for this new CPU model.


Rahul Tanwar (3):
  x86: cpu: Use constant definitions for CPU type
  x86: cpu: Add new Intel Atom CPU type
  x86: arch: Add arch support for new Intel Atom CPU

 arch/x86/include/asm/intel-family.h | 1 +
 arch/x86/kernel/cpu/common.c        | 1 +
 arch/x86/kernel/cpu/intel.c         | 7 ++++---
 arch/x86/kernel/tsc_msr.c           | 5 +++++
 4 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.11.0

