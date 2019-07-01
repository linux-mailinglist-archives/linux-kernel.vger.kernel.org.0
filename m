Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB4563A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFZHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:50:09 -0400
Received: from verein.lst.de ([213.95.11.211]:40977 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZHuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:50:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0B20568B05; Wed, 26 Jun 2019 09:49:36 +0200 (CEST)
Date:   Wed, 26 Jun 2019 09:49:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove unused NPU DMA code
Message-ID: <20190626074935.GA25452@lst.de>
References: <20190625145239.2759-1-hch@lst.de> <20190625145239.2759-4-hch@lst.de> <7bde96e0-7bc5-d5fe-f151-52c29660633c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bde96e0-7bc5-d5fe-f151-52c29660633c@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:44:38AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 26/06/2019 00:52, Christoph Hellwig wrote:
> > None of these routines were ever used anywhere in the kernel tree
> > since they were added to the kernel.
> 
> 
> So none of my comments has been addressed. Nice.

Which comment?  Last time I asked you complaint "it is still used in
exactly the same way as before" which you later clarified that you
have a hidden out of tree user somewhere, and you only objected to
the word "dead".  That has been fixed and there were no further
comments.
