Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A4015D0D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 05:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgBNEFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 23:05:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45038 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgBNEFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:05:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so7864491otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sn4bMSFgKGNC4Gr+AMrvlK002u6brQw4ngrFt1iH2VU=;
        b=yyCesyl6BuSTLYF6201FSZmcpQy7F4CUIyh77rzsAC+SLsu7qtefl2ET5LrX1cSiBA
         laoVLfkmmS4RXv9DQ3Qg2fqaz/51nLSLQOkb3knowvE1u7B6iH0ga/WLGNxaHHkOCHoV
         cShuwJlRy4QcJaN2UtOlzrZ2PWwy3ZlIiQI+5g76wCCA4m7Y7KPYTzgxlewsw/uKxnJJ
         P0wOXIKjDV4cXBLPOYoIUaSV6tyxR2+KeyQUnb/ZmZgWRoAuXVleHlK/BhpC1QewkqCD
         hUxnusFs+RwVGtYIrCAtRXNGLgO0AekDsQygH2KLHwB2A7p1TAaL1XpomZ8JdWTXpSko
         uLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sn4bMSFgKGNC4Gr+AMrvlK002u6brQw4ngrFt1iH2VU=;
        b=lQBvuOZkox7/M2VU0ZvLwzddtJ3lkhCP9wXqyp4f6AG5radD2yXPXQwtlu6jVDQaYe
         hXq/NYaJmrsnnYPy7m8l7U8TM7CUNGFE3ZpwnerKEJQZfyWev57ZqvrTrlZiclJBksRd
         gAgtAPxiXoEMt2wEB9NbxwwgtEDXJ6xNeiIN4YkEiwV8Z1DoUcFNOeOkut0LZ1zJQ0TM
         +TdNfkIeTElDYz584UFLTJdTqdjXia7A/tXGtHElyVEuQaFp2vqubNUEKcunzF7NfMcZ
         kcElS6M6hZyUBIOu761CsTHuF1SYDI5+C6OJVP5z9piEsiqUjFrO3W3A0Hl6zBRMbZOb
         0I7g==
X-Gm-Message-State: APjAAAVGMZoo17R8nYg8t+HboLgdZfGlFxylfQf7FoGbSgPvLYDYRzgS
        wUq+HCOB2CVTUvai9YRbLvpLqoPZhVBrVxinh6RPajiLdIw=
X-Google-Smtp-Source: APXvYqx9pjGF4udxe4xSGSF+CBjS/GwdhBXB94dfU7P4DTxLms3xkZ/OAyQpT0WO+V01GD6u1Y1ueGNfUqKxW37i//4=
X-Received: by 2002:a05:6830:1094:: with SMTP id y20mr716696oto.12.1581653116335;
 Thu, 13 Feb 2020 20:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20200214004413.12450-1-john.stultz@linaro.org> <20200214021922.GO1443@yoga>
In-Reply-To: <20200214021922.GO1443@yoga>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 13 Feb 2020 20:05:05 -0800
Message-ID: <CALAqxLWSXGQ0eD-1cxdB-mkJkyySRLo2MqZ4Y0YokhSZJJ6f-g@mail.gmail.com>
Subject: Re: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 6:19 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> The purpose of 25b4e70dcce9 ("driver core: allow stopping deferred probe
> after init") is to ensure that when the kernel boots with a DeviceTree
> blob that references a resource (power-domain in this case) that either
> hasn't been compiled in, or simply doesn't exist yet, it should continue
> to boot - under the assumption that these resources probably aren't
> needed to provide a functional system.
>
> I don't think your patch maintains this behavior, because when userspace
> kicks in and load kernel modules during the first two minutes they will
> all end up in the probe deferral list. Past two minutes any event that
> registers a new driver (i.e. manual intervention) will kick of a new
> wave of probing, which will now continue as expected, ignoring any
> power-domains that is yet to be probed (either because they don't exist
> or they are further down the probe deferral list).

Hmm. I'll have to look at that again. I worry the logic is overloaded
a bit, because the logic in __driver_deferred_probe_check_state() will
only return -EPROBE_DEFER before late_initcall otherwise it returns
-ETIMEDOUT or 0.  So if we call__genpd_dev_pm_attach() after
late_initcall and the pd isn't ready, the driver probe will fail
permanently and not function.

I'd think in the case you describe (correct me if I'm misunderstanding
you), modules that load in the first two minutes would hit
EPROBE_DEFER only if a dependency is missing, and will continue to try
to probe next round. But once the two minutes are up, they will catch
ETIMEDOUT and fail permanently.

> You can improve the situation somewhat by calling
> driver_deferred_probe_trigger() in your
> deferred_initcall_done_work_func(), to remove the need for human
> intervention. But the outcome will still depend on the order in
> deferred_probe_active_list.

Ok. I'll take a look at that.

Thanks so much for the feedback!
-john
