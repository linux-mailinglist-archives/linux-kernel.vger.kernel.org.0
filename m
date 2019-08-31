Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54594A4346
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHaI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 04:26:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:52486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfHaI0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 04:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF3F3AAB2;
        Sat, 31 Aug 2019 08:26:31 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] W1 drivers for devices used in SGI systems
Date:   Sat, 31 Aug 2019 10:26:20 +0200
Message-Id: <20190831082623.15627-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add two W1 drivers. One is a driver for the W1 master in
SGI ASICs, which is used in various machine starting with SGI Origin systems. 
The other is a W1 slave driver for Dallas/Maxim EPROM devices used
in the same type of SGI machines.

Changes in v3:
- dropped include of asm/sn/types.h which isn't needed at all

Changes in v2:
- added documentation about dev_id field in include/linux/w1.h
- use PTR_ERR_OR_ZERO

Thomas Bogendoerfer (2):
  w1: add 1-wire master driver for IP block found in SGI ASICs
  w1: add DS2501, DS2502, DS2505 EPROM device driver

 drivers/w1/masters/Kconfig           |   9 ++
 drivers/w1/masters/Makefile          |   1 +
 drivers/w1/masters/sgi_w1.c          | 130 ++++++++++++++++
 drivers/w1/slaves/Kconfig            |   6 +
 drivers/w1/slaves/Makefile           |   1 +
 drivers/w1/slaves/w1_ds250x.c        | 290 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/sgi-w1.h |  13 ++
 include/linux/w1.h                   |   5 +
 8 files changed, 455 insertions(+)
 create mode 100644 drivers/w1/masters/sgi_w1.c
 create mode 100644 drivers/w1/slaves/w1_ds250x.c
 create mode 100644 include/linux/platform_data/sgi-w1.h

-- 
2.13.7

