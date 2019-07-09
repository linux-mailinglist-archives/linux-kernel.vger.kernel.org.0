Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4263462E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 04:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfGICgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 22:36:51 -0400
Received: from fieldses.org ([173.255.197.46]:38288 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfGICgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:36:50 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 2298A893; Mon,  8 Jul 2019 22:36:49 -0400 (EDT)
Date:   Mon, 8 Jul 2019 22:36:49 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the vfs tree with the nfsd tree
Message-ID: <20190709023649.GC14439@fieldses.org>
References: <20190708110633.6e491989@canb.auug.org.au>
 <20190708124510.GB7625@fieldses.org>
 <20190709001531.09b535d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709001531.09b535d3@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 12:15:31AM +1000, Stephen Rothwell wrote:
> Hi,
> 
> On Mon, 8 Jul 2019 08:45:10 -0400 "J. Bruce Fields" <bfields@fieldses.org> wrote:
> >
> > I did a fetch of
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > 
> > and looked at the "master" branch and couldn't find that vfs commit.  Am
> > I looking in the wrong place?
> 
> Maybe you were just a little early, I only finished linux-next today a
> few minutes before you sent this email.

Indeed, I see the merge now (ecd27e0ab735: Merge remote-tracking branch
'vfs/for-next').  Thanks!

--b.

> 
> > (I'm sure your resolution is fine, I just thought to be careful it might
> > be nice to run some tests on the merge.)
> 
> Thanks.
> 
> -- 
> Cheers,
> Stephen Rothwell


