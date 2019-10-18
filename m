Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F9DC9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393741AbfJRP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:56:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJRP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=KJa+4irgpl7oUwb4yG4a6Nytg
        Usx622PhpcufRyqAsDqUS6K6FNCbL9Ss5oFSGwjW/VKQrJfWTYXxAp7C0XajvQ0TSqnMVnmGHRUvn
        bF4uHUSv1ounsM/YhnreyrNZiXrgD9MGzGMdtz2YM8VOdYrKQoMpYZ00wx3Gldz18+7XIIuRZaFkP
        PjsuDuB4l5kmdePLQj4yxni4Lk0r9wgZfdzGsQxU0/aIlByNTGeW7bh4sPLVtMR05c65EBXdMtS+H
        kBwLBHyMMfvpkRwlkZ4LsMMYcQbNP9FnrBrg8GfeaBBBOiIQ9U3Z99sJUBBdeeqctrsiTVn9GUI9/
        ozUP4GigQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUbm-0006fZ-Ps; Fri, 18 Oct 2019 15:56:06 +0000
Date:   Fri, 18 Oct 2019 08:56:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alan Kao <alankao@andestech.com>
Subject: Re: [PATCH v3 7/8] riscv: fp: add missing __user pointer annotations
Message-ID: <20191018155606.GE25386@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-8-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-8-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
