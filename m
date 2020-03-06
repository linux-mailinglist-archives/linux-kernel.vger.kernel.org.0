Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BD17B4CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCFDIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 22:08:42 -0500
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:46654 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgCFDIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:08:42 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02638Q0D003586; Fri, 6 Mar 2020 12:08:26 +0900
X-Iguazu-Qid: 34tIY4cItsxDUY9Iiu
X-Iguazu-QSIG: v=2; s=0; t=1583464106; q=34tIY4cItsxDUY9Iiu; m=+i8Z5jthqs8lewgIQyFS/3QaoZABW1knr5SC80GC1gw=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1513) id 02638OTA011326;
        Fri, 6 Mar 2020 12:08:25 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02638OXN015888;
        Fri, 6 Mar 2020 12:08:24 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02638Oj0023927;
        Fri, 6 Mar 2020 12:08:24 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 0/2] mtd: spinand: toshiba: Support for new Kioxia Serial NAND
Date:   Fri,  6 Mar 2020 12:08:21 +0900
X-TSB-HOP: ON
Message-Id: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
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

