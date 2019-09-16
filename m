Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7770EB35CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfIPHj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 03:39:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52580 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfIPHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:39:59 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C248F28C721;
        Mon, 16 Sep 2019 08:39:56 +0100 (BST)
Date:   Mon, 16 Sep 2019 09:39:53 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] i3c: Changes for 5.4
Message-ID: <20190916093953.05c99b3e@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C PR for 5.4.

Regards,

Boris

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.4

for you to fetch changes up to 6030f42d20cedc04df019891851320f3e257038b:

  i3c: master: Use dev_to_i3cmaster() (2019-08-27 09:43:59 +0200)

----------------------------------------------------------------
Core changes:
* Export i3c_device_match_id() so driver can get per-device data
* Add addr and lvr fields to i2c_dev_desc so we can attach I2C devices
  that are not described in the DT
* Add a missing of_node_put()
* Fix a memory leak
* Use dev_to_i3cmaster() instead of open-coding it

Driver changes:
* Use for_each_set_bit() in the Cadence driver

----------------------------------------------------------------
Andy Shevchenko (1):
      i3c: master: cdns: Use for_each_set_bit()

Axel Lin (1):
      i3c: master: Use dev_to_i3cmaster()

Nishka Dasgupta (1):
      i3c: master: Add of_node_put() before return

Przemyslaw Gaj (1):
      i3c: add addr and lvr to i2c_dev_desc structure

Vitor Soares (1):
      i3c: move i3c_device_match_id to device.c and export it

Wenwen Wang (1):
      i3c: master: fix a memory leak bug

 drivers/i3c/device.c                 | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master.c                 | 67 ++++++++++++++-----------------------------------------------------
 drivers/i3c/master/dw-i3c-master.c   |  4 ++--
 drivers/i3c/master/i3c-master-cdns.c | 30 ++++++++++++------------------
 include/linux/i3c/device.h           |  4 ++++
 include/linux/i3c/master.h           |  5 +++++
 6 files changed, 90 insertions(+), 73 deletions(-)
