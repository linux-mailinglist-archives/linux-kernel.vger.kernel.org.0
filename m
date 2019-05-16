Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586F720ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfEPSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 14:41:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42174 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEPSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:41:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so3413952lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBJxqqJ41Gj2UgLcLdw3cvX6XyzdcNuSspjRp/Do27A=;
        b=IYVxqddi8vfmX/QE4v+tde5humzCJklwvwqZXu9M3qJCiAmHqmMOnzrLlWroQ53WGR
         K6YlA59NgT3y5mQSHrTZ+tUnNn/Wecg7LzyQnZKLTFSyQ1eT8f5jAcwcx8ZiPHpxkI+p
         6TJFsF27a/dp8fmtWnWMiWJrVZnlyg16ZPTsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBJxqqJ41Gj2UgLcLdw3cvX6XyzdcNuSspjRp/Do27A=;
        b=g9BsfDX+GNU4VL1SuIkyWL+h8nQ4YmQhgvDyYDW/flhtgc+/cysgm9BbKOqb59uSIu
         8CKtdGGF57I9mvkkBqEZ1yJ3WzQBzxrzJBbR6pvjfYEJHL022+OL42hfO5Gqs/vzFRfO
         qJV0OfbZWyjbR3r2wwKFtxGNF/M9ff2nKqBIojkJgVMi9BpScWv5g8uvFY2X0mlqGUUj
         72R3Me+lL0xrSdw1cQ7lhDCZHMw4IHuD8dVYT1EysMO0XDwOz7fxlQ1pUlWDZ3FHt/xA
         DOt/JqKV1m+K/Lvn+RhnyYaJvBzlIj7irJ4ptWbwrM518lua6VUJel+Ml0z/r0dRkBie
         GLYA==
X-Gm-Message-State: APjAAAV44FaNd3QswzUlQePUxzHKbRjlfkm13qjqsqgf6ZTSmW9LIzwu
        KunXwDIKEQL4qo45hGl5q9O53r6eLQ0=
X-Google-Smtp-Source: APXvYqzvGQag76QZjcucOX5TAZ6oOhJxr50wz60BlL95xvePQ8m62X8T8aeBnXfM+TrwrU6hyqxPaQ==
X-Received: by 2002:a19:2b4d:: with SMTP id r74mr12827898lfr.96.1558032107248;
        Thu, 16 May 2019 11:41:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b29sm1104505lfo.38.2019.05.16.11.41.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 11:41:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d8so3416096lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:41:46 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr24597189lfg.88.1558032105763;
 Thu, 16 May 2019 11:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
In-Reply-To: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 11:41:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Message-ID: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> tags/asm-generic-nommu

Interesting. I haven't seen this error before:

  # gpg: Signature made Tue 23 Apr 2019 12:54:49 PM PDT
  # gpg:                using RSA key 60AB47FFC9095227
  # gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
(0x00, 0x4)
  # gpg: Can't check signature: Wrong key usage

I think it means that you signed it with a key that was marked for
encryption only or something like that.

But gpg being the wonderful self-explanatory great UX that it is, I
have no effin clue what it really means.

Looking at the git history, it turns out this has happened a before
from you, and in fact goes back to pull requests from 2012.

Either I just didn't notice - which sounds unlikely for something that
has been going on for 7+ years - or the actual check and error is new
to gpg, and I only notice it this merge window because I've upgraded
to F30.

          Linus
