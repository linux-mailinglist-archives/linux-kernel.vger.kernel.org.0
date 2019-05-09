Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0D31931A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 21:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfEITyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 15:54:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37967 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfEITyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:54:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id 14so3091381ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGG06UbFIpIka8kH8mF+DXo9oIX85rLGrtvTzTqeUYQ=;
        b=Bhff/nyavJfT40PuALUNmV3NXjnHsrbN+pAjB4c+7XVvzcKW/ubj0wSd2FNv9dp01I
         PEmNRE69Gq1/nhGrWzYnZGlXBoDh5fsc7w049UJnCsXJIwhkrczb6bJT2fpYeG8x9oPA
         +f0BOPIBNwyU7J3ce6H2g/VMV1QRPpnEEQ8wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGG06UbFIpIka8kH8mF+DXo9oIX85rLGrtvTzTqeUYQ=;
        b=OA8zgkQGWKCCwUXwoR1hF2JiRmfyDJeqGxowc5ueAGtL/OGMsFebOdoy/F2qRZ0NMQ
         Px4qu4qrEHm0nPiSSU5V4oIZ5YUB4xFrpBZzuCVC9TpnDQuwXkjIOU9i+TtMyQTxEIa4
         2NeRkBS/xw+icCER4qeBx2zTWvAe8D4Hjl83oQHLlQ2NLgepnSHHwelxujuREnU6ihAo
         Tdxe4x+x1240hEFIEXkHFfIy/yPlpKdChUtgad2QNsUCB+PzaJsWmLRTL0gYDmR3ODQr
         FLBvkjdebfFHNnKgFHjrhYwUKPZKY1/MADFxaxgAuq2+wWKeBTGvMbkzq/rNVcGYXfSj
         V3lw==
X-Gm-Message-State: APjAAAVD+cayXMlc/0i4IfiiFHLbJa+u1FEEiOVl/xBBYFWvrbj1K4YW
        h5r/EuLfjqPBCcKY/lPrYtl0rp71oX0=
X-Google-Smtp-Source: APXvYqzyNy+5VVj8CsmAR2X6geD+QdKvKCWIayORaVBC3Z7I8bCwyXOOfNm2a082i7/KBsRjeX2OyA==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr3491004ljj.184.1557431649700;
        Thu, 09 May 2019 12:54:09 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f4sm563077ljm.80.2019.05.09.12.54.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:54:09 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id d15so3089567ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:54:08 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr3140904ljj.79.1557431648546;
 Thu, 09 May 2019 12:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905100320110.25349@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905100320110.25349@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 12:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Message-ID: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Subject: Re: [GIT PULL] security subsytem: TPM changes for v5.2
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 10:23 AM James Morris <jmorris@namei.org> wrote:
>
> Bugfixes and new selftests for v5.1 features (partial reads in /dev/tpm0).

What the heck is going on?

I got all of these long ago in the "TPM fixes" branch for 5.1. One
month ago, merge commit a556810d8e06.

These are just rebased (!) copies of stuff I already have, and they should

 (a) never have been rebased in the first place

 (b) certainly not be re-sent to me as a new branch

Please throw this branch away and make sure it really is dead and
buried and never shows up again.

And take a moment to look at what happened and why this broken branch
was duplicated and sent twice!

              Linus
