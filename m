Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E35E63F8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 17:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfJ0QNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 12:13:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38797 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfJ0QNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:13:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id q28so5929305lfa.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bv7WyX9iNSHEB3qVzkwmxZwKs0lg3yMNB3J/GaRSYDU=;
        b=VcSxkBjyEaDkzrUHtI1YfwCviMWUIg/gSJhDEHx7IrE8d/PHlxxbMf4FBmPJGqsjPJ
         MpUl0yTlRm1xR8TZvbWjEYU/3bt15kGY0C5ddPfBknhNH9Wea1tP731cH1d1SCdXEIWB
         kui5hVRNrrufsL9oSLtTUqXClmjptWSQMObe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bv7WyX9iNSHEB3qVzkwmxZwKs0lg3yMNB3J/GaRSYDU=;
        b=S05WBnLnCczi8XW2r3GTrFhWhNP6oAsklmQ1BDei8fqPlZN8cFGsqhtXAAogVvSSsN
         560dAEUgPhvJIklpn6If62K8Ll7ALny35iLwarDvvuCahflM0M2JqbZHpUNybRj891yC
         0ZjNtTMbAeic5HRs84lZs2G+2BhI/k7vcO6k8xKGbyq3e9LXTOzzSfnKIvQevRq6pkKe
         MNkY27Mvi32Z6Xu2liuq947q2zWn2V1B24eEfMAMnZJ3wPpJXwyx+4CR1rWr3D4kyumk
         EKP92k+i8KwfhRTZGtItAGIcNP49YwNSj+AiZnJcNSSqwd1KFGRwIGUldYt/J0NtaEkw
         loMQ==
X-Gm-Message-State: APjAAAVjs/YWU/olTWVurKe6fFyt/6gOkQN512AZmUedAf8NwV1tJo+Q
        Aw/8SdMQtvREVZfs0TPsWuz9u8RfA1R4nA==
X-Google-Smtp-Source: APXvYqzYp1MlQvZ10io/n6EyhrzGjrnsuwS4FntkA/4076VAocBWYwkzyhFQrfElFnTWqVz4xYd6HQ==
X-Received: by 2002:a19:2356:: with SMTP id j83mr8619425lfj.103.1572192794134;
        Sun, 27 Oct 2019 09:13:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z26sm4077057lji.79.2019.10.27.09.13.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:13:13 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id v8so5908698lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 09:13:13 -0700 (PDT)
X-Received: by 2002:ac2:4c94:: with SMTP id d20mr7459959lfl.170.1572192792842;
 Sun, 27 Oct 2019 09:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <157219118016.7078.16223055699799396042.stgit@buzz>
In-Reply-To: <157219118016.7078.16223055699799396042.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 12:12:56 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com>
Message-ID: <CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com>
Subject: Re: [PATCH] pipe: wakeup writer only if pipe buffer is at least half empty
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 11:46 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> There is no reason to wakeup writer if pipe has only one empty page.
> This means reader consumes data slower then writer produces it.
>
> This patch waits until buffer is at least half empty before waking writer.

This is a bit dangerous, at least with David's other changes.

In particular, there's now a "max_usage" in his series means that the
writer might be blocked even if there's lots of free slots, because
the writer is only allowed to use part of those slots.

So I'd rather not see this logic particularly now that David is
working on modifying the overall pipe logic.

I do agree with the overall idea, but I'm not entirely happy about the
"half full" logic, because it gets subtle with David's changes.

Also, I'm a bit worried about cases where the readers and writers
block on each other, and depend on "there's enough space in the pipe
that we won't deadlock". Maybe the writer is blocked (because it
filled the pipe), the reader reads just part of the pipe, and then the
reader blocks on the writer doing something else, knowing that it just
free'd up resources for the writer. But the writer is still blocked,
and not woken up, because the pipe is still more than half full. See
what I'm saying?

I'm not sure anything like that exists, but it's an example of a "hmm"
condition.

              Linus
