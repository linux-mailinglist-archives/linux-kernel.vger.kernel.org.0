Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4C1F715
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfEOPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 11:04:23 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43654 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfEOPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:04:22 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x4FF488R014964;
        Thu, 16 May 2019 00:04:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x4FF488R014964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557932648;
        bh=v3kAKgF41p0yp83qN7qAc5WixqxfOrDQ4ujRjR06VhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bB3KeCa5QgpcVMBYPt2dFEG+1YLjnzXKx4zExz1fF341RFWZIEoxX0nnPAzuCDcvr
         CVZHQXgMsOHrgPpGzri8bSUAh2cGB7IO8T7LOIwY67K0Mdh5sHDiosVuIs2YHGm8lv
         Yj9pmp5TjSo87Kqxr44K+2Oxx9YucAUKDD4YUVQxPf0MjQfGr5S0sJ64tSpBWEfGqL
         VYLP1RPAWgdOXDWqwrway/t1uUAmLBwwYZDG/N5heLnOceQTsD2Yi2SV4be7Gipge/
         L8YGKQRNln2mlH08AksXZbvhVvGl2ITwC+ltmE60ph4duzLsmsmRmzKpSX6kw4z77E
         r2H+ERZgytUqQ==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] memory: sanitize jedec_ddr_data.c and jedec_ddr.h
Date:   Thu, 16 May 2019 00:04:04 +0900
Message-Id: <1557932646-29752-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (2):
  memory: move jedec_ddr_data.c from lib/ to drivers/memory/
  memory: move jedec_ddr.h from include/memory to drivers/memory/

 drivers/memory/Kconfig                   | 8 ++++++++
 drivers/memory/Makefile                  | 1 +
 drivers/memory/emif.c                    | 3 ++-
 {include => drivers}/memory/jedec_ddr.h  | 6 +++---
 {lib => drivers/memory}/jedec_ddr_data.c | 5 +++--
 drivers/memory/of_memory.c               | 3 ++-
 lib/Kconfig                              | 8 --------
 lib/Makefile                             | 2 --
 8 files changed, 19 insertions(+), 17 deletions(-)
 rename {include => drivers}/memory/jedec_ddr.h (97%)
 rename {lib => drivers/memory}/jedec_ddr_data.c (98%)

-- 
2.7.4

