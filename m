Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9FF9481
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKLPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 10:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKLPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:38:00 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E51222C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573573080;
        bh=3M2GgVhtmO64YfMuftNxOM0uZYERF5ND+kTKHCwL/Jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jBedKUwiHxJoUI8JzxlPegSojKLDvehD+GyFudXEn5Q3lLMNsbCYgwaWSUiayfLVq
         ysQhjzFkhixOsYzV+bCVD/j+QKMykagp1O2umPPsJ0INI6Y/O6q0XsK23VIR3aBA5K
         T5e7Zyrn/2puEMlh7bJztML1ZyxK86yfFBgQGHbE=
Received: by mail-wm1-f53.google.com with SMTP id u18so3697451wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:38:00 -0800 (PST)
X-Gm-Message-State: APjAAAWvElJv+MmztzxlPYh+nVPR4pOjULjJtjiwlWlWBoXdrHGcyWb5
        lvYBwB8t9aIeyu/s+SUXgEBVrVzKDnX1wrWVCI6ceg==
X-Google-Smtp-Source: APXvYqxMM5+seEM2h4cpIedFo0P0ELFE2AJiK1kdWyFqJ58tghmK4GOLmaDeEUQe2fEKTr7r+Znh4TVRqCkfnFFxJGo=
X-Received: by 2002:a1c:16:: with SMTP id 22mr4872513wma.0.1573573078707; Tue,
 12 Nov 2019 07:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223051.976000327@linutronix.de>
In-Reply-To: <20191111223051.976000327@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 07:37:47 -0800
X-Gmail-Original-Message-ID: <CALCETrUKrDe4qwkq_ve50KZedqTyxB_gThQGaRmtw7+1hq_x-w@mail.gmail.com>
Message-ID: <CALCETrUKrDe4qwkq_ve50KZedqTyxB_gThQGaRmtw7+1hq_x-w@mail.gmail.com>
Subject: Re: [patch V2 05/16] x86/iopl: Cleanup include maze
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Get rid of superfluous includes.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
