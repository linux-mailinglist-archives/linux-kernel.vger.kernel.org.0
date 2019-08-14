Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05728CA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 07:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfHNFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 01:20:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHNFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k/A8rrlN0b04st1tN832tnU3CgBWQXau3gzzxX/cxsg=; b=G4pDJEzpHmqiTgUAgrEqWA91s
        jY+YYoRlCdG61OeAXNZBSAP6aR7zdX95mme9CfVtrjTKX+ULl58DRsqCMgPJEBkApywE1xviqeEnw
        k36iGxwEj1KB46ccYhTAER/nj+0+adBmrvuEojcTbU3XgHXz+n0jw+DLf3jPggVhjCjgIOP+1aANP
        WnMGokuys6R8kPWHimUSW7RwCO6TI16a8qN8r/kMrKViPTicxks8ENQU21noUQ21rYahgF0uLHHyr
        gxc6+05H2XhVfRNxMrfmhzgmj1EFoUjbcq4e09xIb4D29BmjgnnXwrsnl1IGb5QNMcKenwzYov8XM
        w7mgNumjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxlhT-0001yN-1b; Wed, 14 Aug 2019 05:19:55 +0000
Date:   Tue, 13 Aug 2019 22:19:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] powerpc/mm: drop ppc_md.iounmap()
Message-ID: <20190814051955.GA7545@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:11:33PM +0000, Christophe Leroy wrote:
> ppc_md.iounmap() is never set, drop it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Hah, I was just going to send the same patch as part of an tree-wide
ioremap related series..

Reviewed-by: Christoph Hellwig <hch@lst.de>
