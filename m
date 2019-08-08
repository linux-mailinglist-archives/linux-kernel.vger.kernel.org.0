Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D786869
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfHHSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 14:04:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39693 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:04:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so89668832ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPVIyIFOuu9BlX/gHCintNMQg5rj+FYXvfRDehCUpfE=;
        b=laS+Ejjf1crQrUkcZ0HVvIrVqb3ewYNEhG7xK0JMbvQ5Lpraq+3KLsn0b89svGBvSx
         +eG9Atry1SfFP9h9zjVcfJIppEKTfHXHbIpV5GBWl8UIrdYMbAHQ8xoRmPAVWoWPhbZB
         i+u3h8uihh9IS+mtGSydMxuWsnInfvVEQ43Yv1STc+SiP4v/3ESsDvWxenuFqvn2PD+a
         9WGzKwMtMjaIRkUz+C+q5t79uSWXBr7fBK4dY9rxa1+9RLV0ILuPlCLAviTuE2U1Wd/n
         jJbfeqgn9xZ8tmkaqxvekeINS/DPDc7UFbvV98ayyR60Fw+mNKcjybg+rn4wsSZ0bWhj
         0I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPVIyIFOuu9BlX/gHCintNMQg5rj+FYXvfRDehCUpfE=;
        b=Juz0k2BzBjrMeVktn72YAwBztsXGUw7T7RTANAM5YM0xIgRFJaEm3ODCs+MIPOfzFS
         Lat4qGJzibUhj6JISRgFDU9+u9st/d0j2uQ/ysWmEIIEdNUaw0WeAtcylgGpYtQBDJmt
         G3qe0846i9ytqxtSHiJY1WgweaFfuALSqrN1ENetftMVJwuBQd8J6EQVXBWifw5QbZnC
         N8jY+e4gSw+15ruGz6r1dP7y5bzMhjWKvqroymQZJ1TEkyJxnBdqr8v980pFCRYD36YF
         za1lbDRavc6EpdfJE7xujHlNSlZhyeKOwphYrQuXpImQ700tvHPuy20MX0nk+CSJ5Lg4
         uRCQ==
X-Gm-Message-State: APjAAAWTNyqfPOlHewzhs5Ob9eSGAw9juumYNhN03Tvoe1gdqGxP5y2g
        hSRX5bTJh2CDDgq2x7MW1k/wdnRroLuAHZSV2rA1Oo85
X-Google-Smtp-Source: APXvYqxaxXU3AkczbRRaB845/qtW0GhUCaK0Z5cKj1F35ZCOyDcpZJXJWiaDxq9gdmsawWxbmLCSYArleno0nhLLMuM=
X-Received: by 2002:a2e:968e:: with SMTP id q14mr8360041lji.195.1565287467593;
 Thu, 08 Aug 2019 11:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190806071445.13705-1-yamada.masahiro@socionext.com> <CAMuHMdWa=WYUjo-N-ZOmDaR-OMOypTtupTpHT0-B00AN39_YPQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWa=WYUjo-N-ZOmDaR-OMOypTtupTpHT0-B00AN39_YPQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 8 Aug 2019 20:04:16 +0200
Message-ID: <CANiq72=WVEiwEadFWA4DCjEeQ8xd8ZxS9MdwLsF=7UwMRdCD3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: charlcd: move charlcd.h to drivers/auxdisplay
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Willy Tarreau <willy@haproxy.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 9:18 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Aug 6, 2019 at 9:16 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > This header is included in drivers/auxdisplay/. Make it a local header.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Picked it up, thanks!

Cheers,
Miguel
