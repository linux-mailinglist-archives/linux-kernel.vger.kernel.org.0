Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8947A657
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfG3K7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 06:59:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36990 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3K7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:59:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so62196360eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8SZnm7U0dKZS6ERS/bj2Oad7hD6xIkZ46j3/cwzbqOk=;
        b=YVij+roWjKmrnHQ3o+1hwYcwjOWw1SJuoDPUDorVfj9BgASRPI3JIgppZnHaASSJeK
         UpRm1Bb5MWrJUSzTsKKlth4zFNJ2GltamykTQ5UifGNuaD30cECK5y6JAiG89XC/0BtA
         WL34ZOHi01dCyViy4PQOrFww/KtgTIxZA/3d4V33i1b3OJuNpfzGXLMpzuVFk+STVLk3
         Y3K9VBtCphZat+0TIyo0SAysXRJZ/D/9esMOqzqOzhm6ErBNbLMY8udOQtVwWklnWR8T
         uTEnVBAre6n3rLvVwpQZNxoJchgKHXiuWscxdC9OvtvVYvdKoiBx/p3ZIojNfUdEGQeq
         e7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8SZnm7U0dKZS6ERS/bj2Oad7hD6xIkZ46j3/cwzbqOk=;
        b=cGJ9a7/+Uye66xBZrfZKgbqt0rQSTOsTwOIAIEtz+cb4GsPXQnoDjoyclKTIkNr/8y
         uAWz4fUrWi6sG5Cec2+9t+MxezTxvSDsPQor0Hn3pCs7wWdpyXBgeShOBbUVKJzmABYK
         iO4heQNiWC/Hp9DSa/RBKbjGDEzcHfqKFTFVfUpP5Hg8eH26IKxkWQndv5lTw+Ejn5Ym
         /hXcUSOm912n1Nosjt6G6ZQXYSQj2g+fzFX+FXTgrlBcivMM7VDc71BA9iCdV1RN0qeq
         v9OjmsnCVQeZsuYqpQaiT4F6mceZYJVnuLIsRUY8yhI+B5XjiVES9H7zI/iVTHKngk1B
         KDuA==
X-Gm-Message-State: APjAAAW6hScb+oII7ncugIpGlTDi/+cB784EI5p6UHCDs+lQ7648zcQ8
        ceosMLf6Y2fUrdpGvEkpkMXin1HSelEBHXldKbg=
X-Google-Smtp-Source: APXvYqxuk4Jz/o8G+TfE3RnlRT6gHv9G32oCUlV1K08Jq68I2mHDW+iemNKqkhbH+HjIV1c3rwUI1MQxAtHBrvndiiQ=
X-Received: by 2002:a17:906:6d2:: with SMTP id v18mr88435048ejb.279.1564484340195;
 Tue, 30 Jul 2019 03:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151435.9498-1-hslester96@gmail.com> <alpine.DEB.2.21.1907301113580.1738@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907301113580.1738@nanos.tec.linutronix.de>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 30 Jul 2019 18:58:50 +0800
Message-ID: <CANhBUQ2L71Q2j_iOUaHW7qk0BS6wwMBwmtd8N4S5mNLYHr4Dhw@mail.gmail.com>
Subject: Re: [PATCH 05/12] genirq/debugfs: Replace strncmp with str_has_prefix
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 29 Jul 2019, Chuhong Yuan wrote:
>
> > strncmp(str, const, len) is error-prone.
> > We had better use newly introduced
> > str_has_prefix() instead of it.
>
> Can you please provide a proper explanation why the below strncmp() is
> error prone?
>

If the size is less than 7, for example, 2, then even if buf is "tr", the
result will still be true. This is an error.
strncmp(str, const, len) is error-prone mainly because the len is easy
to be wrong.

> Just running a script and copying some boiler plate changelog saying
> 'strncmp() is error prone' does not cut it.
>
> > -     if (!strncmp(buf, "trigger", size)) {
> > +     if (str_has_prefix(buf, "trigger")) {
>
> Especially when the resulting code is not equivalent.
>

I think here the semantic is the comparison should only return true
when buf is "trigger".
The buf's size is 8 and the string's size is at most 7.
Since str_has_prefix()'s implementation is strncmp(str, prefix, strlen(pref=
ix)),
here strlen(prefix) =3D 7, I think it satisfies the requirement.

Regards,
Chuhong

> Thanks,
>
>         tglx
