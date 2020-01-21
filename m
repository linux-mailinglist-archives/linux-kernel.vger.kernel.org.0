Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF3144231
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 17:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAUQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 11:31:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52182 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726555AbgAUQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:31:27 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00LGVBCR018494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 11:31:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 30D94420057; Tue, 21 Jan 2020 11:31:10 -0500 (EST)
Date:   Tue, 21 Jan 2020 11:31:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sam Hartman <hartmans@debian.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Question about dynamic minor number of misc device
Message-ID: <20200121163110.GK15860@mit.edu>
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
 <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
 <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
 <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
 <20200120221323.GJ15860@mit.edu>
 <CAK8P3a2aLxAgjp2_Vb0bKw-0PMVRXKtFw=2giF0MY6hgAQpQRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2aLxAgjp2_Vb0bKw-0PMVRXKtFw=2giF0MY6hgAQpQRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:56:37AM +0100, Arnd Bergmann wrote:
> > > I think one patch to move the ones with unique names would be fine,
> > > but then separate patches for
> > >
> > > - FLASH_MINOR move and rename to avoid conflict
> > > - change speakup to dynamic minors
> > > - support for high dynamic minor numbers if you are really motivated
> > >   (probably nobody needs these)
> >
> > Are we sure that reassigning minor device number conflits isn't going
> > to break systems?  Especially those on random, older, architectures
> > they might not be using udev.
> 
> To clarify: the only numbers that I think should be changed to dynamic
> allocation are for drivers/staging/speakup. While this is a fairly old
> subsystem, I would expect that it being staging means we can be a
> little more progressive with the changes.

Sam,

Would you happen to know how commonly used the speakup system would be
--- in particular, on non-udev systems where changing the minor number
of the device node might break some folks?  Does your hardware system
use speakup, or some other interface?

Also, who would be the best people to reach out at the
linux-speakup.org project to verify what the potential impact might be
of making this change.  It looks like some of the web pages are a bit
dated, so I wasn't sure what's up to date.

Thanks!!

						- Ted
