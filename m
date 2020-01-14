Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A241A13B22D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 19:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANSdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 13:33:13 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:56188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbgANSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:33:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CEE711801E56A;
        Tue, 14 Jan 2020 18:33:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2553:2559:2562:2828:2896:3138:3139:3140:3141:3142:3353:3622:3865:3867:3870:3871:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14659:14721:21080:21433:21451:21627:21939:30029:30045:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bone95_7302979734f62
X-Filterd-Recvd-Size: 2619
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jan 2020 18:33:10 +0000 (UTC)
Message-ID: <805e5dbb1f28e8f8b8f2599adb56294d3225c2d0.camel@perches.com>
Subject: Re: [PATCHv2-next 3/3] serial_core: Remove unused member in
 uart_port
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Date:   Tue, 14 Jan 2020 10:32:15 -0800
In-Reply-To: <20200114175647.GA2055173@kroah.com>
References: <20200114171912.261787-1-dima@arista.com>
         <20200114171912.261787-4-dima@arista.com>
         <e1b3cccb0814ba4b0c99592715776ed48f343795.camel@perches.com>
         <8f11e2fa-495d-fe25-f5e4-52c9580240d7@arista.com>
         <20200114175647.GA2055173@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 18:56 +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 14, 2020 at 05:47:33PM +0000, Dmitry Safonov wrote:
> > On 1/14/20 5:36 PM, Joe Perches wrote:
> > > On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
> > > > It should remove the align-padding before @name.
> > > []
> > > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > > []
> > > > @@ -247,7 +247,6 @@ struct uart_port {
> > > >  
> > > >  	unsigned char		hub6;			/* this should be in the 8250 driver */
> > > >  	unsigned char		suspended;
> > > > -	unsigned char		unused;
> > > 
> > > I suggest this not be applied as this is just to let
> > > readers know that there is an unused 1 byte alignment
> > > hole here that could be used for something else.
> > 
> > Heh, 2/3 adds another `unsigned char`, so the neighbours look like:
> > 
> > : unsigned long sysrq;		/* sysrq timeout */
> > : unsigned int	sysrq_ch;	/* char for sysrq */
> > : unsigned char	has_sysrq;
> > : unsigned char	sysrq_seq;	/* index in sysrq_toggle_seq */
> > :
> > : unsigned char	hub6;		/* this should be in the 8250 driver */
> > : unsigned char	suspended;
> > : unsigned char	unused;
> > : const char	*name;		/* port name */
> > 
> > So the hole became 4 bytes on 64-bit.

Ah, perhaps the commit message could state that
there is no longer an alignment hole instead.

cheers, Joe


