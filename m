Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD114E6F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 10:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfJ1J3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 05:29:36 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:61714 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731707AbfJ1J3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:29:36 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x9S9TQPM013435;
        Mon, 28 Oct 2019 17:29:26 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw
Subject: [PATCH v2 0/4] mtd: rawnand: Add support Macronix Block Protection & deep power down mode
Date:   Mon, 28 Oct 2019 17:55:23 +0800
Message-Id: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x9S9TQPM013435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changelog
v2:
Patch nand_lock() & nand_unlock() for MTD->_lock/_unlock default call-back
function replacement. 
Patch nand_suspend() & nand_resume() with manufacturer specific operation.

v1:
Patch manufacturer post_init for MTD->_lock/_unlock & MTD->_suspend/_resume
replacement.

thanks for your time & review.
Mason


Mason Yang (4):
  mtd: rawnand: Add support manufacturer specific lock/unlock operatoin
  mtd: rawnand: Add support Macronix Block Protection function
  mtd: rawnand: Add support manufacturer specific suspend/resume
    operation
  mtd: rawnand: Add support Macronix deep power down mode

 drivers/mtd/nand/raw/nand_base.c     |  41 ++++++++++-
 drivers/mtd/nand/raw/nand_macronix.c | 137 ++++++++++++++++++++++++++++++++++-
 include/linux/mtd/rawnand.h          |   5 ++
 3 files changed, 175 insertions(+), 8 deletions(-)

-- 
1.9.1

