Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0971CA80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfENOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 10:38:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56938 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfENOiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:38:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B83F0200030;
        Tue, 14 May 2019 16:38:10 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC05220022E;
        Tue, 14 May 2019 16:38:10 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F37B82061C;
        Tue, 14 May 2019 16:38:09 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH v2 0/3] prerequisites for device reserved local mem rework
Date:   Tue, 14 May 2019 17:38:04 +0300
Message-Id: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

For HCs that have local memory, replace the current DMA API usage
with a genalloc generic allocator to manage the mappings for these
devices.
This is in preparation for dropping the existing "coherent" dma
mem declaration APIs. Current implementation was relying on a short
circuit in the DMA API that in the end, was acting as an allocator
for these type of devices.

Only compiled tested, so any volunteers willing to test are most welcome.

Thank you!

For context, see thread here: https://lkml.org/lkml/2019/4/22/357

Changes in v2:
 - use genalloc also in core usb (based on comment from Robin)
 - moved genpool decl to usb_hcd to be accesible from core usb

Laurentiu Tudor (3):
  USB: use genalloc for USB HCs with local memory
  usb: host: ohci-sm501: init genalloc for local memory
  usb: host: ohci-tmio: init genalloc for local memory

 drivers/usb/core/buffer.c     | 12 ++++++-
 drivers/usb/host/ohci-hcd.c   | 23 +++++++++++---
 drivers/usb/host/ohci-sm501.c | 60 +++++++++++++++++++----------------
 drivers/usb/host/ohci-tmio.c  | 23 +++++++++-----
 include/linux/usb/hcd.h       |  3 ++
 5 files changed, 80 insertions(+), 41 deletions(-)

-- 
2.17.1

