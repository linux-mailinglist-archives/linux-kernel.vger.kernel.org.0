Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078FBEF19C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 01:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfKEAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 19:01:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfKEAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TO2eOiS4yp9XeP4RDKM23cRX2kba3mHm/rvOSVnBGjc=; b=kmNkDjrT6P60IuU6ebCJT5SCH
        CuaX20e62rpiK819CnqbDTme4QqXvO2hc2poiVIkEWI7gQUtjA0k/m64w+KuxE/4w3JSpPuGxVVOu
        QgNgRQ+7XjPh+XjienJYw3ykn5wmskQOLySqLDuAs5ybkeBMoITBJiOzwYjsuMzopdmmirAbfNyfu
        Xo43p6CJM74SYpSjqb+jY0r5F/IM1rmAtCfWD91K9Op6Qdju7u9PQlCl4u9fd61zvAODHY6zlavcO
        IFP/WpiDzQoWK8Iw8BYeqNyBZBd5O3atgY31h55iqR901km73tDfbxCh4TwsCVUpLMQlTmWbMIr3I
        trKfpLQMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRmHi-00078c-Qq; Tue, 05 Nov 2019 00:01:22 +0000
Date:   Mon, 4 Nov 2019 16:01:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
Message-ID: <20191105000122.GA22359@infradead.org>
References: <20191001073539.4488-1-geert@linux-m68k.org>
 <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
 <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 12:06:05PM +0100, Geert Uytterhoeven wrote:
> Amiga is fine.
> 
> Mac and Q40 are not, apparently.

Can any users of those legacy ide drivers please get in contact
with Bartlomiej Zolnierkiewicz to ensure we have a tested libata
driver quickly?
