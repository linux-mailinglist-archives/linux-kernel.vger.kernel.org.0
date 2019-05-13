Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92FE1B0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfEMHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 03:07:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfEMHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wvkcqhynYP4xqS1DwKpC2GjLyrx8m7bCCdn1Vpt2fCU=; b=BvzblN72ltK4UWMiPX/NEmNGv
        MzDQHyKxWkBt0LYa61U+KMayG3HM9YW2fBnoNL8a3M3skzEyDktizRL7gpgF1WrRzZ5vi5Cnrvj+v
        f6/7HuL5wcDM72i5QW8Xqxp/VcKV9mhwyQjCpcvquVr/AcdyDkijXjlb7GgRsZr7qr3CdNeBgCk1W
        NuhGF4r0s38GEKt+6777syR/9kkAerx41dBkNuaFUPNR0wnuu5GjWowF5lXJ/GZGH2XlxhwtKQiSo
        PoY5OxDBb9MpMavYk6aWq3MwbCK91kKjc17gASEcp1skUC+++spKxBdEc2BuYuLUTFqV3uq+skBc5
        C/UgTFGpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ53E-0001ix-Jf; Mon, 13 May 2019 07:07:08 +0000
Date:   Mon, 13 May 2019 00:07:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fdomain: Remove BIOS-related code from core
Message-ID: <20190513070708.GA31342@infradead.org>
References: <20190510212335.14728-1-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510212335.14728-1-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 11:23:34PM +0200, Ondrej Zary wrote:
> Move all BIOS signature and base handling to (currently not merged) ISA bus
> driver.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
