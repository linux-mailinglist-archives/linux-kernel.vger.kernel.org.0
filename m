Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03581A7674
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfICVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 17:45:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35179 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfICVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:45:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so9960849pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=DC974GZJGhexkCFBOM5qEmYf6z0HgA/VnDsSvsVF7D0=;
        b=HiSF87MFMlybKjWPbamDnFr8jF4yrV8wWRl/q7vTLdCayEIsdov0M2UgoQlf3JX4H1
         gBBiyAdAu8IAEwYR1bevmCl7HFTR9sajVfhMDgAXak5uU/WC9Pk+G7i996fVdJTigDwR
         CK8z8PVAiAURMoDDeyttp6CxAFcufTD9LoaXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=DC974GZJGhexkCFBOM5qEmYf6z0HgA/VnDsSvsVF7D0=;
        b=jRLQTDFUZUtjvKo9dH3tMT/kdvGIZLwjPWE08+oQZG6DN8pcliAYxTyiZiSGAWRgms
         Lm97fSgY/HMCf6qorH80u9HiTaY15QcPHg30D6ox+rL1FPjK6Zp+Lb60D1jgxNeI+9am
         DHV/aCURK751SAiphGsJdHfGwiaf6xIfXbEjsaF2Nmvjk+KyWo/japvw9pTsxi85QLRA
         J5jTJurF2YGIrnsvDQsMSPCjbOdYSf4WQcApJUhlkF25t7JA4N//+MDKSi5jbfvWadNL
         2PXxzNyzfmP+Fc4v6dB9RzLTB6IBUAGK/7T6p/gV0VOBEB9AxbZUO3mFIcsO7PZ8oOjq
         T2Rw==
X-Gm-Message-State: APjAAAUUiTchlzlNZvV5Ejm/EoX9epxNea5vbYDZjIgQDm19P9C5qhQc
        7B9G6lcWGeOzDZ45BlyNA1orNQ==
X-Google-Smtp-Source: APXvYqyyXLc2Kx3iRoFjN/Pmqbfyp7/k/scbD3QixYgco+j3rtBA2rDoAT/CxZaV2vtfjY0BzldgGg==
X-Received: by 2002:a65:6454:: with SMTP id s20mr32157131pgv.15.1567547110418;
        Tue, 03 Sep 2019 14:45:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ck8sm498898pjb.25.2019.09.03.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 14:45:09 -0700 (PDT)
Message-ID: <5d6edee5.1c69fb81.a3896.1d05@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190903173924.GB9754@jackp-linux.qualcomm.com>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org> <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org> <20190223165218.GB572@tuxbook-pro> <6dc0957d-5806-7643-4454-966015865d38@linaro.org> <5d694878.1c69fb81.5f13b.ec4f@mx.google.com> <20190830164520.GK26807@tuxbook-pro> <5d696ad2.1c69fb81.977ea.39e5@mx.google.com> <f3584f38-dabc-7e7a-d1cb-84c80ed26215@linaro.org> <20190903173924.GB9754@jackp-linux.qualcomm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh@kernel.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
To:     Jack Pham <jackp@codeaurora.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 03 Sep 2019 14:45:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jack Pham (2019-09-03 10:39:24)
> On Mon, Sep 02, 2019 at 08:23:04AM +0200, Jorge Ramirez wrote:
> > On 8/30/19 20:28, Stephen Boyd wrote:
> > > Quoting Bjorn Andersson (2019-08-30 09:45:20)
> > >> On Fri 30 Aug 09:01 PDT 2019, Stephen Boyd wrote:
> > >>
> > >>>>>
> > >>>>> The USB-C connector is attached both to the HS and SS PHYs, so I =
think
> > >>>>> you should represent this external to this node and use of_graph =
to
> > >>>>> query it.
> > >>>>
> > >>>> but AFAICS we wont be able to retrieve the vbux-supply from an ext=
ernal
> > >>>> node (that interface does not exist).
> > >>>>
> > >>>> rob, do you have a suggestion?
> > >>>
> > >>> Shouldn't the vbus supply be in the phy? Or is this a situation whe=
re
> > >>> the phy itself doesn't have the vbus supply going to it because the=
 PMIC
> > >>> gets in the way and handles the vbus for the connector by having th=
e SoC
> > >>> communicate with the PMIC about when to turn the vbus on and off, e=
tc?
> > >>>
> > >>
> > >> That's correct, the VBUS comes out of the PMIC and goes directly to =
the
> > >> connector.
> > >>
> > >> The additional complicating factor here is that the connector is wir=
ed
> > >> to a USB2 phy as well, so we need to wire up detection and vbus cont=
rol
> > >> to both of them - but I think this will be fine, if we can only figu=
re
> > >> out a sane way of getting hold of the vbus-supply.
> > >>
> > >=20
> > > Does it really matter to describe this situation though? Maybe it's
> > > simpler to throw the vbus supply into the phy and control it from the
> > > phy driver, even if it never really goes there. Or put it into the
> > > toplevel usb controller?
> > >=20
> > that would work for me - the connector definition seemed a better way to
> > explain the connectivity but since we cant retrieve the supply from the
> > external node is not of much functional use.
> >=20
> > but please let me know how to proceed. shall I add the supply back to
> > the phy?

So does the vbus actually go to the phy? I thought it never went there
and the power for the phy was different (and possibly lower in voltage).

>=20
> Putting it in the toplevel usb node makes sense to me, since that's
> usually the driver that knows when it's switching into host mode and
> needs to turn on VBUS. The dwc3-qcom driver & bindings currently don't=20
> do this but there's precedent in a couple of the other dwc3 "glues"--see
> Documentation/devicetree/bindings/usb/{amlogic\,dwc3,omap-usb}.txt
>=20
> One exception is if the PMIC is also USB-PD capable and can do power
> role swap, in which case the VBUS control needs to be done by the TCPM,
> so that'd be a case where having vbus-supply in the connector node might
> make more sense.
>=20

The other way is to implement the code to get the vbus supply out of a
connector. Then any driver can do the work if it knows it needs to and
we don't have to care that the vbus isn't going somewhere. I suppose
that would need an of_regulator_get() sort of API that can get the
regulator out of there? Or to make the connector into a struct device
that can get the regulator out per some generic connector driver and
then pass it through to the USB controller when it asks for it. Maybe
try to prototype that out?

