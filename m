Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9734016642
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEGPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 11:09:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35614 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfEGPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:09:02 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so26297658itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMKxSMzwu+s2/SzB62Nh+x3vxif2iOJIy/DFOJy1IA0=;
        b=JttxCubqoLk3AhCSATJ1dG2YMRqkDdBeMD1EsHQl6xUaQs1B71zOLKZ5cMzviHJKwW
         TC/VBGHn1zLbnhTXdleyXucuXKeSTCELa5Q075xnaoCzKzXwWJR0FGxa4EWQs/NBOs/P
         8bgs9hxAdu1KMzEdD0Vh1GrRaWkc/Ekt5c7E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMKxSMzwu+s2/SzB62Nh+x3vxif2iOJIy/DFOJy1IA0=;
        b=E/S8/EZF/Z8R73R8fUQosbO4mAT+NG8MgOR2kczieshe2vBewSzm+lspDJIObWPZbY
         6Of2etDnsfUPyam21LNgqd2zEwbdGNo+kzusi1FmLOuTvla5bkgCcadrG3ns5fWmyN2z
         bJi/A6LPEcKWU/Eu2emLdEOP3FxIUB09HUjwiTOAcrS6fkFPnq36ZbMl0ShCD+f6UxsL
         es5N/S96+HzVhw7v7Oo/JJJSBx4pmW22/PqRmU8fceedYXGgc5YZ7EGjQamuCPiCWlV/
         7+TQJhupFghg64ZZycwNAH3Jm4ScukK4Ly+4DfV6YR3SByJZcRfcX6m0s4iL5FN8Swuw
         ujlw==
X-Gm-Message-State: APjAAAVpIpt+Y2TEGrTfVJlOUiPDloX09piEL8cY22ZeZaN5w9kfUlLN
        BcGCPwbpk+pEj6M0RPuoRT1SnX0DrS4Wl79KxOz9kQ==
X-Google-Smtp-Source: APXvYqxzxPAnUM9yMUPw0bSHqeGRGlrlpk4UlIXm0lTx42L8iYNvI597rZp60jpeX4QnxGdyIAI5VtNkTfFYR51QJ3A=
X-Received: by 2002:a24:9183:: with SMTP id i125mr21968894ite.105.1557241741389;
 Tue, 07 May 2019 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk>
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 08:08:50 -0700
Message-ID: <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 7:33 AM Mark Brown <broonie@kernel.org> wrote:
>
> spi: Updates for v5.2

Hmm. Please be more careful. Commit 1dfbf334f123 ("spi: ep93xx:
Convert to use CS GPIO descriptors") caused a new warning because it
removed a "for ()" loop, but left the now unused variable 'i' around.

I fixed it up in the merge, because I hate warnings that may hide real
problems. But I also expect maintainers to check their warnings,
exactly because the normal build is supposed to have none. So a new
warning does stand out.

                    Linus
