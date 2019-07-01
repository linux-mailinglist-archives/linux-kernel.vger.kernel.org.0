Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC480EF34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 05:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfD3DeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 23:34:05 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:33269 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfD3DeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:34:05 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id DE4EE5C0355; Tue, 30 Apr 2019 05:33:10 +0200 (CEST)
Date:   Tue, 30 Apr 2019 05:33:10 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes
 annotation
Message-ID: <20190430033310.GB23144@osadl.at>
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at>
 <20190430030223.GE23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430030223.GE23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:02:23AM +0100, Al Viro wrote:
> On Tue, Apr 30, 2019 at 04:22:38AM +0200, Nicholas Mc Guire wrote:
> > On Mon, Apr 29, 2019 at 10:03:36AM -0400, Sven Van Asbroeck wrote:
> > > On Mon, Apr 29, 2019 at 2:11 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > > >
> > > > V2: As requested by Sven Van Asbroeck <thesven73@gmail.com> make the
> > > >     impact of the patch clear in the commit message.
> > > 
> > > Thank you, but did you miss my comment about creating a local variable
> > > instead? See:
> > > https://lkml.org/lkml/2019/4/28/97
> > 
> > Did not miss it - I just don't think that makes it any more
> > understandable - the __force __be16 makes it clear I believe
> > that this is correct, sparse does not like this though - so tell
> > sparse.
> 
> ... to STFU, 'cause you know better.  The trouble is, how do we
> (or yourself a year or two later) know *why* it is correct?
> Worse, how do we (or yourself, etc.) know if a change about to be
> done to the code won't invalidate the proof of yours?
> 
> > The local variable would need to be explained as it is
> > functionally not necessary - therefor I find it more confusing
> > that using  __force here.
> 
> What's confusing is mixing host- and fixed-endian values in the
> same variable at different times.  Treat those as unrelated
> types that happen to have the same sizeof.
> 
> Quite a few of __force instances in the tree should be taken out
> and shot.  Don't add to their number.

ok - my bad thn - I had assumed that using __force is reasonable
if the handling is correct and its a localized conversoin only 
like var = be16_to_cpu(var) which evaded introducing additinal
variables just to have different types but no different function.
But the long-term issue of hiding bugs by __force makes sesne to
me - will give it another shot at scripting this in coccinelle.

thx!
hofrat
