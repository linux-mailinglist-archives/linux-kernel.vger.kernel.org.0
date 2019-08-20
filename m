Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4F95C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfHTKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 06:17:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:35575 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfHTKRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:17:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 03:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="185872320"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2019 03:17:00 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/4] stm class/intel_th: Fixes for v5.3
Date:   Tue, 20 Aug 2019 13:16:49 +0300
Message-Id: <20190820101653.74738-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the fixes that I have for v5.3. One is an actual bugfix that's
copied to stable, one SPDX header fix and two new PCI IDs. Signed tag
below, individual patches follow. Please consider applying or pulling.
Thanks!

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-intel_th-fixes-for-greg-20190820

for you to fetch changes up to 1114218bb49423c2ed6767f0f385f994da71c068:

  intel_th: pci: Add Tiger Lake support (2019-08-20 13:02:59 +0300)

----------------------------------------------------------------
stm class/intel_th: Fixes for v5.3

These are:
  * Double-free fix, going back to v4.4.
  * SPDX license header fix.
  * 2 new PCI IDs.

----------------------------------------------------------------
Alexander Shishkin (2):
      intel_th: pci: Add support for another Lewisburg PCH
      intel_th: pci: Add Tiger Lake support

Ding Xiang (1):
      stm class: Fix a double free of stm_source_device

Nishad Kamdar (1):
      intel_th: Use the correct style for SPDX License Identifier

 drivers/hwtracing/intel_th/msu.h |  2 +-
 drivers/hwtracing/intel_th/pci.c | 10 ++++++++++
 drivers/hwtracing/intel_th/pti.h |  2 +-
 drivers/hwtracing/stm/core.c     |  1 -
 4 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.23.0.rc1

