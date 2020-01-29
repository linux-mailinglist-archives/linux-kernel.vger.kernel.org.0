Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9214CF97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA2RYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:24:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2RYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aEA9XM/kaKod4618apCoqRoTlzeWF1A0F1f7CXHzVGQ=; b=oGoMVuceJTs3E2elidGfredB+
        RtpKoV8wTR63N4yq526QLyj8s19iM4n1jH0hWZ13ZAHEnPc/cROhvjFw07HCqCaOIguJr6pApl4kL
        ZI09DRzHaW21T3KFgaDq/2MYpLDQz7upOw2mdz3W8XqYBkxLf/gRkmZsc44iPdpsgmnHii7uK/DDo
        M4OolUKfFm+lwOU9BcJt4bdB0hg80/6CQ2ja5SK0QO3HhdJHaGhyoOr7uAehNSS4BbGYp/363WvLy
        6QM6Lv+OHxLbFrBM5AY/B1YASApUklPEu8Z6zFdmqWFoJcqjp0UMDgeQVGiZMdergCG/G01twTXpa
        6ZSMcq4RA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwr56-00079m-KU; Wed, 29 Jan 2020 17:24:48 +0000
Date:   Wed, 29 Jan 2020 09:24:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/28] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Message-ID: <20200129172448.GG12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11@eucas1p1.samsung.com>
 <20200128133343.29905-12-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-12-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline int ata_ncq_enabled(struct ata_device *dev)
>  {
> +#ifdef CONFIG_SATA_HOST
>  	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
>  			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
> +#else
> +	return 0;
> +#endif

I think this is a prime candidate for IS_ENABLED:

	if (!IS_ENABLED(CONFIG_SATA_HOST))
		return 0;
 	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
  			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
