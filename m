Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CA3387D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFCSp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCSp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:45:56 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E83A271B3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2019 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559587555;
        bh=XZC3VI+5ueBhTr7pzFiAYJE8N7PIcQknuyrcmxqjwuQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QgVGgdQlu6pDwp8TBJ2gCZzg4NjX+5M1bhfyQVV5XLxCQti0unDuCJnW6JO+yn6T6
         yWsABw+QS3g8fEZg5scyap/CarIMIhUuDODx1cMvXH5ae5y6T8COu1iRLsvoUClEoh
         biP07qRfmVt+4mNjseU726Viqp49OvpxIQuWTk7A=
Received: by mail-lf1-f49.google.com with SMTP id r15so14399760lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:45:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUBA62n2lUE7WHDdylKLLv6eFj/8n66Quq9Nqn8x7PDvLMycXqi
        RRukPKg2HPvxJ9oMdaqrQEWR95b/GxuvgLKje2I=
X-Google-Smtp-Source: APXvYqz/rPo8PeUylTkBrW15k2bj+BP8YGTrHBhXfG2bJNxSHVBgdyXNl6JkMSZGLhJN64BxysX/gtDAZa8j7SvVCr0=
X-Received: by 2002:ac2:514b:: with SMTP id q11mr14683046lfd.33.1559587553422;
 Mon, 03 Jun 2019 11:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190512114105.41792-1-yuehaibing@huawei.com>
In-Reply-To: <20190512114105.41792-1-yuehaibing@huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Jun 2019 20:45:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeDRuvmHG=KUCYiPav2ODT4MC4hEgi5hAsy7s_+v-DB3g@mail.gmail.com>
Message-ID: <CAJKOXPeDRuvmHG=KUCYiPav2ODT4MC4hEgi5hAsy7s_+v-DB3g@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: remove unused variables
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux@armlinux.org.uk, rppt@linux.ibm.com,
        akpm@linux-foundation.org, geert+renesas@glider.be,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2019 at 13:51, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix gcc warnings:
>
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:456:13: warning: unused variable 'itcm_end' [-Wunused-variable]
>   extern u32 itcm_end;
>              ^
> arch/arm/mm/init.c:455:13: warning: unused variable 'dtcm_end' [-Wunused-variable]
>   extern u32 dtcm_end;
>              ^
>
> They are not used any more since
> commit 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/arm/mm/init.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Did you submit it to Russell's patch system?

Best regards,
Krzysztof
