Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207DE13D8CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 12:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgAPLRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 06:17:10 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45425 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:17:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id 59so7483672uap.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7tUdno7ArtPSiaOPdMNn5wVN9V2qtibzn63/OmNwzM=;
        b=lwcdtRWLk0imKl7E0r3n6TJW8xeDU1FBZjrxdwbB1j1Ol8VLI6md87iF6Ei32CqstB
         iZsxa6IJPvBFh4/KZIDh7uRZ4kCTldU8Hs1BMoPEFCwDTo7QdO9PKkKKeMCczAi+zG/4
         JZfYXGg313YN4TZwuOTHONOstMiYv8zbow0CFVohUQbrYitLoSQqIkeDcuxGp6qNSXRF
         MSkysZR6XwblHa8eMmPSQT/qJd8xv8W9O4E2ppMNt4Lo0lJZCGfmkzvlu2IAtDMnEnbB
         1QjcmJa6xjbZVSVMx8kwvXsDZZBH7G6592G8of/U/0t0mCjvPQm1g4udNBlpI6gURr5r
         am4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7tUdno7ArtPSiaOPdMNn5wVN9V2qtibzn63/OmNwzM=;
        b=CGrUz3plPhz+V7b2pcGZapPMpHdRpXosgmfIqf2XaUFiblipJGmtKY4F1iXI/ooofL
         nGdO5uNKvU0rQNq9qBMSQIWNgdIbpE9jc3AU3P8b5+PYjApRbQJh9WgiSUlKCsMK7WWZ
         nIs4nMQUx9yz5I4J4JhWJlmYfIPWnSi7l5NqYtEv6Jfe43nOT4yioK9BJJGrPvVcpran
         g8R4ATxTabQacam43/AC/XMu9ZaXdjriChwSiSLAwe7bue2NsGm6339f8y/chG+J7KHD
         pfr2MYfVK4jNAv53LCuY5iwrNiyd21qQgYuNX3EQ5aPrzk96anQr+dW4PqC2GGFqsIUl
         cKLw==
X-Gm-Message-State: APjAAAUBbiZL0vnMkX/g9wMCNnSc8JdOMQ1dNvzJUaPrz6S7KvAKHvXD
        bgQqYiUovLwYGfuEWBnGe5LgdRHbYtDfYFwZ4imhOg==
X-Google-Smtp-Source: APXvYqyiD7on53LJXj+IvnXLqg0ezI6WrramGC7O26YFNv+/TCtHx+KoDKnYfKLOvap+43EPQJV5R5WFI/gCOGKBRMA=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr17143795uas.19.1579173428886;
 Thu, 16 Jan 2020 03:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20191219145843.3823-1-jbx6244@gmail.com> <20191228093059.2817-1-jbx6244@gmail.com>
 <20200104215524.GA28188@bogus>
In-Reply-To: <20200104215524.GA28188@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 12:16:32 +0100
Message-ID: <CAPDyKFp5BvA7tKpBUh-bpn5X4xvg8b9HuMO7+fZVJEp78=ToRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: remove identical phrase in
 disable-wp text
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2020 at 22:55, Rob Herring <robh@kernel.org> wrote:
>
> On Sat, 28 Dec 2019 10:30:58 +0100, Johan Jonker wrote:
> > There are two identical phrases in the disable-wp text,
> > so remove one of them.
> >
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
>
> Applied, thanks.
>
> Rob

Rob,

Normally I pick up the DT doc changes for mmc whenever you have acked
them (at least more non-trivial changes). I regards to the
mmc-controller.yaml file, I have no queued changes in my tree for this
cycle so this should be fine in regards to conflicts.

Going forward, do you prefer to pick the DT doc changes for mmc, or
can I consider this as a single occasion thingy?

Kind regards
Uffe
