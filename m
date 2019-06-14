Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12E245A02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFNKJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 06:09:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfFNKJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YuvfDmTRlrw28HgCcbxWCLme+ZpdUXZ77St9YzhMCWw=; b=IXDbLqgToWu6+SArZBz4mZAcV
        nNd5zi+VwoF0UG1YtG+D7ozFNxiUtyoC4WV4gEi3r3ad0Lj5XN8GbWQa/KNJ9DXHo+flRA5QSiZ/S
        k7T19ABuAfMaiuuEYhvHX/S8sfg7lUC1CxDtrMCedY80uHZBkuE5MsmXtbUlmIONWkZ7flCvw1yDQ
        XvylQaO6KMH8JIK2tVT9MCGIDTiIVzY1sBziAK7C6AIIepQtMppPy5xaDeOfZ4RXXejhfAGgPdHpL
        MD2dJKR+wpAmEF8O6bDGPSlE/2DLUjxZOGVlAYTHejDI8gRVQTNEndMqYgCUTDY9l9H20WVwPhjry
        aU7ZXabcw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbj9I-0007sR-QG; Fri, 14 Jun 2019 10:09:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC] switch nds32 to use the generic remapping DMA allocator
Date:   Fri, 14 Jun 2019 12:09:27 +0200
Message-Id: <20190614100928.9791-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime and Vicent,

can you take a look at the (untested) patch below?  It converts nds32
to use the generic remapping DMA allocator, which is also used by
arm64 and csky.
