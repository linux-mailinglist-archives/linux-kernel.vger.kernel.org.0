Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52D4C76C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 08:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFTGV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 02:21:57 -0400
Received: from verein.lst.de ([213.95.11.211]:57987 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFTGV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:21:57 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ACC1868B05; Thu, 20 Jun 2019 08:21:26 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:21:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove dead NPU DMA code
Message-ID: <20190620062126.GA20765@lst.de>
References: <20190523074924.19659-1-hch@lst.de> <20190523074924.19659-4-hch@lst.de> <db502ec4-2e8f-fbc3-9db2-3fe98464a62c@ozlabs.ru> <20190619072837.GA6858@lst.de> <b0ce7d72-5de7-63d3-cb4e-ea78342cb3fa@ozlabs.ru> <20190620060354.GA20279@lst.de> <309781b5-108f-c219-2cda-49179dca6b13@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <309781b5-108f-c219-2cda-49179dca6b13@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:20:08PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 20/06/2019 16:03, Christoph Hellwig wrote:
> > Hi Linus,
> > 
> > this goes back to the discussion at last years kernel summit, where
> > we had the discussion on removing code never used by any in-kernel
> > user an no prospects of one.  The IBM folks are unfortunately still
> > dragging their feet on the powerpc side.  Can we revise this discussion?
> > 
> > The use case here is a IBM specific bus for which they only have an
> > out of tree driver that their partner doesn't want to submit for mainline,
> > but keep insisting on keeping the code around (which is also built
> > uncondіtionally for the platform).
> 
> 
> I personally keep insisting on correct commit logs, i.e. not calling
> working code dead and providing actual reasons for the change. Thanks,

If that is the only thing you are complaining about I can clarify it
a little of course.  But it didn't sound like that was the actual
problem.
