Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769B4112344
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 08:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfLDHFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 02:05:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfLDHFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:05:48 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E97C20640;
        Wed,  4 Dec 2019 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575443147;
        bh=S6YXY0WSGd40GdEaNS2ZuBBJrr6gttgFTL/R8NsDtj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oPQhtVT6DXaj/yFVSSehxU12rdGiiY2EW3oHDV3cNfOND2cxeIo9d0ygr0ouEQwRO
         5poye7OWzkmKepdangoL/gKDAfiHtY/HIN+0W4xnLmygGO0Tw56raoYHvHBvOgXjbc
         3vqrZjwqLoL3PfDMkKNRZ/Ewl9VxeCmS8ih4+3zo=
Received: by mail-lj1-f179.google.com with SMTP id e10so6772149ljj.6;
        Tue, 03 Dec 2019 23:05:46 -0800 (PST)
X-Gm-Message-State: APjAAAXaNgMf9uF+Y+mPS9JeYcWPElf3P51l7lo7i6aerRLn4eavOf0y
        dQqxzUD+ctmAt4935KSnGlGfYTUonf9eOHDK8fA=
X-Google-Smtp-Source: APXvYqwmL/CgrLwkzf1hlZYxR/WYkN2neDMd1x0s3IQW70j+RMiyMWx9RmGC7qai42FYwmWcxLrrjlMhD8JwCd2wdw4=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr983748ljl.74.1575443145285;
 Tue, 03 Dec 2019 23:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20191203214838.9680-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20191203214838.9680-1-christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Dec 2019 15:05:33 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdfdWYELkxh0HO4GhoinG55Uk7G9o6-q+A4+pPn3f+-jA@mail.gmail.com>
Message-ID: <CAJKOXPdfdWYELkxh0HO4GhoinG55Uk7G9o6-q+A4+pPn3f+-jA@mail.gmail.com>
Subject: Re: [PATCH] regulator: s5m8767: Fix a warning message
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sbkim73@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lgirdwood@gmail.com,
        broonie@kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 10:45, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Axe a duplicated word ("property") in a warning message.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/regulator/s5m8767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
