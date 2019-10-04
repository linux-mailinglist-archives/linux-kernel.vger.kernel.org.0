Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AFCCC1A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfJDRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:24:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35291 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbfJDRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:24:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so7314095lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cj0T9+vptn6BmYzfEFkxrNwWk1ZqyBr8seSB/I2unuQ=;
        b=WN7lt/4ouNG8S/nZKvJRG8Nnddv0XTS6ymVcBvq/UEdD9l6dJGz5SiwAIC/Emm7ema
         LpQpye7Lks18wfqXO90DaSpm5L4GXFN0fsQiPBPWykSHhDJJMhGIL+tvIhvoeCCDXFzw
         nXwUzqMfSWAZ+6NYeD2N93sm9yIYVWO9VHE+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cj0T9+vptn6BmYzfEFkxrNwWk1ZqyBr8seSB/I2unuQ=;
        b=ksra3j8UhaGtilCDpqNVqyjkyrrS/YTjSMyV4pMgS1iO+OqOrIhEF2aQxUlKuPqGAC
         6QfT2RA5SE8mg/VSfJmkg8MXz9ynxfnFKYnFpRwCGx4dLJQOVRmY+x4ciulQfL/zlUAr
         tp+0iTPAEkq1NceH1w2aaxJe5cw3gAjgDhp5Q4v6yhZAoNGu1ZO8/NtVHBsRNdwaX4el
         XCbbYPNs7VS5MXsoC62Fv0ok8UNUU1WW5guQZAgFsT6tPlQcJj48Ld73YUeKU+GuKxGe
         DXktiKCcyjYd0a4mlgGhot5xkjwrUZYO942xkNZrbceaJuP+bxgpVJgBoby05409HTp7
         Jc/A==
X-Gm-Message-State: APjAAAUOPOKxT/0meg17kMZ4909O/26jZmbCD/pD/qT85sspdgr7YGuD
        WiMjbSAbbWCDLoixM85GxVs/2yes6Xw=
X-Google-Smtp-Source: APXvYqzaEm0zOxR23eCYsr2LjbQTJb331WdAAbCUc0meG4+LdYXgW9ePtz9+O3ZmK9FF1zQzLIQzkw==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr10216291ljg.146.1570209862971;
        Fri, 04 Oct 2019 10:24:22 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e19sm1378184lja.8.2019.10.04.10.24.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:24:22 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 7so7291222ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:24:21 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr10520960ljf.48.1570209861611;
 Fri, 04 Oct 2019 10:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191004093947.14471-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191004093947.14471-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 10:24:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNpZdAy3G+6zekugbV+SObfPQRy=fneqwPomFRX3Ym+A@mail.gmail.com>
Message-ID: <CAHk-=wgNpZdAy3G+6zekugbV+SObfPQRy=fneqwPomFRX3Ym+A@mail.gmail.com>
Subject: Re: [GIT PULL] process fixes for v5.4-rc2
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:40 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This pull request contains a couple of fixes:

Pulled.

Small note: it is sad, and I'm ashamed of my life, but to me "process"
these days is about development process rather than about a group of
threads sharing a VM.

I know, I know. I feel like a (shudder) manager. But when I see a pull
request for "process fixes", my mind goes to documentation about our
processes for pull requests and sending patches etc.

You don't need to change anything in your life or emails - you've got
it right - but this just explains why your pull request is now labeled
"clone3/pidfd fixes" in my tree, and why it might be better to talk to
me about "treads" rather than processes.

             Linus
