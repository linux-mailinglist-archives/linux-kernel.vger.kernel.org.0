Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B439BC9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfFHIUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 04:20:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFHIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 04:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=lhD74d33hAIRd/bqO3rjETsgY
        0BMMcWrJSnlHq+54BtF51or9hKyfmbGMXp9/b67HUhCx89BfV1gcotwQrkdli4NGnTnFD9B14vSFZ
        RzbL4gE5gtXVy+v+HaqjtevSSry0KtvAB3hkW46XYStkWkdLTLMDawEfRCzShYrn3MbHKGrgGvLl0
        pj7/CnSb6SBCwd/zI6PuNBaX2R97rm8gOXW70jEhKk/HcVek14nXKZ/giIZImdu2eAZqSsJFHuaC0
        wZdrX/O+2EBUbWI2c6MopIlZrhap3MQOMe5LUH94/3/24BYZy9YiSpg6q2TVxvEr4K6YrIEGlB1G/
        uwO5r7xeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZWZz-000149-L7; Sat, 08 Jun 2019 08:19:59 +0000
Date:   Sat, 8 Jun 2019 01:19:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: Break load reservations during switch_to
Message-ID: <20190608081959.GA26134@infradead.org>
References: <20190607222222.15300-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607222222.15300-1-palmer@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
