Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648EEE1D61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406206AbfJWNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:53:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38368 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405399AbfJWNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:53:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id q78so6089340lje.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdtJvmlMpbgOWEw3BLWspvkkg83Xa7YuDRL7rOYib6w=;
        b=ktDf1/97wyQ7aR+UmyEyC+WKqorEac1hE0xEIahCKqTEEZ05qGTe0dntPWrEcM2A2E
         ojNo8ayW9sJxfGSO+9g0wtx8Nvvjdq8gCmWvDxpoMpfj5oTobeIf008tMfTHCkcSb/Jk
         Zoe1O0CPcjAtMEWYP/oyVEwrQxQFh/7vK7M3m7n80opTUNJaJbJwUvxGJV6r7mDDgG1p
         i5dZr5gBOqmaFOu/FHGPJdyeJ/dKaohPapBceVDW95H6Upc8OoJi3wo3EyM7fhfBpmTo
         oVaS4Yci8oo7X1Wa0sGYiXw5SRBTTT+VzwnSSstEOzgpfBf3gmy/cVW4KCYp1vyhwStk
         zs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdtJvmlMpbgOWEw3BLWspvkkg83Xa7YuDRL7rOYib6w=;
        b=YXyjCbDVVq+TEKqnFQuuxZwYoX6uIi1wMNy0e9y4m16f54oWL0XQ3TdtgcH7UQ6Uni
         qWhdfHWmP9DT8X5rlicoKcAQ7efPS6hJgwGMNwazuHY5yvdX6MscM/HfN+5goE9dLrf6
         DktXO+loJioGQHCTyJJbWzP72HO/lrl8e8NHCl44pq9Tr20/A7txE4mqvxQI2dk0Yp4f
         cD12Q5x2hZES1roAEdaMdMKJtr1QdNnPLsXQ3IGAzlGGEFz2S1yod81tcKuK1DTJLT0T
         rNQiKYJ7PcDOXB9SL9q6bM0E3Qt++EyvNjK83i9EPdeGJb7EUKkJy9eemUSjvQaBk4Ws
         gnFw==
X-Gm-Message-State: APjAAAWLc95xFpL3AG2gIZmMc69lXXaRkbNaSENTZ5S5LjCN/V1IdQFi
        ZGtrIbDj7Jr7stnpXkv1rOw=
X-Google-Smtp-Source: APXvYqwib1R5fkUuWdhYhzQyc6j1+FeMw+t+cnLz/6a5hXkOQbxys6/WQU/TRU0XRuqiP1wR7mgC1g==
X-Received: by 2002:a05:651c:106b:: with SMTP id y11mr6524354ljm.123.1571838803522;
        Wed, 23 Oct 2019 06:53:23 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id q14sm9550178ljc.7.2019.10.23.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:53:21 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C14FB4610AC; Wed, 23 Oct 2019 16:53:20 +0300 (MSK)
Date:   Wed, 23 Oct 2019 16:53:20 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191023135320.GJ12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:47:57PM +0200, Thomas Gleixner wrote:
> 
> And you are right this happens because cea_exception_stacks is not yet
> initialized which makes begin = 0 and therefore point into nirvana.
> 
> So the fix is trivial.

Great! Thanks a lot for sych detailed analysis! I'll test the patch.
