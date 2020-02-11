Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF8159A70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgBKUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 15:21:49 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:32806 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgBKUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:21:48 -0500
Received: by mail-il1-f193.google.com with SMTP id s18so4631748iln.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mIyBy4JCOkJP7cktnPbxhyiRKrh2LvbLi90NtcJ6v8E=;
        b=Z0IeYiK8hcLsi9ZV8xQNT6s6zlkEkPoVIgMbHkLV9P5b78X2FQY1Nh1XUjt5Y4OSjI
         YuR2sf/AEMXakQI+wYWynh6n00jSIbeKHL1+lV4a7YgobAil4L30epBZm+iJ4FAdVoV1
         rSrbnAL2LSvAsf/4i6u7ybtqqPuYo7uDwACE5sfsFPajbMIuvpIPYXEQQ4QppB42bS6V
         SzGLNfrXYYch6QOVzfIASfrqosm9NlC6IAx6WxyxrlndMWPcC1UflBD1EJ6rxfHIlrLV
         B65wxCxWukWItL9y63Pm5Xpe8rqpJwon5t/qQkOa7/2Kkyf8AdXYozLUiI0U5+fNwlOH
         oVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mIyBy4JCOkJP7cktnPbxhyiRKrh2LvbLi90NtcJ6v8E=;
        b=siB2VArbFjkeHFIBPIGZgOi1iRFLEDRZe/pXBeFv59BQ84EPXsP/atmErJEBPI1CQc
         yw+9FlyCZtutPxeM9XMO31MOkGB4tiv/DGqR7wEEg9s+gAm2M2g7iYqU5nWxuIhuFSz7
         XQTSfTlOMwDBGWyQMxk8lSpQHjnF0+As6A0Jiog0hC10Dn5/QvFsC06Xwd5DBZ7zWTmR
         t/7HgJXdIUvIF+bitwrPr9z7clyKexPelUEPKxYBIeQt/eqEcRP71wIjcWiCy4wMfTxA
         WDJvnm/8El0Hka3RtkDlNHD8cvZDAquW7KU+w4TAGu9AE8Mu6T47AhoH6FuiJrHx5UTU
         VN9Q==
X-Gm-Message-State: APjAAAV1LyzN1H8SILfteLyhjFoh6CDXxBctgfo/0Bb8/oOXZ/GeGRvz
        e+Lgns5jcpMg27ANPJnUekw2iuN4bgU=
X-Google-Smtp-Source: APXvYqyXG92CLLE/gaDPSwIn/2AydfJPGTJHRA4qyjmWaFOiqwbPVoP2X3ZZ4BRGt7uUrjsbe8meow==
X-Received: by 2002:a92:dac3:: with SMTP id o3mr8284147ilq.237.1581452507901;
        Tue, 11 Feb 2020 12:21:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v3sm1628309ili.0.2020.02.11.12.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 12:21:47 -0800 (PST)
Subject: Re: [PATCH 3/5] io_uring: fix reassigning work.task_pid from io-wq
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1581450491.git.asml.silence@gmail.com>
 <728f583e7835cf0c74b8dc8fbeddb58970f477a5.1581450491.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a08cc5a-2100-3a31-becb-c16592905c86@kernel.dk>
Date:   Tue, 11 Feb 2020 13:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <728f583e7835cf0c74b8dc8fbeddb58970f477a5.1581450491.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 1:01 PM, Pavel Begunkov wrote:
> If a request got into io-wq context, io_prep_async_work() has already
> been called. Most of the stuff there is idempotent with an exception
> that it'll set work.task_pid to task_pid_vnr() of an io_wq worker thread
> 
> Do only what's needed, that's io_prep_linked_timeout() and setting
> IO_WQ_WORK_UNBOUND.

Rest of the series aside, I'm going to fix-up the pid addition to
only set if it's zero like the others.

-- 
Jens Axboe

