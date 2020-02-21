Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44581681F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgBUPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:40:03 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40049 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728198AbgBUPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:40:03 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 21 Feb 2020 17:40:01 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 01LFe0Io030549;
        Fri, 21 Feb 2020 10:40:00 -0500
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 01LFdxS8013336;
        Fri, 21 Feb 2020 10:39:59 -0500
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
Date:   Fri, 21 Feb 2020 10:39:54 -0500
Message-Id: <cover.1582299415.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by Mellanox BlueFIeld
2 SOCs.

Asmaa Mnebhi (1):
  gpio: add driver for Mellanox BlueField 2 GPIO controller

 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 411 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

-- 
2.1.2

