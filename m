Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC415D35E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 09:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgBNIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 03:07:39 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:38128 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgBNIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:07:39 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2W0W-00B5oY-In; Fri, 14 Feb 2020 09:07:28 +0100
Message-ID: <d8151ac6b1e590d6c49d8c890604a08685cd2303.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Date:   Fri, 14 Feb 2020 09:07:27 +0100
In-Reply-To: <CAKFsvULfrFC_t4CJN5evwu3EnbzbVF1UGs30uHc1Jad-Sd=s9Q@mail.gmail.com> (sfid-20200214_015457_457274_397896E3)
References: <20200210225806.249297-1-trishalfonso@google.com>
         <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
         <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com>
         <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
         <CAKFsvULfrFC_t4CJN5evwu3EnbzbVF1UGs30uHc1Jad-Sd=s9Q@mail.gmail.com>
         (sfid-20200214_015457_457274_397896E3)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 16:54 -0800, Patricia Alfonso wrote:

> Okay, so I'll rebase onto (1) and just add the lines I need from the
> [DEMO]. Are you sure you don't want to be named as a co-developed-by
> at least?

Yeah ... it's like 3 lines of code? Don't worry about it :)

> Yeah, failing loudly does seem to be the best option here.

I just ran into that with userspace ASAN yesterday for some reason, so
yeah.

Perhaps good to tell people what to do - I couldn't actually solve the
issue I had in userspace yesterday. Here, could tell people to check the
address where it's mapped, or so?

johannes

