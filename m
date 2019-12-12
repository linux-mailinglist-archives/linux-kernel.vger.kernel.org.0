Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA90A11D8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfLLV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 16:56:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46269 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:56:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so242017pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=R504xzcVz+CgAl5xRon/DrsTzkWasdrV6fbsiIR7GPY=;
        b=jApF8wDtz44pbe7YQynFmRFce0I/fjN6RAuS8ZCmw0NGt3HCZ5yX5LjPYioFyLTITM
         rtlwl1Y3z3XOz08vPoBAIqbbwrPKqKODSS5hc6Dr+19/yX6IrfpMl3aUXHDaeZrQpnfN
         QEw6ZXGPFysyyyVjGadqzDoIIpkmxkTEteJik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=R504xzcVz+CgAl5xRon/DrsTzkWasdrV6fbsiIR7GPY=;
        b=t/LpE0XuHmBh9jYmdRhJ92gSPWZH1aFvxH7l+E5Hp5Rc15diTPc+djtbXIo6u9Awax
         RlLfB3TQYxjmyEGx30BnX5SZg7aaFVPBeOG2IBTGqx+k2CWba8Vj7k4WOP9zmuImo8VU
         KscbW/ELNpQNGoX8BDrsJiVNdmTtAgzb8azG9mweIhF/xCOPhH+7K3lPrecI2motiirT
         i5nTuErlhYWsTNX5vGEgPhVFe64DPnYwx3XkKkqyA71+LN3CIuqEjk3pi6DunVpNQ1i+
         HU+dKWeZvjQuaj1ukQy0w3o9HzfaxU8crFiwwxepue+99/Ye3oNkj6wUswX1B8lhrQwe
         7jWw==
X-Gm-Message-State: APjAAAWntjaLMTVChYvc17VqJh7N079b9nfilA1re4G7h4xoZSFC2z4x
        kgDEMrfRu65IwpldNG6xDszkWQ==
X-Google-Smtp-Source: APXvYqyzBzZHqigvl/nRwOiBG4spBHBcMMBa2OMSb9eLLysTGsB2DUuYWrNZaR4eXzpnp8M6S+gVZw==
X-Received: by 2002:a63:4723:: with SMTP id u35mr12630015pga.194.1576187808586;
        Thu, 12 Dec 2019 13:56:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w6sm9136180pfq.99.2019.12.12.13.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:56:48 -0800 (PST)
Message-ID: <5df2b7a0.1c69fb81.8e18e.6b3d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.4.I5f67a5ed7665f658c95447a837cbd0021e1dc689@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.4.I5f67a5ed7665f658c95447a837cbd0021e1dc689@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 4/7] arm64: dts: qcom: pm6150: Remove macro from unit name of adc-chan
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:56:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:40)
> This is just like commit e77cc85ee390 ("arm64: dts: qcom: sdm845:
> remove macro from unit name").  It fixes the error in 'make
> dtbs_check':
>=20
> arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: adc@3100: 'adc-chan@0x06' do=
es not match any of the regexes: ...
>=20
> Fixes: a727ec1232d9 ("arm64: dts: qcom: pm6150: Add PM6150/PM6150L PMIC p=
eripherals")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

