Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726701205A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLPM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 07:29:46 -0500
Received: from sauhun.de ([88.99.104.3]:39744 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfLPM3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:46 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 308FD2C04DF;
        Mon, 16 Dec 2019 13:29:44 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] macintosh: replace i2c_new_probed_device with an ERR_PTR variant
Date:   Mon, 16 Dec 2019 13:29:38 +0100
Message-Id: <20191216122939.3411-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the on-going mission to let i2c_new_* calls return an ERR_PTR instead of
NULL, here is a series for this subsystem converting i2c_new_probed_device() to
the newly introduced i2c_new_scanned_device(). Based on v5.5-rc1 and build tested.
Please apply via your tree.

Thanks,

   Wolfram


Wolfram Sang (1):
  macintosh: convert to i2c_new_scanned_device

 drivers/macintosh/therm_windtunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

