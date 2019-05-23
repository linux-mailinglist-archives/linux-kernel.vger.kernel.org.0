Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0872775F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfEWHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:47:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lsgHCa2vpCehpFETQiyNH/o7TEppcQLLkSY0AC+okiA=; b=rZj7TWxRADhac9Kvvt+/WDl6C
        bW6EfWL6kkFNW5mJuOaTXt7KeEjdw8yatC1AIV8E8Fk/iGOzC9/YduaBBOeV075273SM4j855TshK
        ochtlLTCj0BLyFLfQdxrONj6B7772aAOAulInHhxwyayetCdNyiYTD3WgKiLvocCoZ93fHsAfF2w+
        jLKzq5/74UJMRNsrMSMeROaCAzWZSw9YBGV/4xDfA/GNO0HGbnMey+PSEUIrFv1P4yvinPeZcxfNa
        PaB8Ka0MhGFKGoQuM6qj+oSpKH8caqD36jMtEpKVQerx7x1el4lLaHN5HJGWqstYpsdirnZ7r4e4G
        6wptVuhgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTiRC-0003v4-Sr; Thu, 23 May 2019 07:46:54 +0000
Date:   Thu, 23 May 2019 00:46:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv: fix variable "c" set but not used
Message-ID: <20190523074654.GA9873@infradead.org>
References: <20190523023141.2973-1-cai@lca.pw>
 <d0512822-ca22-75ec-3dd9-1024001632f5@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0512822-ca22-75ec-3dd9-1024001632f5@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:26:53AM +0200, Christophe Leroy wrote:
> You are not fixing the problem, you are just hiding it.
> 
> If the result of __get_user() is unneeded, it means __get_user() is not the
> good function to use.
> 
> Should use fault_in_pages_readable() instead.

Also it is not just the variable that is unused, but that whole
function.  I'll resend my series to remote it in a bit.
