Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA672BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGXKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 06:00:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/MAFxUXpNzbi4KjfrTLt3NyDxXRqZOCjaS3pKnzg3rU=; b=ZZcd7Ka0dorUDDVUfi1UN4o90
        ehVjn6m3vk7MR8Ua7fhH+bVC3Zlb1KGryiDONAa8oLUk8nB9/sTDkh0Y2kNacQmbcSIm2TBnySXRr
        okBBjJe5S4tOwVJxq07I/I/BvjqhYxDmsXxaAorTlC6dAUG3Bg/DbcKevXJn12r+6/7THzEVZ/Sem
        V9pwTBvi1nvgWUPttOJLeOwhK/aZphrhxqjXRjPN5FNtxHfTbfuxNRAmbtqWh7SG0lPzgsIj46zY3
        J2pwtxrHDmAIyWdEwrswzselJRaRh4Cy5Ad05+oNkzxyD9g614WCLy/SWJ0LElxfuWAfzLCZmEeVu
        5lsXZ0jEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqE4U-000222-Nc; Wed, 24 Jul 2019 10:00:30 +0000
Date:   Wed, 24 Jul 2019 03:00:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: gfs2: Fix a null-pointer dereference in
 gfs2_alloc_inode()
Message-ID: <20190724100030.GA2239@infradead.org>
References: <20190724084303.1236-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724084303.1236-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:43:03PM +0800, Jia-Ju Bai wrote:
> index 0acc5834f653..c07c3f4f8451 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1728,8 +1728,9 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
>  		memset(&ip->i_res, 0, sizeof(ip->i_res));
>  		RB_CLEAR_NODE(&ip->i_res.rs_node);
>  		ip->i_rahead = 0;
> -	}
> -	return &ip->i_inode;
> +		return &ip->i_inode;
> +	} else
> +		return NULL;
>  }

No need for an else after a return.  You probably just want to
return early for the NULL case.
