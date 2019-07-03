Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56515E6C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGCOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:33:04 -0400
Received: from verein.lst.de ([213.95.11.211]:52174 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCOdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:33:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F177968B05; Wed,  3 Jul 2019 16:33:00 +0200 (CEST)
Date:   Wed, 3 Jul 2019 16:33:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/powernv: remove the unused pnv_pci_set_p2p
 function
Message-ID: <20190703143300.GA10125@lst.de>
References: <20190625145239.2759-2-hch@lst.de> <45f3Mt388Xz9sPD@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f3Mt388Xz9sPD@ozlabs.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:27:06AM +1000, Michael Ellerman wrote:
> On Tue, 2019-06-25 at 14:52:36 UTC, Christoph Hellwig wrote:
> > This function has never been used anywhere in the kernel tree since it
> > was added to the tree.  We also now have proper PCIe P2P APIs in the core
> > kernel, and any new P2P support should be using those.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Series applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/63982618662e2a05e5c5c3e4247456d1d3467f32

Thanks.  For P2P it would be good if you guys could chime in for
the "Removing struct page from P2PDMA" where we are discussion PCIe
P2P requirements so that our future changes can accommodate Power 9
and we can help upstreaming the P2P support in a proper way.
