Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2480911BB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfLKSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:18:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39319 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfLKSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:18:55 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so23664198ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hF9BKa5wnk6mlJKv8zSjQWblgjM1RbwR2kAn63Qo6po=;
        b=h0RUCMUGyGK0TWu6erO5q9iiXC0lQgxW2JFdFQNZ/21zcUbvREAdjB593cW6x2Q61H
         C3on1JVH9ccpq4QLbCr6e9C6t7iyU9b1wOd/mGpjehDj66HbCPk/17OlqTdhi0Sf2qCj
         fWtF4vFvDgUKUeSmzB1RdDjj43cP4mAEhCf2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hF9BKa5wnk6mlJKv8zSjQWblgjM1RbwR2kAn63Qo6po=;
        b=DutiuB1Y24ctFvkzRlngWrEpBGKHnNnaPSRfHkKNnT/aFb6mcTq0on48RDzZAP0Vmx
         B7BfWAFOjrTOZ1jR8Qs4A/ID0AISiZSTa46cHiQlOJb1tQiD5Bn5QY7P6y/uSexVdjKX
         mEYNOgHrNml8nbt+RrrLGR5KpjiHV/5sXYZEGhG6B2xAT/VZTTMde37Re/yVyItmf6Da
         9jcZNYzfFMfLlkhi2PHHeR0yjQHv8Q+GqhJgRcB5cneWD8ha2Joa9xmqZMz4JJDGVJx2
         DBii/wK1Wjgy5lfpX/BQV8mEzvsrWogAws+CA5uLCvFjwk5X/PVFtLWtqxI+34u4fuAT
         sXHw==
X-Gm-Message-State: APjAAAUU2VDx/ggBUZL5X9J0Etp7WpXGzTv33jWF39MJGMI2O/tjD3RW
        Fvg1hTyDsM6jb37Kopiq818eSElsdZE=
X-Google-Smtp-Source: APXvYqzQmVevRHLVe2E0Jb9e2P2BWUe8CHI0rBQf0q9KkyT4mBCl8P9+0wQQPw9wdiEShux1akf01Q==
X-Received: by 2002:a05:6638:950:: with SMTP id f16mr4296053jad.107.1576088334702;
        Wed, 11 Dec 2019 10:18:54 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id k26sm674275iob.25.2019.12.11.10.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:18:54 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id f6so20269599ilh.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:18:53 -0800 (PST)
X-Received: by 2002:a92:911b:: with SMTP id t27mr4383452ild.142.1576088333615;
 Wed, 11 Dec 2019 10:18:53 -0800 (PST)
MIME-Version: 1.0
References: <1576048353-21154-1-git-send-email-rnayak@codeaurora.org> <0101016ef3cdeea5-fba7a1a7-75b0-43bc-b7e4-94d19ae6b576-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ef3cdeea5-fba7a1a7-75b0-43bc-b7e4-94d19ae6b576-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 10:18:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_9DGF9L7YwYnw1JAqk-T7XB0OJD78EarUJNfVR6pvzA@mail.gmail.com>
Message-ID: <CAD=FV=U_9DGF9L7YwYnw1JAqk-T7XB0OJD78EarUJNfVR6pvzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Add aliases for all i2c and spi devices
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 11:13 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add aliases for all i2c and spi nodes
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
