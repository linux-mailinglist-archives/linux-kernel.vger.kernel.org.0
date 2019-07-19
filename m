Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BE6E6D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfGSNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 09:49:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52819 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfGSNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:49:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so28887845wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=smQrXP7fwTxA46Gpk0cUyjwxtkHs1F6EO+T3/TBVils=;
        b=pxnNx+ZxdcuUMn0NtVbfef0Vuu56KnXksI27SUUh5BHVNIbS6fDTjk4NFbivrHrFGU
         xlOQWuNhymyxYBxnfhgYLBeU7DYcDE2kVRzkTWT4+Ok9hfYKFvFCdijgK7TwPKOr3ZZh
         /WpGXY+iRzcYY3/pkhDH98ENcLxmBFr1Oiee9QoE6VqfTCWfCNWKoRoRutz9NDVTX46i
         euVA+8hALb4kWLGLG/X60xQ1PYkdf3cSd/FKQ7/7u2+pYC4fak96WfbyN8IHdiSkGREh
         tVxJv5MkWx9+sSg46E5HmkWgOqDGIqDl1C8lIZIF3+Faf/tVnlWf49RqqMmKWflV0nAi
         gycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=smQrXP7fwTxA46Gpk0cUyjwxtkHs1F6EO+T3/TBVils=;
        b=b8rYCm0GYn8EzDdxFsjfii2Qqv059es6PJzVIy8FBfiXz4mYc1yxL9jJdNk+ny//Re
         lM2ROPjmMu33WpHGAqJuWCdWGLpUY4lQ25WNOMWG0lcSZJPE6qU3xWFejlA216zT9dYS
         pUI/ZbsylqnMkUOB2HFhubEM6LHsUNKzon/1aLD4B/+0nc6uCSutZJY1PQ725NCnqziH
         Qf8n+SlDEwynSSLZteluAuEcuCvxkhzJVTKR/l+KFsImFqE4bcSoiGTdJknzZ0+tm2gs
         0jTKlvfUA0/0b8Q1gez8v0BaqrwnquIE0g+TTWzHsF5TdPE3eX3ZaVIQubMFp6BnPNqW
         vWLA==
X-Gm-Message-State: APjAAAUqztZ49cHIIEGAMbxOe8+U9MZ5mcTO+EzVOHX4so8OyrDZxPKK
        sNNh8I+yA2rXeMHrCxuOPZMIGVrop62P01/PZVQ=
X-Google-Smtp-Source: APXvYqzDaYY9rYKHKDGCwiLwi65ngNe/ST9pocKyF9LYbS7nmk7ou7kxpOekW2VDCTMI1n4rLwN03/IXpSWtL/epsWs=
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr46214806wma.36.1563544139506;
 Fri, 19 Jul 2019 06:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de> <CA+icZUW5jNJY3L5EcxrtOttwpbdAWQ7=U_bZaLHcTogOdNuTcQ@mail.gmail.com>
In-Reply-To: <CA+icZUW5jNJY3L5EcxrtOttwpbdAWQ7=U_bZaLHcTogOdNuTcQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 19 Jul 2019 15:48:46 +0200
Message-ID: <CA+icZUUtNibYGbHEt+cqsu6cuKYF7=MobvPQ9mkXU1pJZhFw9w@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> First of all I find out that it is possible to download and apply the
> series (here: v2) from patchwork (see [1]).
> I highly appreciate to have this in Josh's Git [2].
>

There it is.

- sed@ -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-many-fixes-v2
