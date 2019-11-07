Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3CF3955
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKGUNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 15:13:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:39490 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKGUNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:13:16 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ED69F6EC;
        Thu,  7 Nov 2019 20:13:14 +0000 (UTC)
Date:   Thu, 7 Nov 2019 13:13:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
Message-ID: <20191107131313.26b2d2cc@lwn.net>
In-Reply-To: <20191001075559.629eb059@lwn.net>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20191001075559.629eb059@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dan,

A month or so ago I wrote...

> > See Documentation/maintainer/maintainer-entry-profile.rst for more details,
> > and a follow-on example profile for the libnvdimm subsystem.  
> 
> Thus far, the maintainer guide is focused on how to *be* a maintainer.
> This document, instead, is more about how to deal with specific
> maintainers.  So I suspect that Documentation/maintainer might be the
> wrong place for it.
> 
> Should we maybe place it instead under Documentation/process, or even
> create a new top-level "book" for this information?

Unless I missed it, I've not heard back from you on this.  I'd like to get
this stuff pulled in for 5.5 if possible...  would you object if I were to
apply your patches, then tack on a move over to the process guide?

Thanks,

jon
