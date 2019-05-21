Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3715724F24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 14:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfEUMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 08:47:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TvIxT1o5Tbn+yqyNJ0aiw485bDsO1MWG8TucFoAEnuY=; b=T+OFfgbbJHtIJe647qbAal/v4
        4+2lqlj+lN40ITfC77kbAS9Vmhp9UHGOTLbHbAGa9SDxdHQuH50OBvqBSgBpGxnKrtGFdkbOrRChr
        XP8iIVRyRDVd3X9M4yb9TUYQT7kxWRXQTp5uP61N/fysxGYSpBWExj5YuONT4n09tmT2L3f4L8YtM
        dbx+IK1GbCqlVBmVYKIg+dVWwRxYkUck3wmUAW+XmcSPJdNbluMSHJMgD92n2f0jlqqM41fmpKckS
        UYJEyu/wEJzipFXxRtYaoEmIJiafJZHXqO4uoeJqXxtQT/zVgbsLe93CKJVj4SldbCIlGSzIXyZl1
        fHQvDs/lg==;
Received: from 089144214035.atnat0023.highway.a1.net ([89.144.214.35] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hT4B3-0004Hk-Vr; Tue, 21 May 2019 12:47:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: fixups for the dma_set_mask beahvior change in 5.1
Date:   Tue, 21 May 2019 14:47:27 +0200
Message-Id: <20190521124729.23559-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

in 5.1 I fixed up the DMA mapping API to always accept larger than
required DMA mask.  Except that I forgot about a check in the arm
code that is not required any more, and about the case where a
architecture only supports a 32-bit dma mask, but could potentially
generate large addresses due to offsets for the DMA address.

These two patches should fix up these issues (which were only found by
code inspection).
