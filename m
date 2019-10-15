Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C0D7056
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfJOHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 03:43:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4S4N93Cm9h7fO1vc9dO9u69+HAsS/2PLABvLeEowmjQ=; b=hOZ6xxUjLznsleyIeVNFMWFaT
        WrEj5fzAHZ0sdmwT3R1SR8H9968JD50pGDkVXqzUAOfBE5vfSvoHOLeJENsk/gPNupwX1nQoEBNKl
        2JcEFvMBIG5kKFGKqYs5hry1bGl22i01+NGeLGY+usA7+1QcLSUkL49P3c7umWgq+oAIF2+inWeyV
        QMgpf/JGYkBFj/JWnOmdt62kC6o7kAXsfjT5Ui8kQb77NblmT08ABDg9uuO55WKUzGJbXpfpmyWtO
        GvTl4y7JHsOVEMUVjkt0rQRVcf2vf6tFNeQnrUOPmVAs7j3tfbMTuaPg/PrJwwdMawBNd4vzO90Ln
        F0hOo2mXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHUo-0002G6-3d; Tue, 15 Oct 2019 07:43:54 +0000
Date:   Tue, 15 Oct 2019 00:43:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
Message-ID: <20191015074354.GB3464@infradead.org>
References: <20191011165129.29655-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011165129.29655-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 06:51:29PM +0200, Nicolas Saenz Julienne wrote:
> It's more explicit and lets dma-direct handle the specifics of how to
> translate addresses.
> 
> On top of that get rid of warnings as, since the introduction of commit
> 6fa1d28e38c ("sh: use generic dma_noncoherent_ops"), it's impossible for
> the dev to be NULL.

This looks ok, but the real answer is to switch sh to the generic
dma remapping code.  I've been trying to get this included for about
a year now, but never managed to get a reply from the sh maintainers.

Here is the last one:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sh-dma-remap
