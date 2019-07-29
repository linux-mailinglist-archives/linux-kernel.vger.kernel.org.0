Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12FC78E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfG2Oci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 10:32:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfG2Oci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LQVvrxHhNozlLrCeoa/r+A8a1Nth6EeS0mzOOGaTr78=; b=nXtEMeP3eXdw0s5WVf3Dx0y+L
        4ZsAitEjAUHYUWry1q9onLEND2XAwrHbDYKRNGr8TWIFA0wrFrLwSmnowIGSxI1DqSfqPONkLhb73
        A+8gZx3qMyyFH0f09dKY/0epJqv7+H8jZDiDg5AxYuZcdQf395uliYZFmldMl7Fmvj3zRR9u73DlQ
        J8IFNkhmCrUOUfUcPtAscivnTfeiOSHPo3y2xDD8UkSW19mGq+ZYnzoSYs4DdoN5diyyFd5CFSrhJ
        GAlG8sA05FpHaTRzs8iyQQkVH02LrPi1xvcBBhskH7fgi8LPtDac8u4FkMu/oMZCDCSANW2GkPrNK
        XqtY66wsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6gu-0008Ad-Eg; Mon, 29 Jul 2019 14:31:56 +0000
Date:   Mon, 29 Jul 2019 07:31:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        jingxiangfeng@huawei.com, thunder.leizhen@huawei.com,
        fanchengyang@huawei.com, yebin10@huawei.com
Subject: Re: [RFC PATCH 02/10] powerpc: move memstart_addr and kernstart_addr
 to init-common.c
Message-ID: <20190729143155.GA11737@infradead.org>
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717080621.40424-3-yanaijie@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think you need to keep the more restrictive EXPORT_SYMBOL_GPL from
the 64-bit code to keep the intention of all authors intact.
