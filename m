Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00731C9C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfJCKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 06:44:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36296 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:43:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so1910164wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L443QrtbGJzjXrb9cPjFogwzDzBLOTWJckxbc5KAm6g=;
        b=js4G6PHPUfqE3C3hPfDJj5EMKbSMjV2HW5gUiSmhp4QNJJUh1ocSa1TC82oVye7dyH
         UseO8Ue5uw+H/XTq4HFjjhrqJ9UUj0otn2bkG5z5efO/MOxe+3N91GlqnH21RRjfunCD
         /4H1rzwJN/fMDXz9O941Qnwm+2qJz6Jf4G8axscUMda3aTyBqlVVbQ7Glg0LRqBMKFVP
         3YnkU0+W4oSnIitGGe7VUZDXtNYukVGBMZyfAe5tBtUU8Jau5m2NHYI/WtrkP+LXVonS
         gCp31gnixomWEcvGbzv+vpQJWq5GafYgvy79qZHLM7R/eb8CN+xMePXVM5ZyQvzX7MiW
         g/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L443QrtbGJzjXrb9cPjFogwzDzBLOTWJckxbc5KAm6g=;
        b=mWfHsrvDJ0Eq+D8SWF+6AGM3mqDNPy8ULj+oXSpLx8wX7dRFqkQu8fpoNWendDgudo
         cLMixyduPc5gvRX5bU9qY9da5pic4m49XJn2Q394pzSKcM6vf4KCex6nGGfDsfEdOmm+
         0HN1slaJ9/2wLQArArNLVk9M3krwZaUL4HmeS5HMN/47WF1uxvBU3mtTT5TkojLLvfzb
         OgVXufGBEOLqsTOUCfHVfizQeI2B/zocpp25zEKBEqcPSx8QGnb8lVMzOca8kyV9HAw6
         bcgPWVIZSc+2nLLrS1l97slxNWqxEwkMPWv7r0lJYQBuUxgwxtVPnMw7MCKunPTW1Ynn
         fJWw==
X-Gm-Message-State: APjAAAVGJKg4l8ys6Wa3C8uV4DkL4gS2u36XEPHA1qW+DBFZRzVHzA/n
        tlPF+4fJ7XwhcKhrDGuu/6T1tibiWF0j+A==
X-Google-Smtp-Source: APXvYqz/48XqqPRRCh0PtBQsux17HBetTtAD6J08zwekAjJaS/BCoUn3boG9FzEciCT87JI+2nNiRg==
X-Received: by 2002:a1c:2388:: with SMTP id j130mr6150051wmj.107.1570099437593;
        Thu, 03 Oct 2019 03:43:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id f8sm1746117wmb.37.2019.10.03.03.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:43:56 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:43:56 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: nsdeps not working on modules in 5.4-rc1
Message-ID: <20191003104356.GA77584@google.com>
References: <CAH2r5mv49T9gwwoJxKJfkgdi6xbf+hDALUiAJHghGikgUNParw@mail.gmail.com>
 <CAH2r5mtVW=3-2L+0QFJAqBG+uj2sYmF=dtzT_kqwK59cu94vGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH2r5mtVW=3-2L+0QFJAqBG+uj2sYmF=dtzT_kqwK59cu94vGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve!

On Wed, Oct 02, 2019 at 06:54:26PM -0500, Steve French wrote:
>And running the build differently, from the root of the git tree
>(5.4-rc1) rather than using the Ubuntu 5.4-rc1 headers also fails
>
>e.g. "make  M=fs/cifs modules nsdeps"
>
>...
>  LD [M]  fs/cifs/cifs.o
>  Building modules, stage 2.
>  MODPOST 1 modules
>WARNING: module cifs uses symbol sigprocmask from namespace
>_fs/cifs/cache.o), but does not import it.
>...
>WARNING: module cifs uses symbol posix_test_lock from namespace
>cifs/cache.o), but does not import it.
>  CC [M]  fs/cifs/cifs.mod.o
>  LD [M]  fs/cifs/cifs.ko
>  Building modules, stage 2.
>  MODPOST 1 modules
>./scripts/nsdeps: 34: local: ./fs/cifs/cifsfs.c: bad variable name
>make: *** [Makefile:1710: nsdeps] Error 2

Thanks for reporting this. It appears to me you hit a bug that was
recently discovered: when building with `make M=some/subdirectory`,
modpost is misbehaving. Can you try whether this patch series solves
your problems:
https://lore.kernel.org/lkml/20191003075826.7478-1-yamada.masahiro@socionext.com/
In particular patch 2/6 out of the series.

Cheers,
Matthias

>On Wed, Oct 2, 2019 at 6:45 PM Steve French <smfrench@gmail.com> wrote:
>>
>> Following the instructions in Documentation/namespaces to autogenerate
>> the namespace changes to avoid the multiple build warnings in 5.4-rc1
>> for my module ... I am not able to get nsdeps to work.   For example
>> in my module directory (fs/cifs) trying to build with nsdeps:
>>
>>       make -C /usr/src/linux-headers-`uname -r` M=`pwd` modules nsdeps
>>
>> gets the error "cat: ./modules.order: No such file or directory"
>>
>> This is on Ubuntu 18, running current 5.4-rc1 kernel.  It looks like
>> it is looking for modules.order in the wrong directory (it is present
>> in fs/cifs - but it looks like it is looking for it in /usr/src where
>> of course it won't be found)
>>
>> I am trying to remove the hundreds of new warnings introduced by
>> namespaces in 5.4-rc1 when building my module e.g.
>>
>> WARNING: module cifs uses symbol __fscache_acquire_cookie from
>> namespace .o: $(deps_/home/sfrench/cifs-2.6/fs/cifs/cache.o), but does
>> not import it.
>> --
>> Thanks,
>>
>> Steve
>
>
>
>-- 
>Thanks,
>
>Steve
