Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF76CDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfGRLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 07:48:19 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:23277 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfGRLsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:48:18 -0400
Date:   Thu, 18 Jul 2019 11:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1563450496;
        bh=cL2SsivVQdCHoOaitMMq0EG0ZsqsvmEA1RMpNbp8a5w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=xGmN2FoTM80n8Kbmd039VEpwz9ogj1YYaAln2ycHKcSQ18VtsSkUgondVcR+5Qg5x
         lj1Bs2Je2yK1HnN5EaTR+khBj/qDkS0ydSMmpfwPFeMk8hjbkAFnDKMRRwP+KeVTYQ
         IURslDlJrrpVZUO3Fy8owTCAqmJ5hmCyivsAFItI=
To:     Mel Gorman <mgorman@techsingularity.net>
From:   howaboutsynergy@protonmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: howaboutsynergy@protonmail.com
Subject: Re: [PATCH] mm: compaction: Avoid 100% CPU usage during compaction when a task is killed
Message-ID: <Wnnv8a76Tvw9MytP99VFfepO4X71QaFWTMyYNrCv1KvQrfDitFfdgbYvH8ibLZ9b1oe_dpPfDdQ1I2wwayzXkRJiYf1fnFOx6sC6udVFveE=@protonmail.com>
In-Reply-To: <20190718085708.GE24383@techsingularity.net>
References: <20190718085708.GE24383@techsingularity.net>
Feedback-ID: cNV1IIhYZ3vPN2m1zihrGlihbXC6JOgZ5ekTcEurWYhfLPyLhpq0qxICavacolSJ7w0W_XBloqfdO_txKTblOQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, July 18, 2019 10:57 AM, Mel Gorman <mgorman@techsingularity.ne=
t> wrote:

> "howaboutsynergy" reported via kernel buzilla number 204165 that
<SNIP>

> I haven't included a Reported-and-tested-by as the reporters real name
> is unknown but this was caught and repaired due to their testing and
> tracing. If they want a tag added then hopefully they'll say so before
> this gets merged.
>
nope, don't want :)

Thanks a lot for your work, time, understanding-how-things-work and concise=
ness(level over 9000), Mel Gorman. Much appreciated, enjoyed the read and h=
appy to see this fixed! Hooray!

Best of luck.
Cheers!

