Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5F70DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 02:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbfGWANP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 20:13:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46206 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGWANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:13:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so23689005lfh.13;
        Mon, 22 Jul 2019 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LBMdeaTsY0pPgf4dXuXwZy/ZM28JIwMWj2aWUvIsuFk=;
        b=Ec3YSPyGQPGcAblGkEb1XPltApveiCEstIQFulsNWFASf0mlIpR36wujEZYYDZ6BBF
         6FpPT93wG+RJiqKn3r6U9VU4IpZs/HeyMEW+BqhHVJTGDiuHU7yKsqLpkBzcKYW1vl/T
         RcqQ+ucqs4ksSEiOzhrjle7763UugbNnk9hIMwIjREidkOMeZ5l1fFgk4YGTS/jqEFb9
         WVvOJYJqIBy1qZVHZNTCL/FsHVVxncFaz3dSOLawOUJgltcdyDPgJ/a+9jVxsKbjwAuh
         W5Yf36HovAgKArT1VSPfhOzP7/iNprMJTyTCaqSC8lhHDuw6JD8C/fd98uPowyIs2Ayz
         O4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LBMdeaTsY0pPgf4dXuXwZy/ZM28JIwMWj2aWUvIsuFk=;
        b=ujzlHqPoJzRvhWPNzlq+gJ9tyU1WQ3XEp4vris/oX6wHJg2lfbz11yxNqtzu67BEI6
         jx/emTVXpuxKQ5Yl4iNuApUVr1XcE2d8791jsA0Kn6qopw5YfFREg2c4nHgvOfY/ReUV
         ZHzn89xXFgSGsVOtLTrlYY4kPHsjT/QK91adUmr9M+mkTckqHDYezb0zp64rvPNBTh3Y
         H22lit/Mv8++0UNuyTu4NmnimTpYkkarWudAiUd65S2fjTiMUGM56CUUk7vNMJauW54q
         pVP8+7pGzEeMmljxMStOT5YW0o71YUcEWeM6uFFKkYrng6GzG84jYh1Sl3Vb/ps9s4dm
         8PeQ==
X-Gm-Message-State: APjAAAV711EyJWW39tvwWLZ0hDjZTjxxrnjNglaIp7BJHOpy4qeOb53f
        CJEoFeaqtnngFkPeSvTQUzTmADMn
X-Google-Smtp-Source: APXvYqzv2maXC6SAnxCYuJoQMqenoi1rUSc6zysEoErcQCtSYyXWKRfE09iUdPsEY+ahW3urwqy41Q==
X-Received: by 2002:a19:ca1e:: with SMTP id a30mr32634001lfg.163.1563840792040;
        Mon, 22 Jul 2019 17:13:12 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id p9sm7813053lji.107.2019.07.22.17.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 17:13:11 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clk: tegra: divider: Fix missing check for
 enable-bit on rate's recalculation
To:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190715173527.5719-1-digetx@gmail.com>
 <20190717200821.A77A120818@mail.kernel.org>
 <ca05abf7-1486-ceb7-91d6-266640eea69e@gmail.com>
 <20190722215554.DA23D21951@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2dca58c1-b44c-1396-6ede-22642d047b25@gmail.com>
Date:   Tue, 23 Jul 2019 03:13:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722215554.DA23D21951@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.07.2019 0:55, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-07-17 14:33:36)
>> 17.07.2019 23:08, Stephen Boyd пишет:
>>> Quoting Dmitry Osipenko (2019-07-15 10:35:26)
>>>> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
>>>> have any effect in that case.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>
>>> Any Fixes tags for these patches?
>>
>> I'm not aware of any actual bugs that this change fixes. Probably better
>> to just s/Fix/Add/ in the commit's title?
> 
> Sounds fine to me.
> 

Okay, I'll re-spin these patches.
