Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8091E2742A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 03:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfEWB4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 21:56:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46386 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWB4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:56:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so6642790edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VeCxUerMSUiEe1VSBy4pwjo+lY6Ie9i6gDJMGA8Iaqo=;
        b=a4rFogx1/clKbND5YbpRBpPdX0an/nN716Pu2fh6o0JIN+LIie20RXWA6ei8QBxE/M
         dtSIQF2nxSINr/GTsfn3mhZGWUyMy94gHEGWpSjfJlD9TDSH7yhAXbyUKrKcuCfO/mne
         PRDLz/6ule8aOwm/VBaG9MpFj4UIOXU1U6UnqIpTcQZIzBpSlMiVU0lv/2rzAFtFSAgy
         Ypgkbeh6K+w+QhDgPEQAPiHzeAddh4ptxtGNVMm2jGw1XO+oFSo8eJuRHdmNE2Qc2DMV
         cLKT4Ihj4AODdvK4hE3vQyzHDm3YNAFblSLcHZqUE7hdlFAUmHGcqO2DyxtWZG9HYevY
         7RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VeCxUerMSUiEe1VSBy4pwjo+lY6Ie9i6gDJMGA8Iaqo=;
        b=GfJOJFM5mQI3+1dGRdFud1dw+jVQ35oeYan6tQUMandAvpIB2RGwNjFbgnp1hbco9c
         l9jAcsogzD9LsJj5to2AuiIzGzElW1QsQhOnr55AqJQJdTcQGCQlzTk2Z9pm3GzoE9dh
         5cTFJvwK4JCLPfNwy5mGfweBmV07vKyPZsi6F5t3xl6NsmVucpc9/4KT3gv1dLoZd8Rf
         tl29lF3U6kMs7UB/IM7Gst7xkuxxU284SwEFcuDCLKVBV3nbmm25DSxghgoW8WQ/Zi0h
         98Yq4YVIuIOGQHdwASfaXKuFZMis4J/3JkDjYauHsQ16xLt3LX3dxrzo0WtncNEFXU8L
         BWpg==
X-Gm-Message-State: APjAAAVtwrMBiF0K9spRkHuWIJbuTdk4TUUOF+ImihTQpqPz9d2ddche
        tbPZM1tKwHwDtnXkhoR5lCg=
X-Google-Smtp-Source: APXvYqycu1jKQPpza8Qm3X9Vyhz7ORChxsltnLGa9v8vBaZ6meENQQaydK/+g87mkllBa53MNUMOGA==
X-Received: by 2002:a05:6402:13cf:: with SMTP id a15mr93574743edx.70.1558576601675;
        Wed, 22 May 2019 18:56:41 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id d24sm4146285ejt.12.2019.05.22.18.56.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 18:56:41 -0700 (PDT)
Date:   Wed, 22 May 2019 18:56:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: -Wuninitialized warning in drivers/misc/sgi-xp/xpc_partition.c
Message-ID: <20190523015639.GB17819@archlinux-epyc>
References: <20190503033340.GA7980@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503033340.GA7980@archlinux-i9>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 08:33:40PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> When building with -Wuninitialized, Clang warns:
> 
> drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is uninitialized when used within its own initialization [-Wuninitialized]
>         void *buf = buf;
>               ~~~   ^~~
> 1 warning generated.
> 
> I am not really sure how to properly initialize buf in this instance.
> I would assume it would involve xpc_kmalloc_cacheline_aligned like
> further down in the function but maybe not, this function isn't entirely
> clear. Could we get your input, this is one of the last warnings I see
> in a few allyesconfig builds.
> 
> Thanks,
> Nathan

Hi all,

Friendly ping for comments/input. This is one of a few remaining
warnings I see, it'd be nice to get it fixed up so we can turn it on for
the whole kernel.

Cheers,
Nathan
