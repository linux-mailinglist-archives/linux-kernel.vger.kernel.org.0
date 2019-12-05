Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3730F11461C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfLERlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 12:41:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46738 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:41:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so4498528ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxxdiKNiz39tRqLEdE4fMp8XvXCMdjUYyrnc67CIuPc=;
        b=ORPcmASmhOZl546WvwcyNPKV6KACymeuubMzw/fmh39y+aB87wlfZcWosPv03wpDII
         7wOeTc7QK3DxNZfu8fjlxFHGTJuhZ6VcelBcL9PMvS2MhK43zlFN3DY33wClA1oE7Z3i
         zfRrFnVmNk3pY9gYF4t9b/B5JFUkgzpdua73w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxxdiKNiz39tRqLEdE4fMp8XvXCMdjUYyrnc67CIuPc=;
        b=JfD89nD64HxQBYaFDlmR06RNIWXEpdJ8/uoSs9V+BGbxzdyvIvz4TVJA4O56VkSetP
         r2hNXOugESyG/dRe6QiLUoZQLqUTE9UbMeVGDO0kjjB2Q3exCo342mECyyxkr22JJ7If
         Mm6T8ku6e2/0+malDiPI2trss9N5G/RX1n/NFUdDja0dc8dE0N1muOgSGKzhVf+zEkda
         AXippbOdHjPjbYtqNkPsy+3hSQmYr3wopVNIrRlzWZVYBaC8saax8ZAKXfkHM8eLLJ1u
         h7rQgvltYcCecJ+N/YfHjBx7ij3p8Ll8pgeENXgbnINR9XAmy3IZr/lvUBIy9zXKguwD
         4yQw==
X-Gm-Message-State: APjAAAV1CK8hvPbsYFHgAZzTLzcYqzSpOfijad2E7opIeByaBw+XkN15
        0imuH9AGTI/UoF/uwotMnqmcttP/aQU=
X-Google-Smtp-Source: APXvYqy0yxmZ0zbwR/TK+Vim5ZbVO9D8XnSNObwglZ7YoFhV2mrSq4X7d8b11JMCcm+w6FSiJjYRjw==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr6459408ljj.62.1575567666784;
        Thu, 05 Dec 2019 09:41:06 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u7sm5345739lfn.31.2019.12.05.09.41.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:41:06 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v201so3104357lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:41:05 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr2760573lfo.134.1575567665303;
 Thu, 05 Dec 2019 09:41:05 -0800 (PST)
MIME-Version: 1.0
References: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
 <157556651022.20869.2027577608881946885.stgit@warthog.procyon.org.uk>
In-Reply-To: <157556651022.20869.2027577608881946885.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:40:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNQ2SWwYzrvdwzan5krzE2Tgh35zyDPy+i6nBEVc7EfA@mail.gmail.com>
Message-ID: <CAHk-=wgNQ2SWwYzrvdwzan5krzE2Tgh35zyDPy+i6nBEVc7EfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pipe: Fix missing mask update after pipe_wait()
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:22 AM David Howells <dhowells@redhat.com> wrote:
>
> Fix pipe_write() to regenerate the ring index mask and update max_usage
> after calling pipe_wait().

Honestly, just remove the "mask" and "max_usage" caching. There are no
advantages to it. With all the function calls etc, it will just result
in moving the data from the pipe to a stack slot anyway.

Maybe you can cache it inside the inner loops or something, but
caching it at the outer level is pointless, and leads to these kinds
of bugs.

               Linus
