Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C609C5ECA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfGCTQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 15:16:07 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:35678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbfGCTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:16:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9890718021864;
        Wed,  3 Jul 2019 19:16:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3867:4250:4321:5007:6642:6742:7903:7904:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: farm73_34d274a800e47
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Jul 2019 19:16:02 +0000 (UTC)
Message-ID: <2f19693f2f720dcc037465d4ae517fb846c7eb4f.camel@perches.com>
Subject: Re: [patch v3 1/5] AST2500 DMA UART driver
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date:   Wed, 03 Jul 2019 12:16:01 -0700
In-Reply-To: <20190703174926.GA12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
         <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
         <20190703174926.GA12813@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 19:49 +0200, Greg KH wrote:
> On Tue, Jun 25, 2019 at 04:14:32PM +0530, sudheer.v wrote:
> > +#define UART_TX_R_POINT(x) (0x40 + (x * 0x20))
> > +#define UART_TX_W_POINT(x) (0x44 + (x * 0x20))
> > +#define UART_TX_SDMA_ADDR(x) (0x48 + (x * 0x20))
> > +#define UART_RX_R_POINT(x) (0x50 + (x * 0x20))
> > +#define UART_RX_W_POINT(x) (0x54 + (x * 0x20))
> > +#define UART_RX_SDMA_ADDR(x) (0x58 + (x * 0x20))
> 
> Please use a tab to line these up.

Also x should be surrounded by parentheses

#define UART_TX_R_POINT(x)	(0x40 + ((x) * 0x20))

etc...


