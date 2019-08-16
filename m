Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36D8FD95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHPITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 04:19:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:16899 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHPITI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:19:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 01:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="352483421"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga005.jf.intel.com with ESMTP; 16 Aug 2019 01:19:03 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/3] x86/cpu: Add new Airmont CPU model
Date:   Fri, 16 Aug 2019 16:18:56 +0800
Message-Id: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A forthcoming product uses a new variant of Atom Airmont CPU model.
This series adds support for this new CPU model.

Patches are baselined upon Linux 5.3-rc4 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core

v2:
* Address review concerns about incorrect patch prefixes & redundant comments.
* Improve summary in cover letter and commit messages.

Rahul Tanwar (3):
  x86/cpu: Use constant definitions for CPU type
  x86/cpu: Add new Intel Atom CPU model name
  x86/cpu: Update init data for new Atom CPU model

 arch/x86/include/asm/intel-family.h | 1 +
 arch/x86/kernel/cpu/common.c        | 1 +
 arch/x86/kernel/cpu/intel.c         | 7 ++++---
 arch/x86/kernel/tsc_msr.c           | 5 +++++
 4 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.11.0

