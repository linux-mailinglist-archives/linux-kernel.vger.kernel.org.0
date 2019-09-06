Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524A5AB1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 07:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392318AbfIFFP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 01:15:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45202 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbfIFFP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:15:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id x3so2516382plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=a2LOjFUhPbLgvkL0tM4GO8ba+rPlY6cRwAaIH0yqFhI=;
        b=iRXVe9ZmTGD6DLbHMktGQnAtedAWPBdz7jfymGxrUHhWBukit0PWtlbth0La978u4W
         4wHVbNbkLT+hNE5YQs7GQUbnhTcakSld9AVTwqa+DQ0eWRcv4mpThhKxksYejdJLIkix
         vlXcgcR3HwmnXbsldwWOY/BcqLadXdiuBsE5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=a2LOjFUhPbLgvkL0tM4GO8ba+rPlY6cRwAaIH0yqFhI=;
        b=PY6Nvji2WNPy1bgJ3c1UWK2uWahwsd8DbznMeFW8JzN9Tb4yCju7B4Nx8bkCqpZJ3c
         OrqiEdZhmrLKJu63KMQcbqZvYUKXjKr1128qgfJuG4PeWze1910E4hUpSyeNziP8kwpp
         u4zd2YIdPRcngLEDTc85H7R9CZwGztFilt4+pdTUdMc3FTSzBGMoRel14509QWjZ7rJJ
         NP6b+9rlwYUVhME00EP1qNqhdxI2ZZWSOWnc/ty908JpW7uZ6g5hWlgTBaiNLC9/WRUj
         dYJBogQS9+9tTe7T+PlQdSK8eGncwQl7CwxIQTT7GCNMIcjy7TuNym1A4LjGKR+/2M6A
         ojFg==
X-Gm-Message-State: APjAAAUWWkAo+NQM190KKZ+OvPxkjnqeBCGgCs3LWNS4UZOAAsKhC7rw
        d5adGtFNHKOKegIU+mSI+7O46w==
X-Google-Smtp-Source: APXvYqybda006Iz2xBYD2Y4oUD9Ac0B5n1TbiRO8U56Jzay1kDjVhUeq7xoi+MBZ7VylGLOqJ++gHw==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr7280207plp.161.1567746927912;
        Thu, 05 Sep 2019 22:15:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b18sm4877779pfi.160.2019.09.05.22.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 22:15:27 -0700 (PDT)
Message-ID: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190906033006.17616-1-yuehaibing@huawei.com>
References: <20190906033006.17616-1-yuehaibing@huawei.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr,
        gregkh@linuxfoundation.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, yuehaibing@huawei.com
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] coccinelle: platform_get_irq: Fix parse error
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 22:15:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-09-05 20:30:06)
> When do coccicheck, I get this error:
>=20
> spatch -D report --no-show-diff --very-quiet --cocci-file
> ./scripts/coccinelle/api/platform_get_irq.cocci --include-headers
> --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include
>  -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi
>  -I ./include/uapi -I ./include/generated/uapi
>  --include ./include/linux/kconfig.h --jobs 192 --chunksize 1
> minus: parse error:
>   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column=
 9, charpos =3D 355
>   around =3D '\(',
>   whole content =3D if ( ret \( < \| <=3D \) 0 )
>=20
> In commit e56476897448 ("fpga: Remove dev_err() usage
> after platform_get_irq()") log, I found the semantic patch,
> it fix this issue.
>=20
> Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_ir=
q() excessive prints")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Hmm I had this earlier but someone asked me to change it.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

