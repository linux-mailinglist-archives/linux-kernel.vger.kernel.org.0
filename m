Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69B4740B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfFPJz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 05:55:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfFPJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 05:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IEOh0sWetk7eUh0Rjg4YlSVXRKMictYb1AnLfZ2dm3I=; b=STvGVIwk/uvRBj8V5wSWzfGRj
        5p7XuWqwuPMqVRxsogOUJWU6V7UI32zy4FgdcWrHjaDG+dAycFEpjiOf/BhdXqAr/TzLMoCIPkVNO
        11oso49jFhNuy45mviQKHZ3PaF6oITp20JBJ2ZREJ9rHSO9xjso3vc9aCBMEj8cK7wUlbfQvgFlH5
        fLBZWlkoDiHGKQz+cafKvfwBqB+HvimAy/Cb3GXb8ToY9Us2CD52ih1NFsTFHGaO/tBU+LzF/Fxxp
        m4zGv/CFUC5l/IhfwbYX2gWJ1sYxMMPYeCOZkIbkFuCB8KtlYUCB2hZ4xKzDkKIdJx3KuqecGLSYH
        KjmEQMKZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hcRtC-00030M-75; Sun, 16 Jun 2019 09:55:54 +0000
Date:   Sun, 16 Jun 2019 02:55:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190616095554.GA5156@infradead.org>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org>
 <20190611152655.GA3972@kroah.com>
 <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 03:12:36PM +0300, Oded Gabbay wrote:
> So after the dust has settled a bit, do you think it is reasonable to
> add this patch upstream ?

I'm not Greg, but the answer is a very clear no.  drivers have abslutely
no business adding these hacks.
