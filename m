Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F30138821
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgALUBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 15:01:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34220 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbgALUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 15:01:43 -0500
Received: by mail-il1-f196.google.com with SMTP id s15so6159669iln.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 12:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vltSl3yoS/o4Pj3eivfuysNtj4INdjuW6Z4PNbKDFMw=;
        b=kVUKzsKNr/UN1LgzbrH3VmkkKF/GgSjl47zvtaJVSsJ4ANthVbnW21/egA78M/fnrl
         IfpicMsnXfcbxwEqpieyIAu8rZRsUkSQRo/OPoNmBXJgds0yfPDiduhz+VPWjSk+tw4S
         dYJ4Iug6HP0lwCjKdXgp0ltM2EaGfFIhJlSMu3sjA13JJMNDfovRQT0axtVMsKmy7QeG
         97lJNUoTmoQFhyrPZb5ZJHgZF4Tw67Kd0VGatq8d7xoZCL9rnyXYoLYrTLM+LRVDbrrn
         BI7LN23YdH7gkAhLbb4SXaSD+V+WoL4rQIyWhZfvMuQ14H4G79pr3EyrPWvHL2bNFpYt
         r1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vltSl3yoS/o4Pj3eivfuysNtj4INdjuW6Z4PNbKDFMw=;
        b=YqTPaSHjUR4Cs9h/EVEIou5krlJwkXAq2S9BzzOuyQ8Tt+lvjH6xi6STbQhte+HSgM
         GC8kWJOPyUZtWoupW0KWiFMyPNoPzD9F9tgLGjFBVhliIVYkwdL1rjAHG31p4vhxZGyc
         nBqWvJfHmMpKN9CSbgAntP39blPeGAzn/Ubt/rjWaYIbOgSr2jBbeGESCOhE3+h8x6Mj
         EoHdhYgOwLGbrLxBvvzdON6Nt4Sn7YBPRKVGr6admKPViCcIAXH689x9EQ/dORarI/k9
         8YmmSssPQTGPlZQK3ElL5q1/GnIgGTB0txsUVy5MqKU81kSIOePU48FaIF4Tf8vUHDhY
         Pepg==
X-Gm-Message-State: APjAAAWJtH/dXyXoFpK0HfZFWZaSWhNQNLpVueLiEJ/bT8baaT3+Q7hf
        DGkBOhDRFfWaB1s6C0LyWfg20RPcFtyIwmQMdN6Qxw==
X-Google-Smtp-Source: APXvYqxhD0AB5i0ZIFt3OAw1DMt1N8WD3Cw6RX5iRKqkktFYUteW/DA4rDMoJZRrtrEqDiSmAxbWzcBPtQpncRxq5eM=
X-Received: by 2002:a92:afc5:: with SMTP id v66mr11073775ill.123.1578859303168;
 Sun, 12 Jan 2020 12:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20200113065622.15eb3c87@canb.auug.org.au>
In-Reply-To: <20200113065622.15eb3c87@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 12 Jan 2020 12:01:32 -0800
Message-ID: <CAOesGMjZQTjos9fU52zsrKFZj9LVE3oUXQFpjJov3-dBD0cT+w@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Sun, Jan 12, 2020 at 11:56 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> n commit
>
>   0ff15a86d0c5 ("ARM: dts: stm32: Add power-supply for DSI panel on stm32f469-disco")
>
> Fixes tag
>
>   Fixes: 18c8866266 ("ARM: dts: stm32: Add display support on stm32f469-disco")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
>
> Also, please keep the commit message tags together.

Thanks for the report, we'll keep an eye out for these formatting
tweaks in the future.

Alexandre; no respin needed to fix this IMHO, just something to keep in mind.

-Olof
