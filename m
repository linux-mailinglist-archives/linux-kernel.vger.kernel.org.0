Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471D611D8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfLLV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 16:59:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38306 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfLLV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:59:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id a17so155802pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=CmXfpguq27944eP1eRHL/S89lr4HkiikW6X9wQMZTak=;
        b=Pl/pUQBmMNlT60swExa6Lc0oNeW8xywtmM0c5iE+6MjRqMLAh/sicSUDhIRtJUFEJF
         LkeK0S+MTgT2BjI+j/Bjr/9clApktvsRn9HX1KIaIChXS/MIG/vKXkv5PgabEjK1dGGE
         PKdVuMVX4sx3mWJ46X6FmpnNqriJ5y4UJ1Ir8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=CmXfpguq27944eP1eRHL/S89lr4HkiikW6X9wQMZTak=;
        b=jy8rZj3poPOsT+nQZIgBFnHmhNlSUWueRAmD78wmgB4yn7A7zlmAzDXE9FIWxROk0r
         gplv4k6OKpvTA0dOAu7XdCyQ8EeJe4cPo4UnjJMx/bBvSo0jAL9EzGBmahfMzt31/xp1
         nkhOkUKPITwyEpZXEOUV3ejQJbWuek5Ivr5agEJsnbKxPCUpkrk4a/iqt+uH+SMJDyaZ
         nZ3lkRQVm2+Puhuru8eeaH/hWweIMvh9laNZE6ujyXDggVH+i+KM7xtESGkOAdKCVJCQ
         QCp9vPfadMJ/yuYO7ICZgyFkWUfWcBS9D74KQWhJNfiM5EPgg9r6xxozrjhQVW3aPy5C
         DSdg==
X-Gm-Message-State: APjAAAXswkoynjnEHVkj/RM0XttUgyBlefw0+ZuIYrJ76YSnhYBbVwe4
        UC8ZG+cIincNn2PhH92AErlqJg==
X-Google-Smtp-Source: APXvYqyYdeFIttKHtScn51FUQtkOnmir8OiEGe0EwjEvNpgQw9TAoxHuXImKHk2nhWN4iUrT/Ec2Fg==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr11523626plp.54.1576187993538;
        Thu, 12 Dec 2019 13:59:53 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b73sm8519686pfb.72.2019.12.12.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:59:53 -0800 (PST)
Message-ID: <5df2b859.1c69fb81.3a87e.5ace@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.6.Iec10b23bb000186b36b8bacfb6789d8233de04a7@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.6.Iec10b23bb000186b36b8bacfb6789d8233de04a7@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sc7180: Avoid "phy" for USB QMP PHY wrapper
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:59:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:42)
> The bindings for the QMP PHY are truly strange.  I believe (?) that
> they may have originated because with PCIe each lane is treated as a
> different PHY and the same PHY driver is used for a whole bunch of
> things (incluidng PCIe).
>=20
> In any case, now that we have "make dtbs_check", we find that having
> the outer node named "phy" triggers the
> "schemas/phy/phy-provider.yaml" schema, yelling about:
>=20
>   phy@88e9000: '#phy-cells' is a required property
>=20
> Let's call the outer node the "phy-wrapper" and the inner node the
> "phy" to make dtbs_check happy.
>=20
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Would be good to add phy-wrapper to possible node names in the DT spec
too.

