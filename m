Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272674ED07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFUQUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:20:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:13108 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfFUQUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 09:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,401,1557212400"; 
   d="scan'208";a="312029829"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2019 09:20:07 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/4] intel_th: Fixes for v5.2
Date:   Fri, 21 Jun 2019 19:19:26 +0300
Message-Id: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the fixes I have for v5.2 cycle: two gcc warnings, one dma mapping
issue and a new PCI ID. All issues were introduced in the same cycle, so no
-stable involvement.

All patches are aiaiai-clean. Signed git tag below. Individual patches in
follow-up emails. Please consider pulling or applying. Thanks!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20190621

for you to fetch changes up to 0001019cdade192cb05a3c4e07df3b30a20c8ed0:

  intel_th: pci: Add Ice Lake NNPI support (2019-06-21 18:34:27 +0300)

----------------------------------------------------------------
intel_th: Fixes for v5.2

These are:
  * two trivial fixes for gcc warnings introduced in v5.2-rc1
  * a fix for a dma mapping problem, introduced in v5.2-rc1
  * a new PCI ID

----------------------------------------------------------------
Alexander Shishkin (2):
      intel_th: msu: Fix single mode with disabled IOMMU
      intel_th: pci: Add Ice Lake NNPI support

Shaokun Zhang (1):
      intel_th: msu: Fix unused variable warning on arm64 platform

YueHaibing (1):
      intel_th: msu: Remove set but not used variable 'last'

 drivers/hwtracing/intel_th/msu.c | 45 ++++++++++++++++++++++++++--------------
 drivers/hwtracing/intel_th/pci.c |  5 +++++
 2 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.20.1

