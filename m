Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA7E9765
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 08:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ3HvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 03:51:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46268 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJ3HvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:51:10 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so1378461ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Okxu6w7d4kBEnS57vDGxuBMtTFr/mHU/UQyaytadsfQ=;
        b=kUuKbEvdPYa8fNHrYpYzmh661dxQFL12J2F+lmIBu+SvW4hPvpShVqFU/P2uzbP78t
         n0h2SHxycr/3suv4MqTl6/dlMQa3uzgH4eE3QHfVQ2Z6looWnk6nuEsLAXwT1/sqVLLV
         yKFQgR/sZ38yg6LyVW2sfC6bY4gICvdIrJFY3SxsG/ciVKAoD9AMxt3gdkl9bOC4rPrY
         y31ohXOENkruOwnmerGEYq8LTppuEiFsPz8UQEM1eQGfC1+HRueLp+SBMeWopZht/GVh
         Cc2gW/PY4RzU5dE5LnNI1dF0zgyuxu8fiAUZp43X+9Tnqbvgu40fRVdF6u0qv3fHCGll
         TMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Okxu6w7d4kBEnS57vDGxuBMtTFr/mHU/UQyaytadsfQ=;
        b=FEGFuJbq8RVn+hty3Lnq1Z2Ida6Ccht/PqVwLK6lvpAUk3ExQuDNfF7JEMsgz6aXJy
         +qToNCGfq61e233TsaohFiGpT5e5eOALZFuiLSbLyYaRWA2kb3fLk1FryLoTG057Sfbf
         3v8xHz0IYdMwGCnipQCM5gMkKwh6uIUzuk3lTs9GlYr822k0VMyizgQroWffds0q7s1X
         wQFAlkrXMSOh5UstRLsmmGjVXl3fq2/f+D5dbEIIhHCjJ/Sao9wBbV2ogYTbEUMtUOsS
         pROVsgCuHIf7DvHahWRibTrnQ1koXyTTtCNpo7k2xDRFTHatePTK2QZP8WmOuNFEtJfz
         vCHg==
X-Gm-Message-State: APjAAAW4HVh4+IHy+uy7TiGGXXdlM547s1jBWSC3uNY1vfWvs4a3+i2n
        70RHzKtmeaieOZvsvK3hes2LpbBqWBKwO4IuaoDdXQ==
X-Google-Smtp-Source: APXvYqw040kXjM0AEAMRYxUnnP87MHXu0hAc+Mw5N68WNHfPkVsJsZmP572K6iWlZz7YD9yv0sX0W4DXPrEEAQ0O2Us=
X-Received: by 2002:a02:c98c:: with SMTP id b12mr10674967jap.40.1572421868447;
 Wed, 30 Oct 2019 00:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <20191018211214.444D32089C@mail.kernel.org> <20191021022516.gecunkpahu7okvm5@vireshk-i7>
 <20191028120133.3E85F2086D@mail.kernel.org>
In-Reply-To: <20191028120133.3E85F2086D@mail.kernel.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 30 Oct 2019 13:20:56 +0530
Message-ID: <CAKohpo=ky8FR4thsuW1xPnZrEW8zgXL0n4e+9rkRE0RLKKk1uQ@mail.gmail.com>
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 at 17:31, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Viresh Kumar (2019-10-20 19:25:16)

> Some static OPP is removed at the same time that this function is
> called?

Hmm, not just this line but yeah this can be racy in principle though
not in practice.
As both addition and removal of the static OPPs happen from the same
driver, like
during cpufreq registration and unregistration.

> Right. I don't understand why the count reaches 0 if we can still get a
> pointer to something. I guess we've got this kref thing that has a
> lifetime beyond the life of what it's tracking, which is weird.

Something is weird here for sure as the kref is not protecting a
specific object here.
Maybe we should use a simple counter protected with opp-table lock here.

> Usually
> the kref is embedded inside the pointer that is returned by the "get"
> call, but here it's outside it and used to track when we should free
> static OPPs.

> Why are we removing static OPPs? Shouldn't they just stick
> around forever until the device is deleted vs. populated over and over
> again?

Because the only use of the static OPPs is gone and so freeing them is the
right thing to do. Also, it is possible in principle to change the supported-hw
values after removing the cpufreq driver and adding it back, which means
it is possible to get a new set of OPPs.

--
viresh
