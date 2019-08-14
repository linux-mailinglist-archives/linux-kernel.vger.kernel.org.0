Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9079A8CAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 07:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHNFtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 01:49:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfHNFtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yLBvjgIz0/4kJcpvkkBD2mhvRhrr916GyFhs+M2+Ar0=; b=l89PZLe3h8ePNmyh0C6eM6wvl
        fuUGOalLN8UJhfga5/x6cM+wfPZjKyP5Rya55baqZOzsQaDLp7ZtDMIikFLTGJo/jvDrqoaEEJso8
        4bSX88LZau5MGKh18xEunO8WFA4fU3P+9LXlt7chI7aR+md32QQUHCsE61yupuvbCWyVZnzzDRmwR
        toolzrEcnVxrJi9pBe/2uCpjXcOzUyZMnSlov9ZZKHDGRhPv60trWYFwKnuLXr+eNoG7iATOE8tjX
        v1TrZew0KtMKapyRN+nODjjWFxz23lJr7W2y5Q7+JksSuUOURqm/FAzzBa/MdsQM8Jxc9jVpz76rT
        DVAssgY+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxmAH-0001Q6-5w; Wed, 14 Aug 2019 05:49:41 +0000
Date:   Tue, 13 Aug 2019 22:49:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/10] powerpc/mm: refactor ioremap_range() and use
 ioremap_page_range()
Message-ID: <20190814054941.GC27497@infradead.org>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow this series is missing a cover letter.

While you are touching all this "fun" can you also look into killing
__ioremap?  It seems to be a weird non-standard version of ioremap_prot
(probably predating ioremap_prot) that is missing a few lines of code
setting attributes that might not even be applicable for the two drivers
calling it.
