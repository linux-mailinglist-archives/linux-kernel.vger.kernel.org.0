Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA4FB78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfD3O1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:27:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45800 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3O1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:27:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLTjJ-0003ij-4f; Tue, 30 Apr 2019 14:27:33 +0000
Date:   Tue, 30 Apr 2019 15:27:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Nicholas Mc Guire <der.herr@hofr.at>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes
 annotation
Message-ID: <20190430142733.GL23075@ZenIV.linux.org.uk>
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
User-Agent: Mutt/1.11.3 (2019-02-01)
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
> Then the endinan-ness conversion either needs to happen in
> bus_match() (and we'd have to convert endianness each time
> this function is called).
> Or, we make driver->fieldbus_type bus-endian also, then there
> is no need for conversion... but the driver writer has to remember
> to specify this in bus endianness:
> 
> static struct anybuss_client_driver profinet_driver = {
>         .probe = ...,
>         .fieldbus_type = endian convert?? (0x0089),
> };
> 
> Which pushes bus implementation details onto the
> client driver writer? Also, how to convert a constant
> to a specific endianness in a static initializer?

cpu_to_be16() or htons() - either will be fine there.
On little-endian you'll get
	htons(0x0089) =>
	___htons(0x0089) =>
	__cpu_to_be16(0x0089) =>
	((__force __be16)__swab16((0x0089))) =>
	((__be16)(__builtin_constant_p((__u16)((0x0089))) ?
		___constant_swab16((0x0089)) : __fswab16((0x0089))) =>
	((__be16)(__builtin_constant_p((__u16)((0x0089))) ?
		((__u16)((((__u16)((0x0089)) & (__u16)0x00ffU) << 8) |
			 (((__u16)((0x0089)) & (__u16)0xff00U) >> 8))) :
		__fswab16((0x0089)))
and once the preprocessor has produced that, from compiler POV we have
a constant expression as argument of __builtin_constant_p(), so it
evaluates as true, reducing the whole thing to
	((__be16)(((__u16)((((__u16)((0x0089)) & (__u16)0x00ffU) << 8) |
			 (((__u16)((0x0089)) & (__u16)0xff00U) >> 8))) )
i.e. (__be16)0x8900.  On big-endian expansion will be different,
resulting in (__be16)0x0089...

IOW, you can use endianness convertors in static initializers; things
like
struct sockaddr_in addr = {.sin_addr.s_addr = htonl(0x7f000001),
			 .sin_port = htons(25),
			 .sin_family = AF_INET};
are fine kernel-side (from the compiler POV, that is - something
trying to speak SMTP in the kernel code would obviously be a bad sign).

As for having to remember - sparse will complain about endianness mismatches
in initializer...
