Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD572D2F83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfJJRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 13:23:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:60662 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfJJRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:23:49 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5B8CC5A0;
        Thu, 10 Oct 2019 17:23:48 +0000 (UTC)
Date:   Thu, 10 Oct 2019 11:23:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for RISC-V
Message-ID: <20191010112347.4a7237bb@lwn.net>
In-Reply-To: <CAMuHMdUfqvkVJHHwyuYxLSxj_iUofx-vSvEj92C5mg3bGxHqmA@mail.gmail.com>
References: <alpine.DEB.2.21.9999.1910091252160.11044@viisi.sifive.com>
        <CAMuHMdUfqvkVJHHwyuYxLSxj_iUofx-vSvEj92C5mg3bGxHqmA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 09:10:18 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, Oct 9, 2019 at 9:53 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > Kernels booting on RISC-V can specify "earlycon" with no options on
> > the Linux command line, and the generic DT earlycon support will query
> > the "chosen/stdout-path" property (if present) to determine which
> > early console device to use.  Document this appropriately in the
> > admin-guide.
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

jon
