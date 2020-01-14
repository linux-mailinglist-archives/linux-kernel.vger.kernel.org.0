Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63CC13B0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:31:44 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:48068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgANRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:31:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 91A7C180AAD63;
        Tue, 14 Jan 2020 17:31:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3874:4250:4321:5007:6119:7875:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12740:12760:12895:13069:13071:13141:13230:13311:13357:13439:14180:14659:14721:21060:21080:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: drain93_ead92970f826
X-Filterd-Recvd-Size: 2072
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jan 2020 17:31:40 +0000 (UTC)
Message-ID: <24455cb643415cf9379bb8343525b844ead4236b.camel@perches.com>
Subject: Re: [PATCHv2-next 2/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Date:   Tue, 14 Jan 2020 09:30:45 -0800
In-Reply-To: <20200114171912.261787-3-dima@arista.com>
References: <20200114171912.261787-1-dima@arista.com>
         <20200114171912.261787-3-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.

Hi again Dmitry.  trivia:

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
[]
> +/**
> + *	uart_try_toggle_sysrq - Enables SysRq from serial line
> + *	@port: uart_port structure where char(s) after BREAK met
> + *	@ch: new character in the sequence after received BREAK
> + *
> + *	Enables magic SysRq when the required sequence is met on port
> + *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
> + *
> + *	Returns 0 if @ch is out of enabling sequence and should be
> + *	handled some other way, 1 if @ch was consumed.
> + */

Normally bool functions return values are true/false not 1/0.

> +static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
> +{
> +	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
> +		return 0;

		return false;

etc...


