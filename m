Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81214211F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 04:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfEQCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 22:17:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41353 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEQCRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:17:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so4837854lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 19:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXwn6qQiKsE/7bXRtPFAOmcUXx2LJhwM8N5rIl+lqZM=;
        b=epb6LwWIl4jMyysY/uQWtt/ktjigke6OGYLyGbgKekBewwzPRR+ms3oJwbzqNV8PBO
         4+RGQ+KOIpZloqknWaXo3iW/5Phz+Mq7U9apjgOBxpKz1O45JqWwDPwDtJpgddOmFYDw
         CgEuqiFXgh5kkAoKtLi2wdiVVQCDWRAvqlvLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXwn6qQiKsE/7bXRtPFAOmcUXx2LJhwM8N5rIl+lqZM=;
        b=Fp2piLfCWj7PCKcXtVkL2vZn46OHhN5j2sREMKAawm5tLn8AsWJyjZznJDRIHQQk7y
         OsESf7pPboQ1crEGThuDQPM2FGzmsixiTeUuJO+hS6UaF7TnOyCtMFQeOBj0cMqnsQmy
         toZyn9Yq1XGxhrpcew70pCc6Qu2vN5ZA1EmVIiYOcEV/qHnezOfgyCRQOi5thLisZIoQ
         50ileJu/fKBPRSqjHEzctyje259bsGi2hALcE9mTGJMksIxVnZJZPmEjxaR+KUefwvxo
         PpIBZR3L8mzmox/Mr4vxs4YwZg5OxNQWV0Qh2tBTiMC35FoZ0CfDhZ2kWDemCC9sgfLm
         IVUA==
X-Gm-Message-State: APjAAAW4cBpaXQLwYCO4+EMwu0BOW4PPXW/NVksuO7OG6/AAfyoAJ5TV
        L7YfntNr0DuMIp/0u/KZqncbidsjnDM=
X-Google-Smtp-Source: APXvYqy8d8BfPglA+RwYOPQTCRjXBW76JWD1JyVZKExe64rx7ognJkcXAMeFwtO7KJlcHTIZqIrc+A==
X-Received: by 2002:a2e:9d59:: with SMTP id y25mr20396860ljj.137.1558059454842;
        Thu, 16 May 2019 19:17:34 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s14sm73895lfp.87.2019.05.16.19.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 19:17:33 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id z5so4837760lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 19:17:33 -0700 (PDT)
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr4110865lji.189.1558059453268;
 Thu, 16 May 2019 19:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-5ac66c65-9c46-409c-a5fb-a6551bb206c5@palmer-si-x1e>
In-Reply-To: <mhng-5ac66c65-9c46-409c-a5fb-a6551bb206c5@palmer-si-x1e>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 19:17:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHtaVsbK4dZ79_h0R307Qv-Fdgdkp3SZ+F+QvzHHGrOQ@mail.gmail.com>
Message-ID: <CAHk-=wiHtaVsbK4dZ79_h0R307Qv-Fdgdkp3SZ+F+QvzHHGrOQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1 v2
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:27 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw1

Oh no no no.

You're creating a binary file from your build or something like that:

>  modules.builtin.modinfo                            | Bin 0 -> 46064 bytes

which is completely unacceptable.

I have no idea what you're doing, but this kind of "random garbage in
git commits" is not going to fly. And the fact that you're adding
random files really means that you are doing something *horribly*
wrong.

               Linus
