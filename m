Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85E016DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEGXHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 19:07:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43352 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:07:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so9036741pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ksCK6MwbJy5hkcrjGKRfLybVWED7pfrtN2x342eMfl8=;
        b=AGx8NaFcW0nNXm6FRSDK6XWn3BprVlDb7i1+/3oeRJ/rTpK2ryo/87zzPV5opLP7xf
         39wPiWYVVrh822ck/V2weclYk6f7buLBNfCsV7AaAs/jVezQ9fX6c5+Ib/Cs+xAWW9yu
         OwaApcdTNA+9aDNHpR+2WuMuAs0x4ZCBsFrnyKuD98zkTsrYOhwzMAfhS7onbHITyBti
         EP2BdBCb2EFWw3NHM3JT4nY0Lew6PhPWbwiXnW49AkZmhZApjQVIyVeE5frTrY2Kgxj1
         37Z3lmZG0Xjhzz/PtQ7BjhTj8SXaXK8I6AUi5D9lSE7zPFhoYSel/z4ojks6JAIv5F8n
         fyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ksCK6MwbJy5hkcrjGKRfLybVWED7pfrtN2x342eMfl8=;
        b=a1yIuA+1/B2g0fHjI/AJJ2Af/ZF/y9AI5GLT1Nw/GfaEwTTbfpnpGUliz4d9JOJ86M
         rfbF95aM3l5OsPLoh+doXOX5+2+MDqMY0jjHj1/PFhhsGlixpBylfsZ7exlHNB+Uan+j
         P6Yo/fqMK8Tmw7GOXrbQppAXnpyFPaSHszV27eRNo7PGunHi6Wyh8ztBL8V55sxOD3IQ
         ZcnRFgI4zY0OjxyE9R49xj+QqECnzJtTZiuQP++rdUUW9+/tI8x+vh9j2wbEtnMmL/iQ
         1Bd+VyLb79axpW8i1kBwt75tzpdn5xVIHXrPDO8hqrs/cvLZmP2U2UMj0RTdRwIKmCYa
         Kgtw==
X-Gm-Message-State: APjAAAVeAwqYkGlg0+0eV5uhSpgrKSfz45Gxa01HdU9a+fo898ziE92T
        htqjlfgNwsCsO5mKZvk56Z0=
X-Google-Smtp-Source: APXvYqwl7+tg2Ewiz/jP4v1lUDMe2zgpvST8mIlQ/beigoour/174+exi07SmbvBzd/rqbmEpqcJJg==
X-Received: by 2002:a63:ed16:: with SMTP id d22mr9290179pgi.35.1557270468115;
        Tue, 07 May 2019 16:07:48 -0700 (PDT)
Received: from localhost ([2601:640:2:82fb:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id l68sm19547511pfb.20.2019.05.07.16.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 16:07:47 -0700 (PDT)
Date:   Tue, 7 May 2019 16:07:46 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yury Norov <ynorov@marvell.com>
Subject: Re: [PATCH] powerpc: restore current_thread_info()
Message-ID: <20190507230746.GA19259@yury-thinkpad>
References: <20190507225121.18676-1-ynorov@marvell.com>
 <20190507225856.GP23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507225856.GP23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:58:56PM +0100, Al Viro wrote:
> On Tue, May 07, 2019 at 03:51:21PM -0700, Yury Norov wrote:
> > Commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
> > removes the function current_thread_info(). It's wrong because the
> > function is used in non-arch code and is part of API.
> 
> In include/linux/thread_info.h:
> 
> #ifdef CONFIG_THREAD_INFO_IN_TASK
> /*
>  * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
>  * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
>  * including <asm/current.h> can cause a circular dependency on some platforms.
>  */
> #include <asm/current.h>
> #define current_thread_info() ((struct thread_info *)current)
> #endif

Ah, sorry. Then it might be my rebase issue. I was confused because Christophe
didn't remove the comment to current_thread_info(), so I decided he
removed it erroneously.
