Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266E210431
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfEAD0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 23:26:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36693 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfEAD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:26:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id y8so8238815ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 20:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0h2UcYR7m6/sZil5T2HHxyvcwRmfJqw2U6FSdGaFy0=;
        b=OJrabn9goIjqZyD69xvhOHnyvm0N5S5rWwjABo7MAJVtksrGN3U68niREQRxPC12Z1
         LXOGu7oyPwirXjar4qO2fIQRjyjflsG+xCrjJx6Ir+H1jtGL/zfwXuwZPQdQLNh9jCqs
         k/iSnFGJq2OH9CCeNTH2pcgl7I5Exo+VfMZiXfUJZwF9c8//xVpZY83TcaQtgfh22ROL
         EYpITz43tq9PldzV2mUdxQG7yELAIpQVKZZjRU8W5BMVnkp7PIKJRdTF+4oU0cTrNQr7
         Xf/uqPsHfII9Yvq2KZTWAAGeeQUvNe9SF5uyRKeCgGAzy7MIEh/IEwcOpDXLYvonAaFG
         6A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0h2UcYR7m6/sZil5T2HHxyvcwRmfJqw2U6FSdGaFy0=;
        b=ofLf872ZyRWko7aqY4IYWc7/1NlYYsiiyKdOq+WW3+BvRIIP36WQ9Ap6dmuNgp9Nzy
         7kZjuI3Ik+F1LxW48VrNYusDZj+/Ub8aleZJvXsBohzZbIZqgebcx9FCTDizxZGSM9U+
         jaDW8RBLVucLEVdgMi8uYbgsEMOIGugcSYfeir79vbEedMoKcMF/2a/3tzr66mZ2y8lY
         PfGCdDWQ84Y6s0dV6C5fElKuZTijgqYXwX4Pjqbld06w705PZtLNcPygeT44sCMkkbYe
         PYsOrfqYOFOAIpqzY/P10HpugPzAg1x1uncEkbvdhHyIgR1ZfNqxZlZ3swEXYZzn+G3M
         Fk+A==
X-Gm-Message-State: APjAAAUXsWmgA68qtJ5lcfedJsNH1W6q3GIoKnSjqv9bHHvSiIBCggD7
        kibqlXiq/IT+SI1ET5lvY2fPqXWmu7k8HBlEc548sw==
X-Google-Smtp-Source: APXvYqxPIZOH158rwrHgU+AjL9eIv7npz8JKZkqMUzHMJwbDm+jLiZrjLbfYsez0J5Bh0Gg+09Mew5lAG1LqPYcuTwc=
X-Received: by 2002:a2e:9241:: with SMTP id v1mr15376751ljg.6.1556681193158;
 Tue, 30 Apr 2019 20:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <bab2ed8b-70dc-4a00-6c68-06a2df6ccb62@lca.pw> <CALzJLG-TgHP8tgv_1eqYmWjpO4nRD3=7QRdyGXGp1x_qQdKErg@mail.gmail.com>
In-Reply-To: <CALzJLG-TgHP8tgv_1eqYmWjpO4nRD3=7QRdyGXGp1x_qQdKErg@mail.gmail.com>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Tue, 30 Apr 2019 20:26:22 -0700
Message-ID: <CALzJLG-5ZXeOrOa3rsVEF0nHrfkxJ=65nEH2H7Sfa9pYyDpmRg@mail.gmail.com>
Subject: Re: mlx5_core failed to load with 5.1.0-rc7-next-20190430+
To:     Qian Cai <cai@lca.pw>
Cc:     kliteyn@mellanox.com, ozsh@mellanox.com,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 8:00 PM Saeed Mahameed
<saeedm@dev.mellanox.co.il> wrote:
>
> On Tue, Apr 30, 2019 at 6:23 PM Qian Cai <cai@lca.pw> wrote:
> >
> > Reverted the commit b169e64a2444 ("net/mlx5: Geneve, Add flow table capabilities
> > for Geneve decap with TLV options") fixed the problem below during boot ends up
> > without networking.
> >
>
> Hi Qian, thanks for the report, i clearly see where the issue is,
> mlx5_ifc_cmd_hca_cap_bits offsets are all off ! due to cited patch,
> will fix ASAP.
>

Hi Qian, can you please try the following commit :

[mlx5-next] net/mlx5: Fix broken hca cap offset1093551diffmboxseries
https://patchwork.ozlabs.org/patch/1093551/

$ curl -s https://patchwork.ozlabs.org/patch/1093551//mbox/ | git am

Thanks,
Saeed.
