Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA21344EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 00:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfFMWEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 18:04:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37742 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfFMWEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:04:30 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so1423199iok.4;
        Thu, 13 Jun 2019 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4A1VKLp4InuPvidL/PhnRtNy/GSmXn5dBW09MD2/j28=;
        b=V4ISrfHfdHxjJg4qyZR/cv0K/vQdLrv7PiB6BEq9fihZ2L7ZF4lV2FCVMK2FkSBAMe
         WSOGEkxyO5Z8TOIijhMfb8QsH3wusIWnX9fnGFbw0kp7nXAReRMqjB81z0QtucLWXE3/
         aCGzGL/7hKpNbJmdZryXBat0xPgnjinr2DINxIOtAhiqFrp/l4mQvuR0vW4C3xctK5Bs
         8kNgzZ4yHh87Gnd2TZc2Jc2NnLbi3yRCG9/q2K15KAF4BU8TDo/DBE7IA6qRx2LphotL
         1UwljcZvCLy+IZ6qCTIG9yFPP98JLtv6qgSYZA08qIyQ56XJsQxNRsqDG3vRhlAnZn3R
         L4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4A1VKLp4InuPvidL/PhnRtNy/GSmXn5dBW09MD2/j28=;
        b=lpFtW0iGYWhkyUzOSOhxJw6+XkO04s8H2vIoJF+nT1MyuvcMXn+grDYHSS+u4KKt4L
         X9iJFBPN7BU3J0hKd3wuawHblzBsM2wEhTMgfVUPHNfv+4+Ew40yjp3582+LxmA2Mkkt
         ibIoPt0CTb899hpKJvZRIAvZ0jO6xjr2exDhTCNqGiqICAviYFD4tFhOKPvr/jhr12oR
         wxEIk3oIaFBDeYj93dmrfk+qKuv3JOP164V0UyI/44IWZpu9PgW4rlPGstoCSkx+iA9V
         lkc6f1LuxUwGF4ojvptzCRkh2nZKAlZJIo2L9rBdbNpPgasThYByuMvzFyv6OThpWuJ1
         jGvA==
X-Gm-Message-State: APjAAAXOZ28QIM+txqnR6npecSJMvHfN3Rn11ZmCHwGEPTWv5VHDQXva
        cHw44M8cIa8jdZin7VCowyh/Zyr6br/sApJFnMI=
X-Google-Smtp-Source: APXvYqztDmOkW+jqG1WkD80krHmOCUgrQyGdree4IeepxXtCNzdqLiKzXP8AP0xmbdu7/+mqkwcl9TIAfUCj8iLgp+A=
X-Received: by 2002:a6b:dc17:: with SMTP id s23mr2018020ioc.56.1560463469539;
 Thu, 13 Jun 2019 15:04:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:384b:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 15:04:28
 -0700 (PDT)
In-Reply-To: <20190613.141247.955308190761079084.davem@davemloft.net>
References: <20190527163253.27203-1-thuth@redhat.com> <20190613.141247.955308190761079084.davem@davemloft.net>
From:   Kjetil Oftedal <oftedal@gmail.com>
Date:   Fri, 14 Jun 2019 00:04:28 +0200
Message-ID: <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
To:     David Miller <davem@davemloft.net>
Cc:     thuth@redhat.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019, David Miller <davem@davemloft.net> wrote:
> From: Thomas Huth <thuth@redhat.com>
> Date: Mon, 27 May 2019 18:32:53 +0200
>
>> We already provide the LGPL-2.0 text in LICENSES/preferred/LGPL-2.0,
>> so there is no need for this additional copy here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Applied.
>

Shouldn't the SPDX license identifiers in in arch/sparc/lib be adjusted to
reflect the original intent of LGPL licensing?

-
Kjetil Oftedal
