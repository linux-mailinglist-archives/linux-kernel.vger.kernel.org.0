Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46588A52ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbfIBJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:35:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45681 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfIBJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:35:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so11922010qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vAwnLuMjjeItOOqHHXHJmcc2xpDcbEuHDPmJlUbyfys=;
        b=PlrwvAU2KCgLvuLJeYmq+oXRO6WFqP5OyD8x2GqpXCKWsQyaCQv+JWXDCy8y5BWeL5
         yZzac6WC7sgZDmlZSV40kMzZtSar7DmfkwcY+qjoNz7vl+MVUr94nFmNDMGHou7vDoKr
         1B1ExfRcC4j2fSK0hHmzHPehXdJFDwqnzCaQhW/eOsqs4lGEkbHklA9K71U7T7O4JMti
         pbLv48onqk/2cqgkxei++KAtZJvLIWmMwfSgVsLTSoWwHjt8/8NELscJ9gkK0q1XeH9Y
         +xXI99gACrkxEuyAEdP6FgWTd0DNtbq57D/lBrP/cMOsKt7I0hyS5ASpzkb9T4Zy86QP
         4k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vAwnLuMjjeItOOqHHXHJmcc2xpDcbEuHDPmJlUbyfys=;
        b=LSGqKtIv4tBvq1vs78JWFw+nsdR92svFzVw1to5IaHnjHWGPsO2eYai0Lyf2+Wk2BX
         T+XUR/Jkv7XpYki+eJphXevLTFfaGmXDMckBRapgWVGsZcgLJDANLjWQumIPt4Ak+00P
         4y8cgnkMiZD5htIMCMPH2Zo64+7Hxy1mU7g6U/PIwHS5HOTPvnHbsvSEKqdJxMRPmiB/
         LVZ5FjC0xBAPbvNEe7PuqVCp5FaLqh0KNanrOZ6iTPWasZhbrTAzGuQVL0inhV5dEwI6
         bduHvuHQ6poEmSgxfvfJ8bCHOpLd+sKy04zh275JiwGRTOipp+f6TAKjRohBDYeR6AhO
         bNWQ==
X-Gm-Message-State: APjAAAVaqn2lemZ8WOVPjgHHqAwNRCCSyrZ7nzGqhv9hp4Z3BZkMpHt+
        Cr0Jino65m2IAn8AZCPJEjA/tYvfHJac7ri1D7B6Ng==
X-Google-Smtp-Source: APXvYqwcv2iKNWBzmW6xpbxs7QP7I0kVxvLsIMZ9MSGwXwqDaAyBeeDhkf6dp3c6TQppZmZjMOeNnmx68BmhybQL44Y=
X-Received: by 2002:a37:813:: with SMTP id 19mr24965528qki.427.1567416933410;
 Mon, 02 Sep 2019 02:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <1564754931-13861-1-git-send-email-yannick.fertre@st.com> <50695b37-df51-08d6-a11e-99f9349aa481@st.com>
In-Reply-To: <50695b37-df51-08d6-a11e-99f9349aa481@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 2 Sep 2019 11:35:22 +0200
Message-ID: <CA+M3ks5GaN2-jEHO5-QGGkhYG2U-ExQR4=kNuk0jBxH2BkRGYQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: stm32: move ltdc pinctrl on stm32mp157a dk1 board
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ dri-devel mailing list

Le lun. 2 sept. 2019 =C3=A0 10:45, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> Hi Yannick,
>
> On 8/2/19 4:08 PM, Yannick Fertr=C3=A9 wrote:
> > The ltdc pinctrl must be in the display controller node and
> > not in the peripheral node (hdmi bridge).
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   arch/arm/boot/dts/stm32mp157a-dk1.dts | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/=
stm32mp157a-dk1.dts
> > index f3f0e37..1285cfc 100644
> > --- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
> > +++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> > @@ -99,9 +99,6 @@
> >               reset-gpios =3D <&gpioa 10 GPIO_ACTIVE_LOW>;
> >               interrupts =3D <1 IRQ_TYPE_EDGE_FALLING>;
> >               interrupt-parent =3D <&gpiog>;
> > -             pinctrl-names =3D "default", "sleep";
> > -             pinctrl-0 =3D <&ltdc_pins_a>;
> > -             pinctrl-1 =3D <&ltdc_pins_sleep_a>;
> >               status =3D "okay";
> >
> >               ports {
> > @@ -276,6 +273,9 @@
> >   };
> >
> >   &ltdc {
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&ltdc_pins_a>;
> > +     pinctrl-1 =3D <&ltdc_pins_sleep_a>;
>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
>
> Thanks
> Philippe :)
>
> >       status =3D "okay";
> >
> >       port {
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
