Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2EAC398E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbfJAPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 11:52:53 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40163 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfJAPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:52:53 -0400
Received: by mail-yb1-f194.google.com with SMTP id g9so5639760ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4V5jIWn5TMskOGj1VKmy8D65TjwneLbv47G5q3wYlA=;
        b=gDD8pfoNze5RsniU9r11QB8zd/KUJlt0Q+RcWfdBo50CKMkpUeIlky7lpimlrREF4j
         h8jKpoTXPR5irMaFgCYtW5rWlfQwAOoS9bkbOFaTs4Lx0Rkwpj2Oep5l2PSXB/C/5NRH
         i3cHdHfPVZMSfsqbnUyb/FOymgIjlgWjcp7GWMEs/ifqfdu9ESH1L8mLktPyum3291H5
         zYv0sk+cLhwKhvLP7ufvg9R+y4PSwdkt7kve0IE3xzk+UUMyHhiI6oe6C1HBV/sQiifl
         HnSM4bFQfz3SkOGT7GX1YhBE+rx2F34YtzTGl8kHKIgkceOW2Px12vaKKuh5cTkJR3N8
         Xujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4V5jIWn5TMskOGj1VKmy8D65TjwneLbv47G5q3wYlA=;
        b=kwGnce8MXEqu07ADoBXpGQi6yLNhFQdB/N+hq6LgZddZH8elwsFSZckm4QToux+Dar
         hiPOQeUHkE7kkZAeBXkoHUbFWX0nC4MQ6L+zQWKVijNQnfLRygjVlZVribpO4tn0/lkz
         Ln/ZqBJWuWwHHoXuv1XiZpN7O/uJKqu6t5lM6p1dRluzNuZO5gjbMJwmUxkP6Yih5Z2Q
         erg7VGYMjnz3oBzjhc1wBzorYx+H20Q/62gzlyEA/HuGFoVIgW+m1ZOgm44HKvKYoExP
         lLO7n8EhbZJp6rAnjsVlU21ZMDVBz4w3bjt4cg5SwR3v/upD8bBLj7XZsMjuxebYZeEo
         SXWw==
X-Gm-Message-State: APjAAAVrgJvWt233BoOkpvKotSb3REQ+2X5mUeQU13s+y2n7P7nawsYS
        HmoIGN8eOBwrd+I/fWU4CWlGsXbS
X-Google-Smtp-Source: APXvYqw3tPpR2OS0U5lbBd7pGe+h5SLgVR04GUrogu47vYmcl/jUsqKiC7RoFHO7ddNsZf81DYKjVA==
X-Received: by 2002:a25:4e44:: with SMTP id c65mr18240072ybb.421.1569945169976;
        Tue, 01 Oct 2019 08:52:49 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id l2sm3564881ywd.16.2019.10.01.08.52.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:52:48 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id 129so4984830ywb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 08:52:48 -0700 (PDT)
X-Received: by 2002:a81:9bd7:: with SMTP id s206mr18834302ywg.193.1569945168004;
 Tue, 01 Oct 2019 08:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <1569646705-10585-1-git-send-email-srirakr2@cisco.com>
 <CA+FuTSfN5=xkYUKiafM3uKF37kV6mg0Cn5WGv2QF887Pyw5A5g@mail.gmail.com> <20191001084427.73f130c0@hermes.lan>
In-Reply-To: <20191001084427.73f130c0@hermes.lan>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 1 Oct 2019 11:52:11 -0400
X-Gmail-Original-Message-ID: <CA+FuTScbrrjBucQ0YvncyAFaO5DAoDywgjn8LFt2p0NVusOErg@mail.gmail.com>
Message-ID: <CA+FuTScbrrjBucQ0YvncyAFaO5DAoDywgjn8LFt2p0NVusOErg@mail.gmail.com>
Subject: Re: [PATCH] AF_PACKET doesnt strip VLAN information
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Sriram Krishnan <srirakr2@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 11:44 AM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 30 Sep 2019 11:16:14 -0400
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>
> > On Mon, Sep 30, 2019 at 1:24 AM Sriram Krishnan <srirakr2@cisco.com> wrote:
> > >
> > > When an application sends with AF_PACKET and places a vlan header on
> > > the raw packet; then the AF_PACKET needs to move the tag into the skb
> > > so that it gets processed normally through the rest of the transmit
> > > path.
> > >
> > > This is particularly a problem on Hyper-V where the host only allows
> > > vlan in the offload info.
> >
> > This sounds like behavior that needs to be addressed in the driver, instead?
>
> This was what we did first, but the problem was more general.
> For example, many filtering functions assume that vlan tag is in
> skb meta data, not the packet data itself.

Out of curiosity, can you share an example?

> Therefore AF_PACKET would
> get around any filter rules.

Packet sockets are not the only way to inject packets into the kernel.
This probably also affects tap.
