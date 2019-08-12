Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5327F8983B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfHLHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:48:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53192 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfHLHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:48:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so11244602wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DtQjHVjml5ABPpPR1FU1RhwW7R/a6XbkhJg8OMveU+Y=;
        b=nGv1sEZfev5qpZR7qeROv6jGSlA0bTJAbD+znLGF4/qd3X1G42eTuIO+sC0/cnkk7d
         GfMoXerkRmwn228WB2yZUjcayuAsZ2860zV9fFAjTrONayx/7K5vMLEx07SLrs2+1I/b
         wroQEKB1AgvnHVbJbqRMzGYJL+m5pjDlfeYYNramiqjWb7R36RW9lLtOnXQyrVofBrgV
         u6IESxqa/F1HSverfUUoGsnyZQmDzqbnzKTyTEzepTNZlmadK9JoM42zIpjuGQRr7+Gn
         z6crx2r2Kic9hojMB3+GlIFSu0RiQYgDb7vr4VIMXQbUgV0Wrva+E8RsA7BLIGY3Xl7k
         hgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DtQjHVjml5ABPpPR1FU1RhwW7R/a6XbkhJg8OMveU+Y=;
        b=SFGJ9dHBgJfuZN7xzpuKB4oOBDIIX4TNhjhCPtbbZCqAGUsjadbL+/91jD/9Za2BQF
         S8S0qeLZdddwUoiiGEov9FYlPzMEFYIRMVS3x4Jw7EoMh2QOhjKaVoAvAdKPdc1gG5WU
         Zv9S1QXmmlTjctWwnmxNkuzdYDA0PqdeIowCv0Nx1solzQqfSkUZYfqCaqUZXi/fYmFi
         lfJ8SDxjGmS/C394QrLRlt960+kh17rCnE7wWhQPI2trUEcJmit+SKd7JSO+roTiJ8hn
         YP9NPkjO75vBx+4qQ27cbztAcwuiMQpbcxN9QGkKJZpjs1Qy/PnZlg1rsAts9d6UaLn3
         Fb6w==
X-Gm-Message-State: APjAAAVNm5CnzaH7Dz9qEC387PnLD1qTU9etRqVA+TnNL73IIv80n2J9
        fSzxaTWUypVbi3HQFQop0JT4Hg==
X-Google-Smtp-Source: APXvYqz9WIKblK5DCAAUo+OxYnp5VUq1+T5AlqilAIuRYhcMx9g4QyntUslPo1/CNM2Kko2yPMRM+A==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr19565551wmk.158.1565596101165;
        Mon, 12 Aug 2019 00:48:21 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id f18sm916948wrx.85.2019.08.12.00.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:48:20 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:48:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] mfd: twl-core: convert to i2c_new_dummy_device
Message-ID: <20190812074819.GF4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-15-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-15-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/twl-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
