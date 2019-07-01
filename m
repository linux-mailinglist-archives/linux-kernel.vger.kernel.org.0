Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9438458
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfFGGeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 02:34:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:49508 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfFGGea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:34:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 23:34:29 -0700
X-ExtLoop1: 1
Received: from pg-eswbuild-angstrom-alpha.altera.com ([10.142.34.148])
  by orsmga001.jf.intel.com with ESMTP; 06 Jun 2019 23:34:26 -0700
From:   "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, hean.loong.ong@intel.com,
        chin.liang.see@intel.com
Subject: [PATCHv15 0/3] Intel FPGA Video and Image Processing Suite
Date:   Fri,  7 Jun 2019 22:28:24 +0800
Message-Id: <20190607142827.329-1-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hean-Loong Ong <hean.loong.ong@intel.com>

The FPGA FrameBuffer Soft IP could be seen  as the GPU and the DRM driver
patch here is allocating memory for information to be streamed from the
ARM/Linux to the display port.

Basically the driver just wraps the information such as the pixels to be
drawn by the Sodt IP FrameBuffer 2.

The piece of hardware in discussion is the SoC FPGA where Linux runs on
the ARM chip and the FGPA is driven by its NIOS soft core with its own
proprietary firmware.

For example the application from the ARM Linux would have to write
information on the /dev/fb0 with the information stored in the
SDRAM to be fetched by the Framebuffer 2 Soft IP and displayed
on the Display Port Monitor.

Reviewed and ACKed need to merge this into drm-misc

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Rob Herring <robh@kernel.org>

Ong Hean Loong (1):
  ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite

Ong, Hean Loong (2):
  ARM:dt-bindings:display Intel FPGA Video and Image Processing Suite
  ARM:drm ivip Intel FPGA Video and Image Processing Suite

 .../bindings/display/altr,vip-fb2.txt         |  63 ++++
 MAINTAINERS                                   |   9 +
 arch/arm/configs/socfpga_defconfig            |   8 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/ivip/Kconfig                  |  14 +
 drivers/gpu/drm/ivip/Makefile                 |   6 +
 drivers/gpu/drm/ivip/intel_vip_conn.c         |  93 +++++
 drivers/gpu/drm/ivip/intel_vip_drv.c          | 335 ++++++++++++++++++
 drivers/gpu/drm/ivip/intel_vip_drv.h          |  73 ++++
 10 files changed, 604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
 create mode 100644 drivers/gpu/drm/ivip/Kconfig
 create mode 100644 drivers/gpu/drm/ivip/Makefile
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h

-- 
2.17.1

