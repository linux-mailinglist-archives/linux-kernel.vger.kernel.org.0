Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27BE637B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGIOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:20:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfGIOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XMQ8HzVhV6llIr9Uj69ef+r1U5wbO5cJKt+uhgrA3co=; b=h6hi8M5UNIIpQMGL6nIGE34A2
        nOTVOcfCr9ReD7AdY26h+nNCeC8/9lsfk0YxDLhim/hfRKvTKuEEGuW28ENauItW6QutKUo+aLUaL
        26hrhEChLGn0jVkHF1ZCqbCp+HhjQ7HyrgqXrn31PR7FkEgDDX1/KADLubImwFRq5GUFPzTxEh6b0
        tq/AmOtOemotAkzFe8/7vpZizzEhzeYM1ByzCEHlHrtQq/HG4k+pXtca+HFpIM5r4sEcF49XixB0/
        SkivzY/zSgB0JR5jPh+tV1f+PEu0WMFYoEQEn4qLRtbOxZmcraYzm65S2z/sfAhYQjigs3l/I4zWq
        w7rNyS//g==;
Received: from [209.244.105.251] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkqya-0001BM-5n; Tue, 09 Jul 2019 14:20:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: add swiotlb support to arm32
Date:   Tue,  9 Jul 2019 07:20:09 -0700
Message-Id: <20190709142011.24984-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

This series adds swiotlb support to the 32-bit arm port to ensure
platforms with LPAE support can support DMA mapping for all devices
using 32-bit dma masks, just like we do on other ports that support
> 32-bit physical addressing and don't have an iommu.
