Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF6F2E03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfKGMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 07:15:59 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44224 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:15:59 -0500
Received: by mail-wr1-f46.google.com with SMTP id f2so2716086wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AhvFZA/8mu3kvXFq6TuCaJ1OmjGmDb6ipwRR9+wxEXI=;
        b=tSxjozI0LXsxPhnJbqXdF/zzwjjgM5fA2KPgToWN4mt83gWKz32OaWD3xznwGbAMqA
         IUwDFk6TfCIl0u9cg/6NEFMQnhInxYSCagxChSVX9/J92NSGs1W+ID57ynzueKlBZOL0
         gDwRSm6z+go1F0/igdP0A9HrNovYYuQbPTHUA+gKSYV9vFhO2uI0pQD2Zp3MzR2G6/qa
         ZtkdhIy5YVkZ5U/QxpJNfkka+NqV+2ZtMoB0QK/UOfNdMbth/oLokLx9X0D+kiMQEYEx
         uzWdQ62vTGUG8Pf22fzXmAe3z2c2eS3FuaHELdZcnnGW+8I6XHJuBE/BEiXc/ofrDRFo
         avVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AhvFZA/8mu3kvXFq6TuCaJ1OmjGmDb6ipwRR9+wxEXI=;
        b=D2NForMz02at0ceBnYbDT9H6UpzPqedx6XP7BqmCwbskNZg80pEWSnFDSZkiatZ1ny
         mp2TUs6HjIoDHhDt3ZJ03wga/fAxUXb9xjNvLHgQHBT6DqchbVPP09qXxu5pB6j2E4et
         kseeJgkvd7N08v6nHV08aoD0aifXY+rNGVhv3VgMGznTCpDWaf4HzZgBJqS/5PeifVp8
         82sLLub115nOm/LMLzDyxI6cX/1zDcZd3HDSqL+owy1Vc9Tq8hkAzei7Or/Gupun1f5/
         fH8M7nEyWg1uZGW/U5e72kEAZEySrKNTG3siz9873eqr769IPQ63TJJR7bgHeP7qehEH
         Rg9A==
X-Gm-Message-State: APjAAAXvyfphR1HoTq+Te10SETtIuH08/w+hyrdjpu64DiiqOt9YNZxO
        osKrmh0+rQn96NkyyzsEFPlKyQ==
X-Google-Smtp-Source: APXvYqyEmwY5aHzXCIZs1wotO2/tgtomk2HcI006MSaOMZk7X3Kx3u0jFjkBqSkFHRu9pgkllEysgA==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr2441298wrr.87.1573128955161;
        Thu, 07 Nov 2019 04:15:55 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x8sm1644620wmi.10.2019.11.07.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:15:54 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:15:51 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Lu <aaron.lwe@gmail.com>, Phil Auld <pauld@redhat.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [sched] 10e7071b2f: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20191107121551.GB82729@google.com>
References: <20191107090808.GW29418@shao2-debian>
 <fc023bbd-e282-c986-b43b-18ac31b2e362@arm.com>
 <20191107120922.GA82729@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107120922.GA82729@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 12:09:22 (+0000), Quentin Perret wrote:
> sched_move_task() follows what Peter called the 'change' pattern, so I'm
> thinking this is most likely the same issue. Dropping the lock causes an
> unmitigated race between sched_move_task() and pick_next_task_dl(), so
> hilarity ensues (set_next_task() being called twice for instance).

Bah, scratch that. 10e7071b2 is clearly before the pick_next_task()
rework, so that's not it :(

Quentin
