Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D17123A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 23:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfLQWgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 17:36:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:36:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so28730pfw.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yUR3VGXqcEyFpDj03ashPmu0D0HK7H7Djn3POx5wsk8=;
        b=hpI+f7SS3jE6F9WghLjeR6FFfhRaI/Dl0bjq4N1UHVAwzEa0E+35JRO9yCK2LtqHDE
         8XBHKDEf33L2oT3cbE+2OoqgsEUn+kmBgb4ORJqXy8USwnbqd97H9gayACgUHc4qMMqL
         XIxJX9Y7YV0LYpNPa7HtcL7PvCgjumxAhTcmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUR3VGXqcEyFpDj03ashPmu0D0HK7H7Djn3POx5wsk8=;
        b=Qwcskf4qLqWvoYdkVCEuGJKXd0QIRRblMa4p9mXIHwGQY1Px2OdG7tT0MDEPaQZb1X
         oanf2YLYZ8vIwNIj96n5KNDaFvM48PNzYsZjOvEWDm+ykjpCS5fDSoAv+ENtpTLGH3Jz
         /63EVVvoer+636DuGIWrc+4Cfkda3Bipf1AzGHebydWH3IoXD64HJk+lXN/uJ8Hh4bH+
         aogk9td3zFmg1n6UvPzUItpKPh8ZA156FEKTQULcskjl3+/AWpl5lx2DeYxZslP9w9FB
         EB0hSoHMMf9pJM3FHSlBHQXm1Afv3N9UWSrE1IAD2h+FkL+p5GttPyB0C8gRWfBjYat/
         NG1A==
X-Gm-Message-State: APjAAAU9se98eeZDqnjqCS/MvlLl5/aWfTm/MJkroVWaXw6nmXakx5+z
        7Ft0UCJOBEymD0WR4mQGgoBMhQ==
X-Google-Smtp-Source: APXvYqyse3yodh4Y8GBmMY60C4nZ1Ex8BE7BiinQNGmJIpqd+FR49bz6zBoTrFGG9uLrMKjtWT07ag==
X-Received: by 2002:a63:1908:: with SMTP id z8mr28108344pgl.350.1576622165581;
        Tue, 17 Dec 2019 14:36:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 189sm35588pfw.73.2019.12.17.14.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 14:36:05 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:36:03 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linus.walleij@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Fix I2C/UART numbers 2, 4, 7,
 and 9
Message-ID: <20191217223603.GX228856@google.com>
References: <20191217130352.1.Id8562de45e8441cac34699047e25e7424281e9d4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217130352.1.Id8562de45e8441cac34699047e25e7424281e9d4@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:04:07PM -0800, Douglas Anderson wrote:
> Commit f4a73f5e2633 ("pinctrl: qcom: sc7180: Add new qup functions")
> has landed which means that we absolutely need to use the proper names
> for the pinmuxing for I2C/UART numbers 2, 4, 7, and 9.  Let's do it.
> 
> For reference:
> - If you get only one of this commit and the pinctrl commit then none
>   of I2C/UART 2, 4, 7, and 9 will work.
> - If you get neither of these commits then I2C 2, 4, 7, and 9 will
>   work but not UART.
> 
> ...but despite the above it should be fine for this commit to land in
> the Qualcomm tree because sc7180.dtsi only exists there (it hasn't
> made it to mainline).
> 
> Fixes: ba3fc6496366 ("arm64: dts: sc7180: Add qupv3_0 and qupv3_1")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
