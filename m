Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17955118999
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfLJNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 08:24:28 -0500
Received: from foss.arm.com ([217.140.110.172]:44260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfLJNY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:24:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6047A328;
        Tue, 10 Dec 2019 05:24:26 -0800 (PST)
Received: from DESKTOP-VLO843J.cambridge.arm.com (DESKTOP-VLO843J.cambridge.arm.com [10.1.26.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B7493F52E;
        Tue, 10 Dec 2019 05:24:25 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de, smoch@web.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org
Subject: [PATCH 0/4] mfd: RK8xx tidyup
Date:   Tue, 10 Dec 2019 13:24:29 +0000
Message-Id: <cover.1575932654.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In trying to debug suspend issues on my RK3328 box, I was looking at
how the RK8xx driver handles the RK805 sleep pin, and frankly the whole
driver seemed untidy enough to warrant some cleanup and minor fixes
before going any further. I've based the series on top of Soeren's
"mfd: rk808: Always use poweroff when requested" patch[1].

Note that I've only had time to build-test these patches so far, but I
wanted to share them early for the sake of discussion in response to
the other thread[2].

Robin.

[1] https://patchwork.kernel.org/patch/11279249/
[2] https://patchwork.kernel.org/cover/11276945/

Robin Murphy (4):
  mfd: rk808: Set global instance unconditionally
  mfd: rk808: Always register syscore ops
  mfd: rk808: Reduce shutdown duplication
  mfd: rk808: Convert RK805 to syscore/PM ops

 drivers/mfd/rk808.c       | 122 ++++++++++++++++----------------------
 include/linux/mfd/rk808.h |   2 -
 2 files changed, 50 insertions(+), 74 deletions(-)

-- 
2.17.1

