Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1852ADCD99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbfJRSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 14:10:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41034 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJRSK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:10:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id g81so5964231oib.8;
        Fri, 18 Oct 2019 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWo85hzC3rFDGBh+qfuz6zjPF4f2jpRFQQPWDuhwYqs=;
        b=AUDeot5sdk8RXpqa2rRBSsuSmgFYWqs4lpAV51+6KaztZ2cT8TxjYsmYUF0t+KLaws
         MyMhetN8cI7rdsro2aCR1NACcoyC3E90+149x4CJrHprRW//SMJFooy5OWzUwo+Gc3X3
         mvEGoOI6/3weRp7A8SxaVTEyl7vsLYU5a49cDY4zzu53bLRVpDpyQSFtIWfZIgFcwDtL
         7srgiyNKud5QR/upaeFGc+LTNl10WIdL/wcn22Gz5u6hp6Y+n/pHoDWNWxf30s2enTB6
         d9EasecpycxXWpiBvYl6h8Z2TPNZ5755OAWiV0nPmPlN+FJX0VW/sfrkpwPiWeccacxg
         R0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWo85hzC3rFDGBh+qfuz6zjPF4f2jpRFQQPWDuhwYqs=;
        b=C7uTPNGO4qGk2E62QKxz7mJECIpH+S+tqNlMsWNEyBon2e/qhZD4cp2EqZgXjPUyAI
         HgF8TmxO/qjojALsLDoMoyVmYy8OfS6Q+kKt1rKN94sCyt+GsmEls+3k3W6ZMDDTJM/h
         ZrwRur6wXXma6dl+tkHC7MBok5YpeyiMDjqBtm+BQXlbi2OQfaqQ+zxW4V7YPZX0i+Wg
         1qsoj8ZvrUT2KUQj6JO5FhZPF++cobcJ36I2ShRwY5SlvuMbRD1l/F8sdpYxX+vazKoU
         PB8oVVHG5fJ129yGickpAGcnje8W3Q4RsCy+knqVifCJR2ATs57UdHjCQa3gjTruG/O8
         kE3w==
X-Gm-Message-State: APjAAAXWoAsu7IoPirSBYcabFaSCWa//cogMr7IubJamQMezT2EHuqM9
        aa4XtvYqlIENQ9dNFS8l1AdAa2P3CMw4tV4HymFhIZT0cUyJwA==
X-Google-Smtp-Source: APXvYqwEibktI+IxVNP8RRKtYl//H8Q1mpai1qab+3Ui3eiyhRWcHSzDlv+gK9gKLi9CwTMnjb/N6KWMP6Cc/KSQGW8=
X-Received: by 2002:a05:6808:87:: with SMTP id s7mr9359708oic.47.1571422255246;
 Fri, 18 Oct 2019 11:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
 <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com>
 <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com>
 <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
 <1jwode9lba.fsf@starbuckisacylon.baylibre.com> <CANAwSgSoK4X3_QbO3YpZRXNTpPJ+zVeid=w93f14Eyk8Dd32EQ@mail.gmail.com>
In-Reply-To: <CANAwSgSoK4X3_QbO3YpZRXNTpPJ+zVeid=w93f14Eyk8Dd32EQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Oct 2019 20:10:43 +0200
Message-ID: <CAFBinCBdwqxA2kLMAA9gtOcXevYK-J4x12odHwpQOAWakgWiEg@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Fri, Oct 18, 2019 at 4:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > Next step it to try narrow down the clock causing the issue.
> > Remove clk_ignore_unused from the command line and add CLK_INGORE_UNUSED
> > to the flag of some clocks your clock controller (g12a I think) until
> >
> > The peripheral clock gates already have this flag (something we should
> > fix someday) so don't bother looking there.
> >
> > Most likely the source of the pwm is getting disabled between the
> > late_init call and the probe of the PWM module. Since the pwm is already
> > active (w/o a driver), gating the clock source shuts dowm the power to
> > the cores.
> >
> > Looking a the possible inputs in pwm driver, I'd bet on fdiv4.
> >
>
> I had give this above steps a try but with little success.
> I am still looking into this much close.
it's not clear to me if you have only tested with the PWM and/or
FCLK_DIV4 clocks. can you please describe what you have tested so far?

for reference - my way of debugging this in the past was:
1. add some printks to clk_disable_unused_subtree (right after the
clk_core_is_enabled check) to see which clocks are being disabled
2. add CLK_IGNORE_UNUSED or CLK_IS_CRITICAL to the clocks which are
being disabled based on the information from step #1
3. (at some point I had a working kernel with lots of clocks with
CLK_IGNORE_UNUSED/CLK_IS_CRITICAL)
4. start dropping the CLK_IGNORE_UNUSED/CLK_IS_CRITICAL flags again
until you have traced it down to the clocks that are the actual issue
(so far I always had only one clock which caused issues, but it may be
multiple)
5. investigate (and/or ask on the mailing list, Amlogic developers are
reading the mails here as well) for the few clocks from step #4

> Well I am not the expert in clk or bus configuration.
> but after looking into the datasheet of for clk configuration
> I found some bus are not configured correctly.
did you find any reason which indicates that the problem is related to a bus?
the issues I had were due to clocks not being assigned to their
consumers in .dts - that can be anything (from a bus to something
different).


Martin
