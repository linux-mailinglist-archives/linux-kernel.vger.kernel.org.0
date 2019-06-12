Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7142105
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437569AbfFLJhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:37:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46344 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:37:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so16066911wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rOWtd7XOxe0FfSSEZRoiEo8adVKTNm/zc2wOuo36asU=;
        b=Ct/SEARzF2+ihR9jeLoP/sUqewPGY1VAk2sVOGCDCflsgPDum9PbqyFqPueg2EfxdA
         AOdmBknh2WvjLg3viMh0T32Sk2L9u4XAWuVUXlavuGZLVEWJprCOENyQyAeCcK89DaBR
         xrJ8VYN/50NJueoUU8qDhYPd0leaxmuRaN7vDLDxOfDmJfd2Z0LMrA+KTkWqZQwUy0qZ
         sctlxh0mJcceB5FKIkf65qv4nNoIIjTGQHeqdN48gicR5TfExYbwMlTN4lx4/JAnlQiD
         2BtK3/cZdn2zWXcMDdth0j4f2dD+OOj7zGgFB+zlyAI2QZpYzwriLEWaXnaN6pGlc8T4
         6MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rOWtd7XOxe0FfSSEZRoiEo8adVKTNm/zc2wOuo36asU=;
        b=Cxidh4ymeRYrkQvgs/RCqMCfLrB0qA080GeR2DpMJYO2RDrhsMRdiE37hDmXcO32kF
         dgDFG5iIIuZdj/wHJF9XGrqf3m1M1foYLOIJe3fKOYgHBCGtneyoaW6hIY0AePrRxZE/
         HSETWDMbRYv3Z7tIHHPsu5olwRSgw8kxEkSMciUttS0pALV0vTRJjufvH7BT4S/rcw8m
         /GyfUz8NgmskeIZDve3NrxrH1KQohe5DH+/ry82RXWUcvCIrdf2BLrohN081eJLJSFVw
         dUAzmdcJRtUsVDp0ijhV1PE1iq7llt51CyfC2RDc4OOgQjWbBTaQCIsyKjyXyjLfHrwf
         rFrw==
X-Gm-Message-State: APjAAAWAVqHOq9ipVK97K1c/vK3iB0xtT7TPVC8+OSKLCrmMn0tkeRdd
        SaaYJJAGX5gvZKmx4K1gSJNHvQ==
X-Google-Smtp-Source: APXvYqzCVj0vpoau0f+SroJHtqv1GmqnMQbxGBrbWEt+qIBocJp0pFlYG8Hlpfw9Ms/hqdYTwSZrtA==
X-Received: by 2002:a05:6000:110:: with SMTP id o16mr51576111wrx.200.1560332228225;
        Wed, 12 Jun 2019 02:37:08 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id t15sm8126623wrx.84.2019.06.12.02.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 02:37:07 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:37:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] mfd: stmfx: Uninitialized variable in
 stmfx_irq_handler()
Message-ID: <20190612093706.GF4797@dell>
References: <ccefbd0b-3397-a26e-95e7-059fcced9154@st.com>
 <20190606124127.GA17082@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606124127.GA17082@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2019, Dan Carpenter wrote:

> The problem is that on 64bit systems then we don't clear the higher
> bits of the "pending" variable.  So when we do:
> 
>         ack = pending & ~BIT(STMFX_REG_IRQ_SRC_EN_GPIO);
>         if (ack) {
> 
> the if (ack) condition relies on uninitialized data.  The fix it that
> I've changed "pending" from an unsigned long to a u32.  I changed "n" as
> well, because that's a number in the 0-10 range and it fits easily
> inside an int.  We do need to add a cast to "pending" when we use it in
> the for_each_set_bit() loop, but that doesn't cause a proble, it's
> fine.
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: white space changes
> 
>  drivers/mfd/stmfx.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
