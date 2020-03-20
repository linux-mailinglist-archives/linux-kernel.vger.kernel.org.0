Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6B18CD48
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 12:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCTLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 07:55:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35314 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgCTLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:55:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id y6so2072596ual.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tfQ5hZwVEp45ODRSTsEju3Ran9iEAqdztcJA8RDirg=;
        b=zdrqLVb1ykyKOnWFQ9H01WVTCLgWslxGH7xr0WW4+BJcqebYSm2eB7eCQd7CUfHJfM
         6mZ8DbWag0zcImZUBitu1T3TstwLS7vI/fFBIxeR9jI0ETLXG4U0smVw93f9TK0HUD3V
         iFxJIoyRVVUnaG3Zj1lbSnWEh/miKllOa9o5KOiKCdU/0CPEM0jMISjE24JU93yMegC7
         rn8trEOrkJ995QzS+6d0yi19prb0LdboU4p64tQay4CW22q66PBzVtEZgrT0VXHEoMko
         Dyt++wildRcIKLHdR+c3jdlRQd37Q9Ha9gIjwE18FYkKw+D0ya+ISFsg667fLcjl5C4a
         Pn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tfQ5hZwVEp45ODRSTsEju3Ran9iEAqdztcJA8RDirg=;
        b=a1IhhwHXpVovVUCbEDXnVECzNJfNsl+hilmRyh9fPxeUAxu48XL45V4a/KyJKFguLA
         nGMQFyWEOnV2K7avLzgTk3VATxhid3BuU/XEcOVXJF7kf41S+AEeQ0Yyovdcc5duycbq
         Cd3l9N595kiSNgEIUFztdHMLCtYriDBBKlFnbIpJlybwvDeYRkF4Du94BoKNlZ6ITvMt
         mWsj8dWFBbQB2Ygfnyo0XUqrm4ZkF6UKeNX0DRoxxZyJ8hhGq64pu1RefvOeVViO53Da
         OuvlXX+Swi34T2/B4q9HFroAmmsEC/r1s2PdmevL3gDe5Yv0ZUr7KuSB6f24RNngUSui
         nbTg==
X-Gm-Message-State: ANhLgQ38wzeJEeIE24EvlAFzMEHXilBK97jYiPRgyKoPtTZFTF/9lCP/
        qBiHTpw6GulTWni9+RNrFSXtLQj6CYTe0jucxq2R8Q==
X-Google-Smtp-Source: ADFU+vtzIYeWEVfaW2sSgRymGUxFe+l6fsETT3HH/qeRS9SM3AJBQ0Lptdz5ueBdJemrgsiQyyYYsa/GKby4hESCU+U=
X-Received: by 2002:ab0:6693:: with SMTP id a19mr5386616uan.129.1584705339071;
 Fri, 20 Mar 2020 04:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200320113233.10219-1-patrice.chotard@st.com>
In-Reply-To: <20200320113233.10219-1-patrice.chotard@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Mar 2020 12:55:03 +0100
Message-ID: <CAPDyKFrWnK-TCMDExYHqpyo+5Fz9tKa0xWeauuQfTT1bQjepqQ@mail.gmail.com>
Subject: Re: PM / wakeup: Add dev_wakeup_path() helper
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 12:32, <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Add dev_wakeup_path() helper to avoid to spread
> dev->power.wakeup_path test in drivers.

I am okay adding a helper, but would appreciate if you send a series
to convert those using the flag currently.

>
> In case CONFIG_PM_SLEEP is not set, wakeup_path is not defined,
> dev_wakeup_path() is returning false.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> Currently, in mainline kernel, no drivers are testing dev->power.wakeup_path
> for PM purpose. A stm32 serial driver patch will be submitted soon and will
> make usage of this helper.
>
>  include/linux/pm_wakeup.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index aa3da6611533..d0bd13c19253 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -84,6 +84,11 @@ static inline bool device_may_wakeup(struct device *dev)
>         return dev->power.can_wakeup && !!dev->power.wakeup;
>  }
>
> +static inline bool device_wakeup_path(struct device *dev)
> +{
> +       return !!dev->power.wakeup_path;

Why using "!!" here?

> +}
> +
>  static inline void device_set_wakeup_path(struct device *dev)
>  {
>         dev->power.wakeup_path = true;
> @@ -174,6 +179,11 @@ static inline bool device_may_wakeup(struct device *dev)
>         return dev->power.can_wakeup && dev->power.should_wakeup;
>  }
>
> +static inline bool device_wakeup_path(struct device *dev)
> +{
> +       return false;
> +}
> +
>  static inline void device_set_wakeup_path(struct device *dev) {}
>
>  static inline void __pm_stay_awake(struct wakeup_source *ws) {}
> --
> 2.17.1
>

Kind regards
Uffe
