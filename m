Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F18CA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 07:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHNFX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 01:23:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHNFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6A+GI4gZGWyRuDQP+niAaChFqcQKKkaIrqbRkUwGXwo=; b=TD4osz4EQt2utwjTeRlilo8KF
        06vLqy0TeQlMHW4j741qZOyLyXwopNKhNwi2vlkRKGg9Yg1PxwzKRgG1Mc4MHQx+dNo8eClQKtoEx
        WVgwKQn8hXYR1UahF9IN5BgNOm4+pFRwYE2pTzia4ioSPS27uw1bigd+SfLa8sDEd9QhyxmlBkUv5
        Gg4qZfQNaQcWWI30w0nZCs9TPaP86aoeMEYsOWSfOayyFw72PUgg0ktHzNJFVbxeyUAbolb7YEBsx
        K3xDBThon40273qLCQs5OcEQFSH5vgHmUkjm5lM9iPycSDpM/xaviZY1sZr3qN3lqiWZkzlhj/6mx
        uhhkwQNJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxll8-0003G0-DK; Wed, 14 Aug 2019 05:23:42 +0000
Date:   Tue, 13 Aug 2019 22:23:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/10] powerpc/mm: move __ioremap_at() and
 __iounmap_at() into ioremap.c
Message-ID: <20190814052342.GB7545@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * __iounmap_from - Low level function to tear down the page tables
> + *                  for an IO mapping. This is used for mappings that
> + *                  are manipulated manually, like partial unmapping of
> + *                  PCI IOs or ISA space.
> + */
> +void __iounmap_at(void *ea, unsigned long size)

The comment doesn't mention the function name.  That's why I ususally
don't even add the function name so that it doesn't get out of sync.
