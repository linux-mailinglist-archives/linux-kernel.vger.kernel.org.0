Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8850A9DA1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 01:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHZXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 19:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:47:31 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4AFE2070B;
        Mon, 26 Aug 2019 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566863250;
        bh=Yr2E6qB0qKTdQPuJDk0Uy2OePf+bLbKdzWtfm/XHE/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=GJ8gAJ/vZYfbmDcg/TWgdFmQ5472gQoWWYN0u6rklpD4NsTyiapbZ1sC+XwNUjPyQ
         B6CP+DVGFRRh1DNk/1BQ6+bnesY1GVc+oCj5Odf41mv57qiQ8sxuIIxrdvqT4b39M3
         zyl/K1nE0OEwKi+eYWhkXw30QVDO73+vjADRoLXA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: Drop !clk checks in debugfs dumping
Date:   Mon, 26 Aug 2019 16:47:29 -0700
Message-Id: <20190826234729.145593-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These recursive functions have checks for !clk being passed in, but the
callers are always looping through lists and therefore the pointers
can't be NULL. Drop the checks to simplify the code.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..a5b686307c38 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2847,9 +2847,6 @@ static struct hlist_head *orphan_list[] = {
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
-	if (!c)
-		return;
-
 	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
@@ -2864,9 +2861,6 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 {
 	struct clk_core *child;
 
-	if (!c)
-		return;
-
 	clk_summary_show_one(s, c, level);
 
 	hlist_for_each_entry(child, &c->children, child_node)
@@ -2896,9 +2890,6 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
 
 static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 {
-	if (!c)
-		return;
-
 	/* This should be JSON format, i.e. elements separated with a comma */
 	seq_printf(s, "\"%s\": { ", c->name);
 	seq_printf(s, "\"enable_count\": %d,", c->enable_count);
@@ -2915,9 +2906,6 @@ static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int level)
 {
 	struct clk_core *child;
 
-	if (!c)
-		return;
-
 	clk_dump_one(s, c, level);
 
 	hlist_for_each_entry(child, &c->children, child_node) {

base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
-- 
Sent by a computer through tubes

