Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E361652C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 23:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBSWy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 17:54:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44799 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:54:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id g3so846263pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=eUDORF+FxRcIo6PLdteE5uxC09DOff5/FLLpV2ERyqs=;
        b=mcRJHRAUFj8uZ99AFRUEeGXF/+XT2mLS9m5s88pd/SJOaXb56gVhfIZ/gofaiM3gnh
         cXL9kN4wEF0mOvwU+bmCP5oxVyoWJ71go5xEUfE6ctxUKq5QuPrGUGPbAHI7LRfKQA7+
         asuEGI67vKG7AepBEuz7c/lGS6ZuLpv2biSU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=eUDORF+FxRcIo6PLdteE5uxC09DOff5/FLLpV2ERyqs=;
        b=rKWDwm3ktuOgUXkrnsiGVJmMVM5CfAjTKRY3ohGo0HLNcKHRRuY4DsLMtU6jmdEJQD
         D/ceCOh6PSwsRNgmNFxT4cWfantoscjjP+AaXzUznLj80HvlydTOZkV5nZosvjIxYbaq
         MCQH1dI001/T4+gY0f/5zT3NPczskf+5tmvTXMv2rhXngePwaHkR+viNXHXT2Z/0Oiw3
         ifKXFJ07WYXwAk2hAHdLJhGxSzWLG0hEp8lHyktxxZZSeVJeILv6uV8ouPp256Hmit9+
         4gQqEWi4I9/U8FddsuF4NJQ33O49D+YSdN7Ap+PvYQf8FXlysl/3zYsMjkQhe4q6n/bl
         q+UA==
X-Gm-Message-State: APjAAAUDJD9y03DBDEJeb95jEUNmUu7VjOsgDggAuKcHq6rUA0F8xFqk
        MPb0kZ7JSnRArNDGhltD8hMccw==
X-Google-Smtp-Source: APXvYqy0na+w9G4V2yh+lLPkN/J5LnFRo7hiPZb/dJCUnAb3G8z7wJwi3PUKaITjavzd/cnOkD777w==
X-Received: by 2002:aa7:8610:: with SMTP id p16mr29491721pfn.28.1582152862298;
        Wed, 19 Feb 2020 14:54:22 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y24sm744163pge.72.2020.02.19.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:54:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8dea9b377998de1617dd14aee90c421297262c5c.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <8dea9b377998de1617dd14aee90c421297262c5c.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 1/8] drivers: thermal: tsens: De-constify struct tsens_features
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:54:21 -0800
Message-ID: <158215286106.184098.326019673452132786@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:05)
> struct tsens_features is currently initialized as part of platform data
> at compile-time and not modifiable. We now have some usecases in feature
> detection across IP versions where it is more flexible to update the
> features after probing registers.
>=20
> Remove const qualifier from tsens_features and the encapsulating
> tsens_plat_data.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
