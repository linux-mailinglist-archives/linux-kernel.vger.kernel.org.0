Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50B19B07E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgDAQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 12:27:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37763 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387986AbgDAQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:27:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so155638otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6etzW/Wlmpzc10GfWj1n2fg+ZHJsESBLfASbR0Ngog=;
        b=Rh7xnvV1Jjpe8HCPzeDbsT0qlX2Dq/F5CNcch7nJmW88seFl28DzOKq779NGl4fJP6
         kZcarkrWvs2xKDSx/BKS4ljBBHTZa3AQNaNYPmVX3J+DPyequ5mn+R0wFp4kv6c27QDe
         dg/2ayJkHU7oOEp99SLCGG+uWwa/nTVSGu3cN2AleL7/RTCojjlngMZJzKMflgnsnK04
         5BkwdhtHZqaZJEdYHDQV7PVK/6+woacjQ1GYHHIcQTL04n4/Wfzv3fJrX9Lqy62tuMQE
         RF+m+hIQF1zG9DSV9BNMDXSI/UKxUxCVMOae3jn6P5+1X6w6nadDPnnmashubwidiQ8N
         Rz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6etzW/Wlmpzc10GfWj1n2fg+ZHJsESBLfASbR0Ngog=;
        b=U47D1hJLX//acGBLKAMN24Z53EOjMjrW0bMYJ6hzBxgdCQPLzJkDPrhL8uyQTF7S9D
         P6W7W082fADZe6fnOhrLf1qID4K5zUlQclSavbyELbWRYK8fjUDEMJj4EpDgltbUAbVe
         FQoex9/7SwKUn64fom59rLo5wkBH1dTQkqo9Uzd2cakE9ojGe35TzH/8QDgPe5Hxkhi8
         ybHKZ1jc5AdPEVwlgBglemMSknfAQTGAzrJV+vwxvpNiP+pgnogSfcUDZVkRrNnpEcps
         1yBQkdncCzOeeQju6L9oUGbhhcbRTvtzGUsTRjUL6ekeNyEEwR+EGyzQoz9il/6GXhC4
         LdTQ==
X-Gm-Message-State: ANhLgQ0DuCwTVwrxse9W5PSuKTKuw08sEEE6BuR+4dW0LLfAGqJmkC1q
        rdqHsnUkUO7iuedcYBguMPeW36pzbFIlHdoNMrfoWGqBpGQ=
X-Google-Smtp-Source: ADFU+vvKgnFp9rspmykzhEanYhz/OKqP05HsLNsMveCdWplY4tf3BFByR2bGW/mxVNvhQGG+HpVk5gUY5nxF4PrgO+U=
X-Received: by 2002:a05:6830:18eb:: with SMTP id d11mr17642312otf.243.1585758433464;
 Wed, 01 Apr 2020 09:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200330164328.2944505-1-robert.marko@sartura.hr>
 <20200330164328.2944505-2-robert.marko@sartura.hr> <20200331163103.GA27585@bogus>
 <CA+HBbNEnH+0g0GK+xMGF48vJbLH3Ud2VY6yDOAxdgbRra3Y25A@mail.gmail.com> <CAL_JsqL_V6Lf3-eGoL454Gtgyp7a4hBo_2SXyq1jWfqDoXdXsQ@mail.gmail.com>
In-Reply-To: <CAL_JsqL_V6Lf3-eGoL454Gtgyp7a4hBo_2SXyq1jWfqDoXdXsQ@mail.gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 1 Apr 2020 18:27:02 +0200
Message-ID: <CA+HBbNEcrHgB1_ydaOaPKEWB6L6vrWNf=DYxt5YwdCoqYpLEqw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 5:45 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 31, 2020 at 10:39 AM Robert Marko <robert.marko@sartura.hr> wrote:
> >
> > On Tue, Mar 31, 2020 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, 30 Mar 2020 18:43:29 +0200, Robert Marko wrote:
> > > > This patch adds the binding documentation for the HS/SS USB PHY found
> > > > inside Qualcom Dakota SoCs.
> > > >
> > > > Signed-off-by: John Crispin <john@phrozen.org>
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > > > ---
> > > > Changes from v4 to v5:
> > > > * Replace tabs with whitespaces
> > > > * Add maintainer property
> > > >
> > > >  .../bindings/phy/qcom-usb-ipq4019-phy.yaml    | 48 +++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
> > > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > Error: Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.example.dts:21.25-26 syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.example.dt.yaml' failed
> > > make[1]: *** [Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.example.dt.yaml] Error 1
> > > make[1]: *** Waiting for unfinished jobs....
> > > Makefile:1262: recipe for target 'dt_binding_check' failed
> > > make: *** [dt_binding_check] Error 2
> > >
> > > See https://patchwork.ozlabs.org/patch/1264091
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure dt-schema is up to date:
> > >
> > > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> > >
> > > Please check and re-submit.
> > Hi Rob,
> > I tested locally before submitting and it will pass.
>
> Impossible. Your example has defines, but there are no include files listed.
I don't know how it passed, but I definitively tested with make
dtbs_check and then make dt_binding_check
It could possibly be old DT schema files, I updated today and now it pops up.
I will fix it and send a new version ASAP.

Thanks
>
> Rob
