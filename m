Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179CC127A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLTLeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 06:34:07 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36761 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfLTLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:34:04 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xBKBW2Wt010984;
        Fri, 20 Dec 2019 20:32:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xBKBW2Wt010984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576841524;
        bh=6jBixM0kD4Z6TDatL5XzWOLAsBsJ6q5AmXiipGKg7PA=;
        h=From:To:Cc:Subject:Date:From;
        b=t7uLCHPmhCDjQn2UH113INPsymuwdIgQQTb39RAQ1PqTNqSC2PTZ/t4Csuu5m0B8z
         4oBITna0r3DfIq/t5cPhKmOeheC01CPYRtRjnDm6wxn2URSunjeAMLk6j+39bV9N8y
         79IsNPODMx3zCBIQmIzHm9cq7OOma3vPk8XCWprq+YWKXWZ8xkScJaOZrJC34aK7px
         k3mGZXNBKBoCIRFssKJw1fMStrcFNaAUco1EoyEj2YVJLqiRrTTghUanFkFiNxas6/
         /hoyonHHTuXuBxYnnqcq/KJQRX5L2kdJZ+m0ksdWNorOhyQmbysKIZp3xBhIBf5klr
         dC1bLDbhkNIXA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] mtd: rawnand: denali: a bungle of denali patches that is cleanly applicable
Date:   Fri, 20 Dec 2019 20:31:50 +0900
Message-Id: <20191220113155.28177-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Denali driver patches are flying in ML.

The recently re-submitted patch
http://patchwork.ozlabs.org/patch/1213986/

... caused a conflict with:
http://patchwork.ozlabs.org/patch/1205912/

Instead of discussing "who should rebase his patch" again,
I offer to rebase and tidy up all the patches in a series
(if useful for the NAND maintainer).


Marek Vasut (1):
  mtd: rawnand: denali_dt: Add support for configuring
    SPARE_AREA_SKIP_BYTES

Masahiro Yamada (4):
  mtd: rawnand: denali_dt: error out if platform has no associated data
  dt-bindings: mtd: denali_dt: document reset property
  mtd: rawnand: denali_dt: add reset controlling
  mtd: rawnand: denali: remove hard-coded DENALI_DEFAULT_OOB_SKIP_BYTES

 .../devicetree/bindings/mtd/denali-nand.txt   |  7 +++
 drivers/mtd/nand/raw/denali.c                 | 14 ++---
 drivers/mtd/nand/raw/denali_dt.c              | 56 +++++++++++++++++--
 3 files changed, 64 insertions(+), 13 deletions(-)

-- 
2.17.1

