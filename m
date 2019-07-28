Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6177D23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 03:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfG1BhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 21:37:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33982 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfG1BhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 21:37:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so55096570ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 18:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIqB9c4q6lN44PyPxcoCMV7r219u87AEU3TH3a5CGas=;
        b=ReCshGPBRPhg8Co0BNPLZT9vREYsGam4cGdaeearjxONFJavZVKf+LhXePnkr6GjDd
         dv055zQEh7WaubQiWMfbDBSXBVEnE69NjHs8/Dhwhs0Z21WvqAyGsK3+zGsH7eFuvEmy
         0puWL/Z5h9AvHLyLF+tTBNS7E8BkvAJxrKO+z2q7SOqFOi5E1EDYpVFJ73irpIhurNAL
         nvmpBwAhpYhvBoMkvrAgi1/hTRq4UTTF6DVBB8Rly5XNHtjwK9qcek30L+aGHLNXhqlQ
         /AEnVh3tMutbuoIoehWu91rd+nTcMJBmRa05EvmcNrGREiGzQOT9I3ik+zvyD7F5ak9P
         2tyA==
X-Gm-Message-State: APjAAAWexsc15sKF4hG6xlol5RxCosVxPAdaPWK6OGwhJk/PLeVyve3g
        9wEE2qocSaDhh8vf2PoyovfNysGKCqCkRwCtj597qQ==
X-Google-Smtp-Source: APXvYqwGgdIRAVeuQlsulkeErK79fVKFr19G5qlxtgIIKSyN8WnYjQDqWSBRjwvcPslOs0FyyDwk/YkI/IxY5fV3j5U=
X-Received: by 2002:a2e:9117:: with SMTP id m23mr53783934ljg.134.1564277828052;
 Sat, 27 Jul 2019 18:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190725231546.23878-1-mcroce@redhat.com> <20190726125715.GB5031@kwain>
In-Reply-To: <20190726125715.GB5031@kwain>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sun, 28 Jul 2019 03:36:31 +0200
Message-ID: <CAGnkfhycOc8mvqeQDBcnXueUjrFQMC7hdfAOkxr5k0+xc_tnDw@mail.gmail.com>
Subject: Re: [PATCH net-next] mvpp2: document HW checksum behaviour
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:57 PM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> Hi Matteo,
>
> On Fri, Jul 26, 2019 at 01:15:46AM +0200, Matteo Croce wrote:
> > The hardware can only offload checksum calculation on first port due to
> > the Tx FIFO size limitation. Document this in a comment.
> >
> > Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Looks good. Please note there's a similar code path in the probe. You
> could also add a comment there (or move this check/comment in a common
> place).
>
> Thanks!
> Antoine
>

Hi Antoine,

I was making a v2, when I looked at the mvpp2_port_probe() which does:

--------------------------------%<------------------------------
features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;

if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
    dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
    dev->hw_features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
}

dev->vlan_features |= features;
-------------------------------->%------------------------------

Is it ok to remove NETIF_F_IP*_CSUM from dev->features and
dev->hw_features but keep it in dev->vlan_features?

Regards,
-- 
Matteo Croce
per aspera ad upstream
