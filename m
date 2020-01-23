Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E014B146C74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAWPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 10:17:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39036 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAWPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:17:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id o11so3851128ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q43C7iurJc3yk39+70fKYQz9kS6LAXkSuTfVsqcdm/I=;
        b=j/47bdWfaZKkml1jGYlhjwdiXuVo1Uuc5LbVK+3msMbGhcuGJwwOCSUStnG0BavkZy
         YzFA5xQ2sNFRXvhmCm4szeH76prsER8RuZHyG3vimE4ynW7bjJWvYtd+ukCD8Bb+prJR
         Z5IScBS8TPA/C1hVq/mbI6fS38DmDXfIrDzP5Q1ax29u9aWpZ9y5l/IVwBLuHRGGTq29
         mPuF4q7c/KFT7QRqNulbzCuglpdrNFRlWLGzJPlvz9rg9n/CG7mpdgR2Rl9Uu6by30Iw
         6vnoqc1M7ddUWJ8ng/IExt6nOkqoCt8b8atTpI94UFUaeA/6xqo4LuAU4XNJeauxrIG0
         t0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q43C7iurJc3yk39+70fKYQz9kS6LAXkSuTfVsqcdm/I=;
        b=UMuz9XuQqbCAHxhcieZGqqhn766CCSSmlM9fjUjm/KPvaNyMI+1Q2AjjIpECnzePel
         iB5TfQXGfB9pcVhtpOwBMb3n3R2jxc/UwljcRwyYZG2Dtg/z31tmIgB0HtgNuWoxUp9n
         i1esNZY5oMvRAp+GC0Mp+/ZQbVxUtbA3Bzj59FNbBpiJxejrrfpxKlZb2o3GRal0iLvB
         jOQtt+IQoqvlyeBJ02t0BZT6VfO8ElEB0oD2ebL+4Jk1rWhmlc3BSSS+o2N37vBT/9Yc
         1lwLtB63xseVkd6FRcdSwLqK+JyNDu1Ckg2bEh+Ej6PMR/3VSzXOsKvDe6s1onJZoXBB
         +KAw==
X-Gm-Message-State: APjAAAWLRamfPTIzvnrXNRx08pb+070l4nCTMJc6utGsfemCdF2BYoNl
        6/pDZb4gVv7i7RZsSyJfGVzFhE/zLbGWqVEIXFtmpDPP+V8=
X-Google-Smtp-Source: APXvYqysttcyD53QUOz/qpIy5Qn1YoJFV7kW/KxVf8lxvC61gCRIrRE3ZhYEpo4lpAKs2kBKevYph3lXJWvexgPIYxk=
X-Received: by 2002:a2e:9143:: with SMTP id q3mr23223537ljg.199.1579792632468;
 Thu, 23 Jan 2020 07:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20200118105101.68580-1-sachinagarwal@sachins-MacBook-2.local>
In-Reply-To: <20200118105101.68580-1-sachinagarwal@sachins-MacBook-2.local>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:17:01 +0100
Message-ID: <CACRpkdbJeNqF7dJz2B+uRysRF0AppHKk32hpzkGMC=f3fHb6Ng@mail.gmail.com>
Subject: Re: [PATCH 3/4] GPIO: aspeed: fixed a typo
To:     sachin agarwal <asachin591@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 11:51 AM sachin agarwal <asachin591@gmail.com> wrote:

> From: Sachin agarwal <asachin591@gmail.com>
>
> we had written "handhsaking" rather than "handshaking".
>
> Signed-off-by: Sachin Agarwal <asachin591@gmail.com>

I squashed the different patches together into one and applied.

Yours,
Linus Walleij
