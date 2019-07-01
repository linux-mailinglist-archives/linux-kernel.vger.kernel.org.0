Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228B739BD2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFHIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 04:25:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfFHIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 04:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6nq6f6kYdLzdHlUSUQ3ntvwOT7p4Y3Pp2/1uGKrk4ro=; b=Lzb019GLJEi7wmG3XhG93VmH8
        i6fPgeDs5ArmU+zoH+EuWv492w7OT9y8Gi+s4Rz4MRIeUjHmUCI81G5nx0UVqI+RTDcyEsYkTajPi
        NxZ8aV8CvZhcp9Fz7bN8btQPHhJU/9g1usaFGqNWEDDB2vsbZ6DWBvvD+X16aVEQdNNmnebIoRLL4
        ipBETkU6EZdSz3n/DwKhLiulgEb45eocnD+9ufr6fWB34H3jhpj8dg6uCA8xEq3uecvRQpUA0MGIQ
        gqWAx36QSvoYsI8Nz6fD3pYkekEVGbuYAFyMlATRCuzWeGuwEjn3OS7rRsxmybtfhSPP76rh47Tuy
        GW0t5WZ2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZWfg-0003lR-8q; Sat, 08 Jun 2019 08:25:52 +0000
Date:   Sat, 8 Jun 2019 01:25:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
Message-ID: <20190608082552.GA9613@infradead.org>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155989287898.1506.14253954112551051148.stgit@buzz>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
> Print trim status once at ata device initialization in form:

Do we really need to spam dmesg with even more ATA crap?  What about
a sysfs file that can be read on demand instead?
