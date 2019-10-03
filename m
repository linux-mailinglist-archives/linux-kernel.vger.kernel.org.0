Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0ACB103
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfJCVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 17:22:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39081 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJCVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:22:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so4333526ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMXUawk779Rg0n7VhPYVUvheDt/wHtDxTM0M49SF5fA=;
        b=aZ7lBYY4rKVPH8dxmUG7mt7rDQdVdok66Rw4NZYoRg3NtYbxPIacz5XYEdobLqtBuO
         8VbzJjwcH/DnujSAq6CeR6sCPivqUr6/V+s/zHZCF9D41Mo2p3OxjjrfIrWW1csW/Zp4
         z2jSBIEgN8eAvUq7rq+racF2NZwVxV228QsXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMXUawk779Rg0n7VhPYVUvheDt/wHtDxTM0M49SF5fA=;
        b=VUdQCN27AmPpX0cgsE8nlCKofmiWXARohm+Ca0ALczxYsUjw9+Vs5tNbszmhUisoYB
         5oqroZocnLF4j9/Ko2P3zFuXXdQZYWOYVV/eNLbEKf0wRfuCP+aIgCRH7TkoN7Y2y/JH
         leoZ9tScTCkkMUfbYlvGzmuJXrmjZUs239+ZRxDM+YDe0BbptezGz5HR2ZRwhbYdKv/m
         5O9UbFay41YLUaEPEGhhSz2G7AjqbNMQbtiU455gximOs2JUgzD807qQLJ6FkXotaD+2
         +MYn7HtJla2VB505eoUaYXFqP66WutbRM2nc6Z+ncFgv4Cmwmnf/fffJyVyvWIGIYtiP
         pNCQ==
X-Gm-Message-State: APjAAAWXGolkUNfPeQoqNsTya0PJehqXqXvDKz0BycifsgYY3/PGS5kF
        5yxA8dopA6vlSNDPzxCan+PhT8/qKfY=
X-Google-Smtp-Source: APXvYqzIPqdIWPMGyQ8SNzzW94OLHAWhVgnaOLhm8bMconK2SuQcw6u7HGBfpKRkQ1+tciMuoXYt3w==
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr7249659lje.193.1570137768604;
        Thu, 03 Oct 2019 14:22:48 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id l15sm38013ljj.34.2019.10.03.14.22.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:22:47 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id u3so2903998lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:22:47 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr6965481lfp.134.1570137766481;
 Thu, 03 Oct 2019 14:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <6a26185f-f188-0049-b153-1541d7a514b0@redhat.com>
In-Reply-To: <6a26185f-f188-0049-b153-1541d7a514b0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 14:22:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf=vVVrmKb1rjfp1Y_57CRJjERsbYZ7+hnAWggF99zNw@mail.gmail.com>
Message-ID: <CAHk-=whf=vVVrmKb1rjfp1Y_57CRJjERsbYZ7+hnAWggF99zNw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Fix EOVERFLOW testing in put_compat_statfs64
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:17 PM Eric Sandeen <sandeen@redhat.com> wrote:
>
> As a result, 32-bit userspace gets -EOVERFLOW for i.e. large file
> counts even with -D_FILE_OFFSET_BITS=64 set.

Applied.

           Linus
