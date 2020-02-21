Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1D168920
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBUVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:18:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33584 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgBUVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:18:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so4095406edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBP7f40J0J3eKoNEz0Cylkg5NVkiiGfoOV/snLtt/Cg=;
        b=V3JYFzrWyZ1va3zBN9uGeCbiQztnLKwOF1eem4dxHD4E4fot+n7WJsHWtcaCF5mZn5
         GIZt3wgK4VtWVg0UKmVAzUTJhzHuWKUSWJB4EpHdvsVmnchFkDM6H36v5c/5RSzz/Sd5
         PxEf2QU9vkDMJrJFEyhbXoLZ+OWsgEtL+Z/lwsjghBdw5KaUbFBlxut5id6DcNJOhZ0C
         yoMm3b7BMVvCkLYMLLPIbqzYLUuBtEnTa2AUk4SlDvPL2E6nrtC6/LLZeSZt2jXVDyUx
         o+FN+rbBgwei1Ihrpm/D/c+448FiMwuyTZBqETW69gfS3wavIWzMvO6H9sTjfJYhAwl6
         SVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBP7f40J0J3eKoNEz0Cylkg5NVkiiGfoOV/snLtt/Cg=;
        b=craXSwrAaic46aUmm6C/NJxH+MK9Q7DH9GyjzsfkYA5qJGfxhrCUaoJN3BY03V0d1B
         ghozyU5ktDpkfBsgZ/wTcExdqu03bvEHpvkULJa+80BBbXzOhsDjCVaoDxA4k0J/4COy
         T+n673YYJiJ2PNkfCed4yfXokhEqZMnldUkW5zj+RBXWjAyeh2EQ/BSqcgAuiGSueLrJ
         yYzo9m6yuKuPSIlrL8iXiGqQy/yOjsbrdFq81NW9rVDLyXEbSvABx1HiaCwX8fPKXvTB
         ruch0bzgBok04DuZlh+E4tM6v72xbkWayd5+MO2KO92D+lVAgUKmq/iNPHwfObExZ7VE
         iEUg==
X-Gm-Message-State: APjAAAVRGOpvV4PzNNuxuBcEIyZMoAh6tHXV+vLqSPFxbSQcXS+Ajufi
        nnVNhlGsfB2s7hUUkzEzZ4vIAptJzlI6rtc5KY5p809GYw==
X-Google-Smtp-Source: APXvYqwCnuHPxngKHrdwK9m0w5wDcMtUvOAkK2zHaDns4aBOr8SsmmUQVeLaPWo5verGntkAvMm/xRvqhpkxegxUeog=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr34496938edr.164.1582319891719;
 Fri, 21 Feb 2020 13:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20200221112838.11324-1-mcroce@redhat.com>
In-Reply-To: <20200221112838.11324-1-mcroce@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Feb 2020 16:18:00 -0500
Message-ID: <CAHC9VhQdN571U3-xGpMc44uwkwTayQ5n-yqvouF7q=VurtcS9g@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ensure rcu_read_lock() in cipso_v4_error()
To:     Matteo Croce <mcroce@redhat.com>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 6:28 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Similarly to commit c543cb4a5f07 ("ipv4: ensure rcu_read_lock() in
> ipv4_link_failure()"), __ip_options_compile() must be called under rcu
> protection.
>
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  net/ipv4/cipso_ipv4.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

This seems consistent with the ipv4_link_failure() fix, even though
ipv4_link_failure() has changed a bit since the fix.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 376882215919..0bd10a1f477f 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1724,6 +1724,7 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>  {
>         unsigned char optbuf[sizeof(struct ip_options) + 40];
>         struct ip_options *opt = (struct ip_options *)optbuf;
> +       int res;
>
>         if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>                 return;
> @@ -1735,7 +1736,11 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>
>         memset(opt, 0, sizeof(struct ip_options));
>         opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
> -       if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
> +       rcu_read_lock();
> +       res = __ip_options_compile(dev_net(skb->dev), opt, skb, NULL);
> +       rcu_read_unlock();
> +
> +       if (res)
>                 return;
>
>         if (gateway)
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
