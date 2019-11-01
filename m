Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFAEC21A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 12:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfKALl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 07:41:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39628 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKALl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:41:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so9943636ljj.6;
        Fri, 01 Nov 2019 04:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUVw5pKvFL1V3WBR7Xy8T99diauMbncCUtUodFNi4iw=;
        b=FQeb7YJu7/k2LGGMaoKtNN9e/WDgBbvzmlsRnbWfxwbsUBG8yq7HxrVeB0NFPxhlPq
         /rxcsobtZjTcw9jqaEsZWQGx2EY0FWg/eu7OBYwTLUZHL53FEc/eEHaVkS3bewGiPCRa
         3XTmFyc4nzg7iMlrryIuR+oeL76yB18lstCB8iZ0YU/qnu5VBb58z1X60I2K5xY+WLzU
         OtiEX+BZogtDo4DktKC/Tl1JbpZ/bIZq2CWWEeMtbYR1cStE65LL8z2we8aQ+oJvgBZj
         V5DYSCDSD9WM0L3gWPlvXowym93oTrSpiE8gjpSuoUcsevjdaPzGDjUBSps02wJog7nW
         9SiA==
X-Gm-Message-State: APjAAAWG2lZ54GQuRsvSedwI4Lbs8tLU5In7NU5raEU57Pnz/78kJKLt
        6yroLy3g3cDYxvs+9lTxTivzLcKp
X-Google-Smtp-Source: APXvYqyuOxCXp80A/3Vf8r/kLxNHoC4Hrei7jUTKsQCfluRvYShj0xgspEqS/QBGis4p2JkAAY30XQ==
X-Received: by 2002:a05:651c:10e:: with SMTP id a14mr7744228ljb.177.1572608514450;
        Fri, 01 Nov 2019 04:41:54 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id t22sm2446134lfg.91.2019.11.01.04.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:41:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iQVJR-00030H-4S; Fri, 01 Nov 2019 12:41:53 +0100
Date:   Fri, 1 Nov 2019 12:41:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     jacmet@sunsite.dk, gregkh@linuxfoundation.org, jslaby@suse.com,
        shubhrajyoti.datta@xilinx.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] serial: uartlite: Missing uart_unregister_driver()
 on error in ulite_probe()
Message-ID: <20191101114153.GC3657@localhost>
References: <20191101111950.47817-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101111950.47817-1-maowenan@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 07:19:50PM +0800, Mao Wenan wrote:
> If uart_register_driver(&ulite_uart_driver) is success,
> but followed function is failed in ulite_probe, it needs to call
> uart_unregister_driver to unregister.
> 
> Fixes: f33cf776617b ("serial-uartlite: Move the uart register")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

No, this is broken. The driver is deregistered at module unload.

That said, f33cf776617b ("serial-uartlite: Move the uart register")
should never have been merged as I have pointed out before:

	https://lkml.kernel.org/r/20190523091839.GC568@localhost

I'll see if I can find some time to revisit this and start yelling at
Xilinx people again.

Johan
