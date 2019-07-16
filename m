Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8066A146
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfGPEQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 00:16:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46845 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfGPEQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:16:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so19516114ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWizBVxKl11u9zZiCQ2bgnUadptHwCxpkPEjb6InLlM=;
        b=Y2+eRFTFLkVWKoQou0f/DY8g8pcZFhms1URLBnrzoFkschHi9zOPZjuQmvbenc7+yv
         IyFVzLybu3DLX6Gc+3FwcnW5nG1wuIa5+AMQ0Wzzxlc/CpXA/jj9gs/h/arV4Oa/hdwJ
         Qt8HLGn3KFNkx/CqyUhEWBJnttDVm/+LSa67mEdFvdnPnQ+CA0Ndriu4nm5UUjhdVAhO
         a2eYWBsxQTgyaDxZddmmBUpDvu5Bi71ihgLHI6Ogt1xrjuFEwu50m1Q7YaPpZfcat/c5
         pu7BUO2c3H3I3Ysw9d4aJZc/2OZl0S5QTEJZX4nHJmBIfQ6nN7FI4qWdS4TC9sLiAvj+
         imlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWizBVxKl11u9zZiCQ2bgnUadptHwCxpkPEjb6InLlM=;
        b=bVC7JeQNTMEdXWMvYZkjd9Yor+CeiH7KiXbPaqLtq8AVmRaPI4xdls+NaMY4pc50/S
         Rzw+k1iJ0tMe61Eu0g1tabQQVnxwyMCrcDf9m9orVtMkd1gmOzn4t4c4qx8f1c05IQT+
         UuUk5b4jDbBBmEGSK4HUsn3K0yXjmqINRlrRLTWQaAVXk8UvG+Npd4aTyEQZr96Vk6ro
         Rffls4/kgJJZxkA2wg8T+sHK2ZhfzmwZFQnICOyMPWfz5yps36U/ruio653Mdblbx0et
         EN8GlvN/4l8sq2NURQwWphIhXlagvvNwmSBpt+PND2CAG9EwQwFpKlVhhGeHa4eFkqOS
         SYug==
X-Gm-Message-State: APjAAAVNLkE53JuhMdIBTvAYe3eo0IxdWKwnLdSMlj8aq1eyo4YSuUJp
        RUcwLm/kTjZYwz9B7ezPAdSh7j6rRSN8P+6Fnc8=
X-Google-Smtp-Source: APXvYqyK2Xi/JdxAp2QpiPvoM5uHa1C+X0zxzxzfXfUABgGl7k9/nlUlSqolurCEvEYDE4bg4f5gRo1ve0ATwxIKpV0=
X-Received: by 2002:a9d:1718:: with SMTP id i24mr22110399ota.269.1563250593815;
 Mon, 15 Jul 2019 21:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190715203651.GA7513@kroah.com> <20190715214348.81865-1-trong@android.com>
 <CAJZ5v0gEzZkbeLFtW5yadwxBryvL3vWcUoQTkUy3VkxiTV+UrA@mail.gmail.com> <20190716021102.GA8310@kroah.com>
In-Reply-To: <20190716021102.GA8310@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 16 Jul 2019 13:16:22 +0900
Message-ID: <CANA+-vA_rgqEKKXsSEUBYwHLWoCJrPa1szjvLntHV0YeA6Qfkg@mail.gmail.com>
Subject: Re: [PATCH v4] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>, kaleshsingh@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 11:48:27PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 15, 2019 at 11:44 PM Tri Vo <trong@android.com> wrote:
> > >
> > > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > > blocking wakeup sources over device's boot cycle. This information can
> > > then be used (1) for power-specific bug reporting and (2) towards
> > > attributing battery consumption to specific processes over a period of
> > > time.
> > >
> > > However, debugfs doesn't have stable ABI. For this reason, create a
> > > 'struct device' to expose wakeup sources statistics in sysfs under
> > > /sys/class/wakeup/<name>/.
> > >
> > > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > > source statistics in sysfs.
> >
> > I'm not sure if this is really needed, but I'll let Greg decide.
>
> You are right.  Having zillions of config options is a pain, who is
> going to turn this off?
>
> But we can always remove the option before 5.4-rc1, so I'll take this
> as-is for now :)
>
> > Apart from this
> >
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> thanks for the review!  I'll wait for 5.3-rc1 to come out before adding
> this to my tree.

Greg, Rafael, thanks for taking the time to review this patch!
