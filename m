Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16F3C0E00
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfI0WZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:25:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0WZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sTUGYV4HRk1ZGxJwVj6MQXBA7R1gfQ02c2i8inwWvt4=; b=VlJgK4Eq+b3MnnjJxeu/JnAa+
        x4TqWVhwwVaLrufkCBPVasHwEz44DlollM01jlLT+1Kck1hOMzzj4bvJ8HXWpTTeMCKDLJYTFiGOG
        0UaEbs7nozp1Gg/JxaeDU8W7YY5OM4eZj8YakJDN/Bf8w/AIC3+V51LUM0RNLkFRbk1xw5Xqhxsyz
        zyveyYPfF/mAtEOfxyo30hVvXHpC52Sw715qXGPb7uhhY3xhcInHM/TlNg+AtzxNy0toy0vYQtFWl
        ezuQg3olXoXTl8G+7DLkgWbj0EIEfpNmdUL15zaqAL6K0RkDz/vCaU1OCk59v5lVSY3dLuQJxq7Hc
        a98H2Bfuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDyfu-0004FN-Lb; Fri, 27 Sep 2019 22:25:18 +0000
Date:   Fri, 27 Sep 2019 15:25:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com
Subject: Re: [PATCH 1/4] riscv: avoid kernel hangs when trapped in BUG()
Message-ID: <20190927222518.GF4700@infradead.org>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-2-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569199517-5884-2-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:45:14AM +0800, Vincent Chen wrote:
> When the CONFIG_GENERIC_BUG is disabled by disabling CONFIG_BUG, if a
> kernel thread is trapped by BUG(), the whole system will be in the
> loop that infinitely handles the ebreak exception instead of entering the
> die function. To fix this problem, the do_trap_break() will always call
> the die() to deal with the break exception as the type of break is
> BUG_TRAP_TYPE_BUG.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
