Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80B4446F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392621AbfFMQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:37:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfFMHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=atee/ZdPPEd8Kc7wql5pRPCT+Wff4w6HVGQI7aAWhwM=; b=qsu+Z8BVRHTJPWnoQY613CKD9
        eXGYx43YzeHeljEWLiZAPgkgkg5CDvxnmswUg91Nb9UnuKcoRJP8KGc1I/OO2f3Bvv7tCdlOlTPVk
        LucWW/pLJ7+y/h0GG/s+8o0U2lwsM2u+gW7jlOey5g4g8CXzpf99NgthmTK35fALCUVL4aNsZBN3T
        OPWv7XDcORpWWKSc5EbIoZXYyE1H3OwogopkyBS2pIdv6X8QJANu1eQo4jTmBCe1c/lw7UxYk4tl1
        9nsmwdbN793S+2O4AZSg/ZAGrz2Jsid0Gy0S2JCwMyEtPJMhZGnmIs1/QgMCN19+7vYXRrHO+HoVL
        j7j0/d6gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbK6o-0001uE-Re; Thu, 13 Jun 2019 07:25:18 +0000
Date:   Thu, 13 Jun 2019 00:25:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com
Subject: Re: [PATCH] MAINTAINERS: change the arch/riscv git tree to the new
 shared tree
Message-ID: <20190613072518.GA1327@infradead.org>
References: <20190613070721.8341-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613070721.8341-1-paul.walmsley@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:07:21AM -0700, Paul Walmsley wrote:
> Palmer, with Konstantin's gracious help, set up a shared kernel.org
> git tree for arch/riscv patches going forward.  Change the MAINTAINERS
> file accordingly.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>

Should you be added to the maintainers?  Is Albert still around, as
I see a lot of people Ccing him, but never getting an answer?
