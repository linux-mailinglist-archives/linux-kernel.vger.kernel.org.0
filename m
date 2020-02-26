Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBB170689
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBZRt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:49:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46299 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgBZRt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:49:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id v6so1703819lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRPyRG8072H5Sezzifc28IJW7If3nwtOvcWNfr1pDDA=;
        b=gEFNGuVmVn91+YXMWkxUV4UPweNXXNVgT2p0ldNq/8U48hI3364GWZz73CaeFrYqc8
         m9Me3shfjZOZ39oT0shjaLQkxPYGCUxRVGlIt76FN1l8alqzJdr0d6sYPaMUCOnky0jt
         Fla7VGcoyd50aCqSPSUaAn/xh0wlIAFjVGW4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRPyRG8072H5Sezzifc28IJW7If3nwtOvcWNfr1pDDA=;
        b=fZ8hZJRfjLFbnP3iNtpCVEIcffums2WtBBeVGCGlVYmXgLcNYfOXcu7P39/z6XE4TE
         BXmsM3htMrheVudYc2HcOOEx2UlZBDdAHbvIIA+Gw7O3GP/yZRe4oCAKFNdhanCYZX8l
         FolSg6L2nVY36ur6Xw/NcM+JQlXAfQjX2j/SWF8OfPXNsxWxmu7KWkicHd+OZh6y+kHw
         A8ye7K9ErCAzC/Vtbdk900MqBMcXIhv+alR2U7omQB3PhFGHzk8qr+HwyoJ2zuqlm6i1
         WgKYRZW9iv+FWdpeZ/2wOT3gPZm8cbLkeKO7hyWB71C63LoqHOEzAsNJvax3Y1cxA45l
         Vc0w==
X-Gm-Message-State: APjAAAX/RovlTc1MejH7cQM4lWN/AHTgSBoqpTjqLxpo0NA0968d5QnE
        jxoNf6VIQu5tb4QyiVub0OO0M/ePkVg=
X-Google-Smtp-Source: APXvYqyFIacF+8vbkCNpzllh9WpvpTrFVAjDNLQtD9icTlCbhc6LJq+nuSXY705nNpcHO9eMYxhkhg==
X-Received: by 2002:ac2:4a78:: with SMTP id q24mr3136658lfp.64.1582739363434;
        Wed, 26 Feb 2020 09:49:23 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y12sm1371027lfe.85.2020.02.26.09.49.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:49:21 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id f24so2664905lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:49:21 -0800 (PST)
X-Received: by 2002:ac2:58ec:: with SMTP id v12mr3099702lfo.31.1582739361104;
 Wed, 26 Feb 2020 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
In-Reply-To: <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Feb 2020 09:49:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
Message-ID: <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
To:     Denis Efremov <efremov@linux.com>
Cc:     Willy Tarreau <w@1wt.eu>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 6:57 AM Denis Efremov <efremov@linux.com> wrote:
>
> If Linus has no objections (regarding his review) I would prefer to
> accept 1-10 patches rather to resend them again. They seems complete
> to me as the first step.

I have no objections, and the patches 11-16 seem to have addressed all
my "I wish.." concerns too (except for the "we should rewrite or
sunset the driver entirely"). Looks fine to me.

                Linus
