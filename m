Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81D718E47B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 21:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCUUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 16:31:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46143 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgCUUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:31:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so3792422pgc.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KtHEUeqpEQFTh0Lhcg4n5H6JIosCRRgpxD4fsra1T24=;
        b=MQxHRuAN9tzpFIqfnlglw/uACONg2ZcBhmEd99Vp5/2qkqO9rinxrfuqXDoAu28mpF
         fW+JqkBkRh/RCoKx2c63yeyGbs//OXts5nwquD5iw+gixTOyY+EaaULzCsbyVwnFbLJJ
         jfRk8BGF88aKh4il9KT8vssDj7kEApngp55+wseBfqRuRC666ZJ3cCKBTvV/3OZ+zr4C
         HmJsrto+r2iVf6j3pi6SJIJIulIxOTlGXYYVH2MsQ9nLYv/lyU16SER+4DRvsBrhfe6c
         7VU+vvkHLUxUZUh7QKBlftWhUYFFLMdTLycnauvnSILyuWoX1w1qY4+pKHE1+BaFWL8Q
         EYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KtHEUeqpEQFTh0Lhcg4n5H6JIosCRRgpxD4fsra1T24=;
        b=bS6XHMtcKm8kyyH4jwNUNpyoGmbVQbF76o7Qv/YXwDrgcutOycesXzM//jdXeUttZh
         5ufSOFsZVDDic36IcN73wxx9WIKEXgUhqqSK1rrxfYbreAQbtpuiq1U+eoGeEQ4ZsB1I
         kcjCyKG6NV1ZkCYpRUciLdlDAQJqapqtWqwmqE1VQn0E7p0ofIi4N0VVVU7aGY5bBSJ0
         aQ0oXNIJXEWZF3x07qSSvxQOGr2aOMQ/6O1lcroS5SGclCG0xiDzhe2rV1zEvxVPhLE5
         WQEcaEb7FrBiw8x2Kg4RFKHXkiMSmZ9g5z3H7n8qpqxiS4P9S5U8FwKyshgxXKc5+w9E
         2Sdg==
X-Gm-Message-State: ANhLgQ34VQGQT+f5KvoiM0swC4bB8dEWbb0yUw6LGernlhHDjUN/o+zk
        EyFMsqHXNj0nEeVANkgttkGzKA==
X-Google-Smtp-Source: ADFU+vtkMgIvvqtkf5AO3P+JUquBgDfkgt0cwYNph/foYs8bN4hSKJW1JCzh/ITalvv430YzMkUDkQ==
X-Received: by 2002:a63:7e52:: with SMTP id o18mr15282915pgn.46.1584822677898;
        Sat, 21 Mar 2020 13:31:17 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 5sm9131565pfw.98.2020.03.21.13.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 13:31:17 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 0/4] block, bfq: series of cgroups-related fix
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com
References: <20200321094521.85986-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c1e5f7d-14f8-1092-a777-a7ac457e9d0a@kernel.dk>
Date:   Sat, 21 Mar 2020 14:31:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/20 3:45 AM, Paolo Valente wrote:
> Hi,
> this is a series of four fixes. The first patch fixes the issue
> reported in [1], while the following patches fix a few extra issues
> found while testing the first fix.

Applied for 5.7, thanks.

-- 
Jens Axboe

