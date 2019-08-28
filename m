Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B569FA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 08:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfH1GLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 02:11:50 -0400
Received: from verein.lst.de ([213.95.11.211]:34559 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:11:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D25A168AFE; Wed, 28 Aug 2019 08:11:46 +0200 (CEST)
Date:   Wed, 28 Aug 2019 08:11:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] riscv: provide native clint access for M-mode
Message-ID: <20190828061146.GA21670@lst.de>
References: <20190819101648.GA29645@lst.de> <mhng-6c980844-cfea-4aaa-ac86-3c99ce6a6d14@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6c980844-cfea-4aaa-ac86-3c99ce6a6d14@palmer-si-x1e>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:37:16PM -0700, Palmer Dabbelt wrote:
> clint0 would be version 0 of the clint, with is the core-local interrupt 
> controller in rocket chip.  It should be "sifive,clint-1.0.0", not 
> "riscv,clint0", as it's a SiFive widget.  Unfortunately there are a lot of 
> legacy device trees floating around, but I'm only considering what's been 
> upstream to be actually part of the spec.
>
> In this case the code should match on a "sifive,clint-1.0.0", and the 
> device trees should be fixed up to match.  We match on "riscv,plic0" for 
> legacy systems, and I guess it makes sense to do something similar here.

IFF we decided to change it I'd rather separate DT noes for the ipi
bank vs timecmp register vs timeval to support variable layouts.  The
downside is that we can't just boot on unmodified upstream qemu, which
has used the "riscv,clint0" for years.
