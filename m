Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E511BFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 23:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLKWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 17:13:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42931 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:13:49 -0500
Received: by mail-io1-f67.google.com with SMTP id f82so486845ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WK0R3vgtayVNUB5s3/ppzS6WIJXfYbPpsi6siOolE4=;
        b=d5WomvyX4tnC/dQgAK832nGB1Kl75yZmGi7AihNVzJoCrM+aW4Ie3qCVKGeOPc5KJm
         snJvRR06tTFUg6q/r4CpZg+XqLsV0mSiWfTAT+ctzmceBh1B3nzgA92CF4cf6SHIA3h8
         ov94DUQkYXaaarV15MIN98KM6+XFZCUv+7GaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WK0R3vgtayVNUB5s3/ppzS6WIJXfYbPpsi6siOolE4=;
        b=pVPckBdc/GdAzxNGX9o/doHJBhEErHShgTVlXB7zNtN3R+L2r3jgOaIuYRebzAqn8K
         /EUXWtrTPex5TAvuhHsXEH83UDYdFJWifxATEIzdbpYhvU5PDTa4khUrQjwPo/G6cz/1
         zuhyapUvfnjLqjTNFXc+NpB9/CeiVa5rJ7Up3vmNYiVdU6fon8BLJ9013hXo32ToNkjN
         5K3GoSxizTsKS3gxZdn0pLT/+9WOqMJK8E/dEdLbRcsTea5+w2cOOn9N0hehpoMlF2b4
         lfloP+gr9n/EzC+xl8ZxguVn0XJgjA4ra5mdUb1bpnqwzaUxX145YkqDnxQand3ljrkI
         AfEw==
X-Gm-Message-State: APjAAAXjA5uZuPWIg+60TLC12aSOCJ08Xe7w3iMtH8TQxDr6Heu5C5yh
        DvbT6VBuBxNvn9MjX9aPfoFIkp3DRGc=
X-Google-Smtp-Source: APXvYqzkCJr21+Dje4T6T0IgF0COwePUQ1YXyT+AkKv0yF51T8BxBqNWsEAz75VXaknFPuOHCE5tag==
X-Received: by 2002:a02:5489:: with SMTP id t131mr5356145jaa.40.1576102428098;
        Wed, 11 Dec 2019 14:13:48 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id r2sm1069597ila.42.2019.12.11.14.13.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 14:13:47 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id a22so528254ios.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:13:47 -0800 (PST)
X-Received: by 2002:a6b:5503:: with SMTP id j3mr425338iob.142.1576102426904;
 Wed, 11 Dec 2019 14:13:46 -0800 (PST)
MIME-Version: 1.0
References: <1574940787-1004-1-git-send-email-sanm@codeaurora.org> <1574940787-1004-4-git-send-email-sanm@codeaurora.org>
In-Reply-To: <1574940787-1004-4-git-send-email-sanm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 14:13:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XWsN72pvtHubq2UOgvm6oPs2s+RA61ct5XPGsBDbA13w@mail.gmail.com>
Message-ID: <CAD=FV=XWsN72pvtHubq2UOgvm6oPs2s+RA61ct5XPGsBDbA13w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: usb: qcom,dwc3: Add compatible for SC7180
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 28, 2019 at 3:33 AM Sandeep Maheswaram <sanm@codeaurora.org> wrote:
>
> Add compatible for SC7180 in usb dwc3 bindings.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
