Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB628893A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 09:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfHJHnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 03:43:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6TITaBDZzMYcxlmvixdUZyeuqA25uLCScJvSgm58UkA=; b=hofYnX5GVsR+TrdLOvUBmQwsD
        ZnOmpzcyGQk5VT0z96cj3/oqetjnc4NO/mEdcN6zAY20C4exWfMTP+D91H6WM3f8uQOw7N8NAiPgj
        1/8fMOPBzRsCglJEjO2YAACp26ATBjI6h44dOSmsKnnPqocq0N62Mff3hdw9zd/h7xJspFvuabO3Q
        1fKdCbTcNIGTS5Ol3FVz0XgcwGPdBmg2sYYPMzP78tguPqqmCSFilLjcHtMQC9ktFch3tk1CLNVUd
        74r9zZfndKU1IY75cbZ985/JJS7LJQYf8VfqLxRiYcGXOTeUBY5I1okh7P81We7SNp8LOrrE0lK9q
        F0FHYwQYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hwM21-0006Aw-8w; Sat, 10 Aug 2019 07:43:17 +0000
Date:   Sat, 10 Aug 2019 00:43:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Message-ID: <20190810074317.GA18582@infradead.org>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808202415.25166-1-stephend@silicom-usa.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:24:31PM +0000, Stephen Douthit wrote:
> Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
> reason, so now we get to check the device ID before poking it on reset.

And now you just match on the new IDs, which means we'll perpetually
catch up on any new device.  Dan, can you reach out inside Intel to
figure out if there is a way to find out the PCS register location
without the PCI ID check?


>  static int ahci_pci_reset_controller(struct ata_host *host)
>  {
>  	struct pci_dev *pdev = to_pci_dev(host->dev);
> @@ -634,13 +669,14 @@ static int ahci_pci_reset_controller(struct ata_host *host)
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
>  		struct ahci_host_priv *hpriv = host->private_data;
> +		int pcs = ahci_pcs_offset(host);
>  		u16 tmp16;
>  
>  		/* configure PCS */
> -		pci_read_config_word(pdev, 0x92, &tmp16);
> +		pci_read_config_word(pdev, pcs, &tmp16);
>  		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
> -			tmp16 |= hpriv->port_map;
> -			pci_write_config_word(pdev, 0x92, tmp16);
> +			tmp16 |= hpriv->port_map & 0xff;
> +			pci_write_config_word(pdev, pcs, tmp16);
>  		}
>  	}

And Stephen, while you are at it, can you split this Intel-specific
quirk into a separate helper?
