Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A325C049C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfI0Lun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 07:50:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39957 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfI0Lum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:50:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so1684156lfa.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtkPzUdh0BjwnTFcU6cDEv31BuC4wG3MpqjO9vOb5nc=;
        b=dHkG+HnC9dM6qd1tsawE2B77CGjpChpBeEsSBUvLKNrVXpX+osBDmU/jLYHZPm1B/P
         2dyDxSkFmTP8ieUdkcZKpDi2kNeo10lBoWrXT9wdZ615R12K9KGFf6J/OrMdVyWQEX/z
         wYgpsuDlMp9FCPoF7j0EiuKNEMBtaw/LYAUt7RIkCAlVR/MANI5zfMMqmxqGDQcnXtAL
         2OY3vl+bQvPLR8uEP6OVKQm7w0g52y6Li38Svuxw5AE7QBLcb9eP1aPHP9bXfcFj5qG3
         0/jxw0iG4icNXkyuWt9atKmkl1Z8zGcUZmaUcKj8BAHOSFFYokiX4pBiyg/QJksov5nt
         4GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtkPzUdh0BjwnTFcU6cDEv31BuC4wG3MpqjO9vOb5nc=;
        b=WIR/1b8BUwnc3F6N9PRm2b/4vu2laS+CWqSYJ7BO3vPAvKgXyrz5g1DILMQeMd9y7I
         9cz/fXWy8C8QS+VF1FNs5j9V0zYiIUE2z7lazOsBRkJH0xET4A12fpmnjyFoPnLRefvV
         FUK3bN0Lx9U77CMxpygHxDqjZUeaICOURIa4EeCvBYviUKjlFOEPb8bgvDBzYhJ6jHgs
         wRlsSTt1knm8POAVNC1XjZsP3NW0sLWxJwXPew0EK+zfUwjVRirI+wvo5TPfuj+oUUlX
         kuVH+3rJpwVfR7c/oDq4ZtY2xTOrPLJbkDnyNZrBy5wBdrw0XQ6VsOMu6wvWeuYMqje/
         rUGQ==
X-Gm-Message-State: APjAAAW/13LnzP+xcdUInB3CNsBGsephZuK4HtNP0qd9R3UAK8PjwZ+2
        Q7T3lEs7rglXAFNfAE1yWDjRyuHByZGPfhT1kQZvVw==
X-Google-Smtp-Source: APXvYqyF/AMU9HIQoJBR4mgMcIh/XR7QQxXA0oPACvNrMQJcYHLmYcQQw76chmDwmpMjtdY1kzoSIQzHJDEllWzZAzI=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr2493316lfa.141.1569585039656;
 Fri, 27 Sep 2019 04:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569439337-10482-1-git-send-email-hongweiz@ami.com> <1569439337-10482-3-git-send-email-hongweiz@ami.com>
In-Reply-To: <1569439337-10482-3-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Sep 2019 13:50:28 +0200
Message-ID: <CACRpkdY4RsqAOykyS-9GEFvF--3bmf=UjzADx8U18z=gTHBb4g@mail.gmail.com>
Subject: Re: [v2, 2/2] gpio: dts: aspeed: Add SGPIO driver
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 9:22 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add SGPIO driver support for Aspeed AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

I sent a separate patch to fix this up the way I want it with the file
named gpio-aspeed-sgpio.c and CONFIG_GPIO_ASPEED_SGPIO.

I don't want to mix up the namespaces of something Aspeed-generic
with the namespace of the GPIO subsystem. SGPIO is the name
of a specific Aspeed component.

Yours,
Linus Walleij
