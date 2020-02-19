Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623931652B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 23:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBSWvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 17:51:15 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35451 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgBSWvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:51:15 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so10676pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/C/96K5oLYn6X+y/FSyD1yv4KOr+6D8nD+8tPOB3y0Q=;
        b=L9RxT6F05R55DW31tM4Z5gEB7dV+9AOuoO5r5z9ceAqqDfiSEL/104dEWIO1iraFNT
         089InYs24GWN+iGki+xKDf1BTG0dSNtUruxPvMiJrcIwPvDHxtP43v9EyTIvZdcrcuUu
         HRRYVWm7Ddkt5nek6SrdQonpS/rCmeNVXpdUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/C/96K5oLYn6X+y/FSyD1yv4KOr+6D8nD+8tPOB3y0Q=;
        b=b2HEXndifxnAZDWbaxWY8Idmbrnw+nu8OuIDBWNe/x9CJWrvkP6PjoNt7q5Dez7Xri
         EW9u1UAocQXH+3Qnz99/XWl3Txffoakv26ZOc0YoYH1B9X5ux5vxic2dcugQFSC9QDXu
         +3LcoNiLiJeHrYvZP7PIiHCkTEPsDeLTUxOnuyTuEReITEkemJHQu7hTa3bfilM6m11L
         +j/5brjbJZeUVznxnUKZFV7gcbwiTlmfrjZHC1LVyXBc7BilqXnvkItXrwwLgDhQXgo5
         73Nf/uQBggxiNGWgQXhaEgoy2ecqlzdr7vp49UP9RpeGSVCxVPeobrvF8HAgr1+qdDz4
         Y/Gw==
X-Gm-Message-State: APjAAAWyR2r1W5G2QmuAMytoBK1lsvbZqiFYTHolLCxKAyNVeVTPdI9F
        1JyD8AyzRT8lqW8pPl05hJz8yQ==
X-Google-Smtp-Source: APXvYqya2k/fNH0PCv1YhT7xUIMf025rMaROJHmjvNV8yKGJHvlsVKCJayU+6UxVpnujNIsc/SR0KA==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr10935860pjb.99.1582152673231;
        Wed, 19 Feb 2020 14:51:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k9sm808496pjo.19.2020.02.19.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:51:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 7/8] drivers: thermal: tsens: kernel-doc fixup
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:51:12 -0800
Message-ID: <158215267200.184098.11619305318344159345@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:11)
> Document ul_lock, threshold and control structure members and make
> the following kernel-doc invocation happy:
>=20
> $ scripts/kernel-doc -v -none drivers/thermal/qcom/*
>=20
> drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for q=
pnp_tm_get_temp_stage
> drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tse=
ns_irq_data
> drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_=
to_mC
> drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_=
to_hw
> drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set=
_interrupt
> drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_thr=
eshold_violated
> drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_cri=
tical_irq_thread
> drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq=
_thread
> drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sens=
or
> drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
> drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_fea=
tures
> drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_pla=
t_data
> drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_con=
text
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
