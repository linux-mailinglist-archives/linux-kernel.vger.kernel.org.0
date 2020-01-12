Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4887A138632
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbgALMSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 07:18:54 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60746 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732750AbgALMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 07:18:54 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 12 Jan 2020 14:18:51 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00CCIpSO023227;
        Sun, 12 Jan 2020 14:18:51 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 00/10] platform/x86: Mellanox new system classes and new features
Date:   Sun, 12 Jan 2020 12:18:39 +0000
Message-Id: <20200112121849.7056-1-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds new features for the existing Mellanox systems
and introduces two new system classes.

Patch #1 contains cosmetic changes.
Patch #2 fixes wrong attribute name in documentation.
Patch #3 adds missed attribute name in documentation.
Patch #4 adds more definitions for system attributes
Patches #5 extends documentation.
Patches #6-#7 introduce new system class for the systems equipped with
Spectrum 1 (32x100GbE Ethernet switch) device and Switch-IB/Switch-IB2
devices (36x100Gbe InfiniBand switch).
Patches #7-#8 add support for new group capability register
Patches #10 introduces new system class for the systems equipped
with new switch device Spectrum 3 (32x400GbE/64x200G/128x100G Ethernet
switch).

Vadim Pasternak (10):
  platform/x86: mlx-platform: Cosmetic changes
  Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs
    interfaces
  Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces
  platform/x86: mlx-platform: Add more definitions for system attributes
  Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
  platform/x86: mlx-platform: Set system mux configuration based on
    system type
  platform/x86: mlx-platform: Add support for new system type
  platform/x86: mlx-platform: Add support for new capability register
  platform/mellanox: mlxreg-hotplug: Add support for new capability
    register
  platform/x86: mlx-platform: Add support for next generation systems

 Documentation/ABI/stable/sysfs-driver-mlxreg-io |  83 +++-
 drivers/platform/mellanox/mlxreg-hotplug.c      |  14 +
 drivers/platform/x86/mlx-platform.c             | 564 +++++++++++++++++++++++-
 include/linux/platform_data/mlxreg.h            |   2 +
 4 files changed, 643 insertions(+), 20 deletions(-)

-- 
2.11.0

