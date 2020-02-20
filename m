Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F13166ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 00:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgBTXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 18:18:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45952 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:18:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so26183pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qiIWn/AwNao12jLnO57Zy1eSMfhg2OcOJSkC6NTyoL4=;
        b=Z/ZpxrbeGyYr1O90OCAFhyo23J1bsbTFVT00brNeeTuwwwK96lwnqkLFD1L9OKp7Jr
         psjnCPGENnn4mnePs4ZwzgNh8eDSn+diPoIPMGegJueuimr7kxsidVFZopT24RcG5xDK
         SC/zMlsdynQs1IWQOwGc2ldMpWPCirlqrqHmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qiIWn/AwNao12jLnO57Zy1eSMfhg2OcOJSkC6NTyoL4=;
        b=SYOZUZJkVIGyoTw1bG6P2YF//lJ35Tg1XZ2AI58aidjEjhKBiGtnRpyDi0ROUS4J5K
         5XhxCmM3W8OD3qzr8bToZyAARBQkKHU3rYE7H8Kp+H58ln3LHvSJYK7RrfzUAd4o13TL
         shn+mOcdIS7TGlbLcNIze7Dx542Png23B5yJO4QRVouSGPHTT5LABP10tfPa5TtDtK7i
         bFZdbtiu5zi74tVjuRh6wnenD/jiwvaYngVqXdjqk3mBzEi3btNkWiicuqqZPdTtyScB
         TLNylT4bPxQhtXDVat4icmTfwP22eFp8jfDfb+GEt7KPSCXlSCJ/Cqgo5NwRgOD/cqgW
         +IOg==
X-Gm-Message-State: APjAAAUmCe0lUORJ1C4igT0Xz/lHv0/2DfFEvGXMyfuIu5ZBB4Udvs5E
        5uF9shWjyynLJ3rWweOt5PCBXRw3kT8=
X-Google-Smtp-Source: APXvYqzhEIa1OtXP4MAIV3zoNmbsVPWGunyaLyvhOtt9UX6ZeNPh9zWaBFlyVTh2FozX8mEGqu5nLQ==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr6562607pjv.15.1582240705082;
        Thu, 20 Feb 2020 15:18:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l69sm375799pgd.1.2020.02.20.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:18:24 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:18:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] selftest/lkdtm: Don't pollute 'git status'
Message-ID: <202002201518.AFD4C0C9FA@keescook>
References: <668b6ff463849ceee01f726fbf3e7110687575ec.1580976576.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668b6ff463849ceee01f726fbf3e7110687575ec.1580976576.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:11:39AM +0000, Christophe Leroy wrote:
> Commit 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
> added generation of lkdtm test scripts.
> 
> Ignore those generated scripts when performing 'git status'
> 
> Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Ah! Yes, a very good idea. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index b849a72d69d5..bb05dce58f8e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -100,6 +100,10 @@ modules.order
>  /include/ksym/
>  /arch/*/include/generated/
>  
> +# Generated lkdtm tests
> +/tools/testing/selftests/lkdtm/*.sh
> +!/tools/testing/selftests/lkdtm/run.sh
> +
>  # stgit generated dirs
>  patches-*
>  
> -- 
> 2.25.0
> 

-- 
Kees Cook
