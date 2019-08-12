Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E868A338
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 18:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfHLQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 12:24:45 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45208 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:24:45 -0400
Received: by mail-ot1-f54.google.com with SMTP id m24so8011829otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EX5SqmQimFHHDLW4N4+79Vwj96/2MHoKe+E0fsyJiX4=;
        b=CFmKhYzbI6hIG26EYtPFKdHkeYvVR2LPoEEm1pWnytsnlQjp8uMPlRXJMT4XFPG7Nv
         rgb5569VHjTgVD1Fw2h6+J4/BQgIJJ4Y7y5gNs0SBffw7jpP8QVBO4M/HIbQjpAaa+rb
         oeRnCHlfwZ0DeWobS/2ZmZR0i6iz7uX31WObeAY4TSlcqlDDnOPLMsGDlAAxSd9VdIK6
         mFP6LdlZaGVqB0J1BDRvCpZRlaQbzkDD5nWY3rBN+kBy3eWG6JvzxH2370ZZk4mRkTwa
         bFw004BCG9Ozzkcbd3Kdl3I+0dHSs/liYIYyDatgTOqrNIsd/cRof1FjCqwLGnq2ePe9
         kTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX5SqmQimFHHDLW4N4+79Vwj96/2MHoKe+E0fsyJiX4=;
        b=uh43oRZbu0MYvxm2NMqo2X4xIcJ1YqkblZrmjs+llUhUcWbPgd4Hh9thvhbOm9JoNx
         K0LB7kYdOOH7OYHjgqqsIvygTxd0M8oxqW/dY7YolcqdDY0HaqtAU5naKSXypsWa756W
         gFbw0x7yCnQT6QIQZcaDoAnQsh9ajEmaVebyoXEs8pH2bPHV8uPwJ5kpFA3o3oo35JYh
         dDHv5HYo7XLnWyGQqLGY30xeZvlo0Gph55onZZi7gpDeBHVPsu++VrN4LNI/9ECzE2/7
         KhIrLwS2vNgB+TKyOxx6hdct2lRgE/rGNVAnpgkkXMWq7NcmljvJRaFkuzcsovqdDK/k
         0G/Q==
X-Gm-Message-State: APjAAAWeTjtSIG/31xRy8MxzriFji5k8Mi4l2nXBBf6y0RHJEH/ndANj
        pT02neJkd34tPYdBKyJtkIU/ZkbWswmHG/mjElcL+A==
X-Google-Smtp-Source: APXvYqxmA37cnUt7FIlqtFhijw1GGQINjQ3ttgIzYfaSdF7wC+dpqlZzx5JzYkaAhf5q5G+YBVHWpBw7Op+QeBoNKA4=
X-Received: by 2002:a02:ba91:: with SMTP id g17mr12832603jao.11.1565627084182;
 Mon, 12 Aug 2019 09:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
 <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
 <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de> <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
 <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
 <20190811094630.GA18925@eldamar.local> <alpine.DEB.2.21.1908111456430.7324@nanos.tec.linutronix.de>
 <20190811153326.GA8036@eldamar.local> <20190812112853.53ecc122@gandalf.local.home>
In-Reply-To: <20190812112853.53ecc122@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 12 Aug 2019 09:24:30 -0700
Message-ID: <CACdnJusGKAx-APuDi2+hqSSVXeeH5hBq4Chi-rPirDos4MvhgQ@mail.gmail.com>
Subject: Re: [Linux 5.2.x] /sys/kernel/debug/tracing/events/power/cpu_idle/id:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 8:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> From what I understand, Matthew's "lockdown" work is to prevent the
> system from doing anything to see what is happening in the kernel. This
> includes tracefs. This looks like it is working as designed.

Oopsing the kernel isn't working as designed. Ben has a patch to fix this.
