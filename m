Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349EDEFFB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfKEO2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:28:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfKEO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FnhbKv1NJWSMCBD9NX+uY4kUOFWd6In8uzNN/UHbTD4=; b=MNZ4kIS/8Bvkb8ZCtGO3gowcQ
        ftaA1mskE3sQPwENKvafKux18o+Nr2830mtdd8GBHYngWj+vGvNmZkdr3nL/rgPhwpK63aBvvsFah
        8ZjsHj2jUtMU/hnEwkLr2s76HlCyVppxssFvi+P14BzhBw6KGqK8LprLWX0qn0/v8+eREfzErGgQN
        Gx87YCQDfzMEZk0n6Y8S4R5jjgxRdIF0cVJ+zUy83zTJ9lGYSNoEhjxwvaR2K5UN0ps0VdRRBns/R
        v+dPOP3TayC0ITcFDbPEwAzQJAbLE04GIZRpETUH0CX+2mpZHs9Fusen7YIzaxpcQ5yE/nwSOc22B
        rZFGu/nFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRzoQ-0000Ds-Lx; Tue, 05 Nov 2019 14:28:02 +0000
Date:   Tue, 5 Nov 2019 06:28:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spdxcheck.py complains about the second OR?
Message-ID: <20191105142802.GA30779@infradead.org>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
 <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
 <20191104235340.GA13961@infradead.org>
 <CAG_66ZQ3f39bv=0Yw=Eum0vcxbf94mmXE9jdJUpi6+gEEqkS8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_66ZQ3f39bv=0Yw=Eum0vcxbf94mmXE9jdJUpi6+gEEqkS8A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:39:39AM -0600, Kate Stewart wrote:
> Unfortunately those copy and paste errors introduced new legal terms which
> made it,  its own license.

FYI, I meant there is no reason for this brand new driver to tripple license
2 files under BSD2 clause and OpenIB.  (Or using the OpenIB license for
anything new for that matter).
