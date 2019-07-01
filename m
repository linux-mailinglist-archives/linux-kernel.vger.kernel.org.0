Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED254CF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfFTNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 09:42:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44247 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfFTNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:42:20 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so515428iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rPnlYJTsEWRrrMURVOg3q6s++ndjHj5G41dcqyvtfk=;
        b=CzYZ0K7zoibk1pKo5KT/vMGqHZvVQQKUh5gkqSe9OgFWIZlq/5M9W+8Hhgn8PzdqJW
         vPnp/0ugWsIz86uk+RQvsbpp1SEKlZt0eqXKivb8WmOGtjCD1YLXGjknATlDMbtf4J3+
         G3D9UcKV2KV2Okv/0F6HEVJixRw+T3JhWxx3hKdg7BgcP0o4/GSYow2gAgb05A1EZUBs
         lB0AzA3QT05qAzL/+5ffhKsbpFEEOWpHxMYXt1g5OVCQvzEWzmh77vD1r1td1jt7H2Ae
         jMAsWzq1uTIYIkF6BWmppJdlWJyxEYpXQfkXJw8QoL6FE+gLVUX9sO/+E2YCxxcfuyKC
         eSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rPnlYJTsEWRrrMURVOg3q6s++ndjHj5G41dcqyvtfk=;
        b=i0OzbfodJtydmCF2h0N5/adhyp8GBLNw+bHHUuSWIV2iKj23/GnC32D4jImLlpelAN
         6D3T3dWehOzLw0wDtrNA4HBAz8Rh7oSTawEIDg/SSKEa2LQpBCc3h/eKotGolBJFJQx0
         2UUpaGoGuCN7Jpz6xZIT+tvgstm0ALDmNFHZKV+aWkrNHGwUk4T2mgpyG+JKs6Wa8Uh5
         TCxu6cb94FGmEAiGmKashdPy48KKFv6lZB8SedpxOIksGfEmyeFcgyJEo6XsTst4F67O
         /snFBqhmtqqZCJsMm8qDCXExzFnknNIG6cayMdrhX5XiMw5sY9f10Fckww3b29bruHSp
         6aJg==
X-Gm-Message-State: APjAAAXF2SnWqHPzKk1qeWgGwD48vthj8Kp4JD0IPoyV6bxx5hqLqoU3
        WYLDhhipnWyPXlwncfl7PcFIirpV3sUjo6kFI74Feg==
X-Google-Smtp-Source: APXvYqzLdEI/7zE586TbFVV9DAjh8m0jc4TIa2jBNO57XuYVFLcau4FnwIIZtkh5LxzOxQ398Gmru5hxBp4l7Yl9bx4=
X-Received: by 2002:a02:394c:: with SMTP id w12mr478044jae.126.1561038139505;
 Thu, 20 Jun 2019 06:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <CAOesGMg+jAae5A0LgvBH0=dF95Y208h0c5RZ6f0v6CVUhsMk4g@mail.gmail.com> <8265cdc4-ce24-4efd-a64a-78ce34104b9c@huawei.com>
In-Reply-To: <8265cdc4-ce24-4efd-a64a-78ce34104b9c@huawei.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 20 Jun 2019 14:42:07 +0100
Message-ID: <CAOesGMjKYzj+h=ummXvQLaVHDEYeNNWMqZFUJ4qqmqPr3LDVeA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fixes for HiSilicon LPC driver and logical PIO code
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 1:56 PM John Garry <john.garry@huawei.com> wrote:
>
> On 20/06/2019 13:42, Olof Johansson wrote:
> > Hi John,
> >
> > For patches that go to a soc maintainer for merge, we're asking that
> > people don't cc arm@kernel.org directly.
> >
> > We prefer to keep that alias mostly for pull requests from other
> > maintainers and patches we might have a reason to apply directly.
> > Otherwise we risk essentially getting all of linux-arm-kernel into
> > this mailbox as well.
> >
> >
> > Thanks!
> >
> > -Olof
> >
>
> Hi Olof,
>
> Can do in future.
>
> The specific reason here for me to cc arm@kernel.org was that I wanted
> to at least make the maintainers aware that we intend to send some
> patches outside the "arm soc" domain through their tree, * below.

That's fine -- but it's usually better to cc us individually in those
cases. We normally go find the patches on the lists if/as needed when
we see them come in as well.


-Olof
