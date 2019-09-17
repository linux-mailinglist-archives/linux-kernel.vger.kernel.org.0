Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6198EB47C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbfIQG4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 02:56:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfIQG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bYiI0JJ9ZBjZE1FGSPS2C/WnExB5o+6ZPs1rok4OHT8=; b=SJFwjHFQt4G7gcejJJT7BevFl
        vwDc01e8Mu7YmMNxBCU+YoCfHqqnDUTW+/NKeEJ+gIjie1a3ep45YkUYR0nMXGAzzDUWby4ORbPCY
        Tipuat77Aj9ao7X1fNi0ldJ23xSKdh8zLWQ0kyCOHbtmMJI7cE31/YdM+eqTUgEq8BDFCIbNPggZJ
        BsxzZal7Xg1O/8kfvgo8UNYjPfjbTi7xRC+H/4IqCbKuGEtj09TQCKAcWYS4KNZZVfNU82+y1O9Qs
        1umTLhakjmKJWYKFzy5CZdze7pMvXB5GT1mFsZ8w7/80/EFpzN4OiQwwD2e+vAjoHVtdu4UODDkbH
        gYRe3Yojw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA7Ph-00041w-Me; Tue, 17 Sep 2019 06:56:37 +0000
Date:   Mon, 16 Sep 2019 23:56:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, jason@lakedaemon.net,
        Darius Rad <darius@bluespec.com>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, David Johnson <davidj@sifive.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
Message-ID: <20190917065637.GA15034@infradead.org>
References: <8636gxskmj.wl-maz@kernel.org>
 <mhng-8de39ab4-730a-4ded-a8b5-d50f34d1697b@palmer-si-x1e>
 <861rwhs9on.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861rwhs9on.wl-maz@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the fixes it seems to still work fine on the Kendryte KD210.
Although currently only the serial interrupt is tested and this might
not be a very exhaustive test case..
