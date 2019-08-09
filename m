Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54FC87D5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436513AbfHIO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 10:58:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38185 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfHIO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:58:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so92351573ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ79CBhMDIhtKzgrhUSC7BKhFfOf6yzxvY2SkaGMD4Y=;
        b=Oh52Z0B4cOeDMgLkKxUqnuGS0w6pgwce3U8a9vkzc92zVpe3zOIVq9Oi31EJUTLtPB
         bR9eHnHD/adCL0PKJbib2/6tpHK4ChviyeoCOlqipWsmEXUnj/zGoCTBddZ3p+RojWFX
         EWRtFXYLmgEUWTIfpXtL8dE10JVsjo8UqA0wCm3TZY7ssOFknnyQFyJzXbD40gLwsgr2
         MVa7EkfyLea0Und1pk+zG2duUrIYVri7Amad6Va/x2dBJw0b3kqzdcfNLKEooRgL4L6q
         xnqDmHv2FObOdT6LL26fJ5gHrRjmraZZ4NjYvEE2eBSwSAO0MW0mBqqH6Bxin0O51XtP
         WrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ79CBhMDIhtKzgrhUSC7BKhFfOf6yzxvY2SkaGMD4Y=;
        b=YBS4C4QLBchBryBhC8U3cHLylC3C1+wjRxv48vFadGpe4uVGijHEFctRbOwjNVrZ1V
         hK2Hz5+aKV7IIiuFpESKqgR42biz9e2iZcaLTdyfz+JBYUEmG+V59ytYa8o6ZCYgR1pJ
         kZPoW106zvNlGN5gtIGNxJFNWMzML7OjWVYYyTbdfSySqB0SE7R31C+L0Lpwq/YI2MAU
         HwjETrUD90tHu4/NDtRKgHfUVnk2RD4c/j1HA5hVOo9uDO6AnCPgT46wrA9m2Xileeds
         oshTUPNakUwsUF4oZ817zxKByAF7ZYwVVclUomqNoOKmPhrrAeKKR8inPHtANhmMYQSK
         M+WA==
X-Gm-Message-State: APjAAAW4cv+shR4s+1bj2D26q24YLdpjAvtMnPrHTUlVKeYVqEmYPqq8
        CcAIHSoPlgMV2+WtqWFvkP6j2udtSUQyqLwjluljPg==
X-Google-Smtp-Source: APXvYqzerGx5RsOp4Z3weTStcMMI3L80O7NI5k3kmCM7TXmgoNyXkF59MeBKfKnBTkB/1mrmgHHLsFAGFwbZbPWIOok=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr11430718ljh.149.1565362691877;
 Fri, 09 Aug 2019 07:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190809072415.29305-1-naresh.kamboju@linaro.org>
 <0a0e0563-aba7-e59c-1fbd-547126d404ed@redhat.com> <CA+G9fYt4QPjHtyoZUfe_tv+uT6yybHehymuDWBFHL-QH3K-PxA@mail.gmail.com>
 <28a9ac44-7ae2-7892-4e68-59245b6dc27b@redhat.com>
In-Reply-To: <28a9ac44-7ae2-7892-4e68-59245b6dc27b@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 20:28:00 +0530
Message-ID: <CA+G9fYuJV8GshJSeNKqiLNOn936AyRaocyXYUvgE+QfNU9Zhvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests: kvm: Adding config fragments
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        sean.j.christopherson@intel.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 at 15:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/08/19 09:53, Naresh Kamboju wrote:
> >> I think this is more complicated without a real benefit, so I'll merge v2.
> > With the recent changes to 'kselftest-merge' nested configs also get merged.
> > Please refer this below commit for more details.
>
> Sure---both v2 and v3 work but this one adds more config files with
> little benefit.

I vote for v3.
Because  x86_64/config have its own specific configs now.
No objections and no questions will be asked from other architecture guys.

- Naresh

>
> Paolo
