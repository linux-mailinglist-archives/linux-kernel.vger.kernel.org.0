Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677813CDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391604AbfFKOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:05:42 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55715 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389869AbfFKOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:01 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOQ-0003vU-Hc; Tue, 11 Jun 2019 15:04:54 +0100
From:   Michael Drake <michael.drake@codethink.co.uk>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Drake <michael.drake@codethink.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: [PATCH v1 00/11] Add ti948 and ti949 display bridge drivers
Date:   Tue, 11 Jun 2019 15:04:01 +0100
Message-Id: <20190611140412.32151-1-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the ti948 and ti949 display
bridge devices.  They are both regmap i2c device drivers.

The ti949 converts HDMI video signals to FPD-Link III.
The ti948 converts FPD-Link III video signals to OpenLDI.

The drivers support PM suspend/resume, and rely on device tree /
ACPI nodes to set up any device dependency chain.  (ACPI requiring
the special DT namespace link device ID, PRP0001.)  The unified
device properties API is used to get board-specific config from
device tree / ACPI.

Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>

Michael Drake (11):
  dt-bindings: display/bridge: Add bindings for ti948
  ti948: i2c device driver for TI DS90UB948-Q1
  dt-bindings: display/bridge: Add config property for ti948
  ti948: Add support for configuration via device properties
  ti948: Add alive check function using schedule_delayed_work()
  ti948: Reconfigure in the alive check when device returns
  ti948: Add sysfs node for alive attribute
  dt-bindings: display/bridge: Add bindings for ti949
  ti949: i2c device driver for TI DS90UB949-Q1
  dt-bindings: display/bridge: Add config property for ti949
  ti949: Add support for configuration via device properties

 .../bindings/display/bridge/ti,ds90ub948.txt  |  45 ++
 .../bindings/display/bridge/ti,ds90ub949.txt  |  37 +
 drivers/gpu/drm/bridge/Kconfig                |  16 +
 drivers/gpu/drm/bridge/Makefile               |   2 +
 drivers/gpu/drm/bridge/ti948.c                | 689 ++++++++++++++++++
 drivers/gpu/drm/bridge/ti949.c                | 631 ++++++++++++++++
 6 files changed, 1420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
 create mode 100644 drivers/gpu/drm/bridge/ti948.c
 create mode 100644 drivers/gpu/drm/bridge/ti949.c

-- 
2.20.1

