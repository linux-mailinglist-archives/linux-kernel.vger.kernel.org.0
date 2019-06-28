Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807DC59E03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 16:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF1Oie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 10:38:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33070 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF1Oie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:38:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so3376025plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OENcuWh1eNo2odCCmWlkvrC8foslWGe6z/lQuF+yKiU=;
        b=hI/jZKkTvfKJ1QCuPIA2jwcVCu++15YT4VW/X/uj3BhoidEJrrTRo3JfCW4BDOnFjw
         AuEz2gWKAHuJ9n3W6s2+tDkxgciVxp08zGzb/euU5KAyIEwnuj9bvIZWDfI1uIK9pbRi
         +bbM/SoY8qTBRJd/pz5uGpQbyCErsxx08aFZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OENcuWh1eNo2odCCmWlkvrC8foslWGe6z/lQuF+yKiU=;
        b=g3VV0CNXrkGlqPiwgslbumEeJbwcvBSni5Uq6m5SuaknOacrk+qdYFsPeJCDaPHhJc
         USkrhAxEoUzexYYU/mHAxDg0xZIOcob+Z4mJ6aDpOT01Zo8EdA6ePaelo9bQgygXeKsY
         t3bBO3jjIG/7cgy/y/m4yOmDiOgobOWpsijzLulrKpIZqVkqW6Efmfy84vqgufQNvkNh
         iM2+5z9KyEADeVv7whsdBxXJiQbqpT6RxThRvEOGqr9uLo4aAlQGMyWDJZ4szbcbg4pl
         1G4+raPPNq0JJ6Ta+Jo8D0ocbWQaZWGi+DzjZrAyQxjJGycRZMvW2vkZiVuxYsyliYOk
         TIRA==
X-Gm-Message-State: APjAAAX1QOTtPdgmchsb6LLEvn7KzdiMRW+qEpX4MzhmYWliqrujtkI+
        QFOPRR3GiVaqQLevCrgyCwqIcVG33Xg=
X-Google-Smtp-Source: APXvYqw1esTx+L79bzkow6doELumvuhA+3skfMMkuytCaww2yhuYlDC9ocI7SFjpxEFSke1Kn6fTlA==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr11891718plz.191.1561732713810;
        Fri, 28 Jun 2019 07:38:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17sm2313504pgi.9.2019.06.28.07.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 07:38:32 -0700 (PDT)
Date:   Fri, 28 Jun 2019 07:38:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org
Subject: Re: [PATCH] arm64: Move jump_label_init() before parse_early_param()
Message-ID: <201906280738.AE85B01D2@keescook>
References: <201906261343.5F26328@keescook>
 <20190627080207.sdpwjoi4wnc664gp@mbp>
 <201906270856.8CF50064@keescook>
 <20190627162505.GD9894@arrakis.emea.arm.com>
 <CAG_fn=UhdoyWjFPxdFOJ7XFRHb62RErxFjOKnFeHtMJWTib7pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UhdoyWjFPxdFOJ7XFRHb62RErxFjOKnFeHtMJWTib7pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:26:34AM +0200, Alexander Potapenko wrote:
> Am I understanding right this is already covered by Kees having sent
> his patch to -mm tree and I don't need to explicitly include it into
> my series?

Correct; Andrew added it to -mm already.

-- 
Kees Cook
