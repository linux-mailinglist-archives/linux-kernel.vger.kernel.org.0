Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0169182584
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 00:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgCKXDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 19:03:06 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44060 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgCKXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:03:06 -0400
Received: by mail-vs1-f68.google.com with SMTP id u24so2485700vso.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmAU44+2WU5M+59/aGW/KF6T8HFXFFftVV4HYKoIqRE=;
        b=Yvv0M1bgxd0+ERo0T6RSS7KQwRTXvbLHmgh2GQU5LakeLf2u1+Tai8IP0P527bIzhV
         O552i21SYvZxu2Cv6WF/RqUWq91rqHvEaVLNoSMziNgZgVrQj4uj35thKw0eQswsd+xo
         EAcEcgawzWEd8hFZMNxCcxU03p2CMf1MDCEy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmAU44+2WU5M+59/aGW/KF6T8HFXFFftVV4HYKoIqRE=;
        b=QJ/e1eVkJSOe6FmY72TTMYKyDEGGlofbuODbOgtWXaK3VN4gIv/58op3Li86JEnOoU
         rSqZyxz804pkceJTCSvVGI+z7UcHOgYkCXZET7OTQALYscCYPGov8fgk5ULR1vmrjsi8
         PKODvBPTQt8GUa51Eyta/M1Aqv0dHBMfd/rnvyyokEo9MGkK0D7dVgVyabRUQWWCBqIV
         6jZJZXH/3GdvkN0sOGnM6PqiELQhQ4l9pzPiQj/5oWlD1zamnlT+95Sjk3l5iv/XJNzk
         FAphz8Ldd2mHUh2bUOUvhCPI+IrJ0HUnrpjPZDxfnX4n+nJ9IYha21EeiOfltLYwTrhe
         mMSQ==
X-Gm-Message-State: ANhLgQ05DoaeBMf08McN+XSeEeFPnLB44yelLwypSQpWMNF0mj8186MW
        XtC05BFLmye5sEzAj7UKSJPdY1K4CiM=
X-Google-Smtp-Source: ADFU+vvlO7pm1XhqfE6MtSRQ68VFc0ehKNDTkLz2cFa+qHC0y5FNhqcJL+ZhM2Q7bXwCNPpvUEbsjw==
X-Received: by 2002:a67:d706:: with SMTP id p6mr3771184vsj.143.1583967783085;
        Wed, 11 Mar 2020 16:03:03 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id e21sm2776362uan.1.2020.03.11.16.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 16:03:01 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id t10so2515876vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:03:00 -0700 (PDT)
X-Received: by 2002:a67:e98e:: with SMTP id b14mr3639376vso.106.1583967780416;
 Wed, 11 Mar 2020 16:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org> <1583746236-13325-6-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1583746236-13325-6-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Mar 2020 16:02:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJz4P_XC4S=dGb+0EyKm3dMOT69VFQPvKA6S5-LEGQwg@mail.gmail.com>
Message-ID: <CAD=FV=VJz4P_XC4S=dGb+0EyKm3dMOT69VFQPvKA6S5-LEGQwg@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] drivers: qcom: Update rpmh clients to use start
 and end transactions
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        Taniya Das <tdas@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 9, 2020 at 2:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -263,7 +263,9 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
>         tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
>
>         if (!commit_idx[0])
> -               goto out;
> +               goto end;
> +
> +       rpmh_start_transaction(voter-dev);
>
>         ret = rpmh_invalidate(voter->dev);
>         if (ret) {
> @@ -312,12 +314,15 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
>         tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
>
>         ret = rpmh_write_batch(voter->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
> -       if (ret) {
> +       if (ret)
>                 pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
> -               goto out;
> -       }
>
>  out:
> +       ret = rpmh_end_transaction(voter-dev);

One last note is that your code doesn't actually compile for me since
you need "voter->dev" here (and in the start case), not "voter-dev".

-Doug
