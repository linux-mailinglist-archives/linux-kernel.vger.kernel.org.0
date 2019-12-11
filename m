Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D741911B966
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 17:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfLKQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 11:58:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34102 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfLKQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:58:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so1656032pln.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=5jb7nWK70BZS7ag9B3B5zFJSF1bm+Q/zoWTJh2Z8lXA=;
        b=LeVJVV19ZTloWo+6tCC05BqqcOm7WR1cmQNkt8oeELgRn40lhEYhKQ097l3j0YqAKs
         d33wAq2Mt4CczBc3SBpzhDbXKkHKS1HtXXqznFO0ZNBzQUXgYXGc1jSqB171fw/+o+AL
         0GcK0PByzIbu9tkgACQ9JiW07oc/nU2Ss1rcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=5jb7nWK70BZS7ag9B3B5zFJSF1bm+Q/zoWTJh2Z8lXA=;
        b=jYmYx6hiSOS2IkKH1y1wjQb8jkEuYt8dVqnn/Ug+I8y78pVh9t3JjYmLIrUmTzwLpV
         0EvCYEqhdSPZ+mZ39tD536/wxUo8zx0puImvke0sd/B8AZyGg+vflWiAs/eupCbUw1lZ
         rPlxL4b1UUy/AyyXR6QycBXVYjGJLrbRpqjkjhiLq1eU+2r8nn/ffA4Oy93wJCwJ8Bhu
         djp2JulIj7aPMsBuKzA6nhba0eyPI8qnhS15rSd9ffuIb5027uMWrkD34SgmPriy6EHW
         ULopmezT4FWuytEECFKE9vuTM9QJ3oc+RlcwnkVW49UQcvYNZI835yiPy1y4V8fxbuzK
         Gy+g==
X-Gm-Message-State: APjAAAWASVgkCsJO0rYLy5O0yTlZyuUGJy7YU+XrPFq4ncT9qkJfmoWt
        Qrg3tPiDQT8HFLUHXumpZm2Dqg==
X-Google-Smtp-Source: APXvYqwfxt84EsPzyIIawe7+keVsiepyplg9Ohwph/Y9Z+q0mwLb0vrE3MS2SYn3Q2d0mOtGwTjyPg==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17mr4173201plp.96.1576083535480;
        Wed, 11 Dec 2019 08:58:55 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q21sm3674641pff.105.2019.12.11.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:58:55 -0800 (PST)
Message-ID: <5df1204f.1c69fb81.b4c19.8ce9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016ef3cdeea5-fba7a1a7-75b0-43bc-b7e4-94d19ae6b576-000000@us-west-2.amazonses.com>
References: <1576048353-21154-1-git-send-email-rnayak@codeaurora.org> <0101016ef3cdeea5-fba7a1a7-75b0-43bc-b7e4-94d19ae6b576-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Add aliases for all i2c and spi devices
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 11 Dec 2019 08:58:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-12-10 23:13:09)
> Add aliases for all i2c and spi nodes
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

