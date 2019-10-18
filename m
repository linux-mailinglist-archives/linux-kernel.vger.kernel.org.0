Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E070FDC9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442215AbfJRPzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:55:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJRPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=VHQ9tzqt3FQ4Rrj0MifGJny1U
        iQbclOXivgk80UkrgPK+u8A3Wm2YsUzDytJif0EqQXwSgu+d15wBTUtmAXnvLpMFaZiIDY77RpiaF
        W0ZJggGPpujguYiWqVFWmMQPTyhC8MlxxEkelRFZE0r7Hq9Q7+X2hRbLoK9L+l1LoNZxqu6kJzHkN
        5NqSfU82MK4BTaobMECUKDnRporDwadivPk0ETxUBDSonnyo+7BqUsXCbtEZvTKS7EI8jmNsMN72a
        mxUqr20Ov7f2G5T5bpR2ZjFlAz1fWqbzV2Rom5LqQlXHf1Z2foDKsbdYMnh5/EeDrKUi5yDy0nkeS
        5h+vAdU0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUb5-00064Z-7B; Fri, 18 Oct 2019 15:55:23 +0000
Date:   Fri, 18 Oct 2019 08:55:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] riscv: mark some code and data as file-static
Message-ID: <20191018155523.GC25386@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-6-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-6-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
