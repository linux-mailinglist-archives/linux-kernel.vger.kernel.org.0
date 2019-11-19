Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBE102BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 19:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKSSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 13:33:05 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:49355 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSSdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:33:04 -0500
Received: (qmail 16630 invoked by uid 1019); 19 Nov 2019 18:33:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Nov 2019 18:33:03 -0000
Date:   Tue, 19 Nov 2019 18:33:03 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Palmer Dabbelt <palmer@dabbelt.com>, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the generic-ioremap tree with the
 risc-v tree
In-Reply-To: <20191118065149.GA4850@lst.de>
Message-ID: <alpine.DEB.2.21.999.1911191806040.13729@utopia.booyaka.com>
References: <20191118174501.73050c78@canb.auug.org.au> <20191118065149.GA4850@lst.de>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On Mon, 18 Nov 2019, Christoph Hellwig wrote:

> On Mon, Nov 18, 2019 at 05:45:01PM +1100, Stephen Rothwell wrote:
> >   0c3ac28931d5 ("riscv: separate MMIO functions into their own header file")
> 
> As already mentioned in reply to this patch when it was posted I think
> this kinda of split is a very bad idea.  

Unless I missed a followup from you, you mentioned that you thought there 
might be a better way to implement it, but you didn't highlight any 
problems with it:

   https://lore.kernel.org/linux-riscv/20191031155608.GB7270@lst.de/

If you think there's something critically wrong with the patch that can be 
fixed in time for the merge window, I'm happy to take a look at a 
proposal.  Otherwise I think we'll need to drop the nommu set from the 
v5.5 queue.


- Paul
