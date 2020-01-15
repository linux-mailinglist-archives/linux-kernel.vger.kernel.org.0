Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4912413CA01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAOQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 11:53:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39374 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAOQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:53:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so8783139pfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=45dYKdEEtvBowmZ2Tz/C5Jfdlk+db8W+xCb5uAca8y4=;
        b=ojtgBzNtZ7v7yxreqmgqDqVwTMb/bWdOk1U/635u070ynqeGOGkDNqsowxMqTG/oMd
         SWsFSW5cwAZVmXBgYOWoPHyYDd7dGWjUEdRIgquRkBZ3L/lKUrJHLeqE2RqOsZP1OMVn
         afcbHAOFa9l3neTuJeZ0RubOC0SXw+3qjvCvh1blGpmmbwvlHjYZU3X9BnPFt04f4Ib+
         vONo+9257A20iyw4jXRAPeogYJ/rtvvAZTBP6y+6rzMgiHUOZR5Dur3Hy+OmkQAz8/qf
         cL5JzfQROIvEYRyeNj/rDwFkSmdefg1iKjgugPUCTw0MPyavbqGtKw3TvIHbNDTVFxSj
         PFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=45dYKdEEtvBowmZ2Tz/C5Jfdlk+db8W+xCb5uAca8y4=;
        b=J9d0LJHtwBBw3GG2WnKC1R0rE+buCCt46euEM3z0BmMZ8TWzcuQJbj6lWeOG3joLmK
         t5ZimLay5AZabUY2Gpw9+l7enTvFHk6edAp2twxc/PaMGbwvaArWj742IkaxQ7qNyFJJ
         G5qUFaZeBtqCbsf2yaH9V+ltw0HatKOgpU9Q3Q1Z9JwzK3PQD4q5oU4Vteuky0d/3TBG
         Tt/51H7YMqdTYDTcLGsU3vvUueqauS0uPiqV6jkd0hLxQTspHZ/ZRUHf0WOQAqlW5Skv
         s6NPRvthjIsIfuyqslIFTg4Zq4q05paZfC0dyHEJCoTTVl8mtrGrUu7RN/TTP1S4xbCZ
         5GXQ==
X-Gm-Message-State: APjAAAUYIvXZtOJ4i3RADah8vMaWWRQ6tUAUdqSX9sr4zxgtrB6w5uLK
        gu9pmeVvfgGvfrHn6Ncvoyn98A==
X-Google-Smtp-Source: APXvYqz/HCuuSXebB6RWzOE7pQBUUJ9cY8UpM0RbM8RJTB/p1cM4oTyQlXvwc/8t0OlnCSamr3CXPg==
X-Received: by 2002:a63:504c:: with SMTP id q12mr33899173pgl.117.1579107209330;
        Wed, 15 Jan 2020 08:53:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::1049? ([2620:10d:c090:180::4bca])
        by smtp.gmail.com with ESMTPSA id q12sm22166402pfh.158.2020.01.15.08.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 08:53:28 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix compat for IORING_REGISTER_FILES_UPDATE
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20200115163538.GA13732@asgard.redhat.com>
 <cce5ac48-641d-3051-d22c-dab7aaa5704c@kernel.dk>
 <20200115165017.GI1333@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a039f869-6377-b8b0-e170-0b5c17ebd4da@kernel.dk>
Date:   Wed, 15 Jan 2020 09:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115165017.GI1333@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 9:50 AM, Eugene Syromiatnikov wrote:
> On Wed, Jan 15, 2020 at 09:41:58AM -0700, Jens Axboe wrote:
>> On 1/15/20 9:35 AM, Eugene Syromiatnikov wrote:
>>> fds field of struct io_uring_files_update is problematic with regards
>>> to compat user space, as pointer size is different in 32-bit, 32-on-64-bit,
>>> and 64-bit user space.  In order to avoid custom handling of compat in
>>> the syscall implementation, make fds __u64 and use u64_to_user_ptr in
>>> order to retrieve it.  Also, align the field naturally and check that
>>> no garbage is passed there.
>>
>> Good point, it's an s32 pointer so won't align nicely. But how about
>> just having it be:
>>
>> struct io_uring_files_update {
>> 	__u32 offset;
>> 	__u32 resv;
>> 	__s32 *fds;
>> };
>>
>> which should align nicely on both 32 and 64-bit?
> 
> The issue is that 32-bit user space would pass a 12-byte structure with
> a 4-byte pointer in it to the 64-bit kernel, that, in turn, would treat it
> as a 8-byte value (which might sometimes work on little-endian architectures,
> if there are happen to be zeroes after the pointer, but will be always broken
> on big-endian ones). __u64 is used in order to avoid special compat wrapper;
> see, for example, __u64 usage in btrfs or BPF for similar purposes.

Ah yes, I'm an idiot, apparently not enough coffee yet. We'd need it in
a union for this to work. I'll just go with yours, it'll work just fine.
I will fold it in, I need to make some updates and rebase anyway.

-- 
Jens Axboe

