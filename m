Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C91CEBEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfJGSau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 14:30:50 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:49815 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729335AbfJGSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:30:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6D0351802E6D3;
        Mon,  7 Oct 2019 18:30:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2196:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3867:3868:4321:4385:4605:5007:6117:6119:7903:8603:9121:10004:10400:10848:11026:11473:11658:11914:12043:12296:12297:12555:12760:12986:13439:14093:14097:14181:14394:14659:14721:21080:21433:21627:30012:30054:30080:30090,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: sort50_6e6fb6466222
X-Filterd-Recvd-Size: 3066
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 18:30:47 +0000 (UTC)
Message-ID: <cce61906a5f7f42f5b2b8b947fc61357bcb56e71.camel@perches.com>
Subject: [PATCH] sgi-gru: simplify procfs code some more
From:   Joe Perches <joe@perches.com>
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Oct 2019 11:30:46 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use seq_puts and simple string output and not seq_printf with formats
and individual strings to reduce overall object size.

$ size drivers/misc/sgi-gru/gruprocfs.o* (x86-64 defconfig with gru)
   text	   data	    bss	    dec	    hex	filename
   7006	      8	      0	   7014	   1b66	drivers/misc/sgi-gru/gruprocfs.o.new
   7472	      8	      0	   7480	   1d38	drivers/misc/sgi-gru/gruprocfs.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/misc/sgi-gru/gruprocfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sgi-gru/gruprocfs.c b/drivers/misc/sgi-gru/gruprocfs.c
index 3a8d76d1ccae..2817f4751306 100644
--- a/drivers/misc/sgi-gru/gruprocfs.c
+++ b/drivers/misc/sgi-gru/gruprocfs.c
@@ -119,7 +119,7 @@ static int mcs_statistics_show(struct seq_file *s, void *p)
 		"cch_interrupt_sync", "cch_deallocate", "tfh_write_only",
 		"tfh_write_restart", "tgh_invalidate"};
 
-	seq_printf(s, "%-20s%12s%12s%12s\n", "#id", "count", "aver-clks", "max-clks");
+	seq_puts(s, "#id                        count   aver-clks    max-clks\n");
 	for (op = 0; op < mcsop_last; op++) {
 		count = atomic_long_read(&mcs_op_statistics[op].count);
 		total = atomic_long_read(&mcs_op_statistics[op].total);
@@ -165,8 +165,7 @@ static int cch_seq_show(struct seq_file *file, void *data)
 	const char *mode[] = { "??", "UPM", "INTR", "OS_POLL" };
 
 	if (gid == 0)
-		seq_printf(file, "#%5s%5s%6s%7s%9s%6s%8s%8s\n", "gid", "bid",
-			   "ctx#", "asid", "pid", "cbrs", "dsbytes", "mode");
+		seq_puts(file, "#  gid  bid  ctx#   asid      pid  cbrs dsbytes    mode\n");
 	if (gru)
 		for (i = 0; i < GRU_NUM_CCH; i++) {
 			ts = gru->gs_gts[i];
@@ -191,10 +190,8 @@ static int gru_seq_show(struct seq_file *file, void *data)
 	struct gru_state *gru = GID_TO_GRU(gid);
 
 	if (gid == 0) {
-		seq_printf(file, "#%5s%5s%7s%6s%6s%8s%6s%6s\n", "gid", "nid",
-			   "ctx", "cbr", "dsr", "ctx", "cbr", "dsr");
-		seq_printf(file, "#%5s%5s%7s%6s%6s%8s%6s%6s\n", "", "", "busy",
-			   "busy", "busy", "free", "free", "free");
+		seq_puts(file, "#  gid  nid    ctx   cbr   dsr     ctx   cbr   dsr\n");
+		seq_puts(file, "#             busy  busy  busy    free  free  free\n");
 	}
 	if (gru) {
 		ctxfree = GRU_NUM_CCH - gru->gs_active_contexts;


