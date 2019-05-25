Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428DB2A5BC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEYRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 13:09:39 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:34389 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfEYRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:09:38 -0400
Received: by mail-lf1-f42.google.com with SMTP id v18so9292454lfi.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ink6tdpfa9FrEwBdLArsv4qZyUiZrqIcUZxDK9FC2vI=;
        b=Ds5mxIVVkkDaiO0G4morahNnZq3g/ToUEgKs91oKCSEyORayxyJ5c1Z4rC6a/yHXzW
         RQYQVCt2Xiwt5MStZ2/uTF1dWxW6A6T0qX+pvYvvCofCh7NPzHgyPrL+zVJb7WuS6TyV
         VJwo0paU/h7nzNibfofM2AhRgmp6NXEV7XtiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ink6tdpfa9FrEwBdLArsv4qZyUiZrqIcUZxDK9FC2vI=;
        b=a6aEHZPHHJyw2gtjyaT2AkMwRPpSoflxp/xzIC7nPeCftxpE2m15s7yabL+QofjsoZ
         C/WQBzxF2oV30ng7d/2l7xMtcEZrOJSW/hiY1xNGVglkqMTzhb2TUJyrxLRi8BjyDue2
         +w9W21T8Du+rZdYrORpZbGjuIL0qYGCGZtPCvo4hCTiCGWEcAK2PT9atJ2e2JIgVG20X
         wo3Yv0h64o6xrOtiPqxoOH4PcQ4Tmo4Ld031vYMHk1pMBlTG33FizFwiA7oBZbQrmEVH
         lRcVcHKEVA4N/tzRpBfRk0zoq7dm4OCRy/bMznqhnvohWvrkvhspEfOdlYGQ2UipRpfd
         cAkQ==
X-Gm-Message-State: APjAAAVFUKZZuEYROyteMJe3xVmGPqXhG/bcheKT36an8UgxrejBQyf+
        xahq2BnDbjdQV1SvdgM8lDe0Fkk7Gfs=
X-Google-Smtp-Source: APXvYqyif2WtaezjQaselIS1/EZlnJnCu3IxYrVClV9sc4qQ0hF+WQ2ekgP5/HGmQWbdAD/Zqe96fA==
X-Received: by 2002:ac2:46c3:: with SMTP id p3mr3039827lfo.178.1558804176674;
        Sat, 25 May 2019 10:09:36 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n1sm1228121lfl.77.2019.05.25.10.09.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:09:35 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id m15so11243848ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:09:35 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr40164026ljj.1.1558804175144;
 Sat, 25 May 2019 10:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190524231106.5812936b@gandalf.local.home>
In-Reply-To: <20190524231106.5812936b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 10:09:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgseDTYAw-O7=21j4vQmufm=eZCMqeq9Z+PtCst9WkmnA@mail.gmail.com>
Message-ID: <CAHk-=wgseDTYAw-O7=21j4vQmufm=eZCMqeq9Z+PtCst9WkmnA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Small fixes to histogram code and header cleanup
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 8:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Tom Zanussi sent me some small fixes and cleanups to the histogram
> code and I forgot to incorporate them.
>
> I also added a small clean up patch that was sent to me a while ago
> and I just noticed it.

Why not the warning avoidance patch? It changes no actual code, and
avoids two 20-line build warnings for me that are very annoying..

               Linus
