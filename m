Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4B9C988
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 08:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfHZGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 02:38:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfHZGiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=RHQ7TPUQR59tg/BoRVnXEPwRY
        nLPwiOrNwbxoMzs3Mgzmzf9NGb+DdG3i4L+U7ylRKZIqyPQsEKTGXNEAXiZfu/STrpLFU8H5I3D2p
        n7LtKeWru94XX0bOPOXpBv/+W06na5wnSjwcf6zL/MGx5vhlHxLCOgUplkN+JA08j8s6gguHDFDy8
        d6FcG1ZSEQGc8fKL+rtc0gVV0al+wXb7voM1kweiFC8Ihj9b1IHYj+Xa20M7zXkCUlzIczttGxfS6
        LxVG934thx3MW0WD/sagHJBeSyhuKdJm0a+w0COyl2SmyPTGUF4qke8blH8IDaGsQrPHxUJmswqEK
        hHVaZCKNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i28eQ-00080H-Gk; Mon, 26 Aug 2019 06:38:50 +0000
Date:   Sun, 25 Aug 2019 23:38:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, shameerali.kolothum.thodi@huawei.com,
        alex.williamson@redhat.com, robin.murphy@arm.com, hch@infradead.org
Subject: Re: [PATCH v3] iommu: revisit iommu_insert_resv_region()
 implementation
Message-ID: <20190826063850.GB29871@infradead.org>
References: <20190821120940.22337-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821120940.22337-1-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
