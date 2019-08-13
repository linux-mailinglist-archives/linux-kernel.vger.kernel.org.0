Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9E8BEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfHMQjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 12:39:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHMQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dvjkPHpheIAFUtb/UANWYph+MDgOwH2LKOqRdo6p0/w=; b=ormSlhvAESIenO92lVF8MsFkF
        gu9mbADR7T3jm/hQFhWzSKTi4D1BEkfMjT01ehIabBmhFW3W0pqstq7FeqdmAXQhtXaMNrJTb4PMq
        1xdpkrVe7Mf7CA/qZXNeVak0Bq6ROI5piklNyGZInWExPdRM4WsnQLTNsS2ZPyNpXwP8MUlB9qdY/
        2x3VLmMCo/TmMSMUIonoVsa6amo7bBWjk8cuMdeNEKEyPLxBh/wNR1r/XgiNQT50diJcXdZvCvR9i
        VSLyGF0ekfEIJELKDB/+lP9tuRy4GRPfH1WQ8URZMif1V14O3RWaep35JW0F8Oe+GwYESj0dHsxlG
        2VZZO1mjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZpo-0007MG-Dx; Tue, 13 Aug 2019 16:39:44 +0000
Date:   Tue, 13 Aug 2019 09:39:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, cjia@nvidia.com
Subject: Re: [PATCH v2 2/2] vfio/mdev: Removed unused and redundant API for
 mdev UUID
Message-ID: <20190813163944.GC22640@infradead.org>
References: <20190802065905.45239-1-parav@mellanox.com>
 <20190808141255.45236-1-parav@mellanox.com>
 <20190808141255.45236-3-parav@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808141255.45236-3-parav@mellanox.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:12:55AM -0500, Parav Pandit wrote:
> There is no single production driver who is interested in mdev device
> uuid. Currently UUID is mainly used to derive a device name.
> Additionally mdev device name is already available using core kernel
> API dev_name().
> 
> Hence removed unused exported symbol.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
