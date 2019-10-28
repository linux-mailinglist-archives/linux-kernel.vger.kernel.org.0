Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC748E6DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 09:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfJ1IMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 04:12:48 -0400
Received: from verein.lst.de ([213.95.11.211]:33287 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbfJ1IMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:12:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8C9F68AFE; Mon, 28 Oct 2019 09:12:44 +0100 (CET)
Date:   Mon, 28 Oct 2019 09:12:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 03/15] riscv: abstract out CSR names for supervisor vs
 machine mode
Message-ID: <20191028081244.GA20974@lst.de>
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-4-hch@lst.de> <alpine.DEB.2.21.9999.1910181647110.21875@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910181647110.21875@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 04:55:02PM -0700, Paul Walmsley wrote:
> The basic idea looks good to me, but some of the X-prefixing can make the 
> code difficult to read.  The Xret macro looks fine to me, as do the 
> XIE_XTIE macros.  But I think it would be better if the X-prefixes on the 
> rest of the macros and structure members could be dropped.  This also 
> aligns with the way that these registers often are discussed at the 
> architectural level; e.g., we'd talk about the "epc" registers, not the 
> "xepc" registers.

If we get of the x we should get rid of all of them.  I'll make sure it
is all gone for the next version.
