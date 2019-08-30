Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D9A3DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfH3SuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 14:50:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbfH3SuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:50:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 611B6AD35;
        Fri, 30 Aug 2019 18:50:17 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] W1 drivers for devices used in SGI systems
Date:   Fri, 30 Aug 2019 20:50:05 +0200
Message-Id: <20190830185008.3177-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add two W1 drivers. One is a driver for the W1 master in
SGI ASICs, which is used in various machine starting with SGI Origin systems. 
The other is a W1 slave driver for Dallas/Maxim EPROM devices used
in the same type of SGI machines.

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
 include/linux/platform_data/sgi-w1.h |  15 ++
 include/linux/w1.h                   |   5 +
 8 files changed, 457 insertions(+)
 create mode 100644 drivers/w1/masters/sgi_w1.c
 create mode 100644 drivers/w1/slaves/w1_ds250x.c
 create mode 100644 include/linux/platform_data/sgi-w1.h

-- 
2.13.7

