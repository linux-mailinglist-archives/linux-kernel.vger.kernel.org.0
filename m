Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345409CE37
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfHZLf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 07:35:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbfHZLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aenK8euu943bliEDeJFfs0W3RyIf+T+BCmMxBssGwPM=; b=uxOVl9R6OEU74LUqPOVcmHjSO
        1vQI3HafvvCoFjegccH3y1ZSTxBkWVzevJr84P3xFtXruTep0+qtdi8VqhdVOV7CFXdkyUsrsWfF6
        H/zUcpS0hcioTzQXaWuSuWgOV7YBLUkLkKZ5iaKQvxStyV+T7wsDwZ6ATwhdY5469ykkqO9mi3t0/
        Y/6/19uaEYqe5SVTrNQ+/IoESnCIFZ/Sy8+7bJ0lOa/l4uTeaXYQklMiVjtTBa8czMK8/voeoc8I0
        yPmv9SqCOPALIxKQXkITp0TgdPn3prw2eaA7FKoX+rdsTcvrpBUoj8L3JCGWWI7lQgBxK/bRVpkaB
        BWKSuS1pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2DHS-0001v4-Ev; Mon, 26 Aug 2019 11:35:26 +0000
Date:   Mon, 26 Aug 2019 04:35:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
Message-ID: <20190826113526.GA23425@infradead.org>
References: <20190821092658.32764-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821092658.32764-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:26:58PM +0900, Masahiro Yamada wrote:
> Use the standard obj-y form to specify the sub-directories under
> arch/riscv/. No functional change intended.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Do you have a document what the grand scheme here is?  Less of the magic
in arch/$(ARCH)/Makefile sounds like a good idea, but unless we have
a very specific split between the kbuild makefile and various override
I fear just splitting things up into two files doesn't really help much.
