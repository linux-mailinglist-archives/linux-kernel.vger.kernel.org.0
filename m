Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4AE58CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 07:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfJZFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 01:45:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJZFpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 01:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+5wJzXbxCtQrwDXJERufHrvtviLSbDdpQ5zkUXtHDM8=; b=jvYPutk33nLzO4xA4Vlidwi/f5
        UAGY171Z+5TWnFxLCnOY5/kamSI5NYbuCWKB+fxvnX8Wky7h9PNRx30ftSb/2St3cZezWNq+gTfxi
        EZv2U3SHmkI3ci4WyYcYIpV5BTH5OSegZBTYr/8RD6HEFG1FCNcpxRGMp44JATFjpTi0RW8WtTYc/
        /Fvc/+4pSutIo7Ba/lbk4bndvsQYg2vviwjIaeGCP7TLncb8tWFUsI9s/GttnLpPdlHd9AR3Lk1E6
        SEOFYDz+x9/TCcVxPE54ufSPozof7kRkft+WHziQ7XhBMHFJBHJhybDyBghNd3AxRM5Z0u+VspdhI
        tW6aPHgQ==;
Received: from [2001:4bb8:184:47ee:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOEtd-0007iR-Bq; Sat, 26 Oct 2019 05:45:53 +0000
Date:   Sat, 26 Oct 2019 07:45:51 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fix for 5.4-rc
Message-ID: <20191026054551.GA5340@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0e2adab6cf285c41e825b6c74a3aa61324d1132c:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2019-10-17 17:00:14 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-2

for you to fetch changes up to 9c24eaf81cc44d4bb38081c99eafd72ed85cf7f3:

  iommu/vt-d: Return the correct dma mask when we are bypassing the IOMMU (2019-10-18 17:19:20 +0200)

----------------------------------------------------------------
dma-mapping fix for 5.4

 - fix a regression in the intel-iommu get_required_mask conversion
   (Arvind Sankar)

----------------------------------------------------------------
Arvind Sankar (1):
      iommu/vt-d: Return the correct dma mask when we are bypassing the IOMMU

 drivers/iommu/intel-iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
