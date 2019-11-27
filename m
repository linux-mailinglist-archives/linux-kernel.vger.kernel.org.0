Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0249310BDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfK0Vcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 16:32:54 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:34068 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbfK0Vcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:32:51 -0500
Received: by mail-qv1-f54.google.com with SMTP id o18so2278579qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 13:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9dTNAP7mQf8HMqT2jeCa6ztoJ7KiGrHK94/agAtg+c=;
        b=HOJIQDi0rZeZGqMrKJi3MlbucykVVvq2RnhBkuFZh96G1a57D7c1APHNXW10dPjAdo
         TDRCnkyn5YG6w6a30Ck09rF7FjFYcQkKhv73PVO5EyFnMRarR52a/Q0Izw1GO4yhHWZE
         +8ZiSx8C9eSomD0866UfdAE2VpXVEJlV7bEQafvk4thjESa+2p18FNj+0vA37a5LujwL
         JYrzkOUq6TCRXCDwOlgq6neRqaed93ZW/SYLH5EhXFc4g4/ZrrflXyAufbGHK2JkxEF2
         Xxh+jIj7ShXJFsuLn1sB92D1lB5yMxV8iffjJMB+a6EtAbbWzi8/axvLDclxz0cvGrxP
         JVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9dTNAP7mQf8HMqT2jeCa6ztoJ7KiGrHK94/agAtg+c=;
        b=bUvciErQPz1yeLWphpUWJozohzNFvkD65joEbY+vYXA+WWkHbwk2PBA9lVljvtwLdn
         TH9Y3ztzvPpYdGBGoQNbL3zQrYb17aPlx0Yz95pLZpxfTxMA0Aa/co+wh9aXGcOicmHr
         drgsyUH+zcLZZ0ffz0rl9I+SMj6m5n+/ZEn7TFblqXKQt+gzuF3gXKY8CZPwOmwapnT0
         mQC3g5t2pjnxk0LxbeVIccD3jLdXp6mtbifgZVwZgd+CWXmhRjF8eV3qA35zW82BvDkP
         xnq7MC/VpBQXMwmUzsRxQ9BLxw4bOQ4YF3KugDYKv7/57YeG9aYp7ppb/CJfUmV9+9Sh
         4FwQ==
X-Gm-Message-State: APjAAAWAnNDXlriPZF9wnqVPFCvvQwheaZqhLdXz326Zp2yC/FyIbuXr
        +lk6iQAmL3WsbYThYB2rNstwSeH1J/0DRTWArZ7m
X-Google-Smtp-Source: APXvYqzcs0OiCArf6MiDwH4jPYV7YLGqiQ6hj+ITorUSUVEAZNGa10BVAQyRsoh4Pncusp+I+4MqbKpcupLj/rRNPbg=
X-Received: by 2002:a0c:ee90:: with SMTP id u16mr7344058qvr.56.1574890370159;
 Wed, 27 Nov 2019 13:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20191127095459.168324-1-zenczykowski@gmail.com> <CAB=NE6Ufwg4mkF8Xu9tjajb=bp74pfPiMFYHRATszMqkS7sR0g@mail.gmail.com>
In-Reply-To: <CAB=NE6Ufwg4mkF8Xu9tjajb=bp74pfPiMFYHRATszMqkS7sR0g@mail.gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 27 Nov 2019 13:32:14 -0800
Message-ID: <CAAXuY3o3JvzgchmTVrTBhPXdKDZFgyVXJ+WB5TRLo5EYpHY1Rg@mail.gmail.com>
Subject: Re: [PATCH] proc_do_large_bitmap - return error on writes to
 non-existant bitmap
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 4:44 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
>Can you also extend the tools/testing/selftests/sysctl and respectful lib/test_sysctl.c if needed with a test to cover this case or other cases you can think of to trigger this issue?
+1
