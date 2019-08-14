Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D238D583
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfHNODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:03:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=noq9D28/MFUyTTAkpQb2LOKGLfTUJVojb3JEcNK7ESc=; b=dIkrneJpUUE5jFGK9cE4sKex1
        RuQo1h61KDw7YU4VPSL0P7EhIyGX31V57BcI96RTwFzp6p3tXHlpmXLyglFPWhIeThPiHWwusCLLn
        Xton+x5r10Ah1SjAdOk8QfzK7ZmjtvQ98Ne+KP2q9etTK1zouPZ7Z1HRactqllCAvsTlg8Bedf5o3
        uBFMh9AmiSu7tSvBoCGTOJPyzYWxj4FoKz+glo/CnxZNuczqhDNZsL0EOHJgEGxsuMZkRknRYMLKw
        mTh+UlmBHiVtBxEgt/7K18UVFEOuOTTbJiejNz/kqhhsrHZ/lauPLkISpO1SXwCwserE9GY5ezzTB
        nhnVvydyQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxtsU-00012q-TA; Wed, 14 Aug 2019 14:03:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: convert microblaze to the generic dma remap allocator
Date:   Wed, 14 Aug 2019 16:03:46 +0200
Message-Id: <20190814140348.3339-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

can you take a look at this patch that moves microblaze over to the
generic DMA remap allocator?  I've been trying to slowly get all
architectures over to the generic code, and microblaze is one that
seems very straightfoward to convert.
