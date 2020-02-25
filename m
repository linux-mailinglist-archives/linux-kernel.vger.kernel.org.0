Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2578516EB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgBYQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:33:03 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:36414 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730628AbgBYQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:33:03 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Feb 2020 18:33:01 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 01PGWwP0000925;
        Tue, 25 Feb 2020 11:32:58 -0500
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 01PGWuYg019086;
        Tue, 25 Feb 2020 11:32:56 -0500
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
Date:   Tue, 25 Feb 2020 11:32:52 -0500
Message-Id: <cover.1582647809.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by Mellanox BlueFIeld
2 SOCs.
This patch addresses the following issues:
1) Split in one gpio_chip per instance (there are 3 instances)
2) Use bgpio_init() for set/clear/get gpio values
3) The direction settings need some special HW lock/unlock to happen and it also uses 2 registers to set the direction instead of one.
So direction_input and direction_output are overriden.

Asmaa Mnebhi (1):
  gpio: add driver for Mellanox BlueField 2 GPIO controller

 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 345 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

-- 
2.1.2

