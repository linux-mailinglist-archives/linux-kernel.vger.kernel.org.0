Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBADC9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439672AbfJRPuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:50:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409246AbfJRPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=DXFYvi/mRPvmE4yI6kFdB8och
        h8hVdKyXImuxjWbGQL41J/TV6xcOTCCRuKvs8qetlarRH/VRd3WibFFWcwrjdNo+qd3CB6FTtfdyF
        SZ08ED5Dhw1QfO+ueOHRZy8nZ9W9LfAR5iB4d4N4XhmFhuAl1JpAxc85oI7731WXd83L/b/USBKp8
        AL49bqb9HQszgwONGH4zaKSheT4txWZ9UjJ0HrGy3nS8BI1h36GJa+8nexDSK5iPpa2HPE35bVhUv
        s/XCRmLllWGrw2RvqdcZ3TucbnkudoCND7Qn+y0FD92T+dY5G/k52pxMRsgHmTd3NoqakYJrFoXmq
        pdg18Qv8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUW3-0007N7-Hc; Fri, 18 Oct 2019 15:50:11 +0000
Date:   Fri, 18 Oct 2019 08:50:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 3/8] riscv: init: merge split string literals in
 preprocessor directive
Message-ID: <20191018155011.GA25386@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-4-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-4-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
