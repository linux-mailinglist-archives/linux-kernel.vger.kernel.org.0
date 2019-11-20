Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984FC103AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfKTNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:08:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:58358 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfKTNIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:08:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 05:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="196848286"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2019 05:08:23 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/3] intel_th: Updates for v5.5
Date:   Wed, 20 Nov 2019 15:08:03 +0200
Message-Id: <20191120130806.44028-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some more updates I have for v5.5. These are 2 new PCI IDs and a
bug fix for something old. Stable CC on all of them. Signed tag below.
Individual patches follow. I made sure that there aren't merge conflicts
with other PCI ID patches in char-misc-next, so either way is good.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-for-greg-20191120

for you to fetch changes up to 76a8b4a23ca875ef06401326b9d799f74f55d82a:

  intel_th: pci: Add Tiger Lake CPU support (2019-11-20 14:53:05 +0200)

----------------------------------------------------------------
intel_th: Updates for v5.5

These are:
  * a double free fix
  * two new PCI IDs

----------------------------------------------------------------
Alexander Shishkin (3):
      intel_th: Fix a double put_device() in error path
      intel_th: pci: Add Ice Lake CPU support
      intel_th: pci: Add Tiger Lake CPU support

 drivers/hwtracing/intel_th/core.c |  8 ++------
 drivers/hwtracing/intel_th/pci.c  | 10 ++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.24.0

