Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0025D3A43A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfFIHtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 03:49:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfFIHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nxxyp57smYbpqOTasWziZ8RG57j0OS5gRkGI1VG8Mpk=; b=EUKVNe+bDclRh9ir0L1GK+Yo+
        /BoPSkr7wP3UhcDhMaeIQH90KJJjScIHaRQ3Tval0AGYL/bh7DE4xGxC1gigluqzwpuc8nEiqRKzE
        YUgWFFCYnJzGCzlxUFH2YgRlE6I58Gki9tnI2pxTE55Kj54IAgHEx9QKNXyd0NVA05kTYNmU545JF
        l3PckEat0ijCqLfp8thgsU+r7bfMPQWx+KbjdxFlKJp61F9K1yzmgqhSIGJWCyAk7z1zul9FYnZkt
        WBBULDPG7u6wLJVe1PZDCdVgYxb1Cqg0thRVqVj98RdHiT+oz1a6/9iXQXqW//u/Sc3iNkupoQKNB
        vwnDTyyrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZsa2-0006bN-3M; Sun, 09 Jun 2019 07:49:30 +0000
Date:   Sun, 9 Jun 2019 00:49:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, lollivier@baylibre.com,
        paul@pwsan.com, linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH v3 1/5] arch: riscv: add support for building DTB files
 from DT source data
Message-ID: <20190609074930.GA25109@infradead.org>
References: <mhng-802d67ce-9f78-4ebc-9981-a27e5e4e40df@palmer-si-x1e>
 <alpine.DEB.2.21.9999.1906082245300.720@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1906082245300.720@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 10:50:14PM -0700, Paul Walmsley wrote:
> Once there are SoC variants that have different CPU cores, but with the 
> remaining chip integration the same, I think it would make sense to move 
> the CONFIG_SOC_ stuff out from ARM, RISC-V, etc., into something that's 
> not CPU architecture-specific.  But for the time being, that seems 
> premature.  Might as well have it be driven by an actual use-case.

We've already had a few SOC families with the same periphals glue and
either m68k/powerpc, powerpc/mips or mips/arm/arm64 CPUs, so this isn't
exactly new.  Not really sure the grouping adds that much value, though.
