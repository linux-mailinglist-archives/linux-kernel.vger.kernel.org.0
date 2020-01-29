Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4771414CFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgA2Rb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:31:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2Rb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BOnFJZE4bsLJ9SRG7kCThlThU4gC+VxII0M87EPK9xU=; b=Ts9qeR8dG+erPxTkKIIWMZ6lV
        bo9GR+vruoKrV/aH39p6r1vw/Pz5uVqpoohO1KcSNB+cwvMaPWknPSvBFdfOBYpgWoviF7Mba17Cz
        VwuHhvWBxWwfTIP47HMbs9dc8tzfnb2OxIKOUHkUacKCnNuSCyQIRJ/iJHNAfplg6JCRN1IevkjXh
        BXCrYP/JkHX684i7mtECyVGn1ck8G/XRZpLwcepJ2JIHFF6MVLeqMBDf3oVZSJ0IkZV8W8V+OB1yA
        +JetYDoKRt0Yq1ojNphy9iw5zSlZVnMWvQRhTINPypLHEbxDadMnf058syaw7KQsZaKjG0Ux0p6Ek
        7sXRoNTMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwrC0-00025O-IT; Wed, 29 Jan 2020 17:31:56 +0000
Date:   Wed, 29 Jan 2020 09:31:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/28] ata: start separating SATA specific code from
 libata-scsi.c
Message-ID: <20200129173156.GL12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae@eucas1p1.samsung.com>
 <20200128133343.29905-25-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-25-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * include libata-scsi-sata.c in the build when CONFIG_SATA_HOST=y

The libata-core.c vs libata-scsi.c split already is a bit weird, any
reason not to simply have a single libata-sata.c?
