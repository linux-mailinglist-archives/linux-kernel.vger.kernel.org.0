Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB1973E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHUHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 03:50:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:24467 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfHUHu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:50:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 00:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="329947210"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2019 00:50:56 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL v1 0/4] stm class/intel_th: Fixes for v5.3
Date:   Wed, 21 Aug 2019 10:49:51 +0300
Message-Id: <20190821074955.3925-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the fixes that I have for v5.3. One is an actual bugfix that's
copied to stable, one SPDX header fix and two new PCI IDs, copied to
stable as well. Signed tag below, individual patches follow. Please
consider applying or pulling. Thanks!

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

