Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5119105E91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 03:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVCUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 21:20:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33007 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKVCUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:20:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id a24so4640854edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZKiFJfK+QnaDabq2KuDAv3MPPigTMKz2YqtvbwcsBE=;
        b=e6NPk8y0Od9eSqId12ooausAsOJe6fSLW4i2fperQF/VoSj/UBOW77u8q1bk2zdVaO
         DJjhD73XFlXItuuIQnFx/PrjmxuCLTxyGlx8MIR4Yb19Q81k4CFHK46heedRrUDGJUta
         MUYGHnmbbQ+fZA5UryP11na5aTitYSj4B+UkVvqO+v16FUUsgnjCoHCDalIVdoqSsTNT
         NXkpV2aCP/qSIc6bL9zaw3NvKvn9glnZMwfSgD9HHMfNwJncDpWSvTdReALlyRyFlToJ
         Lknl9s2+nb52Rv9LqHJD2ssgN2xV9ZZIvMw0O0r/KpKAVGBIug/y/rxT318m+tgtKKrt
         XB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZKiFJfK+QnaDabq2KuDAv3MPPigTMKz2YqtvbwcsBE=;
        b=dy8G3CFreKnu1G0WuPILjD1eP6SMIpK37GVsSFJwU5GGjR2+dAzhO58aBNdruRLXsU
         +yJSRiVVqK4+StMpXmezqU90h5EYYbSgjrrLgj+CPFrzb0cI4mubf5HmAjmHbCvWFGcw
         KqjajdyhY54x5sJdANDDhgwqZ4UcTHPJRkLGhD8MV93RRoXa6t0UqpJ7g97vfV7CEU9X
         okIGxR9QyBriLu0d4uhHU4DRxpCLVlbi8/HU53siyG60WpDyWLsX1HC62XPYcj4ZW6Rr
         yEpRQhTe64ulCnV9OTt1A/OoCvJXJpC8CG9vAq0miXYXR6jEJFkR6wdYKDut2E0zxYQ4
         ZIVQ==
X-Gm-Message-State: APjAAAUs4dnVVX7s2NwGizVzYsKraX+cZ6qy+GI2RTZWWjtYI0bBj84p
        6qrhxxAgPbYuxzDTHtVs7RbyE6S0Uk3CCaHZNm2lmw==
X-Google-Smtp-Source: APXvYqw9amlPQfGbqL89y89/NKWzDB1NXkpkS7Lf2eLq8xcEu/NYPT00O/pqP8qpKSe6hmyYrC521a/FC0f4bs3UFx8=
X-Received: by 2002:a17:906:5246:: with SMTP id y6mr18836740ejm.330.1574389247998;
 Thu, 21 Nov 2019 18:20:47 -0800 (PST)
MIME-Version: 1.0
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-4-pasha.tatashin@soleen.com> <CAMo8BfJYEh_HYGuKwKgfwVdVwg-w-AxN=+6zDuYdwB+E_dTSzA@mail.gmail.com>
In-Reply-To: <CAMo8BfJYEh_HYGuKwKgfwVdVwg-w-AxN=+6zDuYdwB+E_dTSzA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 21 Nov 2019 21:20:37 -0500
Message-ID: <CA+CK2bCvbZCseGgZV9wjmko3z6h2yNyLy=k3onhL=-7CERSbMw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: remove the rest of asm-uaccess.h
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not related to arm64 or to the changes in the description,
> but the change itself is OK. Whether you keep it in this patch,
> or choose to split it out feel free to add
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com> # for xtensa bits

Sorry, this was accidental change. I will remove it from the next
version of this series.

Pasha
