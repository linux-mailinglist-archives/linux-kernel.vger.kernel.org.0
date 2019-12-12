Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6611D8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 22:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfLLVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 16:55:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731194AbfLLVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:55:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so282808pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=urg3oqpkUyFoOb/JDlCrmqkZ7jXqGD4fg9eldRMT63E=;
        b=XOcfVfvOeLyjRRYv4YyBXqZXcq674DERW9bH+JuR+mQJt/1eouj+sPsXldunowJEUn
         qlpu9yXRRfrpE6pfkWSuTGgw8mAJbHuDHNCDrkx2oINnIZ6BMwSP9wwG3T8SlxIXEEZi
         7mdxLGuIfBHoCbfpCh4O4Dca0tfCbxhpKNjAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=urg3oqpkUyFoOb/JDlCrmqkZ7jXqGD4fg9eldRMT63E=;
        b=Vafs5OrjbVzGeiMRpGPB2Q5c4mRbWocPvTY+DGjKZHqAy37TTAiRcvYfHioStsiy5z
         WS2/1d96UaHHvWRAxm8+BFV0fWXSNw901AUQVZ/vcfYpjxPtA093ny8GYStloCqC85FR
         h1+LJGKqk3RNiH91xRngXAgMmKqeDt+YkaVsEE29G/EQ5tf29//J4rfHAUlus7GvjppV
         yPksA3VvbbjzyrZGR5m1/ADgazwFaf97kES0G0Mri8NsBY5TO+3qZuFjMgc0mqC1fLVj
         NB1OemOpMnV/9k4io1kTc2Pm+3JkkYxTYKGvsuBYIiEgZBHwhF0dCvOAxY3vO/VAsI9b
         KKPw==
X-Gm-Message-State: APjAAAUKB9v36ivGGUDQTZsrFTM4rrZYUTug5FA2Zemn4TDHYjKP9FqK
        8UlAfjVoA0mEE7I0+t3oYuYKUA==
X-Google-Smtp-Source: APXvYqxsU3Zn83nmi5BMPuXs1io7SR/MxzioX+tPsoqMwseMYXhYSyyUPQtfuvaRWLq5j4dET5VfoQ==
X-Received: by 2002:a63:d543:: with SMTP id v3mr12769373pgi.285.1576187731374;
        Thu, 12 Dec 2019 13:55:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o8sm6775711pjo.7.2019.12.12.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:55:30 -0800 (PST)
Message-ID: <5df2b752.1c69fb81.77c46.0f9a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sc7180: Use 'ranges' in arm,armv7-timer-mem node
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:55:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:43)
> Running `make dtbs_check` yells:
>=20
>   arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: timer@17c20000: #size-cell=
s:0:0: 1 was expected
>=20
> It appears that someone was trying to assert the fact that sub-nodes
> describing frames would never have a size that's more than 32-bits
> big.  That's certainly true in the case of sc7180.
>=20
> I guess this is a hint that it's time to do the thing that nobody
> seems to do but that "writing-bindings.txt" says we should all do.
> Specifically it says: "DO use non-empty 'ranges' to limit the size of
> child buses/devices".  That means we should probably limit the

It got cut off here. I'm waiting to find out what it is!!

>=20
> I believe that this patch is the way to do it and there should be no
> bad side effects here.  I believe that since we're far enough down
> (not trying to describe an actual device, just some sub-pieces) that
> this won't cause us to run into the problems that caused us to
> increase the soc-level #address-cells and #size-cells to 2 in sdm845
> in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase address
> and size cells for soc").
>=20
> I can at least confirm that "arch_mem_timer" seems to keep getting
> interrupts in "/proc/interrupts" after this change.
>=20
> Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for =
SC7180 soc")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

This pattern exists in most of the qcom dts files. Can you fix all the
arm,armv7-timer-mem nodes. Maybe the binding has the same problem too in
the example.

>=20
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 36 ++++++++++++++--------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
