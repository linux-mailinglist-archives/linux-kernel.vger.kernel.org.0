Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC43C15BF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 14:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgBMNYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 08:24:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:44559 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgBMNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:24:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 05:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="347728482"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2020 05:24:29 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/9] usb: typec: Driver for Intel PMC Mux-Agent
Date:   Thu, 13 Feb 2020 16:24:19 +0300
Message-Id: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Intel PMC (Power Management Controller) microcontroller, which is
available on most SOCs from Intel, has a function called mux-agent.
The mux-agent, when visible to the operating system, makes it possible
to control the various USB muxes on the system.

In practice the mux-agent is a device that controls multiple muxes.
Unfortunately both the USB Type-C Class and the USB Role Class don't
have proper support for that kind of devices that handle multiple
muxes, which is why I had to tweak the APIs a bit.

On top of the API changes, and the driver of course, I'm adding a
header for the Thunderbolt 3 alt mode since the "mux-agent" supports
it.

thanks,

Heikki Krogerus (9):
  usb: typec: mux: Allow the muxes to be named
  usb: typec: mux: Add helpers for setting the mux state
  usb: typec: mux: Allow the mux handles to be requested with fwnode
  usb: roles: Leave the private driver data pointer to the drivers
  usb: roles: Provide the switch drivers handle to the switch in the API
  usb: roles: Allow the role switches to be named
  device property: Export fwnode_get_name()
  usb: typec: Add definitions for Thunderbolt 3 Alternate Mode
  usb: typec: driver for Intel PMC mux control

 drivers/base/property.c                       |   1 +
 drivers/usb/cdns3/core.c                      |  10 +-
 drivers/usb/chipidea/core.c                   |  10 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  10 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |  26 +-
 drivers/usb/gadget/udc/tegra-xudc.c           |   8 +-
 drivers/usb/mtu3/mtu3_dr.c                    |   9 +-
 drivers/usb/musb/mediatek.c                   |   9 +-
 drivers/usb/roles/class.c                     |  29 +-
 .../usb/roles/intel-xhci-usb-role-switch.c    |  26 +-
 drivers/usb/typec/class.c                     |  10 +-
 drivers/usb/typec/mux.c                       |  47 +-
 drivers/usb/typec/mux/Kconfig                 |   9 +
 drivers/usb/typec/mux/Makefile                |   1 +
 drivers/usb/typec/mux/intel_pmc_mux.c         | 434 ++++++++++++++++++
 include/linux/usb/role.h                      |  23 +-
 include/linux/usb/typec_mux.h                 |  25 +-
 include/linux/usb/typec_tbt.h                 |  53 +++
 18 files changed, 667 insertions(+), 73 deletions(-)
 create mode 100644 drivers/usb/typec/mux/intel_pmc_mux.c
 create mode 100644 include/linux/usb/typec_tbt.h

-- 
2.25.0

