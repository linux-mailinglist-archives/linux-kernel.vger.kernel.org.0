Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183F422DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfETIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbfETIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:35 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABDC20863;
        Mon, 20 May 2019 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339535;
        bh=Wtf8ydMMfyfJ3sAFi/Hglgs7fc07JVIK7VJrnPdLjpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohkKS1kFeDs6AhPfm0BNhc9ncVna0zNXm3TuOb/f415FmPUmgzkuJN3D3fmyfO4dV
         msBkbh4oDb4g9ejSUgHSxDiE+kQVFKeqFbUvskJZHcZf0cOKdrOurBr3vDRgp8WwiP
         6wGIau8oUMVS68VhR3fzBU00in/UlHRKWLPp+4rs=
Received: by wens.tw (Postfix, from userid 1000)
        id 2AD595FABC; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] clk: Fix debugfs clk_possible_parents for clks without parent string names
Date:   Mon, 20 May 2019 16:03:57 +0800
Message-Id: <20190520080421.12575-2-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Following the commit fc0c209c147f ("clk: Allow parents to be specified
without string names"), the parent name string is not always populated.

Instead, fetch the parents clk_core struct using the appropriate helper,
and read its name directly.

Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/clk.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..bdb077ba59b9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3000,12 +3000,16 @@ DEFINE_SHOW_ATTRIBUTE(clk_flags);
 static int possible_parents_show(struct seq_file *s, void *data)
 {
 	struct clk_core *core = s->private;
+	struct clk_core *parent;
 	int i;
 
-	for (i = 0; i < core->num_parents - 1; i++)
-		seq_printf(s, "%s ", core->parents[i].name);
+	for (i = 0; i < core->num_parents - 1; i++) {
+		parent = clk_core_get_parent_by_index(core, i);
+		seq_printf(s, "%s ", parent ? parent->name : NULL);
+	}
 
-	seq_printf(s, "%s\n", core->parents[i].name);
+	parent = clk_core_get_parent_by_index(core, i);
+	seq_printf(s, "%s", parent ? parent->name : NULL);
 
 	return 0;
 }
-- 
2.20.1

