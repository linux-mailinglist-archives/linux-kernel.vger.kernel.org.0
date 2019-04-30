Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD82EEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 04:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfD3CXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 22:23:31 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:33220 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfD3CXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:23:31 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id DE5905C0355; Tue, 30 Apr 2019 04:22:38 +0200 (CEST)
Date:   Tue, 30 Apr 2019 04:22:38 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes
 annotation
Message-ID: <20190430022238.GA22593@osadl.at>
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:03:36AM -0400, Sven Van Asbroeck wrote:
> On Mon, Apr 29, 2019 at 2:11 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > V2: As requested by Sven Van Asbroeck <thesven73@gmail.com> make the
> >     impact of the patch clear in the commit message.
> 
> Thank you, but did you miss my comment about creating a local variable
> instead? See:
> https://lkml.org/lkml/2019/4/28/97

Did not miss it - I just don't think that makes it any more
understandable - the __force __be16 makes it clear I believe
that this is correct, sparse does not like this though - so tell
sparse. The local variable would need to be explained as it is
functionally not necessary - therefor I find it more confusing
that using  __force here.

If that rational is wrong let me know.

thx!
hofrat

