Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20287122540
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 08:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfLQHTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 02:19:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34220 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLQHTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:19:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id l127so5255944pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=QzyD4fDBzuaA1wIHJrNGEEBy+sHP/QLbZfm+HTOKkR4=;
        b=cZ1UC4FU3oudipQIsRudGn7YYFzZwyRBr1Zx7UQVgiVjQGSZdJX35BExXyDtla7LwV
         jej5EkyALQChYmnfdvo1zM5HQcVSNKaSG9JnD+NXcHzxhZDCOWCLFopoCTe0+htP0CWa
         qtqcPwfOBdZJ3wCN8hDIukHxFgBwycoLJVA1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=QzyD4fDBzuaA1wIHJrNGEEBy+sHP/QLbZfm+HTOKkR4=;
        b=WOBWAJF7TavmyxNWvKzARlbiXRv8AwhlSd+13eroqVV0LRrJ31vBKmv+iv9Ja24/uO
         Xi9a6C2FD6pPQGhsT/WxKsb3HsPAXm7I+ncRqod/49kFk92Gd/lKLStc5FlY6rADzxvG
         g9pQYzIGe0V/zczvArXBRq4HSrYh7x0Vy7qRpHm/35wL+lGzDiECI1UiErkVHmseXcB7
         H9G4gxdtO7AzVLi9f0IAKpCTqkfN3IgG0HemtgaKQ8LYUD5CrgSiYCij7zjNoSxB/pU6
         6iUOpisBqhhU4VZPoo1cTlI890c95C9ag/afRfn8IeUGvR85cNT8BBasY9qNQx2xcaXY
         +whQ==
X-Gm-Message-State: APjAAAV3gRvtUCkklM2w/8mxO9PRIwmA9brK39n2sqgQtwm84wP3xANO
        nnfA8yAYP795cfxsqIaMQ8ZgMg==
X-Google-Smtp-Source: APXvYqz8hXemqVKZ6ua+7ANmnhFp0S8vFyVnswmIUvKNq9CdU6rmkd75hMilfxjn3EFucyUHU5xjxw==
X-Received: by 2002:a62:51c3:: with SMTP id f186mr21387191pfb.163.1576567185644;
        Mon, 16 Dec 2019 23:19:45 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o12sm26225089pfg.152.2019.12.16.23.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 23:19:45 -0800 (PST)
Message-ID: <5df88191.1c69fb81.3b35e.c8d1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216222021.1.I684f124a05a1c3f0b113c8d06d5f9da5d69b801e@changeid>
References: <20191216222021.1.I684f124a05a1c3f0b113c8d06d5f9da5d69b801e@changeid>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Rename gic-its node to msi-controller
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 23:19:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-16 22:20:25)
> This is just like commit ac00546a6780 ("arm64: dts: qcom: sc7180:
> Rename gic-its node to msi-controller") but for sdm845.  This fixes
> all arm64/qcom device trees that I could find.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

