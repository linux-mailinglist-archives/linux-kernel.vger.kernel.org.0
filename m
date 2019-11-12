Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D587F892A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 07:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfKLG4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 01:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfKLG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:56:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9E2206A3;
        Tue, 12 Nov 2019 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573541793;
        bh=r0sc5/XzhNJIqfRx4BwQyUrbUeptifp8j9vAKXgaYjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFKYlVXOsiL7FaaBRZj3pZQA+ljakifCep4BzkE7lHK14YdhMWhb1UeymOeCpXgtl
         rUWylDHSGWblvFdlUHPUnGwrDUM5bkWW0oxbcahxseMrPioIyeyZCvkwXQSHvs2o6O
         39kxVd60E4PzxfJnJmVi6Tp5CoV02Q6X2PwRXCpg=
Date:   Tue, 12 Nov 2019 07:56:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     devel@linuxdriverproject.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] IIO fixes / Staging driver for 5.4-rc7
Message-ID: <20191112065629.GA1242198@kroah.com>
References: <20191110154303.GA2867499@kroah.com>
 <20191112063440.GA15951@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112063440.GA15951@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:34:40PM -0800, Christoph Hellwig wrote:
> On Sun, Nov 10, 2019 at 04:43:03PM +0100, Greg KH wrote:
> > The staging driver addition is the vboxsf filesystem, which is the
> > VirtualBox guest shared folder code.  Hans has been trying to get
> > filesystem reviewers to review the code for many months now, and
> > Christoph finally said to just merge it in staging now as it is
> > stand-alone and the filesystem people can review it easier over time
> > that way.
> 
> No, this is absolutely contrary to what I said.  I told Hans to just
> send it to Linus because it is ready and not staging fodder a atll.

Hah, ok, I got that totally wrong.  I'll send a patch moving it to the
"real" part of the kernel now.

thanks,

greg k-h
