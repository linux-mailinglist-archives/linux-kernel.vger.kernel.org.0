Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C58D22C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfHNLbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 07:31:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36495 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfHNLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:31:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so4152077wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpgdRd/asOikWKpcYOp7GCtusnJpkP9qaZJO14nOi54=;
        b=hfTFjhzlmuNszaG+J2XzDCFC9aCurGRC0kLthghagIg+0PJ20Dx7kf2nNkG9JU3ERX
         sMqGce+Qf4BDhgEUPK4Rd4vEZCpbmQC7K1/6RZzfY31Yp3haEq0Js3ELAwSBr9/nA2iD
         GhyVpqwCGQyu+Jhti41HcgsIDNhvWeTYe8EGzhknBYSr9WC8t5KgB1iHXZZaKT6PHkhe
         FuAELBI2DEa7WfzxP/VFy/LtihhymwQhun/vKe6/XpqccxmxnBDjxBiHIYhVqBDg+HqX
         0JwWXfqaDZu0VuZuScYKhzuItc+tUInwwQqP+t+INn6cOvKuXjpC4eEpvKJAMb201k1H
         iTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpgdRd/asOikWKpcYOp7GCtusnJpkP9qaZJO14nOi54=;
        b=r+fr21vaEGZshmKthh8oDjd9+6gQzzGn6ytYrzXQFUx9cAh0q2jZLW6QpQSQdRYd2K
         xJUmXBBRDamSC/9vmc2orquyfqxkqPUq79lwabTeGMMyRb3PyxvVdclxElUC7SiJDuey
         ++dcdFxGzB1H2sQn21HFvffs7TRSRyKkGZGWRXp2KLEYYjBAjO2WRzlLziFfsdY/N715
         1WAimo3u3QjnEiVMtLtTb4occX5xuLp8g5xrmV0j8I+Zvnq4RZOkxqVdKXukml7UxK75
         cFbjSWWWwYKxgQevunyPcjdoEA6Q+nZjd4Nio3YqdFH1lqiw7e36bDMlxCAlmAcpB3Fi
         3e8Q==
X-Gm-Message-State: APjAAAWXdvTgoioKABeDUcMBLin0YTx3uRD5koodEunWcMLWfWILySSU
        obbbtT/U8+6ywRNLZU6CeB8=
X-Google-Smtp-Source: APXvYqzoN/SFNr2n82+7oK/p1XvBt/QNrznmv2OOYTSvMxrNYtuX4Mj5uXeLY4ZZiHdavFSt3jiBfg==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr8368403wmi.168.1565782267282;
        Wed, 14 Aug 2019 04:31:07 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id 12sm3824512wmi.34.2019.08.14.04.31.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:31:06 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     codekipper@gmail.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [linux-sunxi] Re: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Wed, 14 Aug 2019 13:31:04 +0200
Message-ID: <4005451.bVnTXbg3Co@jernej-laptop>
In-Reply-To: <20190814072007.6tfvhzsw4oxbwpc2@flea>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com> <20190814072007.6tfvhzsw4oxbwpc2@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 14. avgust 2019 ob 09:20:07 CEST je Maxime Ripard napisal(a):
> On Wed, Aug 14, 2019 at 08:08:54AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> > 
> > Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> > to reflect this.
> > 
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> 
> This patch looks like it's fixing something while the commit log
> doesn't mention what is being fixed.

Main issue addressed here is that SUN4I_I2S_FIFO_CTRL_REG has two self-clear 
registers (SUN4I_I2S_FIFO_CTRL_FLUSH_RX and SUN4I_I2S_FIFO_CTRL_FLUSH_TX) and 
thus it should be marked as volatile.

Best regards,
Jernej

> 
> Having some context here would be great.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com




