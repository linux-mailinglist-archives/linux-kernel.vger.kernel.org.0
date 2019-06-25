Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5605275F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfFYJBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:01:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfFYJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4HmIjMyOHEEhOy14RQWOUrL2KXii1cUSgMaRaarX+OI=; b=BYCIud7F1rrcBCQc9kf1cGWZa
        XyR4Zv36df4KT8RBcakUsq9GdudrTANjlUgRQJJX6Ld1HBF7yLniUQaJV02e3zDuGRgA8urAFZ1im
        Uq1bZQeHj2POx5OjmpDQgnXWysZwWXNcZJS7rTaipizsnyBWqpzxuWwx89N/J/VdHA5uBrkWx1/hE
        gH+U0XGVRoPMJL+bW5OKF3jgWbyx6/hm5q2Y2FsiBpxwcpKBb/cE/MLSb6gNpcI9p5LuJPy2k/TA3
        cZonWh+jXeh684P7SLsfHC5H0/bHVSEb3s8VuOkUhZrk9DUST2GWBVeDnDOARVfOobbPMtUGdx0w6
        m1sMqq7TQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfhKc-0004C4-5u; Tue, 25 Jun 2019 09:01:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: switch m68k to use the generic remapping DMA allocator v2
Date:   Tue, 25 Jun 2019 11:01:33 +0200
Message-Id: <20190625090135.18872-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

can you take a look at the (untested) patches below?  They convert m68k
to use the generic remapping DMA allocator, which is also used by
arm64 and csky.

Changes since v2:
 - fix kconfig dependencies to properly build on sun3
 - updated a patch description to better explain why we are doing this
