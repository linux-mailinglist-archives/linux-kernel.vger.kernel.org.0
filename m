Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409656F5AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfGUUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 16:54:41 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:45604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbfGUUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:54:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C6CE9283D;
        Sun, 21 Jul 2019 20:54:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:1981:2110:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3872:4250:4321:4605:5007:6742:8603:8957:9008:10004:10400:10848:11026:11232:11233:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:21080:21433:21627:30012:30030:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: badge91_457dfadbc403e
X-Filterd-Recvd-Size: 2397
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 20:54:37 +0000 (UTC)
Message-ID: <817d0c88a2764ef07b4169bd0e2632f3e78c47d8.camel@perches.com>
Subject: Re: [PATCH v10 2/6] usb:common Separated decoding functions from
 dwc3 driver.
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Pawel Laszczak <pawell@cadence.com>, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        rogerq@ti.com, linux-kernel@vger.kernel.org, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Date:   Sun, 21 Jul 2019 13:54:35 -0700
In-Reply-To: <Pine.LNX.4.44L0.1907211639390.9901-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1907211639390.9901-100000@netrider.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-21 at 16:45 -0400, Alan Stern wrote:
> On Sun, 21 Jul 2019, Joe Perches wrote:
> 
> > On Sun, 2019-07-21 at 19:32 +0100, Pawel Laszczak wrote:
> > > Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> > > to driver/usb/common/debug.c file. These moved functions include:
> > []
> > > diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
> > []
> > > +static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
> > > +                                    __u16 wValue, __u16 wIndex,
> > > +                                    char *str, size_t size)
> > 
> > It's probably not necessary to use Hungarian
> > when moving these functions into generic code.
> 
> In fact, these are the well known and commonly accepted names for these
> data values, as given in the USB specification and used in many other
> places in the Linux USB stack.  See for example the definition of
> struct usb_ctrlrequest in include/uapi/linux/usb/ch9.h.
>
> Changing them here would only make the code less readable.

Perhaps, but these have already been converted from
the __le types, so perhaps not.  It might be more
sensible to convert the __u16 uses to u16 and avoid
the __le16 names.

cheers, Joe

