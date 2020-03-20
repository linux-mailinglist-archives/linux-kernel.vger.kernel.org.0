Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCD18D685
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 19:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCTSGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 14:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTSGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:06:08 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D983E20739;
        Fri, 20 Mar 2020 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584727568;
        bh=yp6Fom7/yku8A2ZiuJodg4eNORs8y5P9+1DLpLiuzU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0t+YdURE3JanVJ6MrOTl2uJULL3rYmZJFZXo6r3CxueI9GjL9PUT3EkqqU8ut8Ri0
         3Vdyvk5NYZFw64VfzX6XcP4lzURWmrPoD76h7yB++qk5TGdK2bjuOgU/gAr6guOYN4
         W0CdiYp7c8ZIWpA071YXlbI/nsTvx5CSM2Uaey+8=
Received: by mail-qv1-f54.google.com with SMTP id o18so3464812qvf.1;
        Fri, 20 Mar 2020 11:06:07 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0ud2VlrQrOmmULMXUWYAW8pisBx/e3MtCkm7KcFAXTDWCokWPC
        wHB7TKMdtIY027JQYQxmb00EzofNFG/fRwaTtg==
X-Google-Smtp-Source: ADFU+vvYx1xhQtLz6A1KIug0vLHM4f1NO+sqNMOQFA87tKUVNVLKmGv10+EhK/AOJ+8fVdPqLc+hLhLeF/am0yONDGM=
X-Received: by 2002:a05:6214:a6f:: with SMTP id ef15mr9213953qvb.79.1584727567033;
 Fri, 20 Mar 2020 11:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200229160507.31309-1-devik@eaxlabs.cz> <20200229160507.31309-2-devik@eaxlabs.cz>
 <20200310190054.GA2826@bogus>
In-Reply-To: <20200310190054.GA2826@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Mar 2020 12:05:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
Message-ID: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add st,swap to stm32-usart
To:     Martin Devera <devik@eaxlabs.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 1:00 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, 29 Feb 2020 17:05:07 +0100, Martin Devera wrote:
> > Add new st,swap property to allow for RX & TX pin swapping.
> >
> > Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> > ---
> >  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

I take this back as there's a 2nd binding (Qcom GENI) doing swapping.
So can you use 'rx-tx-swap' instead.

Rob
