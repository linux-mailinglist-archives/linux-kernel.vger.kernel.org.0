Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9647861FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfGHNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 09:55:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38093 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:55:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so16571932wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sp/tZgDFKZU93dnNpAW0b42FyVjdurtoOYWEUaBdt4=;
        b=MNqwKhb54VaXXVvgOIOJY1T5x7WYZBPhD3LvMNi4dxS18G0fkn22x/kmi92jSG5P0R
         mlLrlJZjU3VGoquvDlACk8vmjE2c3NYlXMaYzWRlQr0k3sAy1PI7irBbB2OGRwyAKO5x
         8GiOEucxVVhTVEZ42wAFrSJgQl1cm6CkIZW1SPxiuaa5GPpBswiU7/RgHhzT1//iU54I
         w1O1Ie6zZhst9ZqvSCysxAOvg4ELDX8gRm5SWzvvhkurPMCMOCzom+ybHb9BSeQr7U+0
         4eAaZKLU0RYwTW+jXOBOJ+GqATqgegWOseaSCWLwNFKo4IBLJY04hBCYRuW7sUp2+uQS
         KngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sp/tZgDFKZU93dnNpAW0b42FyVjdurtoOYWEUaBdt4=;
        b=VR6iJn86NvGojczJJxcyRWjTHugrSfXk/jQhf0vqmdBsyVqFp5zPL63XENw0aIGapc
         WuEF8c8uF80t7T79NYRgjCIgIVXLYLlUjQ9k/lq8oOZa/63+XU4NRjGtSN3DzVRFrvVj
         PbV6123HMB7IuQ1Jnji3FfA6KPtPqWHTHqWB7nkeUE+1io+lFEv56OsazjaYQgAT07iH
         F36mQTLgspeAtGAKM5eTajs5A69oonwFQw95sWFvEk5Zl3uXu8D3mEERYfqJ6YDG6lB9
         48kGhN1XkCttXUI6lW/MDAQRjo/Q3veTOpBsG4mdr2QP1CQe76IyKU8Rt62EUZM7oP7G
         XE3A==
X-Gm-Message-State: APjAAAUvhIZJiN6CkB+2OwZX7AdaaIw5G4mV8sdhhGjeyRIcSUajuv3e
        y9yqc3HB8NsBd9m2W+n09JNWP85BPccK8bO2Q+xzxw==
X-Google-Smtp-Source: APXvYqz3MLRLCiixcvJvT3c2PGSq0SN54PM/2CAHZS15T8aReVMNTcEdEHh6jTbUrUhw1ziE6ph6GPSVI0zEdXHDvhA=
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr17201666wmc.133.1562594147798;
 Mon, 08 Jul 2019 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190708125733.3944836-1-arnd@arndb.de> <20190708125733.3944836-2-arnd@arndb.de>
In-Reply-To: <20190708125733.3944836-2-arnd@arndb.de>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Mon, 8 Jul 2019 09:55:11 -0400
Message-ID: <CACSApvYkWwjzOhu+rvv1LOkcFYbU8Jgw=Q1f+HrCReEeKBLuuA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] bpf: avoid unused variable warning in tcp_bpf_rtt()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Priyaranjan Jha <priyarjha@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 8:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_BPF is disabled, we get a warning for an unused
> variable:
>
> In file included from drivers/target/target_core_device.c:26:
> include/net/tcp.h:2226:19: error: unused variable 'tp' [-Werror,-Wunused-variable]
>         struct tcp_sock *tp = tcp_sk(sk);
>
> The variable is only used in one place, so it can be
> replaced with its value there to avoid the warning.
>
> Fixes: 23729ff23186 ("bpf: add BPF_CGROUP_SOCK_OPS callback that is executed on every RTT")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  include/net/tcp.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e16d8a3fd3b4..cca3c59b98bf 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2223,9 +2223,7 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock *sk)
>
>  static inline void tcp_bpf_rtt(struct sock *sk)
>  {
> -       struct tcp_sock *tp = tcp_sk(sk);
> -
> -       if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTT_CB_FLAG))
> +       if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
>                 tcp_call_bpf(sk, BPF_SOCK_OPS_RTT_CB, 0, NULL);
>  }
>
> --
> 2.20.0
>
