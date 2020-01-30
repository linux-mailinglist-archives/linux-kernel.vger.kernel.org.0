Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0316F14E63F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 00:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgA3X6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 18:58:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34406 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgA3X6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:58:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so2496463pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkEoSxiIFSIBmIjDJvwmwkDr10wCmUtM3ogvmSTNOOM=;
        b=Pbguk1VuKmMl8wfCRQpGeW4W+cBH2CF5Vhhdr902Zc3g2Rz1BP99zMAQCrH8hpXIOU
         JKiC13/sE5vdMdmhwLXNNATDIQS9qRv7VPTwY67yoEgtLxbBOed0go+Z/Nve6nYRAivJ
         XiPaMAiLz5mvPRgUC/aaTEIxt+thPN2/5pjaOW6H9yInzyJ2h7jasvXnZgTtmydNu4+n
         RmsB7U1Tgbos5+Zy71zDtuv16WVvCuzxMCfOAwo0YYNmB/sH+89cD4iz6LGQZl5bUdY2
         ih06b1SfkvKWZ2oVO0ZGp/q2ph64R64gr7/TrHpkY5JTQXVdcmRr7OoIli9md4twB5Su
         EVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkEoSxiIFSIBmIjDJvwmwkDr10wCmUtM3ogvmSTNOOM=;
        b=oMAk0nBTcdPLVyQkKfRqL3opSSqyP8NeTifUHuvOQsN2qGAvwGO9ZYXsO3DPRkiTn/
         bAsqDWiNpRaqfzZruFupZ6UCAwS6NyqbEd6JV9WmBTDLJc4PInC0R1gXk51tKsJPSYrH
         M3mHMt9CU/Oy/ygpw+piaCu/enEuXrt8lTgSlIbwJGFNSu6lQKWjwQoQ4wlvcl9ODFo6
         TCA2dvtle5WaKE6uxHce9HOZO+XAT448lsWswePF/nUfCozmNl3AvMMh2Ak96GrC0cPc
         7n5bhuf6ymNPLQBSdYisj/dVnnEt2E6SYcnHRYYONESHlBDk/6ZMasvQ6ctnvYxU5bd1
         M7IA==
X-Gm-Message-State: APjAAAWJeiQaAkdjiSwGZhgTv40cqkinctVjeO1tj2QAE+4IaSsSOo8h
        boyahwk+Alv19JBFzXwkouZlyJPex8487PMVy/+Nrg==
X-Google-Smtp-Source: APXvYqzixJ7GEdILtQGm5ko/4d0slKWLyxlOw1tHWdlu1yS2Pq+DANtjshTj5j/hy/mTVP89HWl6HEKm7y9NdPDWacA=
X-Received: by 2002:a63:1d5f:: with SMTP id d31mr7432066pgm.159.1580428682829;
 Thu, 30 Jan 2020 15:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20200130192129.2677-1-krzk@kernel.org>
In-Reply-To: <20200130192129.2677-1-krzk@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 30 Jan 2020 15:57:51 -0800
Message-ID: <CAMo8BfJiC1O18+9AXCwPk-+AMd7c5Jc-xUZv17tfcD-zstPNFQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: configs: Cleanup old Kconfig IO scheduler options
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:21 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
> commit f382fb0bcef4 ("block: remove legacy IO schedulers").
>
> The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
> now enabled by default (along with MQ_IOSCHED_KYBER).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/xtensa/configs/audio_kc705_defconfig   | 2 --
>  arch/xtensa/configs/cadence_csp_defconfig   | 2 --
>  arch/xtensa/configs/generic_kc705_defconfig | 2 --
>  arch/xtensa/configs/iss_defconfig           | 2 --
>  arch/xtensa/configs/nommu_kc705_defconfig   | 2 --
>  arch/xtensa/configs/smp_lx200_defconfig     | 2 --
>  6 files changed, 12 deletions(-)

Thanks, applied to my xtensa tree.

-- Max
