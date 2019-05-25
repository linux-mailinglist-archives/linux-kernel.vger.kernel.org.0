Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094092A218
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 02:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEYAWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 20:22:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44204 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfEYAWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:22:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so5867827pgp.11;
        Fri, 24 May 2019 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7MZFVL6BQOoEldIxODirdsUOwMtCHcXwhPVYVkRjlWA=;
        b=U3fzjaiN70Tkffyo7D37fJ/8//S148cw2r1qtvNaX3GvGQ+gtdl4yOP0L7Yo8sy0D8
         +C/xQyb/jdXwEx9FUve4BUfVoE/Goi3sMQ3fph8MFjahikqLvCb9oqAdinl1D5bINwFS
         /8nnjA9yq5x9HcXSH4reh7I2GSNiZfEL8sWTg3Ocf+BxeqqAq6TzUApx04xO6TxmgSk8
         viTrnR7HLQw+L6VSaj+5gxoComeTXKD5YfngAL4H6GlURrrfOupGh9FZa7aP4Q15X3eh
         qmqQXyirjn3TPOOIOdO9RStQiDp/e9uu+1d/A+Fk45qZ9ISnSW1lwyvYdUc8UxWNBrIC
         WDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7MZFVL6BQOoEldIxODirdsUOwMtCHcXwhPVYVkRjlWA=;
        b=dVh9DH7BxxvQewvqUrTi4cFVgg9Q62JV57aAugLEOWsIi54nuzcUZM7Bo8iuVcndju
         A/T5bqIg9sseY+X4MxmqJ9Hbq4IsVsWTM5SoYlwIoWTAHNI4IQPLP17Qw0gdXVCDbrpI
         FBEpQWmuBnFOwuvbjHxBc3H+to+1gO1SF3A8xAvBXs/B/BV8Xy2Wlw5EDgYihdsheyw9
         HExEpDcP1M1oULDedGbH1wGa7SZGBQBMOY5rI1audxnbECojluyupNsvjKVufg6ur1e0
         Q4YimG+xgBgGUy04VJNuHv8ouQKnF2EzguuRokaMTqLFH+/snCimxxsSPd+tkhOYI448
         2JoA==
X-Gm-Message-State: APjAAAXePglFrDEbyHD1N9n7RKf8MIITzx3qUAQ5rNi6pqWkb9WXH42a
        DuPttujYC/Pus7RzCqI3NVnPSYkr
X-Google-Smtp-Source: APXvYqyDNBrKpadgNtJa1k0AdKOxS6UC831LZTk4NOZNI9cSfDeSuhRNM1nbsMxhKNERdbGyg7ZmLA==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr6546603pgo.335.1558743768695;
        Fri, 24 May 2019 17:22:48 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e184sm5689646pfa.169.2019.05.24.17.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 17:22:48 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6d3995c1-e1e7-35ff-d091-501822c97ecd@gmail.com>
Date:   Fri, 24 May 2019 17:22:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 2:53 PM, Saravana Kannan wrote:
> On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/23/19 6:01 PM, Saravana Kannan wrote:

< snip >

>> Another flaw with this method is that existing device trees
>> will be broken after the kernel is modified, because existing
>> device trees do not have the depends-on property.  This breaks
>> the devicetree compatibility rules.
> 
> This is 100% not true with the current implementation. I actually
> tested this. This is fully backwards compatible. That's another reason
> for adding depends-on and going by just what it says. The existing
> bindings were never meant to describe only mandatory dependencies. So
> using them as such is what would break backwards compatibility.

Are you saying that an existing, already compiled, devicetree (an FDT)
can be used to boot a new kernel that has implemented this patch set?

The new kernel will boot with the existing FDT that does not have
any depends-on properties?

-Frank
