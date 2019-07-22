Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1370808
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfGVR7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:59:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43026 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGVR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:59:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so40318639wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycadGQDE4oZyvw12oXYJ4WF1B4/T2UP6dzxNsmJvfxM=;
        b=jTBi+NPyGucvcpKOawAKTa0RLUGhkfYhXUuvJrCeVHn2mamHggpENuFUQc17rIYjEg
         fvweoDdId5HjjQHL/BXWLYzpHNAKAAtn3kFtQucL/ebJCC8HFda9utGu93YOT70asHpa
         xAqg7mmUBFNQCrDHfUh+SBx959Ytn4b2EpVPxmL5qoyXuSiFwbGm/G0IFVT63mKFAAXR
         Bm8WA3GII0DdIlLrXQeFGhfw0h3kYbaR9+9FBdUC/RPxDqZvjmkFpd3seNxTBj4ufgwo
         xKVj6U8ora6iIsfETSBbNdpl5NTtPwHKWbbPSDcSJNVJ+OXpOzk3vcksTEcaJRRnJg+T
         5dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycadGQDE4oZyvw12oXYJ4WF1B4/T2UP6dzxNsmJvfxM=;
        b=Aqj20tzDQa3o5oMYrrTUYWw9wUSqlF8RJNallovNaAMDwA7Hg1TYTzi7WJ74olsIUB
         QKLVToADZ0OLFrL7ifanJwj/9807lmSU+iH1g2BFcl12NrRprkrKSU1le6/+ALfM0BNW
         AJnml33/x9sttZ8vJwiLaJj5Z78jj2sYeWA0ug0hbTy4mr7IVOACfE4Jcu+drAqbQlh/
         ikW2WVH+PL1dzrCd2fL9ZZFgIKDbvoMQzTLwRA9tQklQ7CqiKPwaE8Gj/KVzAiQ2E0xQ
         y7syoPpR+/rXnBUDyJQVuMN1Jn95pon8gcvpfftZuxW4Mit36ztMwSNY4fjrYLla7kdj
         FUmw==
X-Gm-Message-State: APjAAAWhE4z7bUzEtQm8nU8vUTG7271tLLzMCnTVqAg4/cs5/qLqMQjJ
        b41vLTPuVplkB1+ORqT1J3QHEgOAmzsU7+lNFlETAdK2Aso=
X-Google-Smtp-Source: APXvYqwlRd47wiagLFbiUTQcD8iVytL4bqRXE0cbaMtP/4phsmBBnlC1SVVbRDBhCh2JWkOpN6VJUQ4COpQROg2kSG4=
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr35059124wrw.21.1563818380982;
 Mon, 22 Jul 2019 10:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <94b6bb5f3ba41fe87bf5207e08f75e8dfe17ef18.1563599043.git.410860423@qq.com>
In-Reply-To: <94b6bb5f3ba41fe87bf5207e08f75e8dfe17ef18.1563599043.git.410860423@qq.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Jul 2019 10:59:28 -0700
Message-ID: <CALAqxLUL-p6eF5tK3SnYa0RbCHLg92uQ-Z9T8U0QGnNbpnJG5g@mail.gmail.com>
Subject: Re: [alsa-devel][PATCH] Signed-off-by: lsh <410860423@qq.com>
To:     lsh <linsheng_111@163.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, 42304622@qq.com,
        lsh <410860423@qq.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:35 PM lsh <linsheng_111@163.com> wrote:
>
> From: lsh <410860423@qq.com>
>
> Modification of leap seconds from 58 59 59 00 to 58 59 00 00

In the future, on other patches, you should provide a rational for
*why* you are submitting this change, not what the change does.

As for this patch, it would be a bad change, as this changes the
established behavior that the repeating 59th second w/ the TIME_OOP
flag set is the 60th/leap second and would break any apps that care to
actually watch for the leap second. Your change would cause
applications that do not care about leapseconds which have timers set
to the 00:00:00 UTC to fire a second early.

thanks
-john
