Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA857ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF0JBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 05:01:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q3tCNAVxddI/QHJQExO0pnzOA4z7aTNyOfjRp+/T+To=; b=GNp4P0L3ZHZIsV1n4nV8Mlovp
        uytP8vB0gzlcMhIMhR9nFTE+wG6ROkzh8IpwmFIani/0kKoG4V5Hr9u9TThw9/HyRmr5HgnKYlPki
        ZhNPZvAGJgBB+5UK2spWwrgYynOpbs2PdRFMjrAMH6zFN2q3brsTEfNTBGooQ3PyJMIdNd0wVMDMm
        6DDJadSCYEdodQUhmthWLeKxG32YHi14CjcRaQFrEgHg8588ixmNwsil2uY+t+7CNakDP1/uV0gP2
        jEMizhgAvRFXx12vm6x/PHHRGVu/XYlvBY4i/o3rHF8rYpqd+TzTwcwOLYVX/KznjEp14L0UHQxLa
        R3ohZ+NLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgQHM-0007f0-SE; Thu, 27 Jun 2019 09:01:16 +0000
Date:   Thu, 27 Jun 2019 02:01:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change the arch/riscv git tree to the new
 shared tree
Message-ID: <20190627090116.GB23838@infradead.org>
References: <20190613070721.8341-1-paul.walmsley@sifive.com>
 <20190613072518.GA1327@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613072518.GA1327@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:25:18AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 12:07:21AM -0700, Paul Walmsley wrote:
> > Palmer, with Konstantin's gracious help, set up a shared kernel.org
> > git tree for arch/riscv patches going forward.  Change the MAINTAINERS
> > file accordingly.
> > 
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> 
> Should you be added to the maintainers?  Is Albert still around, as
> I see a lot of people Ccing him, but never getting an answer?

ping?
