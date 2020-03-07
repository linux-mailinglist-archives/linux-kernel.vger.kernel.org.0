Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC117CF13
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 16:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCGPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 10:36:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgCGPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 10:36:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so2561868pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X8Q0iQvt9yySsKBxTObcLgqNokyvnZ8EgfUe1/v9Oag=;
        b=o6S4yzpEbBoXuEbGBPbuI2aVMha7Hq4/PaqQ+0ISNq4VryGl2gneRQo1uyI5G8y+sM
         MPep6y8foCYeMdjVWvSmCeZEwaoTKAss0DymSfmCUSw5mmZy8dX5EYd0dbPtFQauatHF
         Tq4KA4FK5iTzaF1F4yo8NafTb/L4UDtzPK83LM7ZmbnT7zKe0gGyKf3jHiMrOQMIAj1Q
         MfomBNKKxgx1Conwk1sof1Cok2NUDN5FKrEfTepJgbx5JaYYRiaLnCHu9LKwQNVYkhgJ
         FMMS37a1CReTT0N3q6GxYYXPvCZBvu2NdjFjkSSS92EVfXv6oWmHy5AHH69Fg0i8xEGb
         d8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8Q0iQvt9yySsKBxTObcLgqNokyvnZ8EgfUe1/v9Oag=;
        b=Ci9jjI+9Hkho8ma7KvFF1zmXEqnTtzG4dleFhZmn7FhxLh+A0tmsdhrq+jhL5NHMYd
         kYeJREU06o7+Rb9UmKULSzXWAzYclkIROb63ME6IN4oa9dTIrY6Fo5ywZ4Noy993/lAK
         mYi7DdbXpchLU+lsa/8cbSYgfaGWivnbG3EL/a3M7YTPihU+bsUp7M4gGwa8R0EeSwbH
         Yxznapl+Da3L9etQOYbXPmpDQANEWTUewG6+pF7dwXxji6tGWrKYWPoPNr0LPM5uhRLU
         rLfVj0ff0IWFjKeSfZ626rEg/Wl2VyK/l1xpIUpYz7w8mIPAsQALSRPG++ZW6NskXAq1
         K/tw==
X-Gm-Message-State: ANhLgQ3enOrKxUWD0sVqH3CrsRV4uORlu2yRPFNkhzFB0JBE5EPH4km0
        dErxCVQAMLhJtg/UhuUy9gQFwkFZ5/w=
X-Google-Smtp-Source: ADFU+vv/CpDAMDYJcxi9ndwAxm1jhXPFLdwR0Dr7LdLSFsjt7ExIeOBElk+ZsZWGCaJjSUGKsulRyA==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr8739393pfn.232.1583595392111;
        Sat, 07 Mar 2020 07:36:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c18sm38291906pgw.17.2020.03.07.07.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 07:36:31 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: fix lockup with timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <54e141c75da11f55f607d53c54943b9fee5bbd70.1583532280.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a96385c-52ea-cba8-455d-6fd3042bd49e@kernel.dk>
Date:   Sat, 7 Mar 2020 08:36:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <54e141c75da11f55f607d53c54943b9fee5bbd70.1583532280.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 3:15 PM, Pavel Begunkov wrote:
> There is a recipe to deadlock the kernel: submit a timeout sqe with a
> linked_timeout (e.g.  test_single_link_timeout_ception() from liburing),
> and SIGKILL the process.
> 
> Then, io_kill_timeouts() takes @ctx->completion_lock, but the timeout
> isn't flagged with REQ_F_COMP_LOCKED, and will try to double grab it
> during io_put_free() to cancel the linked timeout. Probably, the same
> can happen with another io_kill_timeout() call site, that is
> io_commit_cqring().

Thanks, looks good, applied.

-- 
Jens Axboe

