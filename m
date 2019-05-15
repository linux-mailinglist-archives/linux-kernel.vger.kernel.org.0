Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30A11E863
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEOGmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:42:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfEOGmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C4NCv7pgiloZDQGj85J1ppwbhpG4JKjnfaneGv0KUtI=; b=M1eMAwlsHu7Scbxr64RFRMLWC
        4uusHPvXk51cNyaOUKvRqmmovsF4QhvdlgRZlDfxt3G/T5IyN0tQApaALuoa8ZCeUz/iWk/3yQXGA
        fvjDA8rCsSpy9j9hTYR/QBUyVEMd7yUEj8JNegUcU8q35r/eTthPIYOxK+siM1YTdpI2rnqlqWeN0
        /tLPwKeDfqWT+PuVgWICSFns1dDRG+y9fogkIYo/8xAnsdMB9ltrX7cVFScuKVqf9IiOC2utRtkIN
        I+eChmi+2KtR0gOe+yA1KHISC+Q9IGDJ3eEzpqRafdgFDMTXdjzmV0c7cO4OZrZ386BEVkMjVr7wt
        uIuBWqzQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQnc5-0005NN-E2; Wed, 15 May 2019 06:42:05 +0000
Date:   Tue, 14 May 2019 23:42:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc/mm: Implement STRICT_MODULE_RWX
Message-ID: <20190515064205.GB15778@infradead.org>
References: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int change_page_ro(pte_t *ptep, pgtable_t token, unsigned long addr, void *data)

There are a couple way too long lines like this in the patch.
