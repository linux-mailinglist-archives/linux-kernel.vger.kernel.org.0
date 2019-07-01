Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2DFAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfD3ODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfD3ODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:03:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDE22087B;
        Tue, 30 Apr 2019 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556633021;
        bh=5Yif/yKxf4rflzOEZiUhwArgTU/nL3MH7dDNZxArZf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6Qx48taZwHDibhQaSBIaOzXRz8/huG2FbJsINlT4huwhzcV4f1aTK148K6MvusTK
         9BnXl1b7FqeDQaYzZrhiRsKRJAMu3cAkTM6Mt2rQFhP4515UjLLFvptz9NPlxPEbHF
         6IwPfKDnqEUMZWipbYoROrWHzblMRdigsQBM06wk=
Date:   Tue, 30 Apr 2019 16:03:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, devel@driverdev.osuosl.org,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes
 annotation
Message-ID: <20190430140339.GA18986@kroah.com>
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at>
 <20190430030223.GE23075@ZenIV.linux.org.uk>
 <20190430033310.GB23144@osadl.at>
 <20190430041934.GI23075@ZenIV.linux.org.uk>
 <CAGngYiVSg86X+jD+hgwwrOYX82Fu3OWSLygwGFzyc9wYq6AesQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVSg86X+jD+hgwwrOYX82Fu3OWSLygwGFzyc9wYq6AesQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 09:32:20AM -0400, Sven Van Asbroeck wrote:
> On Tue, Apr 30, 2019 at 12:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ... not that there's much sense keeping ->fieldbus_type in host-endian,
> > while we are at it.
> 
> Interesting! Suppose we make device->fieldbus_type bus-endian.

Keep it bus-endian, as that's the "normal" way bus structures work (like
PCI and USB for example), and that should be in a documented, and
consistent, form, right?

Then do the conversion when you access the field from within the kernel.
Again, examples of USB and PCI can be used if you want to copy what they
do.

thanks,

greg k-h
