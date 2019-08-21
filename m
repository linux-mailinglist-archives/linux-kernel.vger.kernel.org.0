Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF83297D76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfHUOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 10:45:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfHUOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P5/ZWod6fAHXWUWrprOInsPqq0oUZgow3uUQibZVw8Y=; b=FhDR6yl/wOx357dfIqkd4iRMS
        lbPa7cQHtnNhLrpvGVKVIzSEOU5OD5851S775jhqytjk5D5lt0S3eyss/RUFaAlrAjqFs9oI+misK
        vni4mvVT9RppPtnmq/H3efqx52UccUrxQBM6Z8gqzj8m8TioTP8AydUH8rmN1e3tDJW78XI/xi82+
        wZnSvSRd/JHou7xSZqJVqPrTJthEH8RUTJKo+iDIk05uRHk9Lk2ibLM/hg5Ma2zukE63NJ/tWgSAq
        sQmAGVFS6y6wTfRqccdScleOFikXP314flN1+FLqOecos5ZY6J4v8oeIHN4yl0QydDM7QUizB+O+s
        jGTHtPkvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0Rs0-0007h8-PC; Wed, 21 Aug 2019 14:45:52 +0000
Date:   Wed, 21 Aug 2019 07:45:52 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190821144552.GB4925@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820004735.18518-1-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, for the next version it also might make sense to do one
optimization at a time.  E.g. the empty cpumask one as the
first patch, the local cpu directly one next, and the threshold
based full flush as a third.
