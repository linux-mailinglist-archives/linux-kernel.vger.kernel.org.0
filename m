Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69DB6F437
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfGUQxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 12:53:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42449 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGUQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 12:53:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id s19so24901068lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5u5pYqXEq+IeJ5qYP8FGZejReb4Nr/dgdEELXviWuQ=;
        b=SfsRifqu+/ZSthpm4gGscjWytOn4AblnNEKGWQiyBnd3PO0tY2AUD1Dw9bLJkXVq6l
         bi7L001ejkx8PoKwPhLRRscBLevCouzWJTl1UCqvNgOy0GG+3IBFVFZSuRizDg6/6ob+
         yCDdDMR+6ZXuFfvVtmBzj0aLDjFeTHeOeokhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5u5pYqXEq+IeJ5qYP8FGZejReb4Nr/dgdEELXviWuQ=;
        b=AK/x3GTF7Nx2C9KCyhr5QtBc1IExleKeHkS4Gkx7Rd6MOpjjy+hMnZlo7SJ22fBAJo
         Ude365hZm9kwhEWB2qnmln6WIma0/xyoDKyxvS0oysgq4fCCSmfLupqxkZA6wHasrsXC
         KikbSKaVTKEAVQG+c44JT81uBX2kLSAHA44YEtr0zl1h8f4x59VrtcQ4AAxgTYL34IK7
         e9uBCphZOKRY+sj2iQT9/toUfn1xOY/R6dW8yERg7P+Hek7TjxoLVs5zhlmE/8IE8Lk4
         LSj7vD8C+HrncC1oNGLLo3T+ddxUgKYkPndz3xfY6S064+BeDoVUzkzs0do3K5pFG9rN
         t+Zw==
X-Gm-Message-State: APjAAAUQVsuW0F5by9DTOWZcUHnPGPv6j9eWJ+GQzmiga/tlqrbankKo
        oDr/i/a+iKj+Obp4sX6cBUixwHpMSsw=
X-Google-Smtp-Source: APXvYqxrBRnXlRT9eboDopueSA851OKo2cNfCdyuRALXHYSXoKlhZETy416hDInUbUyqeW3lBF043g==
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr29860326lff.135.1563728028050;
        Sun, 21 Jul 2019 09:53:48 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j3sm5685388lfp.34.2019.07.21.09.53.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 09:53:47 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id i21so35201685ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 09:53:47 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr4208181ljg.52.1563728026894;
 Sun, 21 Jul 2019 09:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190721141914.GD26312@rapoport-lnx>
In-Reply-To: <20190721141914.GD26312@rapoport-lnx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jul 2019 09:53:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbd8UWeX-O-Zpn5iKdC6YMxef9UuH3R=TL14W5N86h0g@mail.gmail.com>
Message-ID: <CAHk-=whbd8UWeX-O-Zpn5iKdC6YMxef9UuH3R=TL14W5N86h0g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 06/14] hexagon: switch to generic version of pte allocation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 7:19 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> I understand that merge window is going to close in couple of hours, but
> maybe this may still go in?

Applied.

              Linus
