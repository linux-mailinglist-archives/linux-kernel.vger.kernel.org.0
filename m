Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FD443CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392050AbfFMQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:32:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:24465 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbfFMIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:16:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 01:16:50 -0700
X-ExtLoop1: 1
Received: from pslai-z620.png.intel.com ([10.221.79.142])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2019 01:16:48 -0700
From:   "Lai, Poey Seng" <poey.seng.lai@intel.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Add Elkhart Lake PCI ID
Date:   Fri, 14 Jun 2019 00:21:38 +0800
Message-Id: <1560442899-11169-1-git-send-email-poey.seng.lai@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is to add Elkhart lake PCI ID
in order to support Elkhart Lake SoC.

Lai, Poey Seng (1):
  ALSA: hda: Add Elkhart Lake PCI ID

 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4

