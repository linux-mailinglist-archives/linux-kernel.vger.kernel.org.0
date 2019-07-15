Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B86911C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391325AbfGOO0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 10:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390462AbfGOO0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:26:39 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1C021897
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200798;
        bh=DNqlzREK4dV/aPzROroMGAgiODE6UVu/9+MH9locEQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SabY96C/POfFbxV/Umsy2WGXdijJG7KF8f3Ysqqdifd7WqBbEJx+xG8P7Mmx5WDBz
         q3jA6uUizcJUa+q10TuC7UrMWVr4NRyvH6PaW3VSAzRFj033Puah609iqGVB5ULYFh
         WWDH1OLKrjzSjdlcJvmRoz/+0x0+44lupFxtDxGM=
Received: by mail-wr1-f41.google.com with SMTP id p17so17309328wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:26:38 -0700 (PDT)
X-Gm-Message-State: APjAAAUmT7CkchuRovuWrwd0s4r31JPTt3bNV/jt7JQDcIToouuGDwfq
        xLPG+TVxXXUB8QciTIo458bgOVDQrishDYyZrqrRow==
X-Google-Smtp-Source: APXvYqww0AN3+Pb54VR+Bz/+6fgGsdMSZEJs1XScvHSY8TTgNMqkXTS8y1miAw5Idq1Dc5EeFC1Tkcu7M/Wx0leEMSw=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr27817870wrm.265.1563200796986;
 Mon, 15 Jul 2019 07:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190715130056.10627-1-andrew.cooper3@citrix.com> <a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
In-Reply-To: <a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 07:26:25 -0700
X-Gmail-Original-Message-ID: <CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
Message-ID: <CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
To:     Juergen Gross <jgross@suse.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        FengTang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Alok Kataria <akataria@vmware.com>,
        Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 6:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 15.07.19 15:00, Andrew Cooper wrote:
> > There is a lot of infrastructure for functionality which is used
> > exclusively in __{save,restore}_processor_state() on the suspend/resume
> > path.
> >
> > cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
> > independently by lapic_{suspend,resume}().
>
> Aren't those called only with CONFIG_PM set?
>


Unless I'm missing something, we only build any of the restore code
(including the write_cr8() call) if CONFIG_PM_SLEEP is set, and that
selects CONFIG_PM, so we should be fine, I think.
