Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B286A61E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 08:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfICGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 02:54:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICGyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T+PF9nI/UzswEFIMDskT8tvvKXEkHyUFFsZIV3W9dq4=; b=NckRZ4e1JnfYIjs6wsInfvUGS
        4fwfAQLoC4cCGwbGbVj9yFOF5MHFfTl392qKh9kB2l0RLPCmNVK1+fhXWNMajto2/IalTJSl7Vn0z
        9mCVwRuZ2eS2+6MsSwN1+17ZQ9V4LZI4zgzrX1CL0cn0WZhujA2r6V27/7+LuaG1Ddsho5LGVIhqL
        AU5CpoReMG3TjoYQNWNELQjLDTUegQ0z887aUeUr/TLPwZ8AkMyFAqreJX8B9n8QKkkNwpwo2hgil
        hsx957IysdYrxsnRMxoltaK7PrsUV18dniBryxIIJMdmSbpSbet0Frhn7JmUE7qi2FkC/z4Tsl4U8
        dxxjaey9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i52iA-0000tZ-LK; Tue, 03 Sep 2019 06:54:42 +0000
Date:   Mon, 2 Sep 2019 23:54:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] iommu: virt: Use iommu_put_resv_regions_simple()
Message-ID: <20190903065442.GB28322@infradead.org>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
 <20190829111752.17513-6-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829111752.17513-6-thierry.reding@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the subject should say virtio instead of virt.
