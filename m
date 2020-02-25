Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27216F29C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 23:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgBYWc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 17:32:27 -0500
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:34866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgBYWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:32:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 710EC181D3030;
        Tue, 25 Feb 2020 22:32:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:4321:5007:7875:7903:9707:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21611:21627:21740:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fowl93_894fd78211c48
X-Filterd-Recvd-Size: 2234
Received: from XPS-9350 (unknown [172.58.27.58])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 22:32:23 +0000 (UTC)
Message-ID: <635523a920bcc317eaf48230f003cd050f51c9bb.camel@perches.com>
Subject: Re: [PATCH 1/2] modpost: rework and consolidate logging interface
From:   Joe Perches <joe@perches.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 25 Feb 2020 14:30:51 -0800
In-Reply-To: <20200225173526.9617-1-jeyu@kernel.org>
References: <20200225173526.9617-1-jeyu@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 18:35 +0100, Jessica Yu wrote:
> Rework modpost's logging interface by consolidating merror(), warn(),
> and fatal() to use a single function, modpost_log(). Introduce different
> logging levels (WARN, ERROR, FATAL) as well as a conditional warn
> (warn_unless()). The conditional warn is useful in determining whether
> to use merror() or warn() based on a condition. This reduces code
> duplication overall.
[]
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
[]
> @@ -51,41 +51,39 @@ enum export {
>  
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>  
> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>  
> -PRINTF void fatal(const char *fmt, ...)
> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {
> +	char *level = NULL;
>  	va_list arglist;
>  
> -	fprintf(stderr, "FATAL: ");
> +	switch(loglevel) {
> +	case(LOG_WARN):
> +		level = "WARNING: ";
> +		break;
> +	case(LOG_ERROR):
> +		level = "ERROR: ";
> +		break;
> +	case(LOG_FATAL):
> +		level = "FATAL: ";
> +		break;
> +	default: /* invalid loglevel, ignore */
> +		break;

Odd parentheses around case labels and
likely level should be initialized as ""
and not NULL.

	const char *level = "";
	...
	switch (loglevel) {
	case LOG_WARN:
		level = "WARNING: ";
		break;
	...
	}


