Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9E499A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfFRG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:59:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFRG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hhqWgjBEP1JDDjQFjFNZlS8HG66TBGkF9/IRb4uAt24=; b=K8EHUHzJZc1WfxOIdvz1/7lTM
        BBR3nIrgl0dBPhs/f2TNf0c1983Sqje8gxyJw04tgBSm6BzbaoUh6AcxK5KRLJA1yLA5k7SQOvPV0
        TmVz6SANdrHtJaBHV6/gjat1XWIcQnefeBfwjAsdk8F73Re606PTvbAKuz5gdJ0jEumgpDzjqZDRo
        5vXG3+COcLnOI70oLFYT88rzBn8Bxmmbqf6sF6v6UEH0/htUp3DstaoukMTHTDBAcyEBS9xizmKtl
        9LmZnXy38HXNaIpcPfxYjj0tsum/LZDx8yZ+m8nuDMkYkiAq2pA0YR0NVSxzjbF5FzARaWwSvyrRO
        iCg7kDg3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hd85Q-0004Yp-9c; Tue, 18 Jun 2019 06:59:20 +0000
Date:   Mon, 17 Jun 2019 23:59:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fs: cramfs_fs.h: Fix shifting signed 32-bit value
 by 31 bits problem
Message-ID: <20190618065920.GA3620@infradead.org>
References: <20190618041257.5401-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618041257.5401-1-puranjay12@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1 << 31)
> +#define CRAMFS_BLK_FLAG_UNCOMPRESSED	(1U << 31)
>  #define CRAMFS_BLK_FLAG_DIRECT_PTR	(1 << 30)

Please use the unsigned constants for all flags, not just one.
