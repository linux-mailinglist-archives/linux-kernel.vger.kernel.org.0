Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6550C1822B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgCKTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:45:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46297 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgCKTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:45:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so3366092oth.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oV6RDMEr0DsUD3DHB/8n4G2/2iDeZ0eLNZSWiNXyaYM=;
        b=xKbtf0BnQk2BwtdQKQs7iuKaaF2pVL9Zhrk9eB97r+Pw62Z0Mc0PJJEGVcj1qQO3+c
         2Ah6Uc0wfIAHqSse+Qtuy4aRzHAuGHtrw8F0AlY2s7cXDuKS/wgq4uDY2EhpjwALHi6Q
         T+Teel11DLCqp0DOeJ7tN2MxihFchjCh/SpxspvF+0YxSE56L2eexVX762pccmO1/yml
         FrN04tjCQ8Ai7F5iTk4XZIcci6KQsJ6SYMFLHuAQna7AX0Hw+FOeJpjZcqnHvioYooe7
         t24RVM7ZnnyLImbtmRaUdiK6Q62zjDnJR+5IdY+f/atp2UdHwvCeIoGDSRPY3y1wQwsj
         /ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oV6RDMEr0DsUD3DHB/8n4G2/2iDeZ0eLNZSWiNXyaYM=;
        b=FcLO92B/32NbgFhvnpF9Rb/tbr/oqsLG7J1tTX91yDvSBZkEqDVwDuzXOqwo27MeT6
         5br2/I+/V/1V1ckw/Pm2cwzL5CLGgV6wSQVCaelRmSpBSJP0teYsz3tmeFpRls1wMuDh
         VDsaxCh+rlXBYlXjRfE6OOLugasXPvpWg0q4NUoz/PIF99sjMJBPyl35bkUTL82HKigI
         eV1a8sdX4jWLZAVdAyYVioeVvCgdevM8GZdfg2hn6WjfFgVOIkzS+nNlbsURtS4VuN0x
         EQw3Xn6gtrbBGVgvJj6nfNrPLLuQuUYvF23to9DT2CXMuo7yngxFDpaGY5u8J1HKOM/t
         mthQ==
X-Gm-Message-State: ANhLgQ0N/t/AotX8S5rbAfsEuCbLlugQgMUThqczDhcfQX04g3/xPJkc
        ROqB0llvYiSeGVrdfnNbR66uvmdyMs6atTysm/jpGg==
X-Google-Smtp-Source: ADFU+vuiGPlZRPXW6M5wIKU0EkZlFtqjjR8FoEm6ZPVcrHo0mOHeyQGIqaYDMzGR9l74VwCe9fS+4J5P7I3NGcElo48=
X-Received: by 2002:a4a:9e15:: with SMTP id t21mr1447319ook.70.1583955904880;
 Wed, 11 Mar 2020 12:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200311172109.45134-1-john.stultz@linaro.org>
 <20200311172109.45134-2-john.stultz@linaro.org> <7337bea7-1449-e6e3-4c65-1bb802a2c316@linaro.org>
In-Reply-To: <7337bea7-1449-e6e3-4c65-1bb802a2c316@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 11 Mar 2020 12:44:54 -0700
Message-ID: <CALAqxLXEZQnH3a8z9CGf52VUbb-ZHX-R78DPM1psJhV9_bs35g@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 1/6] usb: dwc3: Registering a role switch in
 the DRD code.
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:17 PM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> > +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
>
> @bjorn found an API change that explodes this one.
>
> Fixed here: https://lkml.org/lkml/2020/3/11/1034

Huh. I wonder why I don't see that causing trouble in my testing.  :/

Oddly, trying to use your patch results in build failures for me... Is
the api change something in -next?

thanks
-john
