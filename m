Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8510ED9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLBQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 11:59:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfLBQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3ykgoWuVkN+wjrzc/eQPiBn6mq0Gz+cdTGiRXv4caZY=; b=NrY935yLJ8NkW4ZaE2IcJgBmo
        6SR7tdZjZW4MHIKcNieD/doI4l7MARJLsJ+NuwPjj+RHUqRfDU8sH2e5nb19EG9mkmbmFgJrYEsCU
        MDFmhVAfj2ydBPVqNlADouYO2CUlBi4SyLOsShB0VRLwcX2iGQVSWdZhdVAC+LsHMysOsOpKCtaWU
        OV7pX/DMEST1e2cxzlb9Scjb4eXiG/FsU/IAl+dkuhW7Wee+/C0PmOv9aYE6Bo39VkhsaTV5JX87X
        0WPeYCTBdyxgvd+PtEC2QQlfMNYO32QyPen4M2svV1gsrLpBPNsYrq4Kute69OejDiFP7evDuX4F/
        H2PheOe+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibp2f-0007u9-Lh; Mon, 02 Dec 2019 16:59:21 +0000
Date:   Mon, 2 Dec 2019 08:59:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
Message-ID: <20191202165921.GB30032@infradead.org>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-3-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129004855.18506-3-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	return (mag && mag->size == IOVA_MAG_SIZE);

> +	return (!mag || mag->size == 0);

No need for the braces in both cases.
