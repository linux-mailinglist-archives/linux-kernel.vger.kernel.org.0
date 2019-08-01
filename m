Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C07E165
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbfHARv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 13:51:26 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:40995 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727899AbfHARvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:51:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A41C018029123;
        Thu,  1 Aug 2019 17:51:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2827:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11658:11783:11914:12043:12291:12295:12297:12438:12555:12683:12740:12895:12986:13894:14181:14659:14721:21080:21324:21451:21627:30012:30029:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: club18_80939144a8607
X-Filterd-Recvd-Size: 3545
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 17:51:23 +0000 (UTC)
Message-ID: <aab16d5347eb5378c8b8a24571a070dbf8926010.camel@perches.com>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 10:51:22 -0700
In-Reply-To: <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
References: <20190729151505.9660-1-hslester96@gmail.com>
         <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
         <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 23:23 +0800, Chuhong Yuan wrote:
> Joe Perches <joe@perches.com> 于2019年7月30日周二 上午8:16写道：
> > On Mon, 2019-07-29 at 23:15 +0800, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone.
> > > We had better use newly introduced
> > > str_has_prefix() instead of it.
> > []
> > > diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
> > []
> > > @@ -11,10 +11,10 @@
> > > 
> > >  int _braille_console_setup(char **str, char **brl_options)
> > >  {
> > > -     if (!strncmp(*str, "brl,", 4)) {
> > > +     if (str_has_prefix(*str, "brl,")) {
> > >               *brl_options = "";
> > >               *str += 4;
> > > -     } else if (!strncmp(*str, "brl=", 4)) {
> > > +     } else if (str_has_prefix(*str, "brl=")) {
> > >               *brl_options = *str + 4;
> > 
> > Better to get rid of the += 4 uses too by storing the result
> > of str_has_prefix and using that as the addend.
> > 
> > Perhaps
> >         size_t len;
> > 
> >         if ((len = str_has_prefix(*str, "brl,"))) {
> >                 *brl_options = "";
> >                 *str += len;
> >         } else if ((len = str_has_prefix(*str, "brl="))) {
> >                 etc...
> > 
> 
> I find that checkpatch.pl forbids assignment in if condition.
> So this seems to be infeasible...

So the code could be rewritten like below:
(though it's trivial as-is)
---
 kernel/printk/braille.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 1d21ebacfdb8..46dd9fcc7525 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,19 +11,29 @@
 
 int _braille_console_setup(char **str, char **brl_options)
 {
-	if (!strncmp(*str, "brl,", 4)) {
+	size_t len;
+
+	len = str_has_prefix(*str, "brl,");
+	if (len) {
 		*brl_options = "";
-		*str += 4;
-	} else if (!strncmp(*str, "brl=", 4)) {
-		*brl_options = *str + 4;
-		*str = strchr(*brl_options, ',');
-		if (!*str) {
-			pr_err("need port name after brl=\n");
-			return -EINVAL;
-		}
-		*((*str)++) = 0;
+		*str += len;
+		return 0;
+	}
+
+	len = str_has_prefix(*str, "brl=");
+	if (!len)
+		return 0;
+
+	*brl_options = *str + len;
+
+	*str = strchr(*brl_options, ',');
+	if (!*str) {
+		pr_err("need port name after brl=\n");
+		return -EINVAL;
 	}
 
+	*((*str)++) = 0;
+
 	return 0;
 }
 

