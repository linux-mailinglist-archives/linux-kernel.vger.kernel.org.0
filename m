Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A748F95E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 11:44:25 -0500
Received: from ms.lwn.net ([45.79.88.28]:41868 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:44:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2262B7DE;
        Tue, 12 Nov 2019 16:44:24 +0000 (UTC)
Date:   Tue, 12 Nov 2019 09:44:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for RISC-V
Message-ID: <20191112094422.7abbc581@lwn.net>
In-Reply-To: <alpine.DEB.2.21.999.1911111729271.32333@utopia.booyaka.com>
References: <alpine.DEB.2.21.9999.1910091252160.11044@viisi.sifive.com>
        <CAMuHMdUfqvkVJHHwyuYxLSxj_iUofx-vSvEj92C5mg3bGxHqmA@mail.gmail.com>
        <20191010112347.4a7237bb@lwn.net>
        <20191108061009.GA30335@lst.de>
        <alpine.DEB.2.21.999.1911111729271.32333@utopia.booyaka.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 17:30:13 +0000 (UTC)
Paul Walmsley <paul@pwsan.com> wrote:

> On Fri, 8 Nov 2019, Christoph Hellwig wrote:
> 
> > can you please revert this?  The paragraph above this addition already
> > describes the riscv case perfecty well with my previous patch:
> > 
> > 	earlycon=	[KNL] Output early console device and options.
> > 
> > 			When used with no options, the early console is
> > 			determined by stdout-path property in device tree's
> > 			chosen node or the ACPI SPCR table if supported by
> > 			the platform.
> > 
> > 			[RISCV] When used with no options, the early
> > 			console is determined by the stdout-path
> > 			property in the device tree's chosen node.  
> 
> I support reverting the RISCV section, now that Christoph's more general 
> change has gone in.

OK, the patch has been reverted.

Thanks,

jon
