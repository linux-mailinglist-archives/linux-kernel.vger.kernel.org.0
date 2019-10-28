Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44CBE76D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 17:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbfJ1QnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 12:43:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731441AbfJ1QnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:43:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id y24so5837445plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5W7u7DSJb0LcwKOy/vRW0vYB0Jd8xNfJY0DoVS5j3s=;
        b=OTIwhWIMVYSCUPSVUxSOG8qI1iEq/l4wie9FZSeQ/pzkHfU5FBJd4eHTLTh3V0W7tn
         eS9zbcOAXPW9vtlHlsEcOCuU+eKNRul6YzlJPuidR+Ig8lriDtDTszsm/JRb68e+7IR3
         1Q7KArlazBtJibtpRFKzKAH9aJ5lMIc9FV8fGcw4ca+k8MdsIX4SUZr5H0sz3A29Kw3q
         qScOzIPjEJnGztkYMFMWeUtPlRw/8dNsCcMbE3XY4g6X1kuq29zuJJUOsKxVRxh49jH2
         X4gYh51ujEqHA7Hnoq3uNLWteKgTULb3Zom1yaj/hVnzUW6lZy5V3pKxUdZHZkNeB40R
         Y6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5W7u7DSJb0LcwKOy/vRW0vYB0Jd8xNfJY0DoVS5j3s=;
        b=Yjsf4aq7tA94pcpazgh5AivrL/kMq7EXF3PcJHl7We9gIFcqpe9o9KNz7UnEH5xihM
         HqJIs+suAaqnZwPHBQWFaqkGZINYaKe1viiOqXMxA2/1eCX2bY/Op0t3PcsrW6VHgraQ
         ZIa1Y/YWzbCmhEHOZPrK1i7hltKCVo3EtNPyc8r/OPRb589cGVFOhvNNxsN89audAtpY
         LcfDRxwqJonZZ5+NCWqFT5WNZLJa8Xv9iUyqq/hv/8jxG+zxTFUfh6iH8XZtC5T1KmAR
         12dYcLEuG+C//6X6vQHLS2SJYtgNXhf5njgL5GgWdfpWS2tABWu1VM9R3PFzJBEV92ew
         kNyg==
X-Gm-Message-State: APjAAAV6qZ0U6W1PvehdbWiTlrr36UDq+OQVUMRyRgIoQMpIGE8PJHOs
        76SVlpUHkvrhsSli3QJ6iSO0RA==
X-Google-Smtp-Source: APXvYqw2wzSu4h7m5+/pUIVg57bxdA5IgeZdPD7e7Al7cGAsvsFvM7ZvjCh5RkgS5wnHCk9pJH1nzQ==
X-Received: by 2002:a17:902:122:: with SMTP id 31mr20000084plb.257.1572280981838;
        Mon, 28 Oct 2019 09:43:01 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id s18sm5146575pfc.120.2019.10.28.09.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:43:01 -0700 (PDT)
Date:   Mon, 28 Oct 2019 09:42:53 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andy Lutomirski <luto@kernel.org>, dev@dpdk.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
Message-ID: <20191028094253.054fbf9c@hermes.lan>
In-Reply-To: <20191025064225.GA22917@1wt.eu>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
        <20191025064225.GA22917@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 08:42:25 +0200
Willy Tarreau <w@1wt.eu> wrote:

> Hi Andy,
> 
> On Thu, Oct 24, 2019 at 09:45:56PM -0700, Andy Lutomirski wrote:
> > Hi all-
> > 
> > Supporting iopl() in the Linux kernel is becoming a maintainability
> > problem.  As far as I know, DPDK is the only major modern user of
> > iopl().
> > 
> > After doing some research, DPDK uses direct io port access for only a
> > single purpose: accessing legacy virtio configuration structures.
> > These structures are mapped in IO space in BAR 0 on legacy virtio
> > devices.
> > 
> > There are at least three ways you could avoid using iopl().  Here they
> > are in rough order of quality in my opinion:  
> (...)
> 
> I'm just wondering, why wouldn't we introduce a sys_ioport() syscall
> to perform I/Os in the kernel without having to play at all with iopl()/
> ioperm() ? That would alleviate the need for these large port maps.
> Applications that use outb/inb() usually don't need extreme speeds.
> Each time I had to use them, it was to access a watchdog, a sensor, a
> fan, control a front panel LED, or read/write to NVRAM. Some userland
> drivers possibly don't need much more, and very likely run with
> privileges turned on all the time, so replacing their inb()/outb() calls
> would mostly be a matter of redefining them using a macro to use the
> syscall instead.
> 
> I'd see an API more or less like this :
> 
>   int ioport(int op, u16 port, long val, long *ret);
> 
> <op> would take values such as INB,INW,INL to fill *<ret>, OUTB,OUTW,OUL
> to read from <val>, possibly ORB,ORW,ORL to read, or with <val>, write
> back and return previous value to <ret>, ANDB/W/L, XORB/W/L to do the
> same with and/xor, and maybe a TEST operation to just validate support
> at start time and replace ioperm/iopl so that subsequent calls do not
> need to check for errors. Applications could then replace :
> 
>     ioperm() with ioport(TEST,port,0,0)
>     iopl() with ioport(TEST,0,0,0)
>     outb() with ioport(OUTB,port,val,0)
>     inb() with ({ char val;ioport(INB,port,0,&val);val;})
> 
> ... and so on.
> 
> And then ioperm/iopl can easily be dropped.
> 
> Maybe I'm overlooking something ?
> Willy

DPDK does not want to system calls. It kills performance.
With pure user mode access it can reach > 10 Million Packets/sec
with a system call per packet that drops to 1 Million Packets/sec.

Also, adding new system calls might help in the long term,
but users are often kernels that are at least 5 years behind
upstream.
