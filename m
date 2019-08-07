Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AEA84BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfHGMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 08:43:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35349 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfHGMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:43:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so63887667lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yF1OuQ8WOJDwWnUlO01EbGsBbNmAnc6oHp1K7rziEs=;
        b=Qkscwp0fMEP5YUts5kZ8mBnyK/OpngNCEOAidd5gDqm0omiSQCT3uXzqoJPoysQldz
         4lgN3op4lyvYbnF7bj7XfuUgFO6pwFysEYZMaCCnrUJlzlPGxFwNFeauDS0cgSVcL7BY
         pm4cXe7UqsCsczPq0q/Heh79nqUVbQTn9fVdGaphofDgpniehIo0S+O6IJLzZQyNyX+o
         wIRGwN1AH7uLn2xcWDXs1OYlPr9AqlCmgjBvgMTBdNy3GC4ZQRXWorQnlqPRh63kFRTB
         5zu+oi072EGWXe3id3Q7WIXYE8q7u98sy0ME0/BOW1lQMgBpriiH7N559fFPEU+BNVg5
         WtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yF1OuQ8WOJDwWnUlO01EbGsBbNmAnc6oHp1K7rziEs=;
        b=YqKzGTBd7Iy36XWdj2i0g3bAr6c9udF5NPeMngD2LTiivtznQpZe08fiFLBH1ITrlr
         7/nlmo6pNAGDZkq/Bjh1k2DPg/vl2gy7MXyb3L/lRhm0ln/eCC8+4FDMry3bEap3mfpn
         TAl38krESGyKSNxVHDnxv5rapwqQpjdtGBAqptO9BvbgCbzWkdLE2UmDOWPjOzM10QqJ
         V+SLy8NgFqHHKXZpjG//Uecd1x7i1yUPN6SA7w2TFfGZcf75NfYx2V8PcyBnhx7stqJF
         /O2CLj36my3pKlsCs6BmB5Tepiew2NYNY+NWZC1S+tAX2hfHtVGnBUlwg467STogg9Kc
         rXpw==
X-Gm-Message-State: APjAAAVuTJRBwb6DV7edqQKoZT4JJF5L1tUedwJxhrjVggpRnqkXNliK
        zhV5Jvs38Cl6drZJ7DL8sPRO+dQ6HKaL/mxSk3gGew==
X-Google-Smtp-Source: APXvYqyHcn+uEIkjeMH25oklHeb5+qGtHeaOrVJcVtMtUqMfkChzi4CWRJOO4SFcOgHxdBcv6Lm+gTNdGKL7HocbYwI=
X-Received: by 2002:ac2:5939:: with SMTP id v25mr5930898lfi.115.1565181819882;
 Wed, 07 Aug 2019 05:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190806060536.18094-1-rnayak@codeaurora.org>
In-Reply-To: <20190806060536.18094-1-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Aug 2019 14:43:28 +0200
Message-ID: <CACRpkdYdVFR3CnC+bO0ZYP9FyXsuGQZAiBxMchSrhpQGtJnd9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add SC7180 pinctrl binding
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jitendra Sharma <shajit@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 8:05 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> From: Jitendra Sharma <shajit@codeaurora.org>
>
> Add the binding for the TLMM pinctrl block found in the SC7180 platform
>
> Signed-off-by: Jitendra Sharma <shajit@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> [rnayak: Fix some copy-paste issues, sort and fix functions]
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Patch applied.

Yours,
Linus Walleij
