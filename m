Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7823C4C9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFTIqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:46:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTIqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:46:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1EA9ADC4;
        Thu, 20 Jun 2019 08:46:02 +0000 (UTC)
Date:   Thu, 20 Jun 2019 10:45:51 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Ethan Sommer <e5ten.arch@gmail.com>
Cc:     hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Ingo Molnar <mingo@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] replace timeconst bc script with an sh script
Message-ID: <20190620084550.GC28346@zn.tnic>
References: <8a9ffb4b-791d-35d1-bb2a-7b6ad812bff1@ideasonboard.com>
 <20190620081142.31302-1-e5ten.arch@gmail.com>
 <20190620082557.GB28346@zn.tnic>
 <CAMEGPiqk5TU=z2_wvMfPuihVc5zOLRrTSVCpLA23k0r-hmAzmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMEGPiqk5TU=z2_wvMfPuihVc5zOLRrTSVCpLA23k0r-hmAzmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:29:19AM -0400, Ethan Sommer wrote:
> Ah sorry about that, I accidentally replied to Kieran only instead of to
> all, my response was "I will upload a patch with those issues fixed
> shortly, in terms of the dependency as far as I know commands only required
> for running tests don't count as kernel compilation dependencies, and I
> don't see any other uses of bc except for Documentation/EDID/Makefile, so I
> believe that bc can be removed from the kernel compilation section of the
> process document and will include that change with the updated patch that
> fixes the 2 issues you pointed out."

Sounds like parts of it should be in your commit message as a
justification *why* you're doing it. You can do that for your next
revision once you've waited a couple of days to gather feedback.

Also, please do not top-post.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
