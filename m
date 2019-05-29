Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D558C2D744
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE2IGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfE2IGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:06:18 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA9B216FD;
        Wed, 29 May 2019 08:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559117177;
        bh=zvkST1rrqAg/0EOMioHca7dyZZQf08kifXr9Tqwv1TY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vUNz/6qp6rgUk8CZ+2U7gSM5z5XeE+KIKg/XYq1Pc5+kVlDHCfRFV1RLa8xzUeCsK
         MR6znKBAa6DT2x6mrdgVdyb42sTfTGyJwEbRVyaa9KtmE14E2qtbshiO5c5/qLxbC8
         9lDQge5BCqUrdC/ctmqhyTVLrD+qtZFjXRFOvODw=
Received: by mail-lj1-f174.google.com with SMTP id h11so1508443ljb.2;
        Wed, 29 May 2019 01:06:17 -0700 (PDT)
X-Gm-Message-State: APjAAAVUCj/lMAuoFFGrnuzmQGx9jTGTgOr7tedFc6wgOHfgkIBLTd39
        V1JlyM70Pu5vn8+ElVFnSAZlMm8kImgxPjuyWnw=
X-Google-Smtp-Source: APXvYqyCNE8aywzruJ1YPsXvoW7Bi8221F62kZ3/oAeiwe1WKZBh2+oYFfOng8NxegoBNooj4esz6WKDqWb0C1gMxKU=
X-Received: by 2002:a2e:9601:: with SMTP id v1mr21039204ljh.60.1559117175876;
 Wed, 29 May 2019 01:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190528134305.10184-1-yuehaibing@huawei.com>
In-Reply-To: <20190528134305.10184-1-yuehaibing@huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 10:06:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfdhZ1WZZQrqMn69mwJ1aAVVOAD4TJqOc7FMws0+-MG9A@mail.gmail.com>
Message-ID: <CAJKOXPfdhZ1WZZQrqMn69mwJ1aAVVOAD4TJqOc7FMws0+-MG9A@mail.gmail.com>
Subject: Re: [PATCH -next] usb: ohci-s3c2410: Remove set but not used variable 'hcd'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     stern@rowland.harvard.edu, kgene@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 at 15:43, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/usb/host/ohci-s3c2410.c: In function s3c2410_hcd_oc:
> drivers/usb/host/ohci-s3c2410.c:296:18: warning: variable hcd set but not used [-Wunused-but-set-variable]
>
> It is never used, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/usb/host/ohci-s3c2410.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
