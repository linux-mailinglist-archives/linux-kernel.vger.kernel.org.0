Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4917658C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 22:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBVE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 16:04:58 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56396 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgCBVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:04:58 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 2 Mar 2020 23:04:51 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 022L4o2k010194;
        Mon, 2 Mar 2020 16:04:50 -0500
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 022L4nQX016153;
        Mon, 2 Mar 2020 16:04:49 -0500
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
Date:   Mon,  2 Mar 2020 16:04:45 -0500
Message-Id: <cover.1583182325.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by Mellanox BlueFIeld
2 SOCs.
This patch addresses the following issues:
1) Make mlxbf2_gpio_lock_acquire and mlxbf2_gpio_lock_release symmetrical
2) renamed mlxbf2_gpio_state to mlxbf2_gpio_context
3) removed unnecessary informational message.

Asmaa Mnebhi (1):
  gpio: add driver for Mellanox BlueField 2 GPIO controller

 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 335 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

-- 
2.1.2

