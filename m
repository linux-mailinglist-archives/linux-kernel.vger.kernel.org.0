Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4637EF86E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 03:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKLC3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 21:29:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43049 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:29:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id l24so18059749qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qig4rmkNJ4m0gykaw+RmR5zfcN4BREbLY12fsfP7HVE=;
        b=FhOoZzKOgkSUDBp9Ce2AQ0Va8bxX6Hk2GvpQ/6JLie21f3bcdzv4YZkuRc67JPwITa
         dbQfHeW1cEZim+e6IpI4fjWcvtdbeWbd9Zo01OJg7KK0Imx6kSchAc045Z+8sFCyOr5Z
         cerG7ijZY16HiPyzXTTbW4ECpe5FmL9iQ925Q2LsOYb3ZqDewv3BUI8xpfPapdO5dnz4
         GcHxCaXTO51xXlg4icLrc1o0RqHDpzgO0u/bMfh3SeuyZekqfwKXgkiWrbMqFGGJrr6X
         J7GHyZiiXAuRh8FL7SQX296lsyIQSBbgg649R7xuOT9O4aMyS6LTif+J5oR4ngVFlCoF
         bCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qig4rmkNJ4m0gykaw+RmR5zfcN4BREbLY12fsfP7HVE=;
        b=BVCbW+Tu4SzrsoR+8WjWbM65PidP27Bu5EeFFCc6Azg0SDe+ss551fPS4xUwZTbepP
         1gZXNNpR2l1XUUufxs5wPg5nhp00YTobKeWbzOyHnm3Xu3cw2uJvHVvKoZXXMFj0qTnm
         1io3SA4xdzmMPWolRz/WIVV/7oD7OCPJ73VJlydNRtGlD1uC+OX2WtFhKw2pEHDABpJ4
         PbTPZaKUuE4risY6tBADE7fnrHII3eCxlXkRauREK7vP1THDP3JDtAYes8PYlYWP5f3N
         UxEPy3Q6EtZ4siFw9BCBmv/y7kuy2ZORrbzsiMC9YCC3i7AhsxTFFLnZoRf7yu4balDj
         ZB5w==
X-Gm-Message-State: APjAAAUrZ/9TvLcKhIFkd4uaBZclX206fRrhWSuTxBOrvbiZeDBIdVCF
        C4c8xrtCgMLdds9tWGFpZY1ULXtLMQCYINzyyM34xeuUi5gBaA==
X-Google-Smtp-Source: APXvYqx78JE37xWz0R+OnGDIkczM7fduIQqmhhuL2QSYfeg4Vj4kBNXxrykubN3nL8VYzIDHpxWm178W1TIPKzZS/JE=
X-Received: by 2002:ac8:3968:: with SMTP id t37mr29109381qtb.37.1573525743977;
 Mon, 11 Nov 2019 18:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20191110104955.131246-1-zhengyongjun3@huawei.com>
In-Reply-To: <20191110104955.131246-1-zhengyongjun3@huawei.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 12 Nov 2019 10:28:52 +0800
Message-ID: <CAB4CAwfCNgd6nr9yrPtPd33P075CURKw+e3ZOUN0iKecvJfR2Q@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Remove set but not used variable 'rsr'
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 6:51 PM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: In function rtl8xxxu_gen2_config_channel:
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1266:13: warning: variable rsr set but not used [-Wunused-but-set-variable]
>
> rsr is never used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>

Since the rtl8xxxu_gen2_config_channel is only invoked for 8723BU. I
verified the hal/rtl8723b_phycfg.c of RTL8723BU vendor driver. The RSR
register is also left intact. This commit looks good to me.

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index c6c41fb962ff..2c1ca4bc4e56 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -1255,7 +1255,7 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
>  void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw)
>  {
>         struct rtl8xxxu_priv *priv = hw->priv;
> -       u32 val32, rsr;
> +       u32 val32;
>         u8 val8, subchannel;
>         u16 rf_mode_bw;
>         bool ht = true;
> @@ -1264,7 +1264,6 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw)
>
>         rf_mode_bw = rtl8xxxu_read16(priv, REG_WMAC_TRXPTCL_CTL);
>         rf_mode_bw &= ~WMAC_TRXPTCL_CTL_BW_MASK;
> -       rsr = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
>         channel = hw->conf.chandef.chan->hw_value;
>
>  /* Hack */
> --
> 2.23.0
>
