Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E973180DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 02:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCKBr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 21:47:29 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:46352 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCKBr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:47:29 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02B1l9uk002491; Wed, 11 Mar 2020 10:47:09 +0900
X-Iguazu-Qid: 34triqBKPQ0PGTNQU4
X-Iguazu-QSIG: v=2; s=0; t=1583891228; q=34triqBKPQ0PGTNQU4; m=BJbfuCHSBkFwoHEZqBUYMdwQP41o/mM0L9KuOOruQf8=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 02B1l7Qa003838;
        Wed, 11 Mar 2020 10:47:08 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02B1l6db020674;
        Wed, 11 Mar 2020 10:47:06 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02B1l6Aw016080;
        Wed, 11 Mar 2020 10:47:06 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v4 0/2] mtd: spinand: toshiba: Support for new Kioxia Serial NAND
Date:   Wed, 11 Mar 2020 10:47:04 +0900
X-TSB-HOP: ON
Message-Id: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
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

