Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC4A8D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfIDRGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 13:06:10 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:32795 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732115AbfIDRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:06:10 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 515453A341; Wed,  4 Sep 2019 19:05:43 +0200 (CEST)
Date:   Wed, 4 Sep 2019 19:05:42 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: exfat: cleanup braces for if/else statements
Message-ID: <20190904170536.GA12633@valentin-vidic.from.hr>
References: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
 <20190903173249.GL1131@ZenIV.linux.org.uk>
 <20190903181208.GA8469@valentin-vidic.from.hr>
 <d14cda319c584db9b8aa35b15b542f89@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14cda319c584db9b8aa35b15b542f89@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:38:55AM +0000, David Laight wrote:
> From: Valentin Vidic
> > Sent: 03 September 2019 19:12
> > On Tue, Sep 03, 2019 at 06:32:49PM +0100, Al Viro wrote:
> > > On Tue, Sep 03, 2019 at 06:47:32PM +0200, Valentin Vidic wrote:
> > > > +			} else if (uni == 0xFFFF) {
> > > >  				skip = TRUE;
> > >
> > > While we are at it, could you get rid of that 'TRUE' macro?
> > 
> > Sure, but maybe in a separate patch since TRUE/FALSE has more
> > calls than just this.
> 
> I bet you can get rid of the 'skip' variable and simplify the code
> by using continue/break/return (or maybe goto).

Seems it is not so simple - the value of skip is used to control the
behavior in the next loop iteration based on the current uni value.
So maybe just replace skip with a less confusing name.

-- 
Valentin
