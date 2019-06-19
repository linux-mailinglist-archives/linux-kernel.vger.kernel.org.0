Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87584B315
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfFSH3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 03:29:08 -0400
Received: from verein.lst.de ([213.95.11.211]:51540 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfFSH3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:29:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B5D1268B05; Wed, 19 Jun 2019 09:28:37 +0200 (CEST)
Date:   Wed, 19 Jun 2019 09:28:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove dead NPU DMA code
Message-ID: <20190619072837.GA6858@lst.de>
References: <20190523074924.19659-1-hch@lst.de> <20190523074924.19659-4-hch@lst.de> <db502ec4-2e8f-fbc3-9db2-3fe98464a62c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db502ec4-2e8f-fbc3-9db2-3fe98464a62c@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:34:54AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 23/05/2019 17:49, Christoph Hellwig wrote:
> > None of these routines were ever used since they were added to the
> > kernel.
> 
> 
> It is still being used exactly in the way as it was explained before in
> previous respins. Thanks.

Please point to the in-kernel user, because that is the only relevant
one.  This is not just my opinion but we had a clear discussion on that
at least years kernel summit.
