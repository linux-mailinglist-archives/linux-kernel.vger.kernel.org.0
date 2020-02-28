Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8571735B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 11:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgB1K4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 05:56:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38018 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1K4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:56:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id e25so2854519edq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kz7kWSwEg7SrZDq5RTh+Y2PzjYeluKBAFvL16xMm9t0=;
        b=AByl6elZqVlPjy72DINpI0r2yItB4pHixbBUiXhYz31NU3PrrTT5MXG8vHTPuXExfJ
         rJ+819KSeYHTGsI1QRMoJ8rH+H1yPUGiRjLRsGo3nL+bxBsYBYDvB9XNevv18O7Ccm2d
         7ni2QZ0sYcrkKSFWBL874TNmwdHLdQufWdKuXLJOHsZ5nPQPa01aM+jFL96/cNfh9I6T
         bzyygGnQG8aIc5bGYBV9Sktyb37qWS1Jgh5qkBwkiEDRT69Ka9Il5NXPYggA7q89POhE
         j5nzlCBZqAsd+ETnleE4ynUoictVIHefYIt1z/Ew/WoO3kmJWYdieYPNJmhAJAilMwjh
         DsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kz7kWSwEg7SrZDq5RTh+Y2PzjYeluKBAFvL16xMm9t0=;
        b=L4JuU9V4huRAuZM5m4GtUr5i/Gc6IvYc32NtNNZB5IoeFf0aAqsuAISHpvZKMO3iH4
         oAXa7sZtr62SEH0CrZxCI/ohuJzaM/wA2ccYoBnFaFnWIX+/xZovyn64GPYY0MO5JqwR
         kvxgSbxPxISzEPgzRPgHkMyNjse6mxOQ3crAnJcS21HV9OzhT0WW9IQzt8S2B6A9p3iW
         aNE4PiFxU2YTg3R16gvxvucx8KGvW1P6RMA/YCJoXYuDoX5yc2LtMUX/SnMpj18e2KVk
         JdcaAbeACp8icAH9SOKsACYYAdxtikiNrpWwKoHCDjEIfrIO/+iUpsJ142J3mKO7NfZG
         1qjQ==
X-Gm-Message-State: APjAAAW9Ejv7/XqmgHipthuQyCXs7/BuJAFEQTXkhUaYsJ4YYhp12g/Y
        PYNxnWqIz2OzaMkkEGbPyAnKRTw9Nlw2AsFqBepiYA==
X-Google-Smtp-Source: APXvYqx/UDeZmGH34cW4wEe3ZVhgpiV9DzGWhUDRIvCeKp9OEpRUkHHLMdqTzeRODyDT4GB+BuQ0Kd2RNzh/WsWNsB4=
X-Received: by 2002:a50:d65b:: with SMTP id c27mr3468481edj.206.1582887373150;
 Fri, 28 Feb 2020 02:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20200227173428.5298-1-lrizzo@google.com> <87h7zbuid7.fsf@toke.dk>
In-Reply-To: <87h7zbuid7.fsf@toke.dk>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Fri, 28 Feb 2020 02:56:01 -0800
Message-ID: <CAMOZA0JxgQ5Dvg7vvUk7TY8mx6Pd0raPXNBfbWup1JE1tr09fw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] netdev attribute to control xdpgeneric skb linearization
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>, sameehj@amazon.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 2:16 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Luigi Rizzo <lrizzo@google.com> writes:
>
> > Add a netdevice flag to control skb linearization in generic xdp mode.
> >
> > The attribute can be modified through
> >       /sys/class/net/<DEVICE>/xdp_linearize
> > The default is 1 (on)
>
> Calling it just 'xdp_linearize' implies (to me) that it also affects
> driver-mode XDP. So maybe generic_xdp_linearize ?

done in v4, xdpgeneric_linearize for consistency

...

> > +Description:
> > +             boolean controlling whether skb should be linearized in
> > +             generic xdp. Defaults to true.
>
> Could you also add a few words explaining what the tradeoff here is?
> Something like: "turning this off can increase the performance of
> generic XDP at the cost of making the content of making the XDP program
> unable to access packet fragments after the first one"

done too in v4

thanks
luigi
