Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4E2B9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfE0SDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 14:03:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46500 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0SDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:03:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id m15so535241ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wNFuC91c5YlSB1hcwsQ9GxjfgiwOWc7KaX4c/hxk/s=;
        b=qGzb3KcShEQWnth+drQ8SaRGF84WheM6+KcQcL4T/eN0NPIBQ5Nn1KYiKRwJu3N7MH
         tB0FwugQd2qWrAYcHB/m6NkJEvaj0e0OvgtZ0sj+ZE2+LuDgC73e7+g/7FeCC0FQkwXT
         cVeSracUaAWpII6gQdqJ9LHRSi5t7ME94XduStkE/Y1w+/w6T0z6tkE1nrWAwVeXWVq3
         Gh3cNn2KxW8CPhs/A5OmaRU8Ve2ES3EUgOaOoBmGgFnFrdVBmDkTx48NTbAmPBRiSYlw
         jwudjg6LGBc5aZlKuamkJqqqsxfbb2Lu3M+SazM6xU4tTHJy+esfiLhQuf+ymtgiYssb
         LiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wNFuC91c5YlSB1hcwsQ9GxjfgiwOWc7KaX4c/hxk/s=;
        b=lD4S6CD2vNPs+h/bTmVvrGpbcxltncUrkQZ03Do0FbEYFIGqK+1QO4y8Z5wJk3I8cK
         8eI6UckQzlfEXLshjsD8BRB6V0X66tpfm4NsSQhRAhZlqny922unvYjxJN2cf85+GWBC
         Dn+7K7umsM5w3VfbQSeD61+4qSgD2ynpq2lczloesqo0z/qYQH7SQJ+Aafd9+j/1rVrw
         1L7adZTdroHmiDg2zBCzJ0RHXWLKh1qCGju9CI7IH8fpvAJjq5FF3a+0Gvtp+myVsLZU
         egZ07r2+oSL99dFlCMbTtP2Mz3bYqrlliyjnJGK7XjLyvkKNlvi4pdZLAdOauZUX1s3F
         EXxQ==
X-Gm-Message-State: APjAAAVEwfIEQgYvgOg/EHoYw65q4JbG8llyC738UGKtM9ApjGRX5YuY
        cWXKSSj25kt4hiFbmqJtsDy9osdNdlGN/21+HtA=
X-Google-Smtp-Source: APXvYqzKN6/qez+afD6DmlVqDRy1CUBvwTyZWvhzopa5q+smvOT+3QEtqbHtV7E5lx7Um2VvQ5LSZ5SibgQ1nf/Xmoo=
X-Received: by 2002:a2e:3818:: with SMTP id f24mr35962218lja.13.1558980220290;
 Mon, 27 May 2019 11:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <1558378918-25279-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1558378918-25279-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 27 May 2019 23:33:28 +0530
Message-ID: <CAFqt6zaVp5nvuz65tiaBisnoRpXrjpQf7Y4bc_Eyt0-pcOYvrA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/svm: Convert to use hmm_range_fault()
To:     bskeggs@redhat.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:27 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use hmm_range_fault().

Any comment on this patch ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 93ed43c..8d56bd6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -649,7 +649,7 @@ struct nouveau_svmm {
>                 range.values = nouveau_svm_pfn_values;
>                 range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
>  again:
> -               ret = hmm_vma_fault(&range, true);
> +               ret = hmm_range_fault(&range, true);
>                 if (ret == 0) {
>                         mutex_lock(&svmm->mutex);
>                         if (!hmm_vma_range_done(&range)) {
> --
> 1.9.1
>
