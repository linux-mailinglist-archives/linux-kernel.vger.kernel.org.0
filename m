Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3199D30F73
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEaOAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 10:00:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40656 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:00:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id u16so779485wmc.5;
        Fri, 31 May 2019 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NOwlld2o61g53ikPgtNne2HrK56iyMC4CudXWPFjlEI=;
        b=qveRJQgkceN4UUmgq0oCfgIJbTH/rwzmiKyj6+6zZ+Z/+INOpKfHZtlqrMuwzYWNEr
         yuDOcjIp+yL3QACa5tvGJBfnFbIv2026MCLU0lvV/NUSg2V9wIpAO+5uFv3CI50k6Zsy
         wTjh1Ad6538/Uvph9MtBwzFXJRNCAx+zgnqHlQsLdhnH7Nsqgd7r6vm6H83g9mDE3FDU
         H43egHgKX7QO75MZT5w+PDvZssLHmpR+WGzTqcQlE0+zZCa0iBSYMwB6JqJvR7bxYTVE
         sGj3/Z3Nbe1IASdWqBWRMoLI186S0LiHV+xtpldRQYOigYphkmoat/FdD+/CV/TG4Hl7
         8VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=NOwlld2o61g53ikPgtNne2HrK56iyMC4CudXWPFjlEI=;
        b=O2yAzuCuIJ6xx90QrHFsKZr6M2CzVv2jVSo7Hx4PX22ufWjiZ/niEyuDG1bf0hfhWT
         EJwMt/WWmxMORZE6zDX4XnyvqgM+iOhn7bkRt8o+KTYhQ+eqtTBi4vKhwKo9JwiGI09a
         2+pcpvB1U/lLQJCbiQ0dIZbbQKG1H3xDKJyrpsM8nnX36ea0OMTdpwxwWOlDaAXjHFNe
         mwVInUOUhlVsYg8DbPg/o+v+9YvBqksy1xzXF6YQJQSYZgQ9sCkBKOYbqAmq/kW+QNTT
         EktTwOPNdkElXq+tCVOAMULDvWv3KaATM5F7UluGHDPu0HpPmulwYFnZhDEmMBn2ERMT
         hk1w==
X-Gm-Message-State: APjAAAVcFMADlVXXft8JT2j/i5dSWzTB96wXsxj3cAWCGSQeuOEFjZ4x
        pKUvrA6PCZdtiqVrQ+TqbKs=
X-Google-Smtp-Source: APXvYqzfNlf2DdFt2bxxDUMP+V68qs+JPCXOL1YaLFWxOZHmPbWlk1oJQADBFWBwjnMzpnbK4bKxyg==
X-Received: by 2002:a05:600c:506:: with SMTP id i6mr5968967wmc.57.1559311216221;
        Fri, 31 May 2019 07:00:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id p3sm3387244wrd.47.2019.05.31.07.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:00:15 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 11/22] gpu: amdgpu: fix broken amdgpu_dma_buf.c references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <f7378a751557277eab6f37f3f5692cf5f1aff8c6.1559171394.git.mchehab+samsung@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <bf8163be-eb1f-f060-1c5a-405bc6d4c8c5@gmail.com>
Date:   Fri, 31 May 2019 16:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f7378a751557277eab6f37f3f5692cf5f1aff8c6.1559171394.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.05.19 um 01:23 schrieb Mauro Carvalho Chehab:
> This file was renamed, but docs weren't updated accordingly.
>
> 	WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function PRIME Buffer Sharing ./drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c' failed with return code 1
> 	WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c' failed with return code 2
>
> Fixes: 988076cd8c5c ("drm/amdgpu: rename amdgpu_prime.[ch] into amdgpu_dma_buf.[ch]")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   Documentation/gpu/amdgpu.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index a740e491dfcc..a15199b1b02e 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -37,10 +37,10 @@ Buffer Objects
>   PRIME Buffer Sharing
>   --------------------
>   
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>      :doc: PRIME Buffer Sharing
>   
> -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>      :internal:
>   
>   MMU Notifier

