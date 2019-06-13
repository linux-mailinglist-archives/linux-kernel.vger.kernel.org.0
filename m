Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97B5443CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392370AbfFMQcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:32:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:35368 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfFMIQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:16:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 01:16:56 -0700
X-ExtLoop1: 1
Received: from pslai-z620.png.intel.com ([10.221.79.142])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2019 01:16:54 -0700
From:   "Lai, Poey Seng" <poey.seng.lai@intel.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Add Elkhart Lake PCI ID
Date:   Fri, 14 Jun 2019 00:21:39 +0800
Message-Id: <1560442899-11169-2-git-send-email-poey.seng.lai@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560442899-11169-1-git-send-email-poey.seng.lai@intel.com>
References: <1560442899-11169-1-git-send-email-poey.seng.lai@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HD Audio Device PCI ID for the Intel Elkhart Lake
platform.

Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0741eae..1f37789 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2387,6 +2387,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Elkhart Lake */
+	{ PCI_DEVICE(0x8086, 0x4b55),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-- 
2.7.4

