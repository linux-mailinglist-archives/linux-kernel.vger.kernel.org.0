Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8540142908
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 06:15:38 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:39919 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgATLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:15:38 -0500
Date:   Mon, 20 Jan 2020 11:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579518932;
        bh=ztKRnJXh6SC9VjPoU9v3xTYeT7azpddtQ73Cs29v3ZA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=FNAQnMPKiZHQFi5GsUcTJhLQQwpgOYod+IpJ+duXQwjRQdFs0selSq+Psm162r6EC
         f+y17mZdQr/t9lq3W+np8sYsJISoHzK9vPtWLM+oJXGZ7rHrxz9jUuR7kSKyVXTFpx
         bBlvnl6ih7pd6CXJ4rQ4zBnT6MUyMdojiGCAh2dQ=
To:     Andy Lutomirski <luto@amacapital.net>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "malat@debian.org" <malat@debian.org>,
        "mzhivich@akamai.com" <mzhivich@akamai.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_tuned_baseclk flag disabling CPUID.16h use for tsc calibration
Message-ID: <pdsz0EbsOFH8qmBn1Uv20EOOr71rKXljZIItC75EhT9KO4TKEKrt83Es88ZeaAh3MYuk0UM8F6XKfvmmRHgZjF50CXk9sigWEH_SyXp6lZE=@protonmail.com>
In-Reply-To: <6BFAC54D-65CA-4F8A-9C5B-CEFB108C90FD@amacapital.net>
References: <9rN6HvBfpUYE7XjHYSTKXKkKOUHQd_skSYGqjXlI0jTIk4nqLoLUloev1jgSayOdvzmkXgRNP8j_mgcikMJy6L_JN_vJhUJn9vD9xm_ueSo=@protonmail.com>
 <6BFAC54D-65CA-4F8A-9C5B-CEFB108C90FD@amacapital.net>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_20,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 17, 2020 4:37 PM, Andy Lutomirski <luto@amacapital.net> =
wrote:
> Wouldn=E2=80=99t it be better to have an option tsc_max_refinement=3D to =
increase the 1%?

All that is in the commends about it say that:

 * If there are any calibration anomalies (too many SMIs, etc),
 * or the refined calibration is off by 1% of the fast early
 * calibration, we throw out the new calibration and use the
 * early calibration.

I still don't fully understand why the "1% rule" exists.

Ideally it would be better to get the early calibration right than risk get=
ting
it wrong because of an "anomaly".
OTOH if you system doesn't support any of the early calibration methods oth=
er
than CPUID.16h (mine doesn't support either PIT or MSR) "tsc_max_refinement=
"
would allow you to control max tsc_hz error.

If you think that would be better please let me know.
