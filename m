Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23957172F31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 04:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgB1DL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 22:11:59 -0500
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:49780 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgB1DL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:11:59 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 01S3BV4k025720; Fri, 28 Feb 2020 12:11:31 +0900
X-Iguazu-Qid: 2wGrMQpE3AjzZXqGSe
X-Iguazu-QSIG: v=2; s=0; t=1582859491; q=2wGrMQpE3AjzZXqGSe; m=Gg9jScaW+L64ARWnrv/fIo0JxfoLbuRupyJP9N2Y6Rs=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1113) id 01S3BTJA006170;
        Fri, 28 Feb 2020 12:11:30 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 01S3BTNk017041;
        Fri, 28 Feb 2020 12:11:29 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 01S3BT1P005672;
        Fri, 28 Feb 2020 12:11:29 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2 0/2] mtd: spinand: toshiba: Support for new Kioxia Serial NAND
Date:   Fri, 28 Feb 2020 12:11:27 +0900
X-TSB-HOP: ON
Message-Id: <cover.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is to rename function name becase of add new device.
Second patch is to supprot for new device.

Yoshio Furuyama (2):
  mtd: spinand: toshiba: Rename function name to change suffix and
    prefix (8Gbit)
  mtd: spinand: toshiba: Support for new Kioxia Serial NAND

 drivers/mtd/nand/spi/toshiba.c | 173 +++++++++++++++++++++++++++++++----------
 1 file changed, 130 insertions(+), 43 deletions(-)

-- 
1.9.1

