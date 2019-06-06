Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B803436F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFFI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 04:57:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfFFI5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6pIxH8GAWp3IuaRt1s0Ws8HzMVWnBdLBFOygcGYJKcU=; b=lKlkUxF6n5+A8+RkC8w0yn6pu
        EZCes93Ox1IEC+EQcVlLD3OxYSO6GmQO+08/FTFwMODRTs59EkAhBSCyHcavGgCAS/JYhks4Gs5O6
        tmiVvmkmKSvoxB0DCb7aK/ccAs9+8jsjENkRMTQHjBAAS7S2xqmvZd7ub3bSs6cpaztWCtd4jTE4+
        KUq6AX1JVodPkV/OjkLZMQLA5Dz0tcVwmUgYeRR0wzECYvAOS8sB0ALRSaTXmVIV4S/kObGriSrju
        2GsAQS3qCc9P3WX6swBuIQoC1gfV25iwjp6LqNLv9JV3Rf33D405ipKow6x5divdAtLXURTKFeF18
        /4QpRg6HA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYoCj-0000XC-QQ; Thu, 06 Jun 2019 08:57:01 +0000
Date:   Thu, 6 Jun 2019 01:57:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: defconfig: enable clocks, serial console
Message-ID: <20190606085701.GA1369@infradead.org>
References: <20190605175042.13719-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605175042.13719-1-khilman@baylibre.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 10:50:42AM -0700, Kevin Hilman wrote:
> Enable PRCI clock driver and serial console by default, so the default
> upstream defconfig is bootable to a serial console.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
