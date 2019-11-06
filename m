Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97BAF131D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfKFKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 05:00:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731731AbfKFKAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42CCAAFE3;
        Wed,  6 Nov 2019 10:00:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: Fix CMA/crashkernel reservation
Date:   Wed,  6 Nov 2019 10:59:43 +0100
Message-Id: <20191106095945.22933-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Qian Cai[1] the series enabling ZONE_DMA in arm64
breaks CMA/crashkernel reservations on large devices, as it changed its
default placement. After discussing it with Catalin Marinas we're
restoring the old behavior.

The Raspberry Pi 4, being the only device that needs CMA and crashkernel
in ZONE_DMA will explicitly do so trough it's device tree.

[1] https://lkml.org/lkml/2019/10/21/725

---

Changes since v1:
  - Move CMA area registration into bcm2711.dtsi

Nicolas Saenz Julienne (2):
  ARM: dts: bcm2711: force CMA into first GB of memory
  arm64: mm: reserve CMA and crashkernel in ZONE_DMA32

 arch/arm/boot/dts/bcm2711.dtsi | 20 ++++++++++++++++++++
 arch/arm64/mm/init.c           |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.23.0

