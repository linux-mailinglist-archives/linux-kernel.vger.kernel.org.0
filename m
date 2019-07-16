Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE06A486
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfGPJG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 05:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfGPJG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:06:27 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7DD9217F4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563267986;
        bh=Jlmctw/gzL2L8/5Pqug84d7JJ15nW+VemHO5Vvewne8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T0ZMeWgQLQEwNeco6Fkrs3vXiny2QmVrsjR6P2yOEGZ9hnOmQdit9WvRO4cuDB4X9
         5jZOQLyvHS3y6Ifi4CkP2iIPCZK4tv0JJTK0N/KsuZUn0HagdcBo2hWOWHpRtwv6gF
         ElhPu7jcCepxUivj88RoQOXtaYTdssuX8T/65Ww4=
Received: by mail-lj1-f171.google.com with SMTP id r9so19147354ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:06:25 -0700 (PDT)
X-Gm-Message-State: APjAAAV76xcg4S1ryBJ8RL6LuoMydloeNTy/75fGaXXiQKjHZC2pfztu
        1n/R5HQvFKXePVtzqtg6OCkjYYBQjiCeFd6l9hg=
X-Google-Smtp-Source: APXvYqwJUenAh147I7eROUvMV332N8DMmZO8okgQOyNEo5ii4Rw42CEuXT8+BdsqWu59mquP0PTWvHC/c7s2+iMLbzg=
X-Received: by 2002:a2e:980a:: with SMTP id a10mr17161445ljj.40.1563267984174;
 Tue, 16 Jul 2019 02:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn> <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Jul 2019 11:06:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdGAsc=XpJXVRg+oaa1o1PXkJJ8JDAnkNkJuzJrfE_OJA@mail.gmail.com>
Message-ID: <CAJKOXPdGAsc=XpJXVRg+oaa1o1PXkJJ8JDAnkNkJuzJrfE_OJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: samsung: odroid: fix an use-after-free issue
 for codec
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019 at 05:48, Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The codec variable is still being used after the of_node_put() call,
> which may result in use-after-free.
>
> Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  sound/soc/samsung/odroid.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
