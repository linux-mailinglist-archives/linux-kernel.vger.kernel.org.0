Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31ED318CF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfFAAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 20:31:25 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46350 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfFAAbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:31:25 -0400
Received: by mail-ua1-f65.google.com with SMTP id a95so4479225uaa.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 17:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Kd7/+kr4jxVkBeK6chb/uAQy3afbVih/qTqLzH6YXg=;
        b=fFR8Yoeaj7rQIWQWlq5wNouI2OAxcAVIV3ViDHmGepDRlaAgLcyqpr8Iz7xvqv9yY5
         KJmkoV7EiKoPljy47wPqBEY60yV3btg78qOiRyIpUHSX0g63rNFdXWGeuMwWQMMpOOh2
         a4i5ZjgFDQtwHDCayYIL8rsqq5gfw9tPM6UkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Kd7/+kr4jxVkBeK6chb/uAQy3afbVih/qTqLzH6YXg=;
        b=H2mRod2myLs+LWPHsQKgXmfC8NvMlXKDMbA26PIzX4sgGsoCHeyNo4yuqHkuYUoxCj
         QUToZsplgeddJqmOgsqcUkO5vxrKvVBjO53/pr3h98mwVpFjCx4i2ya6LE8WJ+Chot0B
         MTZmIRRTa5IQ1aHLG/YdmIlPXDDcV2tmv2jizFTVhvNHiqTIg1ZRFqgYz42xmxArO7Nb
         UkSFML21XuzAiGKeWYYNgt07IUjJc0F4Vv+8cUY/xSBprDCoW/+AMSmI9JcPGsETk3th
         F9DOGP0TfYPkly9UJhHSJqt2EDUgL5Ppw+TPT5Ne5rVhevaAjtccdgpQ/GqhgJBb915r
         Zetg==
X-Gm-Message-State: APjAAAUVSXCvUY1iUBF6EZXQ72C13YJ8y6n+A/mo7ratzxWIBJweLxZS
        wUMkyuSmM6ePvTzyOjFOIVdGYbQh/9I=
X-Google-Smtp-Source: APXvYqyyv9TAoEyO+7ZVWry+PL1bztSf5+cx607W2fLfy5OqGYigPZX3aExrPw5K69NIyGpPC/w/Zg==
X-Received: by 2002:ab0:4d67:: with SMTP id k39mr6956463uag.59.1559349084129;
        Fri, 31 May 2019 17:31:24 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id c3sm1066672vso.2.2019.05.31.17.31.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 17:31:22 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id l3so4375899uad.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 17:31:22 -0700 (PDT)
X-Received: by 2002:ab0:670c:: with SMTP id q12mr6641706uam.106.1559349081772;
 Fri, 31 May 2019 17:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190531030057.18328-1-bjorn.andersson@linaro.org>
 <20190531030057.18328-3-bjorn.andersson@linaro.org> <CAD=FV=V=_ozPiTvT-Fnrc1a+qfHYi3ynNn8cbw9ibqfKk7Am_w@mail.gmail.com>
 <20190601000917.GE25597@minitux>
In-Reply-To: <20190601000917.GE25597@minitux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 May 2019 17:31:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDtMgEeFsG9NxzsY1tEcCOTDShMe50J=5wNWQ095uejw@mail.gmail.com>
Message-ID: <CAD=FV=VDtMgEeFsG9NxzsY1tEcCOTDShMe50J=5wNWQ095uejw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] soc: qcom: Add AOSS QMP driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 31, 2019 at 5:09 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 31 May 15:24 PDT 2019, Doug Anderson wrote:
>
> > Hi,
> >
> > On Thu, May 30, 2019 at 8:01 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > +/**
> > > + * qmp_send() - send a message to the AOSS
> > > + * @qmp: qmp context
> > > + * @data: message to be sent
> > > + * @len: length of the message
> > > + *
> > > + * Transmit @data to AOSS and wait for the AOSS to acknowledge the message.
> > > + * @len must be a multiple of 4 and not longer than the mailbox size. Access is
> > > + * synchronized by this implementation.
> > > + *
> > > + * Return: 0 on success, negative errno on failure
> > > + */
> > > +static int qmp_send(struct qmp *qmp, const void *data, size_t len)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (WARN_ON(len + sizeof(u32) > qmp->size))
> > > +               return -EINVAL;
> > > +
> > > +       if (WARN_ON(len % sizeof(u32)))
> > > +               return -EINVAL;
> > > +
> > > +       mutex_lock(&qmp->tx_lock);
> > > +
> > > +       /* The message RAM only implements 32-bit accesses */
> > > +       __iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
> > > +                        data, len / sizeof(u32));
> > > +       writel(len, qmp->msgram + qmp->offset);
> > > +       qmp_kick(qmp);
> > > +
> > > +       ret = wait_event_interruptible_timeout(qmp->event,
> > > +                                              qmp_message_empty(qmp), HZ);
> > > +       if (!ret) {
> > > +               dev_err(qmp->dev, "ucore did not ack channel\n");
> > > +               ret = -ETIMEDOUT;
> > > +
> > > +               /* Clear message from buffer */
> > > +               writel(0, qmp->msgram + qmp->offset);
> > > +       } else {
> > > +               ret = 0;
> > > +       }
> >
> > Just like Vinod said in in v7, the "ret = 0" is redundant.
> >
>
> If the condition passed to wait_event_interruptible_timeout() evaluates
> true the remote side has consumed the message and ret will be 1. We end
> up in the else block (i.e. not timeout) and we want the function to
> return 0, so we set ret to 0.
>
> Please let me know if I'm reading this wrong.

Ah, it's me that's confused.  I missed the "!" on ret.  Maybe it'd be
less confusing if you did:

time_left = wait_event_interruptible_timeout(...)
if (!time_left)

Even though you _can_ use "ret", it's less confusing to use a
different variable since (often) ret is an error code.

Speaking of which: do you actually handle the case where you get an
interrupt?  Should the above just be wait_event_timeout()?
