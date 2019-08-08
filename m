Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7CD85F30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 12:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfHHKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 06:03:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:25684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbfHHKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:03:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 03:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="179792908"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2019 03:02:10 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/3] serial: lantiq: Update driver to support new SoC
Date:   Thu,  8 Aug 2019 18:02:05 +0800
Message-Id: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new Intel Atom based Lightning Mountain(LGM) network processor SoC
which reuses Lantiq ASC serial controller IP. This patch series updates the
driver design and code to add support for LGM SoC as well.

These patches are baselined upon Linux 5.3-rc2 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

Patch 1 modifies devicetree compatible string to a use explicit string instead
of a fixed macro because this patch series adds support for multiple SoCs.

Patch 2 modifies driver design to support dynamic assignment of IRQ resources
& ISRs based on devicetree node compatible entries. This is because new LGM SoC
supports single IRQ for all tx/rx/err interrupts while older SoCs support three
separate IRQs for tx/rx/err interrupts.

Patch 3 adds LGM SoC specific IRQ/ISR support.

v2:
* Address review concerns.
* Separate dt binding document from this patch series. Will try to push it
  separately by first converting existing txt file to YAML and then add new
  properties.
* Omit resending one patch in this series which is already reviewed & added
  to tty-next.


Rahul Tanwar (3):
  serial: lantiq: Use proper DT compatible string
  serial: lantiq: Make IRQ & ISR assignment dynamic
  serial: lantiq: Add support for Lightning Mountain SoC

 drivers/tty/serial/lantiq.c | 214 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 168 insertions(+), 46 deletions(-)

-- 
2.11.0

