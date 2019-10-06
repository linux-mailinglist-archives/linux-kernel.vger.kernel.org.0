Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8CCD886
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJFSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 14:07:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39537 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfJFSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:07:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so11291133ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYZhJ8z29L9VXaq40W7IaPRpHSPw3yWamQCRA+/ko3U=;
        b=bGADQTdQUdcHqbYbNLqk9QwKozcUBscZ2f20slYeCKfCvmhN38YzMKFvX2ufUc7FXY
         ODiodrltVBR1zqdLTv38xj3MP/5BMFzRTbjwiz51A8ILCCXUKeHQexCepEAVI85inw7X
         VnAVOK7Rvj9ezJaN6A43dtjOY05DLDXYKJxuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYZhJ8z29L9VXaq40W7IaPRpHSPw3yWamQCRA+/ko3U=;
        b=Ct/fkEnzpyVmEp/IOX399QyRjhHEa2RI+QjevTMPeqGb1wu+oH93mrfe7dhpD1afx1
         hfvHyXqdefMZthGcbGFurlUhRpbK7EmqKaQE0tZ7SmNpB0DJtyj1s80fqZd7IzyxzHr6
         c2nsFe6RzllJGuU6GFPHorLOIoF9iKisqcnxnbJ8I6Tfg8tC8MSku51i5B9Yp25GH2Kq
         14qZe7aJQ+Z53aklnu0PwrHwB9cCBo5ix/w+LwrVYdnrt0BAJfKAUZWNzKqp4sjcYlkV
         ezK06Q+hUf8mlegbJTpVwaWojG+XWyTXvgTus2oMM5+5sZLmREdL73JHTgOw3XnijW6i
         Oh7w==
X-Gm-Message-State: APjAAAWc6QWxFsWSuWYgguJ5AoPuznrmf92V3okFIbzqtJS9LOr7xL8E
        o+3K3wNZ4MCrjMzN8oJw++lRB6h/2YY=
X-Google-Smtp-Source: APXvYqxl7Yi78ER+qSOIF1u82NyFH6Xm7K17/2FM+VrkSru27m4vAxPvzYR0OnpdWhvGLdOQWYj9Eg==
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr16057961ljh.106.1570385216821;
        Sun, 06 Oct 2019 11:06:56 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q24sm2422376lfa.94.2019.10.06.11.06.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 11:06:55 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 7so11281963ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:06:54 -0700 (PDT)
X-Received: by 2002:a2e:9556:: with SMTP id t22mr15616404ljh.97.1570385214720;
 Sun, 06 Oct 2019 11:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd> <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd>
In-Reply-To: <20191006173501.GA31243@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 11:06:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
Message-ID: <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 10:35 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> It will not: boot is now halted because systemd wants some
> entropy. Everything is idle and very little interrupts are
> happening. We have spinning rust, but it is idle, and thus not
> generating any interrupts.

Yes, but we have that problem now solved.

Except on embedded platforms that have garbage CPU's without even a
cycle counter.

But those won't have spinning rust anyway.

Yes, bad SSD's and MMC disks (that they do have) will generate timing
noise too, but in the absense of a cycle counter, that noise won't be
much use.

                 Linus
