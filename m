Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF90196F45
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgC2S02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 14:26:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgC2S02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:26:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id m11so12425311wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzLC2qzq86wrfSK0vb/dNLSGr6D+NOIwmb/1It/LkLw=;
        b=m2zJxeHTWnDeGv7bhlY5Fjn9Cx8uOjtraLsathguaUSeiVanKONo6XsuMy6DP3MuKe
         AGYrs212tUiXFUx9BZDR5w/R5fGMknOeFhTavqz2DxhIqJsYltQXisQa/hUgHC2ZSt6u
         ZzR1bpPnUCEG9yaP/9i8ISaegSvJqV3NH1M+fuollBbMJ06lQ4PVbKdq9/Rh3f8kBbGk
         7tGDG9Th7O1hTiptUR/k/L08mSwpTgoSpCuqGrGacN4A1CuGYk0LqGpJckRZKnm9aQFr
         pRNWbfdeunQjqTUArL8SStEXDNfl4R6qV5VCVEzNCwACB8yfXtyNOdPFIrA3pXggDw7n
         3IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzLC2qzq86wrfSK0vb/dNLSGr6D+NOIwmb/1It/LkLw=;
        b=TtgPtxLLxxJ9HAfwbcGXLZL0N5FU5NRtoVhfhTCXC5IsGJfweqNFIQp73eiJtvuVE3
         bEgiOXCe8t8f/YXHMK7JhAlqc0/4eB0t8Lyj6OLnfSrDZq2LoyEFWS6VaYnQ0kvxZORM
         fHW11S+lWIHl7ZUBBHbZK9/yNzqYhWdm6YvYzs0S9TJegP8b57B4uplV36fXvFIuaRs0
         X8PVThAEdYRUc9gogs9kUBZhRekvzeuLiJ7UQnykexPSZAsxvT6w1KS+zrTemxaH3IIZ
         1EhgUzhbUtU+bnTvim2goEvNsgrIo4V/NVaT5fkQVkt1u5PX5wM0Lnja6tELeVV+AaW6
         EYFQ==
X-Gm-Message-State: ANhLgQ3BRRfNvAJanu9B35QyqKRmUf1r/7cZt0pINuxlNtRu/IrADkvG
        kHv1y+N41qKSh9+Pr17QKu4=
X-Google-Smtp-Source: ADFU+vsF8U0a8bYHxZAV5JKKqwms8/lqsCynYG9TNVrfZAsHmRk87ZHCRpNwuIrKPKgtO+mlB/m5QQ==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr10309174wrs.4.1585506385782;
        Sun, 29 Mar 2020 11:26:25 -0700 (PDT)
Received: from giga-mm ([195.245.54.172])
        by smtp.gmail.com with ESMTPSA id r9sm18226132wma.47.2020.03.29.11.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 11:26:25 -0700 (PDT)
Date:   Sun, 29 Mar 2020 20:26:24 +0200
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] random: Drop ARCH limitations for
 CONFIG_RANDOM_TRUST_CPU
Message-Id: <20200329202624.087251ba5c6d2d9715e5710f@gmail.com>
In-Reply-To: <20200329165624.GO53396@mit.edu>
References: <20200329082909.193910-1-alexander.sverdlin@gmail.com>
        <20200329165624.GO53396@mit.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ted,

On Sun, 29 Mar 2020 12:56:24 -0400
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> On Sun, Mar 29, 2020 at 10:29:09AM +0200, Alexander Sverdlin wrote:
> > The option itself looks attractive for the embedded devices which often
> > have HWRNG but less entropy from user-input. And these devices are often
> > ARM/ARM64 or MIPS. The reason to limit it to X86/S390/PPC is not obvious.
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> This feature is *only* applicable if the CPU supports a
> arch_get_random_seed_long() or arch_get_random_long().  I believe
> there are some server-class ARM64 CPU's that support such an
> instruction, but I don't believe any of the embedded arm64 --- and
> certainly non of the embedded arm --- SOC's support
> arch_get_random_long().

you are right! Thank you for the explanation!
I totally missed the fact that it's not connected to hwrng drivers...
Please ignore the patch.

[...]

> So we should either add ARM64 to the dependency list, or we could, as
> you suggest, simply remove the dependency altogether.  The tradeoff is
> that it will cause an extra CONFIG prompt on a number of platforms
> (mips, arm, sparc, etc.) where it will be utterly pointless since
> those architectures have no chance of support a RDRAND-like
> instruction.

-- 
Alexander Sverdlin.
